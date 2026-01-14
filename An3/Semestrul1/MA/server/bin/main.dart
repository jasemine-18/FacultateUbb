import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final _uuid = Uuid();

// -------------------- In-memory "DB" --------------------
final Map<String, Map<String, dynamic>> _trips = {};
final Map<String, Map<String, dynamic>> _checklist = {}; // itemId -> item JSON
final Map<String, Map<String, dynamic>> _expenses = {};  // expenseId -> expense JSON

// -------------------- WebSocket clients --------------------
final Set<WebSocketChannel> _wsClients = {};

void _log(String msg) {
  final ts = DateTime.now().toIso8601String();
  // ignore: avoid_print
  print("[$ts] $msg");
}

void _broadcast(Map<String, dynamic> event) {
  final payload = jsonEncode(event);
  for (final c in _wsClients.toList()) {
    try {
      c.sink.add(payload);
    } catch (_) {
      _wsClients.remove(c);
    }
  }
}

// -------------------- Helpers --------------------
Response _jsonOk(Object body) => Response.ok(
  jsonEncode(body),
  headers: {'content-type': 'application/json; charset=utf-8'},
);

Response _jsonErr(int code, String message) => Response(
  code,
  body: jsonEncode({'error': message}),
  headers: {'content-type': 'application/json; charset=utf-8'},
);

Future<Map<String, dynamic>?> _readJson(Request req) async {
  try {
    final s = await req.readAsString();
    if (s.trim().isEmpty) return {};
    final obj = jsonDecode(s);
    if (obj is Map<String, dynamic>) return obj;
    return null;
  } catch (_) {
    return null;
  }
}

Map<String, dynamic> _sanitizeTripForCreate(Map<String, dynamic> inJson) {
  // server manages ID
  final nowMs = DateTime.now().millisecondsSinceEpoch;

  return {
    'id': _uuid.v4(),
    'destination': (inJson['destination'] ?? '').toString(),
    'startDateMs': (inJson['startDateMs'] ?? 0),
    'endDateMs': (inJson['endDateMs'] ?? 0),
    'transportMode': (inJson['transportMode'] ?? 'plane').toString(),
    'accommodation': inJson['accommodation'], // nullable
    'budgetPlanned': (inJson['budgetPlanned'] ?? 0).toDouble(),
    'budgetSpent': (inJson['budgetSpent'] ?? 0).toDouble(),
    'packingList': (inJson['packingList'] ?? '').toString(),
    'placesToVisit': (inJson['placesToVisit'] ?? '').toString(),
    'placesToEat': (inJson['placesToEat'] ?? '').toString(),
    'notes': (inJson['notes'] ?? '').toString(),
    'status': (inJson['status'] ?? 'planned').toString(), // planned/completed
    'createdAtMs': nowMs,
    'updatedAtMs': nowMs,
  };
}

Map<String, dynamic> _sanitizeTripForUpdate(
    Map<String, dynamic> existing,
    Map<String, dynamic> inJson,
    ) {
  final nowMs = DateTime.now().millisecondsSinceEpoch;

  // id stays same, createdAt stays same
  return {
    ...existing,
    'destination': (inJson['destination'] ?? existing['destination']).toString(),
    'startDateMs': (inJson['startDateMs'] ?? existing['startDateMs']),
    'endDateMs': (inJson['endDateMs'] ?? existing['endDateMs']),
    'transportMode': (inJson['transportMode'] ?? existing['transportMode']).toString(),
    'accommodation': inJson.containsKey('accommodation')
        ? inJson['accommodation']
        : existing['accommodation'],
    'budgetPlanned': (inJson['budgetPlanned'] ?? existing['budgetPlanned']).toDouble(),
    'budgetSpent': (inJson['budgetSpent'] ?? existing['budgetSpent']).toDouble(),
    'packingList': (inJson['packingList'] ?? existing['packingList']).toString(),
    'placesToVisit': (inJson['placesToVisit'] ?? existing['placesToVisit']).toString(),
    'placesToEat': (inJson['placesToEat'] ?? existing['placesToEat']).toString(),
    'notes': (inJson['notes'] ?? existing['notes']).toString(),
    'status': (inJson['status'] ?? existing['status']).toString(),
    'updatedAtMs': nowMs,
  };
}

