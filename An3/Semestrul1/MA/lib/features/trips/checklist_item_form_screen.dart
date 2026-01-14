import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/local/app_db.dart';
import 'trip_details_providers.dart';
import '../trips/trips_providers.dart';


class ChecklistItemFormScreen extends ConsumerStatefulWidget {
  final String tripId;
  final String? itemId;

  const ChecklistItemFormScreen.create({super.key, required this.tripId}) : itemId = null;
  const ChecklistItemFormScreen.edit({super.key, required this.tripId, required this.itemId});

  @override
  ConsumerState<ChecklistItemFormScreen> createState() => _ChecklistItemFormScreenState();
}

class _ChecklistItemFormScreenState extends ConsumerState<ChecklistItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _textCtrl = TextEditingController();

  bool _saving = false;
  bool _loading = false;

  int? _createdAtMs;
  int _orderIndex = 0;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _loadIfEdit();
  }

  Future<void> _loadIfEdit() async {
    if (widget.itemId == null) return;

    setState(() => _loading = true);

    final db = ref.read(dbProvider);
    final row = await (db.select(db.checklistItems)..where((t) => t.id.equals(widget.itemId!)))
        .getSingleOrNull();

    if (row != null) {
      _textCtrl.text = row.textValue;
      _done = row.done;
      _orderIndex = row.orderIndex;
      _createdAtMs = row.createdAtMs;
    }

    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final repo = ref.read(checklistRepoProvider);
    final isEdit = widget.itemId != null;
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final id = isEdit ? widget.itemId! : const Uuid().v4();

    final item = ChecklistItemsCompanion(
      id: drift.Value(id),
      tripId: drift.Value(widget.tripId),
      textValue: drift.Value(_textCtrl.text.trim()),
      done: drift.Value(_done),
      orderIndex: drift.Value(_orderIndex),
      createdAtMs: drift.Value(isEdit ? (_createdAtMs ?? nowMs) : nowMs),
      pendingSync: const drift.Value(true),
    );

    try {
      if (isEdit) {
        await repo.update(item);
      } else {
        await repo.create(item);
      }
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEdit ? "Could not update item." : "Could not add item.")),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.itemId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Checklist Item" : "Add Checklist Item")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textCtrl,
                decoration: const InputDecoration(labelText: "Task"),
                validator: (v) =>
                v == null || v.trim().isEmpty ? "Task is required" : null,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text("Done"),
                value: _done,
                onChanged: (v) => setState(() => _done = v),
              ),
              const Spacer(),
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
