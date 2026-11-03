import 'dart:io';

import 'package:plate_core/plate_core.dart';
import 'package:plate_core/testing.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

/// A golden per Turkish category, each in its own livery, plus the validator.
///
/// Rendered in Roboto Bold — the family the theme resolves to on a device —
/// rather than the DejaVu the other goldens use: DejaVu's figures are a fifth
/// wider, and the slots scale them down to fit, which would hide the size the
/// plate actually paints.
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final loader = FontLoader('Roboto');
    for (final path in const [
      '/usr/share/fonts/truetype/roboto/unhinted/RobotoTTF/Roboto-Bold.ttf',
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final file = File(path);
      if (!file.existsSync()) continue;
      loader.addFont(file.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  // The folded classes render through the resolver: `CD`, `GMR`, `CC` recolour
  // their base livery, `T` draws the taxi rule.
  final strip = TurkeyThemes.civilian;
  final cases = <(String, PlateSpec, PlateTheme, String)>[
    ('tr_private', TurkeyPlates.strip, strip, '34 AB 1234'),
    (
      'tr_international',
      TurkeyPlates.strip,
      TurkeyThemes.internationalOrganization,
      '34 B 0426',
    ),
    ('tr_diplomatic', TurkeyPlates.strip, strip, '34 CD 012'),
    ('tr_temporary_customs', TurkeyPlates.strip, strip, '34 GMR 032'),
    ('tr_istanbul_taxi', TurkeyPlates.strip, strip, '34 TAB 12'),
    ('tr_taxi', TurkeyPlates.strip, strip, '06 T 0123'),
    (
      'tr_temporary',
      TurkeyPlates.temporary,
      TurkeyThemes.temporary,
      '34 G 1234',
    ),
    (
      'tr_temporary_strip',
      TurkeyPlates.temporaryWithStrip,
      TurkeyThemes.temporary,
      '34 G 1234',
    ),
    ('tr_police', TurkeyPlates.plain, TurkeyThemes.police, '16 A 01234'),
    ('tr_gendarmerie', TurkeyPlates.plain, TurkeyThemes.police, '06 JAA 1234'),
    ('tr_consulate', TurkeyPlates.plain, TurkeyThemes.police, '34 CC 0001'),
    (
      'tr_provincial',
      TurkeyPlates.plain,
      TurkeyThemes.provincialGovernment,
      '06 AA 012',
    ),
    ('tr_official', TurkeyPlates.plain, TurkeyThemes.official, '34 AB 123'),
    ('tr_governor', TurkeyPlates.governor, TurkeyThemes.state, '34 0001'),
    ('tr_parliament', TurkeyPlates.parliament, TurkeyThemes.state, '0019'),
    (
      'tr_parliament_labelled',
      TurkeyPlates.parliamentLabelled,
      TurkeyThemes.state,
      '009',
    ),
    ('tr_sample', TurkeyPlates.sample, TurkeyThemes.civilian, '34 123'),
    (
      'tr_motorcycle',
      TurkeyPlates.motorcycle,
      TurkeyThemes.civilian,
      '34 UF 2409',
    ),
  ];

  for (final (name, spec, theme, value) in cases) {
    testWidgets(name, (tester) async {
      expect(value.split(' ').length, spec.slotCount);
      final controller = PlateController.fromValues(spec, value.split(' '));
      await pumpPlateGolden(
        tester,
        controller,
        'goldens/$name.png',
        theme: theme,
        country: TurkeyCountry.turkey,
        stage: Size(520, 520 * spec.canvasHeight / spec.canvasWidth),
      );
    });
  }

  group('variable fields', () {
    test('the shapes build', () {
      for (final spec in [
        TurkeyPlates.strip,
        TurkeyPlates.plain,
        TurkeyPlates.motorcycle,
      ]) {
        expect(debugValidateSpec(spec), isTrue);
      }
      expect(TurkeyPlates.strip.slotCount, 3);
    });

    test('letters and figures complete at their minimum', () {
      final c = PlateController.fromValues(TurkeyPlates.strip, [
        '34',
        'A',
        '12',
      ]);
      expect(c.isCompleted, isTrue);
      c.setAt(2, '1');
      expect(c.isCompleted, isFalse);
      c.dispose();
    });
  });

  group('TurkeyPlateValidator', () {
    PlateValidation check(PlateValidator v, PlateSpec spec, String value) =>
        v.validate(PlateEntry(spec: spec, values: value.split(' ')));

    test('accepts the article examples', () {
      expect(
        check(
          TurkeyPlateValidator.general,
          TurkeyPlates.strip,
          '34 AB 1234',
        ).isValid,
        isTrue,
      );
      expect(
        check(
          TurkeyPlateValidator.police,
          TurkeyPlates.plain,
          '06 JAA 1234',
        ).isValid,
        isTrue,
      );
    });

    test('rejects province 82, excluded letters, seven chars', () {
      expect(
        check(
          TurkeyPlateValidator.general,
          TurkeyPlates.strip,
          '82 AB 1234',
        ).isValid,
        isFalse,
      );
      expect(
        check(
          TurkeyPlateValidator.general,
          TurkeyPlates.strip,
          '34 QB 1234',
        ).isValid,
        isFalse,
      );
      expect(
        check(
          TurkeyPlateValidator.general,
          TurkeyPlates.strip,
          '34 ABC 1234',
        ).isValid,
        isFalse,
      );
    });
  });
}
