import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/log.dart';
import '../../data/local/app_db.dart';
import 'trips_providers.dart';
import 'trip_form_screen.dart';
import 'trip_details_screen.dart';

class TripListScreen extends ConsumerWidget {
  const TripListScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, Trip t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete trip?"),
        content: Text('Delete "${t.destination}"?\nThis will also delete checklist & expenses.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (ok != true) return;

    try {
      await ref.read(tripRepoProvider).deleteTripCascade(t.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Trip deleted.")),
        );
      }
    } catch (e, st) {
      log.e("Trip delete failed", error: e, stackTrace: st);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not delete trip. Please try again.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripsAsync = ref.watch(tripsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("WayFind - Trips")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TripFormScreen.create()),
        ),
        child: const Icon(Icons.add),
      ),
      body: tripsAsync.when(
        data: (trips) {
          if (trips.isEmpty) {
            return const Center(child: Text("No trips yet. Tap + to add one."));
          }

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (_, i) {
              final t = trips[i];

              return ListTile(
                title: Text(t.destination),
                subtitle: Text("${t.status} • ${t.transportMode}"),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TripDetailsScreen(
                      tripId: t.id,
                      tripTitle: t.destination,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TripFormScreen.edit(t.id)),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _confirmDelete(context, ref, t),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          log.e("Trips read failed", error: e, stackTrace: st);
          return const Center(
            child: Text("We couldn't load your trips. Please try again."),
          );
        },
      ),
    );
  }
}
