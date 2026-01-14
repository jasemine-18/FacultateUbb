import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/trips/trip_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: WayFindApp()));
}

class WayFindApp extends StatelessWidget {
  const WayFindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WayFind',
      theme: ThemeData(useMaterial3: true),
      home: const TripListScreen(),
    );
  }
}
