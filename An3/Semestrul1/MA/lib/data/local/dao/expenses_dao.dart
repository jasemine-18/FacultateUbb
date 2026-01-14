import 'package:drift/drift.dart';
import '../app_db.dart';
import '../tables.dart';

part 'expenses_dao.g.dart';

@DriftAccessor(tables: [Expenses])
class ExpensesDao extends DatabaseAccessor<AppDb> with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  Stream<List<Expense>> watchByTrip(String tripId) {
    return (select(expenses)
      ..where((e) => e.tripId.equals(tripId))
      ..orderBy([(e) => OrderingTerm.desc(e.dateMs)]))
        .watch();
  }

  Future<void> insertExpense(ExpensesCompanion data) =>
      into(expenses).insert(data);

  Future<bool> updateExpense(ExpensesCompanion data) =>
      update(expenses).replace(data);

  Future<int> deleteById(String id) =>
      (delete(expenses)..where((e) => e.id.equals(id))).go();

  Future<int> deleteByTripId(String tripId) =>
      (delete(expenses)..where((e) => e.tripId.equals(tripId))).go();

}
