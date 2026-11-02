import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';

/// Goldens for the Tajik car, whose letters pick the livery: `TT` amber.
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final loader = FontLoader('Roboto');
    final file = File('/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf');
    if (file.existsSync()) {
      loader.addFont(file.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  for (final (name, values) in const <(String, List<String?>)>[
    ('car_private', ['9999', 'MK', '02']),
    ('car_transport', ['9006', 'TT', '05']),
  ]) {
    testWidgets('tj.$name', (tester) async {
      final controller = PlateController.fromValues(
        TajikistanPlates.car,
        values,
      );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: RepaintBoundary(
              child: SizedBox(
                width: 420,
                child: PlateCanvas(
                  spec: TajikistanPlates.car,
                  theme: TajikistanThemes.civilian,
                  controller: controller,
                  onChooseCharacter: (_) async => null,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(RepaintBoundary).first,
        matchesGoldenFile('goldens/tajikistan/$name.png'),
      );
    });
  }
}
