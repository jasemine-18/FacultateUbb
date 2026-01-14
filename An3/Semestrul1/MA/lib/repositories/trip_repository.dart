import 'dart:async';

import 'package:drift/drift.dart' as drift;

import '../core/log.dart';
import '../core/network.dart';
import '../data/local/app_db.dart';
import '../data/remote/api_client.dart';

class TripRepository {
  final AppDb db;
  final ApiClient api;
  final Network net;

  TripRepository(this.db, this.api, this.net);

  // READ (observer): UI listens to this stream (OFFLINE-FIRST)
  Stream<List<Trip>> watchTrips() => db.tripsDao.watchAllTrips();

  Future<Trip?> getTripById(String id) => db.tripsDao.getTripById(id);

  /// Call once on app start or when WS notifies changes.
  /// Pulls from server and upserts to local DB.
  /// IMPORTANT: should NOT crash the app if server is down.
  Future<void> refreshTripsFromServer() async {
    if (!await net.isOnline()) {
      log.d("refreshTripsFromServer skipped (no internet)");
      return;
    }

    try {
      final list = await api.getTrips();

      for (final x in list) {
        final m = (x as Map).cast<String, dynamic>();
        await db.tripsDao.upsertTrip(_tripJsonToCompanion(m));
      }

      log.d("Trips refreshed from server: ${list.length}");
    } catch (e, st) {
      // server down / timeout -> keep offline data, don't crash
      log.e("Refresh trips failed (ignored, offline-first)", error: e, stackTrace: st);
    }
  }

  // -------------------- CREATE --------------------
  /// Online: POST to server, upsert returned trip.
  /// Offline OR server-down: insert locally with pendingSync=true.
  Future<void> createTrip(TripsCompanion trip) async {
    // always ensure local fallback has a local id
    final localId = trip.id.value;

    if (await net.isOnline()) {
      try {
        final created = await api.createTrip(_toServerCreate(trip));
        await db.tripsDao.upsertTrip(_tripJsonToCompanion(created));
        log.d("Trip created on server: ${created['id']}");
        return;
      } catch (e, st) {
        // IMPORTANT: this is the fix you needed
        log.e("Server create failed -> saving offline", error: e, stackTrace: st);
      }
    }

    // Offline path (or fallback)
    try {
      await db.tripsDao.insertTrip(
        trip.copyWith(pendingSync: const drift.Value(true)),
      );
      log.d("Trip created offline (pendingSync=true): $localId");
    } catch (e, st) {
      log.e("Create trip offline failed", error: e, stackTrace: st);
      rethrow;
    }
  }

  // -------------------- UPDATE --------------------
  /// Online: PUT; Offline OR server-down: update locally pendingSync=true.
  Future<void> updateTrip(TripsCompanion trip) async {
    final id = trip.id.value;

    if (await net.isOnline()) {
      try {
        final updated = await api.updateTrip(id, _toServerUpdate(trip));
        await db.tripsDao.upsertTrip(_tripJsonToCompanion(updated));
        log.d("Trip updated on server: $id");
        return;
      } catch (e, st) {
        log.e("Server update failed -> saving offline", error: e, stackTrace: st);
      }
    }

    try {
      await db.tripsDao.updateTrip(
        trip.copyWith(pendingSync: const drift.Value(true)),
      );
      log.d("Trip updated offline (pendingSync=true): $id");
    } catch (e, st) {
      log.e("Update trip offline failed", error: e, stackTrace: st);
      rethrow;
    }
  }

  // -------------------- DELETE --------------------
  /// Online: delete server; Offline: delete locally (pending server sync not implemented here).
  Future<void> deleteTripCascade(String tripId) async {
    if (await net.isOnline()) {
      try {
        await api.deleteTrip(tripId);
        log.d("Trip deleted on server: $tripId");
      } catch (e, st) {
        // If server is down, still delete locally (offline-first behavior)
        log.e("Server delete failed -> deleting locally anyway", error: e, stackTrace: st);
      }
    } else {
      log.d("Offline delete (server not updated): $tripId");
    }

    try {
      await db.transaction(() async {
        await db.expensesDao.deleteByTripId(tripId);
        await db.checklistDao.deleteByTripId(tripId);
        await db.tripsDao.deleteTripById(tripId);
      });

      log.d("Trip cascade deleted locally: $tripId");
    } catch (e, st) {
      log.e("Cascade delete trip failed", error: e, stackTrace: st);
      rethrow;
    }
  }

