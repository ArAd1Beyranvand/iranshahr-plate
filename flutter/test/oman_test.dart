import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';
import 'package:plate_core/testing.dart';

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
    ('private_4_1', OmanPlates.standard, OmanThemes.private, '4517 A'),
    ('private_4_2', OmanPlates.standard, OmanThemes.private, '4517 BM'),
    ('private_5_1', OmanPlates.standard, OmanThemes.private, '91169 A'),
    ('private_5_2', OmanPlates.standard, OmanThemes.private, '91169 BM'),
    ('taxi_4_2', OmanPlates.standard, OmanThemes.taxi, '1255 KK'),
    ('taxi_5_1', OmanPlates.standard, OmanThemes.taxi, '91169 K'),
  ];

  test('every spec has a golden', () {
    expect(cases.map((c) => c.$2).toSet(), OmanPlates.all.toSet());
  });

  for (final (name, spec, theme, values) in cases) {
    testWidgets(name, (tester) async {
      final controller = PlateController.fromValues(spec, values.split(' '));
      await pumpPlateGolden(
        tester,
        controller,
        'goldens/om_$name.png',
        theme: theme,
        scoped: false,
        country: OmanCountry.oman,
        stage: Size(520, 520 * spec.canvasHeight / spec.canvasWidth),
      );
    });
  }

  PlateEntry e(PlateSpec s, List<String?> v) => PlateEntry(spec: s, values: v);

  test('a field at its minimum is valid, one below is flagged', () {
    const v = OmanPlateValidator();
    final spec = OmanPlates.standard;
    expect(v.validate(e(spec, ['4517', 'BM'])).isValid, isTrue);
    expect(v.validate(e(spec, ['91169', 'A'])).isValid, isTrue);
    expect(v.validate(e(spec, ['451', 'BM'])).isValid, isFalse);
    expect(v.validate(e(spec, ['4517', null])).isValid, isFalse);
  });

  test('only the sourced letter codes are offered', () {
    expect(OmanAlphabets.letters.characters, ['A', 'B', 'K', 'M', 'BM', 'KK']);
  });

  test('every spec passes debugValidateSpec', () {
    for (final spec in OmanPlates.all) {
      expect(debugValidateSpec(spec), isTrue);
    }
  });
}
