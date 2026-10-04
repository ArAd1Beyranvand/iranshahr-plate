import 'dart:io';

import 'package:plate_core/plate_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

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
    ('tr_private', TurkeyPlates.private, TurkeyThemes.civilian, '34AB1234'),
    (
      'tr_international',
      TurkeyPlates.internationalOrganization,
      TurkeyThemes.internationalOrganization,
      '34B0426',
    ),
    (
      'tr_diplomatic',
      TurkeyPlates.diplomatic,
      TurkeyThemes.diplomatic,
      '34CD012',
    ),
    (
      'tr_temporary_customs',
      TurkeyPlates.temporaryCustoms,
      TurkeyThemes.temporaryCustoms,
      '34GMR032',
    ),
    (
      'tr_foreign_resident',
      TurkeyPlates.foreignResident,
      TurkeyThemes.civilian,
      '34MA012',
    ),
    (
      'tr_syrian_resident',
      TurkeyPlates.syrianResident,
      TurkeyThemes.civilian,
      '34SAB012',
    ),
    (
      'tr_istanbul_taxi',
      TurkeyPlates.istanbulTaxi,
      TurkeyThemes.civilian,
      '34TAB12',
    ),
    ('tr_taxi', TurkeyPlates.taxi, TurkeyThemes.civilian, '06T0123'),
    ('tr_temporary', TurkeyPlates.temporary, TurkeyThemes.temporary, '34G1234'),
    (
      'tr_temporary_strip',
      TurkeyPlates.temporaryWithStrip,
      TurkeyThemes.temporary,
      '34G1234',
    ),
    ('tr_police', TurkeyPlates.police, TurkeyThemes.police, '16A01234'),
    (
      'tr_gendarmerie',
      TurkeyPlates.gendarmerie,
      TurkeyThemes.police,
      '06JAA1234',
    ),
    (
      'tr_coast_guard',
      TurkeyPlates.coastGuard,
      TurkeyThemes.police,
      '34SGH1234',
    ),
    ('tr_consulate', TurkeyPlates.consulate, TurkeyThemes.consulate, '34CC0001'),
    (
      'tr_provincial',
      TurkeyPlates.provincialGovernment,
      TurkeyThemes.provincialGovernment,
      '06AA012',
    ),
    ('tr_official', TurkeyPlates.official, TurkeyThemes.official, '34AB123'),
    ('tr_governor', TurkeyPlates.governor, TurkeyThemes.state, '340001'),
    ('tr_parliament', TurkeyPlates.parliament, TurkeyThemes.state, '0019'),
    (
      'tr_parliament_labelled',
      TurkeyPlates.parliamentLabelled,
      TurkeyThemes.state,
      '009',
    ),
    ('tr_sample', TurkeyPlates.sample, TurkeyThemes.civilian, '34123'),
    (
      'tr_motorcycle',
      TurkeyPlates.motorcycle(2, 4),
      TurkeyThemes.civilian,
      '34UF2409',
    ),
  ];

  for (final (name, spec, theme, value) in cases) {
    testWidgets(name, (tester) async {
      expect(value.length, spec.slotCount);
      final controller = PlateController.fromValues(spec, value.split(''));
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

  group('every format builds and validates', () {
    for (final (l, d) in const [(1, 4), (1, 5), (2, 3), (2, 4), (3, 2), (3, 3)]) {
      test('strip $l letters $d figures', () {
        final spec = TurkeyPlates.strip(l, d);
        expect(debugValidateSpec(spec), isTrue);
        expect(spec.slotCount, 2 + l + d);
        expect(identical(spec, TurkeyPlates.strip(l, d)), isTrue);
      });
    }
  });

  group('TurkeyPlateValidator', () {
    PlateValidation check(PlateValidator v, PlateSpec spec, String value) => v
        .validate(PlateEntry(spec: spec, values: value.split('')));

    test('accepts the article examples', () {
      expect(
        check(TurkeyPlateValidator.general, TurkeyPlates.private, '34AB1234')
            .isValid,
        isTrue,
      );
      expect(
        check(
          TurkeyPlateValidator.gendarmerie,
          TurkeyPlates.gendarmerie,
          '06JAA1234',
        ).isValid,
        isTrue,
      );
    });

    test('rejects province 82, excluded letters, wrong prefix, seven chars', () {
      expect(
        check(TurkeyPlateValidator.general, TurkeyPlates.private, '82AB1234')
            .isValid,
        isFalse,
      );
      expect(
        check(TurkeyPlateValidator.general, TurkeyPlates.private, '34QB1234')
            .isValid,
        isFalse,
      );
      expect(
        check(TurkeyPlateValidator.diplomatic, TurkeyPlates.diplomatic, '34CC012')
            .isValid,
        isFalse,
      );
      expect(
        check(
          TurkeyPlateValidator.general,
          TurkeyPlates.strip(3, 4),
          '34ABC1234',
        ).isValid,
        isFalse,
      );
    });
  });
}