  // keep old API if called somewhere
  Future<void> deleteTrip(String id) => deleteTripCascade(id);

  // -------------------- Mapping helpers --------------------

  TripsCompanion _tripJsonToCompanion(Map<String, dynamic> m) {
    int _asInt(dynamic v, [int fallback = 0]) =>
        v is int ? v : int.tryParse(v?.toString() ?? '') ?? fallback;

    double _asDouble(dynamic v, [double fallback = 0.0]) {
      if (v == null) return fallback;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse(v.toString()) ?? fallback;
    }

    String _asString(dynamic v, [String fallback = ""]) {
      if (v == null) return fallback;
      final s = v.toString();
      if (s.trim().isEmpty || s == "null") return fallback;
      return s;
    }

    String? _asStringOrNull(dynamic v) {
      if (v == null) return null;
      final s = v.toString();
      if (s.trim().isEmpty || s == "null") return null;
      return s;
    }

    return TripsCompanion(
      id: drift.Value(_asString(m['id'])),
      destination: drift.Value(_asString(m['destination'])),
      startDateMs: drift.Value(_asInt(m['startDateMs'])),
      endDateMs: drift.Value(_asInt(m['endDateMs'])),
      transportMode: drift.Value(_asString(m['transportMode'], "plane")),

      // dacă în DB e nullable, păstrează așa:
      accommodation: drift.Value(_asStringOrNull(m['accommodation'])),

      // ✅ NON-nullable în DB -> trebuie double (nu double?)
      budgetPlanned: drift.Value(_asDouble(m['budgetPlanned'], 0.0)),
      budgetSpent: drift.Value(_asDouble(m['budgetSpent'], 0.0)),

      // ✅ NON-nullable în DB -> trebuie String (nu String?)
      packingList: drift.Value(_asString(m['packingList'], "")),
      placesToVisit: drift.Value(_asString(m['placesToVisit'], "")),
      placesToEat: drift.Value(_asString(m['placesToEat'], "")),
      notes: drift.Value(_asString(m['notes'], "")),
      status: drift.Value(_asString(m['status'], "planned")),

      createdAtMs: drift.Value(_asInt(m['createdAtMs'])),
      updatedAtMs: drift.Value(_asInt(m['updatedAtMs'])),

      pendingSync: const drift.Value(false),
    );
  }

  Map<String, dynamic> _toServerCreate(TripsCompanion t) {
    // IMPORTANT: use `.value` but allow nulls (server can default)
    return {
      "destination": t.destination.value,
      "startDateMs": t.startDateMs.value,
      "endDateMs": t.endDateMs.value,
      "transportMode": t.transportMode.value,
      "accommodation": t.accommodation.value,

      // optional fields (send null if not set; server should accept)
      "placesToVisit": t.placesToVisit.value,
      "placesToEat": t.placesToEat.value,
      "notes": t.notes.value,
      "status": t.status.value,
    };
  }

  Map<String, dynamic> _toServerUpdate(TripsCompanion t) {
    // IMPORTANT: avoid crashing on null .value for optional doubles/strings
    return {
      "destination": t.destination.value,
      "startDateMs": t.startDateMs.value,
      "endDateMs": t.endDateMs.value,
      "transportMode": t.transportMode.value,
      "accommodation": t.accommodation.value,

      "budgetPlanned": t.budgetPlanned.value,
      "budgetSpent": t.budgetSpent.value,
      "packingList": t.packingList.value,

      "placesToVisit": t.placesToVisit.value,
      "placesToEat": t.placesToEat.value,
      "notes": t.notes.value,
      "status": t.status.value,
    };
  }
}