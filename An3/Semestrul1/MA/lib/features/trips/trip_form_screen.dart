import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/local/app_db.dart';
import 'trips_providers.dart';

class TripFormScreen extends ConsumerStatefulWidget {
  final String? tripId;

  const TripFormScreen.create({super.key}) : tripId = null;
  const TripFormScreen.edit(this.tripId, {super.key});

  @override
  ConsumerState<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends ConsumerState<TripFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _destinationCtrl = TextEditingController();
  final _accommodationCtrl = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  String _transportMode = "plane";
  String _status = "planned";

  bool _saving = false;
  bool _loadingTrip = false;

  int? _createdAtMs;

  @override
  void initState() {
    super.initState();
    _loadIfEdit();
  }

  Future<void> _loadIfEdit() async {
    if (widget.tripId == null) return;

    setState(() => _loadingTrip = true);

    final repo = ref.read(tripRepoProvider);
    final trip = await repo.getTripById(widget.tripId!);

    if (trip != null) {
      _destinationCtrl.text = trip.destination;
      _accommodationCtrl.text = trip.accommodation ?? "";

      _startDate = DateTime.fromMillisecondsSinceEpoch(trip.startDateMs);
      _endDate = DateTime.fromMillisecondsSinceEpoch(trip.endDateMs);

      _transportMode = trip.transportMode;
      _status = trip.status;

      _createdAtMs = trip.createdAtMs;
    }

    if (mounted) setState(() => _loadingTrip = false);
  }

  @override
  void dispose() {
    _destinationCtrl.dispose();
    _accommodationCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    final initial = isStart ? (_startDate ?? DateTime.now()) : (_endDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null) return;

    setState(() {
      if (isStart) {
        _startDate = picked;
      } else {
        _endDate = picked;
      }
    });
  }

  Future<void> _saveTrip() async {
    if (!_formKey.currentState!.validate()) return;

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select start and end dates.")),
      );
      return;
    }

    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("End date must be after start date.")),
      );
      return;
    }

    setState(() => _saving = true);

    final repo = ref.read(tripRepoProvider);
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final isEdit = widget.tripId != null;
    final id = isEdit ? widget.tripId! : const Uuid().v4();

    // ✅ IMPORTANT: complete the fields that your repository sends to the server
    final trip = TripsCompanion(
      id: drift.Value(id),
      destination: drift.Value(_destinationCtrl.text.trim()),
      startDateMs: drift.Value(_startDate!.millisecondsSinceEpoch),
      endDateMs: drift.Value(_endDate!.millisecondsSinceEpoch),
      transportMode: drift.Value(_transportMode),
      accommodation: drift.Value(
        _accommodationCtrl.text.trim().isEmpty ? null : _accommodationCtrl.text.trim(),
      ),

      // ✅ defaults for server payload (avoid null->double crash)
      budgetPlanned: const drift.Value(0.0),
      budgetSpent: const drift.Value(0.0),
      packingList: const drift.Value(""),
      placesToVisit: const drift.Value(""),
      placesToEat: const drift.Value(""),
      notes: const drift.Value(""),

      status: drift.Value(_status),

      createdAtMs: drift.Value(isEdit ? (_createdAtMs ?? nowMs) : nowMs),
      updatedAtMs: drift.Value(nowMs),

      pendingSync: const drift.Value(true),
    );

    try {
      if (isEdit) {
        await repo.updateTrip(trip);
      } else {
        await repo.createTrip(trip);
      }

      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isEdit
                ? "Could not update trip. Please try again."
                : "Could not save trip. Please try again."),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.tripId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Trip" : "Create Trip")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loadingTrip
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _destinationCtrl,
                decoration: const InputDecoration(labelText: "Destination"),
                validator: (v) =>
                v == null || v.trim().isEmpty ? "Destination is required" : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _transportMode,
                decoration: const InputDecoration(labelText: "Transportation"),
                items: const [
                  DropdownMenuItem(value: "plane", child: Text("Plane")),
                  DropdownMenuItem(value: "train", child: Text("Train")),
                  DropdownMenuItem(value: "car", child: Text("Car")),
                  DropdownMenuItem(value: "bus", child: Text("Bus")),
                ],
                onChanged: (v) => setState(() => _transportMode = v ?? "plane"),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _accommodationCtrl,
                decoration: const InputDecoration(labelText: "Accommodation (optional)"),
              ),
              const SizedBox(height: 12),

              InputDecorator(
                decoration: const InputDecoration(labelText: "Trip dates"),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => _pickDate(true),
                      child: Text(
                        _startDate == null
                            ? "Start date"
                            : _startDate!.toLocal().toString().split(" ").first,
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: () => _pickDate(false),
                      child: Text(
                        _endDate == null
                            ? "End date"
                            : _endDate!.toLocal().toString().split(" ").first,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: "Status"),
                items: const [
                  DropdownMenuItem(value: "planned", child: Text("Planned")),
                  DropdownMenuItem(value: "completed", child: Text("Completed")),
                ],
                onChanged: (v) => setState(() => _status = v ?? "planned"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saving ? null : _saveTrip,
                child: Text(_saving
                    ? "Saving..."
                    : (isEdit ? "Update Trip" : "Create Trip")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
