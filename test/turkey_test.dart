import 'dart:io';

import 'package:plate_core/plate_core.dart';
import 'package:flutter/material.dart';
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

  final cases = <(String, PlateSpec, PlateTheme, String)>[
    ('tr_private', TurkeyPlates.private, TurkeyThemes.civilian, '34 AB 1234'),
    (
      'tr_international',
      TurkeyPlates.internationalOrganization,
      TurkeyThemes.internationalOrganization,
      '34 B 0426',
    ),
    (
      'tr_diplomatic',
      TurkeyPlates.diplomatic,
      TurkeyThemes.diplomatic,
      '34 CD 012',
    ),
    (
      'tr_temporary_customs',
      TurkeyPlates.temporaryCustoms,
      TurkeyThemes.temporaryCustoms,
      '34 GMR 032',
    ),
    (
      'tr_foreign_resident',
      TurkeyPlates.foreignResident,
      TurkeyThemes.civilian,
      '34 MA 012',
    ),
    (
      'tr_syrian_resident',
      TurkeyPlates.syrianResident,
      TurkeyThemes.civilian,
      '34 SAB 012',
    ),
    (
      'tr_istanbul_taxi',
      TurkeyPlates.istanbulTaxi,
      TurkeyThemes.civilian,
      '34 TAB 12',
    ),
    ('tr_taxi', TurkeyPlates.taxi, TurkeyThemes.civilian, '06 T 0123'),
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
    ('tr_police', TurkeyPlates.police, TurkeyThemes.police, '16 A 01234'),
    (
      'tr_gendarmerie',
      TurkeyPlates.gendarmerie,
      TurkeyThemes.police,
      '06 JAA 1234',
    ),
    (
      'tr_coast_guard',
      TurkeyPlates.coastGuard,
      TurkeyThemes.police,
      '34 SGH 1234',
    ),
    (
      'tr_consulate',
      TurkeyPlates.consulate,
      TurkeyThemes.consulate,
      '34 CC 0001',
    ),
    (
      'tr_provincial',
      TurkeyPlates.provincialGovernment,
      TurkeyThemes.provincialGovernment,
      '06 AA 012',
    ),
    ('tr_official', TurkeyPlates.official, TurkeyThemes.official, '34 AB 123'),
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
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 520,
                height: 520 * spec.canvasHeight / spec.canvasWidth,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: TurkeyCountry.turkey,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(PlateView),
        matchesGoldenFile('goldens/$name.png'),
      );
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
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
          TurkeyPlates.private,
          '34 AB 1234',
        ).isValid,
        isTrue,
      );
      expect(
        check(
          TurkeyPlateValidator.gendarmerie,
          TurkeyPlates.gendarmerie,
          '06 JAA 1234',
        ).isValid,
        isTrue,
      );
    });

    test(
      'rejects province 82, excluded letters, wrong prefix, seven chars',
      () {
        expect(
          check(
            TurkeyPlateValidator.general,
            TurkeyPlates.private,
            '82 AB 1234',
          ).isValid,
          isFalse,
        );
        expect(
          check(
            TurkeyPlateValidator.general,
            TurkeyPlates.private,
            '34 QB 1234',
          ).isValid,
          isFalse,
        );
        expect(
          check(
            TurkeyPlateValidator.diplomatic,
            TurkeyPlates.diplomatic,
            '34 CC 012',
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
      },
    );
  });
}
