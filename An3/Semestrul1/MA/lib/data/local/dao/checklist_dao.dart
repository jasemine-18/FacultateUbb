import 'package:drift/drift.dart';
import '../app_db.dart';
import '../tables.dart';

part 'checklist_dao.g.dart';

@DriftAccessor(tables: [ChecklistItems])
class ChecklistDao extends DatabaseAccessor<AppDb> with _$ChecklistDaoMixin {
  ChecklistDao(super.db);

  Stream<List<ChecklistItem>> watchByTrip(String tripId) {
    return (select(checklistItems)
      ..where((c) => c.tripId.equals(tripId))
      ..orderBy([(c) => OrderingTerm.asc(c.orderIndex)]))
        .watch();
  }

  Future<void> insertItem(ChecklistItemsCompanion data) =>
      into(checklistItems).insert(data);

  Future<bool> updateItem(ChecklistItemsCompanion data) =>
      update(checklistItems).replace(data);

  Future<int> deleteById(String id) =>
      (delete(checklistItems)..where((c) => c.id.equals(id))).go();

  Future<int> deleteByTripId(String tripId) =>
      (delete(checklistItems)..where((c) => c.tripId.equals(tripId))).go();

}
