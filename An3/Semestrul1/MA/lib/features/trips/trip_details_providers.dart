import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/checklist_repository.dart';
import '../../repositories/expense_repository.dart';
import 'trips_providers.dart';
import '../../data/local/app_db.dart';

final checklistRepoProvider = Provider<ChecklistRepository>((ref) {
  return ChecklistRepository(ref.read(dbProvider));
});

final expenseRepoProvider = Provider<ExpenseRepository>((ref) {
  return ExpenseRepository(ref.read(dbProvider));
});

final checklistByTripProvider =
StreamProvider.family<List<ChecklistItem>, String>((ref, tripId) {
  return ref.read(checklistRepoProvider).watchByTrip(tripId);
});

final expensesByTripProvider =
StreamProvider.family<List<Expense>, String>((ref, tripId) {
  return ref.read(expenseRepoProvider).watchByTrip(tripId);
});
