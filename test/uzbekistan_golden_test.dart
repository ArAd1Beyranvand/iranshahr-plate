import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';

/// One golden per category, drawn with real bold faces so the ink can be
/// measured against the references (`platekit golden-check`).
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  setUpAll(() async {
    final FontLoader loader = FontLoader('Roboto');
    for (final String path in const <String>[
      '/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',
    ]) {
      final File face = File(path);
      if (!face.existsSync()) continue;
      loader.addFont(face.readAsBytes().then((b) => ByteData.view(b.buffer)));
    }
    await loader.load();
  });

  /// category id -> (spec, theme, space-separated sample value)
  final Map<String, (PlateSpec, PlateTheme, String)> cases =
      <String, (PlateSpec, PlateTheme, String)>{
        'passenger': (UzbekistanPlates.passenger, UzbekistanThemes.passenger, '01 A 123 BC'),
        'foreign_citizen': (
          UzbekistanPlates.foreignCitizen,
          UzbekistanThemes.foreignCitizen,
          '01 012345',
        ),
        'foreign_company': (
          UzbekistanPlates.foreignCompany,
          UzbekistanThemes.foreignCompany,
          '10 012345',
        ),
        'temporary': (UzbekistanPlates.temporary, UzbekistanThemes.temporary, '012345 01'),
        'ambassador': (UzbekistanPlates.ambassador, UzbekistanThemes.diplomatic, '012 345'),
        'diplomat': (UzbekistanPlates.diplomat, UzbekistanThemes.diplomatic, 'D 012 345'),
        'united_nations': (UzbekistanPlates.unitedNations, UzbekistanThemes.unitedNations, '0123'),
        'trailer': (UzbekistanPlates.trailer, UzbekistanThemes.trailer, '0123 AB 01'),
        'motorcycle': (UzbekistanPlates.motorcycle, UzbekistanThemes.motorcycle, '123 AB 01'),
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(spec, values.split(' '));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 680,
                height: 300,
                child: PlateThemeScope(
                  theme: theme,
                  child: PlateView(
                    controller: controller,
                    theme: theme,
                    country: UzbekistanCountry.uzbekistan,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
      await tester.pumpAndSettle();
      await expectLater(find.byType(PlateView), matchesGoldenFile('goldens/uz_${c.key}.png'));
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
