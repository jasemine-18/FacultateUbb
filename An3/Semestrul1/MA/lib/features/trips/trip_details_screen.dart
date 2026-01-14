import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;

import '../../core/log.dart';
import '../../data/local/app_db.dart';
import 'checklist_item_form_screen.dart';
import 'expense_form_screen.dart';
import 'trip_details_providers.dart';
import 'trip_form_screen.dart';


class TripDetailsScreen extends ConsumerWidget {
  final String tripId;
  final String tripTitle;

  const TripDetailsScreen({
    super.key,
    required this.tripId,
    required this.tripTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checklistAsync = ref.watch(checklistByTripProvider(tripId));
    final expensesAsync = ref.watch(expensesByTripProvider(tripId));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tripTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TripFormScreen.edit(tripId)),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Checklist"),
              Tab(text: "Expenses"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            // CHECKLIST TAB
            checklistAsync.when(
              data: (items) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChecklistItemFormScreen.create(tripId: tripId),
                      ),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  body: items.isEmpty
                      ? const Center(child: Text("No checklist items yet. Tap + to add one."))
                      : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final it = items[i];
                      return ListTile(
                        leading: Checkbox(
                          value: it.done,
                          onChanged: (v) async {
                            try {
                              await ref.read(checklistRepoProvider).update(
                                ChecklistItemsCompanion(
                                  id: drift.Value(it.id),
                                  tripId: drift.Value(it.tripId),
                                  textValue: drift.Value(it.textValue),
                                  done: drift.Value(v ?? false),
                                  orderIndex: drift.Value(it.orderIndex),
                                  createdAtMs: drift.Value(it.createdAtMs),
                                  pendingSync: const drift.Value(true),
                                ),
                              );
                            } catch (e, st) {
                              log.e("Toggle checklist failed", error: e, stackTrace: st);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Could not update item.")),
                                );
                              }
                            }
                          },
                        ),
                        title: Text(it.textValue),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChecklistItemFormScreen.edit(
                                    tripId: tripId,
                                    itemId: it.id,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDeleteChecklist(
                                context,
                                ref,
                                it.id,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) {
                log.e("Checklist read failed", error: e, stackTrace: st);
                return const Center(child: Text("Could not load checklist."));
              },
            ),

            // EXPENSES TAB
            expensesAsync.when(
              data: (items) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ExpenseFormScreen.create(tripId: tripId),
                      ),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  body: items.isEmpty
                      ? const Center(child: Text("No expenses yet. Tap + to add one."))
                      : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final ex = items[i];
                      return ListTile(
                        title: Text("${ex.category} • ${ex.amount.toStringAsFixed(2)} ${ex.currency}"),
                        subtitle: Text(ex.description.isEmpty ? "—" : ex.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ExpenseFormScreen.edit(
                                    tripId: tripId,
                                    expenseId: ex.id,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _confirmDeleteExpense(
                                context,
                                ref,
                                ex.id,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) {
                log.e("Expenses read failed", error: e, stackTrace: st);
                return const Center(child: Text("Could not load expenses."));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteChecklist(BuildContext context, WidgetRef ref, String id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete checklist item?"),
        content: const Text("This will remove the item from the checklist."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Delete")),
        ],
      ),
    );

    if (ok != true) return;

    try {
      await ref.read(checklistRepoProvider).deleteById(id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Checklist item deleted.")),
        );
      }
    } catch (e, st) {
      log.e("Delete checklist failed", error: e, stackTrace: st);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not delete item.")),
        );
      }
    }
  }

  Future<void> _confirmDeleteExpense(BuildContext context, WidgetRef ref, String id) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete expense?"),
        content: const Text("This will remove the expense from the trip."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Delete")),
        ],
      ),
    );

    if (ok != true) return;

    try {
      await ref.read(expenseRepoProvider).deleteById(id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Expense deleted.")),
        );
      }
    } catch (e, st) {
      log.e("Delete expense failed", error: e, stackTrace: st);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not delete expense.")),
        );
      }
    }
  }
}
