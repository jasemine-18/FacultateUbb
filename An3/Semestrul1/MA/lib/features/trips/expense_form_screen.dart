import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/local/app_db.dart';
import 'trip_details_providers.dart';
import '../trips/trips_providers.dart';


class ExpenseFormScreen extends ConsumerStatefulWidget {
  final String tripId;
  final String? expenseId;

  const ExpenseFormScreen.create({super.key, required this.tripId}) : expenseId = null;
  const ExpenseFormScreen.edit({super.key, required this.tripId, required this.expenseId});

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _category = "food";
  final _amountCtrl = TextEditingController();
  final _currencyCtrl = TextEditingController(text: "RON");
  final _descCtrl = TextEditingController();

  DateTime? _date;
  bool _saving = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadIfEdit();
  }

  Future<void> _loadIfEdit() async {
    if (widget.expenseId == null) return;

    setState(() => _loading = true);

    final db = ref.read(dbProvider);
    final row = await (db.select(db.expenses)..where((t) => t.id.equals(widget.expenseId!)))
        .getSingleOrNull();

    if (row != null) {
      _category = row.category;
      _amountCtrl.text = row.amount.toString();
      _currencyCtrl.text = row.currency;
      _descCtrl.text = row.description;
      _date = DateTime.fromMillisecondsSinceEpoch(row.dateMs);
    }

    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _currencyCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
    setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (_date == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date.")),
      );
      return;
    }

    setState(() => _saving = true);

    final repo = ref.read(expenseRepoProvider);
    final isEdit = widget.expenseId != null;
    final id = isEdit ? widget.expenseId! : const Uuid().v4();

    final amount = double.tryParse(_amountCtrl.text.trim());
    if (amount == null) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Amount must be a number.")),
      );
      return;
    }

    final e = ExpensesCompanion(
      id: drift.Value(id),
      tripId: drift.Value(widget.tripId),
      category: drift.Value(_category),
      amount: drift.Value(amount),
      currency: drift.Value(_currencyCtrl.text.trim().isEmpty ? "RON" : _currencyCtrl.text.trim()),
      dateMs: drift.Value(_date!.millisecondsSinceEpoch),
      description: drift.Value(_descCtrl.text.trim()),
      pendingSync: const drift.Value(true),
    );

    try {
      if (isEdit) {
        await repo.update(e);
      } else {
        await repo.create(e);
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEdit ? "Could not update expense." : "Could not add expense.")),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.expenseId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Expense" : "Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: const InputDecoration(labelText: "Category"),
                items: const [
                  DropdownMenuItem(value: "transport", child: Text("Transport")),
                  DropdownMenuItem(value: "food", child: Text("Food")),
                  DropdownMenuItem(value: "lodging", child: Text("Lodging")),
                  DropdownMenuItem(value: "tickets", child: Text("Tickets")),
                  DropdownMenuItem(value: "other", child: Text("Other")),
                ],
                onChanged: (v) => setState(() => _category = v ?? "food"),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _amountCtrl,
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) =>
                v == null || v.trim().isEmpty ? "Amount is required" : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _currencyCtrl,
                decoration: const InputDecoration(labelText: "Currency"),
              ),
              const SizedBox(height: 12),

              InputDecorator(
                decoration: const InputDecoration(labelText: "Date"),
                child: TextButton(
                  onPressed: _pickDate,
                  child: Text(
                    _date == null
                        ? "Select date"
                        : _date!.toLocal().toString().split(" ").first,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _descCtrl,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saving ? null : _save,
                child: Text(_saving ? "Saving..." : (isEdit ? "Update" : "Add")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
