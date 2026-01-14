import 'package:drift/drift.dart';
import '../app_db.dart';
import '../tables.dart';
part 'trips_dao.g.dart';

@DriftAccessor(tables: [Trips, ChecklistItems, Expenses])
class TripsDao extends DatabaseAccessor<AppDb> with _$TripsDaoMixin {
  TripsDao(super.db);

  // READ in a list via observer/stream:
  Stream<List<Trip>> watchAllTrips() {
    return (select(trips)..orderBy([(t) => OrderingTerm.desc(t.updatedAtMs)])).watch();
  }

  Future<Trip?> getTripById(String id) {
    return (select(trips)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  // CREATE:
  Future<void> insertTrip(TripsCompanion data) => into(trips).insert(data);

  // UPDATE (reuses the same db element, same id):
  Future<bool> updateTrip(TripsCompanion data) => update(trips).replace(data);

  // DELETE by id only:
  Future<int> deleteTripById(String id) =>
      (delete(trips)..where((t) => t.id.equals(id))).go();

  Future<void> deleteTripCascade(String tripId) async {
    await transaction(() async {
      await (delete(checklistItems)..where((c) => c.tripId.equals(tripId))).go();
      await (delete(expenses)..where((e) => e.tripId.equals(tripId))).go();
      await (delete(trips)..where((t) => t.id.equals(tripId))).go();
    });
  }

  Future<void> upsertTrip(TripsCompanion data) {
    return into(trips).insert(
      data,
      mode: InsertMode.insertOrReplace, // simplu și safe pentru rubrică
    );
  }

  Future<List<Trip>> getPendingTrips() {
    return (select(trips)..where((t) => t.pendingSync.equals(true))).get();
  }

}
