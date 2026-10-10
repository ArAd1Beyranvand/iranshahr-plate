import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per design and livery, rendered with real bold faces so the ink
/// can be measured against the article's artwork.
void main() {
  setUpAll(() async {
    // The gallery app's Vazirmatn, Latin and Arabic merged into one bold face
    // (the same file sudan_plate uses): the test engine never falls back
    // between fonts, so one file has to hold both scripts.
    final loader = FontLoader('Roboto')
      ..addFont(
        File(
          'test/fonts/Vazirmatn-Bold-merged.ttf',
        ).readAsBytes().then((b) => ByteData.view(b.buffer)),
      );
    await loader.load();
  });

  final cases = <(String, PlateSpec, PlateTheme, String)>[
    ('private_4_1', OmanPlates.fourDigitOneLetter, OmanThemes.private, '4517A'),
    (
      'private_4_2',
      OmanPlates.fourDigitTwoLetter,
      OmanThemes.private,
      '4517BM',
    ),
    (
      'private_5_1',
      OmanPlates.fiveDigitOneLetter,
      OmanThemes.private,
      '91169A',
    ),
    (
      'private_5_2',
      OmanPlates.fiveDigitTwoLetter,
      OmanThemes.private,
      '91169BM',
    ),
    ('taxi_4_2', OmanPlates.fourDigitTwoLetter, OmanThemes.taxi, '1255KK'),
    ('taxi_5_1', OmanPlates.fiveDigitOneLetter, OmanThemes.taxi, '91169K'),
  ];

  test('every spec has a golden', () {
    expect(cases.map((c) => c.$2).toSet(), OmanPlates.all.toSet());
  });

  for (final (name, spec, theme, values) in cases) {
    testWidgets(name, (tester) async {
      final controller = PlateController.fromValues(
        spec,
        values.split('').toList(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 520,
                height: 520 * spec.canvasHeight / spec.canvasWidth,
                child: PlateView(
                  controller: controller,
                  theme: theme,
                  country: OmanCountry.oman,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/om_$name.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }

  PlateEntry e(PlateSpec s, String v) => PlateEntry(
    spec: s,
    values: v.split('').map((c) => c == '_' ? null : c).toList(),
  );

  test('complete plate is valid, an empty slot is flagged', () {
    const v = OmanPlateValidator();
    final spec = OmanPlates.fourDigitTwoLetter;
    expect(v.validate(e(spec, '4517BM')).isValid, isTrue);
    expect(v.validate(e(spec, '451_BM')).isValid, isFalse);
    expect(v.validate(e(spec, '4517B_')).isValid, isFalse);
  });

  test('every spec passes debugValidateSpec', () {
    for (final spec in OmanPlates.all) {
      expect(debugValidateSpec(spec), isTrue);
    }
  });
}