bool _validateTrip(Map<String, dynamic> t) {
  if ((t['destination'] ?? '').toString().trim().isEmpty) return false;
  final s = t['startDateMs'];
  final e = t['endDateMs'];
  if (s is! int || e is! int) return false;
  if (e < s) return false;
  final status = (t['status'] ?? '').toString();
  if (status != 'planned' && status != 'completed') return false;
  return true;
}

// -------------------- Router --------------------
Router _buildRouter() {
  final r = Router();

  // Health
  r.get('/health', (Request req) => _jsonOk({'ok': true}));

  // WebSocket
  r.get('/ws', webSocketHandler((WebSocketChannel ws) {
    _wsClients.add(ws);
    _log("WS client connected. total=${_wsClients.length}");

    ws.stream.listen(
          (msg) {
        // optional: accept pings or ignore
        _log("WS recv: $msg");
      },
      onDone: () {
        _wsClients.remove(ws);
        _log("WS client disconnected. total=${_wsClients.length}");
      },
      onError: (_) {
        _wsClients.remove(ws);
      },
    );
  }));

  // -------- Trips --------

  // READ list
  r.get('/trips', (Request req) {
    final list = _trips.values.toList()
      ..sort((a, b) => (b['updatedAtMs'] as int).compareTo(a['updatedAtMs'] as int));
    _log("GET /trips -> ${list.length}");
    return _jsonOk(list);
  });

  // READ by id
  r.get('/trips/<id>', (Request req, String id) {
    final t = _trips[id];
    if (t == null) return _jsonErr(404, "Trip not found.");
    _log("GET /trips/$id");
    return _jsonOk(t);
  });

  // CREATE (server creates id)
  r.post('/trips', (Request req) async {
    final body = await _readJson(req);
    if (body == null) return _jsonErr(400, "Invalid JSON.");
    final t = _sanitizeTripForCreate(body);

    if (!_validateTrip(t)) {
      return _jsonErr(422, "Invalid trip data (destination/dates/status).");
    }

    _trips[t['id'] as String] = t;
    _log("POST /trips -> created id=${t['id']}");
    _broadcast({'type': 'trip_created', 'id': t['id'], 'updatedAtMs': t['updatedAtMs']});
    return Response(
      201,
      body: jsonEncode(t),
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  });

  // UPDATE (reuse same server element, id stays same)
  r.put('/trips/<id>', (Request req, String id) async {
    final existing = _trips[id];
    if (existing == null) return _jsonErr(404, "Trip not found.");

    final body = await _readJson(req);
    if (body == null) return _jsonErr(400, "Invalid JSON.");

    final updated = _sanitizeTripForUpdate(existing, body);

    if (!_validateTrip(updated)) {
      return _jsonErr(422, "Invalid trip data (destination/dates/status).");
    }

    _trips[id] = updated;
    _log("PUT /trips/$id -> updated");
    _broadcast({'type': 'trip_updated', 'id': id, 'updatedAtMs': updated['updatedAtMs']});
    return _jsonOk(updated);
  });

  // DELETE by id (and cascade minimal)
  r.delete('/trips/<id>', (Request req, String id) {
    final existing = _trips[id];
    if (existing == null) return _jsonErr(404, "Trip not found.");

    // cascade minimal: delete children (checklist + expenses)
    final checklistIds = _checklist.values
        .where((x) => x['tripId'] == id)
        .map((x) => x['id'])
        .toList();

    for (final cid in checklistIds) {
      _checklist.remove(cid);
    }

    final expenseIds = _expenses.values
        .where((x) => x['tripId'] == id)
        .map((x) => x['id'])
        .toList();

    for (final eid in expenseIds) {
      _expenses.remove(eid);
    }

    _trips.remove(id);

    _log("DELETE /trips/$id -> deleted (cascade checklist=${checklistIds.length}, expenses=${expenseIds.length})");
    _broadcast({'type': 'trip_deleted', 'id': id});
    return Response(204);
  });

  // -------- Checklist (by trip) --------

  r.get('/trips/<tripId>/checklist', (Request req, String tripId) {
    if (!_trips.containsKey(tripId)) return _jsonErr(404, "Trip not found.");
    final items = _checklist.values.where((x) => x['tripId'] == tripId).toList()
      ..sort((a, b) => (a['orderIndex'] as int).compareTo(b['orderIndex'] as int));
    _log("GET /trips/$tripId/checklist -> ${items.length}");
    return _jsonOk(items);
  });

  r.post('/trips/<tripId>/checklist', (Request req, String tripId) async {
    if (!_trips.containsKey(tripId)) return _jsonErr(404, "Trip not found.");
    final body = await _readJson(req);
    if (body == null) return _jsonErr(400, "Invalid JSON.");

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final item = <String, dynamic>{
      'id': _uuid.v4(),
      'tripId': tripId,
      'textValue': (body['textValue'] ?? '').toString(),
      'done': (body['done'] ?? false) == true,
      'orderIndex': (body['orderIndex'] ?? 0) is int ? body['orderIndex'] : 0,
      'createdAtMs': nowMs,
    };

    if (item['textValue'].toString().trim().isEmpty) {
      return _jsonErr(422, "Checklist item text is required.");
    }

    _checklist[item['id'] as String] = item;
    _log("POST /trips/$tripId/checklist -> created id=${item['id']}");
    _broadcast({'type': 'checklist_created', 'tripId': tripId, 'id': item['id']});
    return Response(
      201,
      body: jsonEncode(item),
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  });

  // -------- Expenses (by trip) --------

  r.get('/trips/<tripId>/expenses', (Request req, String tripId) {
    if (!_trips.containsKey(tripId)) return _jsonErr(404, "Trip not found.");
    final items = _expenses.values.where((x) => x['tripId'] == tripId).toList()
      ..sort((a, b) => (b['dateMs'] as int).compareTo(a['dateMs'] as int));
    _log("GET /trips/$tripId/expenses -> ${items.length}");
    return _jsonOk(items);
  });

  r.post('/trips/<tripId>/expenses', (Request req, String tripId) async {
    if (!_trips.containsKey(tripId)) return _jsonErr(404, "Trip not found.");
    final body = await _readJson(req);
    if (body == null) return _jsonErr(400, "Invalid JSON.");

    final expense = <String, dynamic>{
      'id': _uuid.v4(),
      'tripId': tripId,
      'category': (body['category'] ?? 'other').toString(),
      'amount': (body['amount'] ?? 0).toDouble(),
      'currency': (body['currency'] ?? 'RON').toString(),
      'dateMs': (body['dateMs'] ?? DateTime.now().millisecondsSinceEpoch) is int
          ? body['dateMs']
          : DateTime.now().millisecondsSinceEpoch,
      'description': (body['description'] ?? '').toString(),
    };

    if ((expense['amount'] as double) <= 0) {
      return _jsonErr(422, "Expense amount must be > 0.");
    }

    _expenses[expense['id'] as String] = expense;
    _log("POST /trips/$tripId/expenses -> created id=${expense['id']}");
    _broadcast({'type': 'expense_created', 'tripId': tripId, 'id': expense['id']});
    return Response(
      201,
      body: jsonEncode(expense),
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  });

  return r;
}

// -------------------- Middleware: CORS + logging --------------------
Middleware _cors() {
  return (Handler inner) {
    return (Request req) async {
      if (req.method == 'OPTIONS') {
        return Response.ok(
          '',
          headers: _corsHeaders,
        );
      }

      final res = await inner(req);
      return res.change(headers: {
        ..._corsHeaders,
        ...res.headers,
      });
    };
  };
}

const _corsHeaders = <String, String>{
  'access-control-allow-origin': '*',
  'access-control-allow-methods': 'GET,POST,PUT,DELETE,OPTIONS',
  'access-control-allow-headers': 'Origin, Content-Type, Accept',
  'access-control-allow-credentials': 'true',
};

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;
  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8081;

  final router = _buildRouter();

  final handler = Pipeline()
      .addMiddleware(logRequests(logger: (msg, isError) => _log(msg)))
      .addMiddleware(_cors())
      .addHandler(router);

  final server = await serve(handler, ip, port);
  _log('Server running on http://${server.address.host}:${server.port}');
  _log('WS endpoint: ws://${server.address.host}:${server.port}/ws');
}
