import '../core/log.dart';
import '../data/local/app_db.dart';

class ChecklistRepository {
  final AppDb db;
  ChecklistRepository(this.db);

  Stream<List<ChecklistItem>> watchByTrip(String tripId) =>
      db.checklistDao.watchByTrip(tripId);

  Future<void> create(ChecklistItemsCompanion item) async {
    try {
      await db.checklistDao.insertItem(item);
      log.d("Checklist item created: ${item.id.value}");
    } catch (e, st) {
      log.e("Create checklist item failed", error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> update(ChecklistItemsCompanion item) async {
    try {
      await db.checklistDao.updateItem(item);
      log.d("Checklist item updated: ${item.id.value}");
    } catch (e, st) {
      log.e("Update checklist item failed", error: e, stackTrace: st);
      rethrow;
    }
  }

  Future<void> deleteById(String id) async {
    try {
      await db.checklistDao.deleteById(id);
      log.d("Checklist item deleted: $id");
    } catch (e, st) {
      log.e("Delete checklist item failed", error: e, stackTrace: st);
      rethrow;
    }
  }
}
