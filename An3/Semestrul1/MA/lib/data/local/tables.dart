import 'package:drift/drift.dart';

@DataClassName('Trip')
class Trips extends Table {
  TextColumn get id => text()(); // UUID (managed by app/db)
  TextColumn get destination => text()();

  IntColumn get startDateMs => integer()(); // epoch ms
  IntColumn get endDateMs => integer()();

  TextColumn get transportMode =>
      text().withDefault(const Constant("plane"))();

  TextColumn get accommodation => text().nullable()();

  RealColumn get budgetPlanned => real().withDefault(const Constant(0))();
  RealColumn get budgetSpent => real().withDefault(const Constant(0))();

  // IMPORTANT: must end with ();  + named(...) to be safe
  TextColumn get packingList => text()
      .named('packing_list')
      .withDefault(const Constant(""))();

  TextColumn get placesToVisit => text()
      .named('places_to_visit')
      .withDefault(const Constant(""))();

  TextColumn get placesToEat => text()
      .named('places_to_eat')
      .withDefault(const Constant(""))();

  TextColumn get notes => text()
      .named('notes_text')
      .withDefault(const Constant(""))();

  TextColumn get status =>
      text().withDefault(const Constant("planned"))();

  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  BoolColumn get pendingSync =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ChecklistItem')
class ChecklistItems extends Table {
  TextColumn get id => text()();
  TextColumn get tripId => text()();

  TextColumn get textValue => text().named('text_value')();
  BoolColumn get done => boolean().withDefault(const Constant(false))();

  IntColumn get orderIndex => integer().withDefault(const Constant(0))();
  IntColumn get createdAtMs => integer()();

  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Expense')
class Expenses extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get tripId => text()(); // FK to Trips.id

  TextColumn get category => text()(); // transport/food/lodging/tickets/other
  RealColumn get amount => real()();
  TextColumn get currency => text().withDefault(const Constant("RON"))();

  IntColumn get dateMs => integer()();
  TextColumn get description => text().withDefault(const Constant(""))();

  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

