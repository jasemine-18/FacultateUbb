import '../core/log.dart';
import '../data/local/app_db.dart';

class ExpenseRepository {
  final AppDb db;
  ExpenseRepository(this.db);

  Stream<List<Expense>> watchByTrip(String tripId) =>
      db.expensesDao.watchByTrip(tripId);

  Future<void> create(ExpensesCompanion e) async {
    try {
      await db.expensesDao.insertExpense(e);
      log.d("Expense created: ${e.id.value}");
    } catch (err, st) {
      log.e("Create expense failed", error: err, stackTrace: st);
      rethrow;
    }
  }

  Future<void> update(ExpensesCompanion e) async {
    try {
      await db.expensesDao.updateExpense(e);
      log.d("Expense updated: ${e.id.value}");
    } catch (err, st) {
      log.e("Update expense failed", error: err, stackTrace: st);
      rethrow;
    }
  }

  Future<void> deleteById(String id) async {
    try {
      await db.expensesDao.deleteById(id);
      log.d("Expense deleted: $id");
    } catch (err, st) {
      log.e("Delete expense failed", error: err, stackTrace: st);
      rethrow;
    }
  }
}
