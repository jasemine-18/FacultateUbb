import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../core/log.dart';
import '../../core/network.dart';
import '../../data/local/app_db.dart';
import '../../data/remote/api_client.dart';
import '../../repositories/trip_repository.dart';

// --------------- Config ---------------
const _baseUrlAndroidEmulator = "http://10.0.2.2:8081";
const _baseUrlLocalhost = "http://localhost:8081";

// alege una
const serverBaseUrl = _baseUrlAndroidEmulator;

// --------------- DB + Repo singletons ---------------

final dbProvider = Provider<AppDb>((ref) {
  final db = AppDb();
  ref.onDispose(db.close);
  return db;
});

final networkProvider = Provider<Network>((ref) => Network());

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(serverBaseUrl);
});

final tripRepoProvider = Provider<TripRepository>((ref) {
  return TripRepository(
    ref.read(dbProvider),
    ref.read(apiClientProvider),
    ref.read(networkProvider),
  );
});

// --------------- Read stream (offline-first) ---------------

final tripsStreamProvider = StreamProvider<List<Trip>>((ref) {
  ref.watch(tripsWsListenerProvider);
  unawaited(_safeInitialRefresh(ref));
  return ref.read(tripRepoProvider).watchTrips();
});

Future<void> _safeInitialRefresh(Ref ref) async {
  try {
    await ref.read(tripRepoProvider).refreshTripsFromServer();
  } catch (e, st) {
    log.e("Initial server refresh failed", error: e, stackTrace: st);
  }
}

// --------------- WebSocket listener ---------------

final tripsWsListenerProvider = Provider<void>((ref) {
  final wsUrl = serverBaseUrl.replaceFirst("http://", "ws://") + "/ws";

  WebSocketChannel? channel;
  StreamSubscription? sub;
  Timer? reconnectTimer;

  bool disposed = false;
  bool connecting = false;

  late void Function() connect;
  late void Function() scheduleReconnect;

  Future<void> cleanup() async {
    reconnectTimer?.cancel();
    reconnectTimer = null;

    try {
      await sub?.cancel();
    } catch (_) {}
    sub = null;

    try {
      await channel?.sink.close();
    } catch (_) {}
    channel = null;
  }

  scheduleReconnect = () {
    if (disposed) return;
    reconnectTimer?.cancel();
    reconnectTimer = Timer(const Duration(seconds: 2), () {
      if (disposed) return;
      connect();
    });
  };

  connect = () {
    if (disposed || connecting) return;
    connecting = true;

    () async {
      try {
        await cleanup();

        log.d("WS connecting: $wsUrl");

        // IMPORTANT: connect poate arunca înainte de listen -> e prins în try/catch
        channel = WebSocketChannel.connect(Uri.parse(wsUrl));

        sub = channel!.stream.listen(
              (msg) async {
            try {
              final decoded = jsonDecode(msg.toString());
              if (decoded is! Map) return;

              final type = decoded["type"]?.toString() ?? "";
              log.d("WS event: $type");

              if (type.startsWith("trip_") ||
                  type.startsWith("checklist_") ||
                  type.startsWith("expense_")) {
                await ref.read(tripRepoProvider).refreshTripsFromServer();
              }
            } catch (e, st) {
              log.e("WS parse failed", error: e, stackTrace: st);
            }
          },
          onError: (e, st) {
            // IMPORTANT: să nu se propage ca Unhandled
            log.e("WS error", error: e, stackTrace: st);
            scheduleReconnect();
          },
          onDone: () {
            log.d("WS closed");
            scheduleReconnect();
          },
          cancelOnError: true,
        );
      } catch (e, st) {
        // IMPORTANT: aici ajung timeouts / SocketException de la connect
        log.e("WS connect failed", error: e, stackTrace: st);
        scheduleReconnect();
      } finally {
        connecting = false;
      }
    }();
  };

  // 🚀 START
  connect();

  // 🧹 DISPOSE
  ref.onDispose(() async {
    disposed = true;
    await cleanup();
  });

  return;
});