import 'package:plate_core/plate_core.dart';
import 'package:flutter/material.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iranshahr Plates',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PlatesScreen(),
    );
  }
}

class PlatesScreen extends StatelessWidget {
  const PlatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bahrain & Azerbaijan Plates')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Bahrain Plates', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: PlateCanvas(
              spec: BahrainPlates.eu,
              theme: BahrainThemes.civilian,
              mode: PlateMode.display,
              onChooseCharacter: (_) => Future.value(null),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PlateCanvas(
              spec: BahrainPlates.us,
              theme: BahrainThemes.civilian,
              mode: PlateMode.display,
              onChooseCharacter: (_) => Future.value(null),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Azerbaijan Plates',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: PlateCanvas(
              spec: AzerbaijanPlates.car,
              theme: AzerbaijanThemes.civilian,
              mode: PlateMode.display,
              onChooseCharacter: (_) => Future.value(null),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PlateCanvas(
              spec: AzerbaijanPlates.bicycle,
              theme: AzerbaijanThemes.transport,
              mode: PlateMode.display,
              onChooseCharacter: (_) => Future.value(null),
            ),
          ),
        ],
      ),
    );
  }
}
