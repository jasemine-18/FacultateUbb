import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift/drift.dart' as drift;

import 'tables.dart';
import 'dao/trips_dao.dart';
import 'dao/checklist_dao.dart';
import 'dao/expenses_dao.dart';


part 'app_db.g.dart';

@drift.DriftDatabase(
  tables: [Trips, ChecklistItems, Expenses],
  daos: [TripsDao, ChecklistDao, ExpensesDao],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  drift.MigrationStrategy get migration => drift.MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
        await m.createAll();
        },
  );

  static drift.QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'wayfind.sqlite',
      native: const DriftNativeOptions(
        shareAcrossIsolates: true,
      ),
    );
  }
}
