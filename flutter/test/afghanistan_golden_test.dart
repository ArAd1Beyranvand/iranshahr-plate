import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';

/// Goldens for the Afghan specs whose province block and livery come from the
/// values: the block's name and code are slots, and `T` turns the car yellow.
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final loader = FontLoader('Roboto');
    for (final path in const [
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
      '/usr/share/fonts/truetype/noto/NotoSansArabic-Bold.ttf',
    ]) {
      final file = File(path);
      if (!file.existsSync()) continue;
      loader.addFont(file.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  for (final (name, spec, values) in <(String, PlateSpec, List<String?>)>[
    ('car_private', AfghanistanPlates.car, ['12346', 'P', 'HRT']),
    ('car_taxi', AfghanistanPlates.car, ['123', 'T', 'NGR']),
    ('cycle', AfghanistanPlates.cycle, ['1234', 'R', 'KBL']),
    ('car_duplicate', AfghanistanPlates.car, ['12346', 'D', 'HRT']),
    ('kabul6', AfghanistanPlates.kabul6, ['5', '12346', 'P']),
    ('temporary', AfghanistanPlates.temporary, ['12346', 'HRT']),
  ]) {
    testWidgets('af.$name', (tester) async {
      final controller = PlateController.fromValues(spec, values);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          home: Center(
            child: RepaintBoundary(
              child: SizedBox(
                width: 420,
                child: PlateCanvas(
                  spec: spec,
                  theme: AfghanistanThemes.civilian,
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
        matchesGoldenFile('goldens/afghanistan/$name.png'),
      );
    });
  }
}
