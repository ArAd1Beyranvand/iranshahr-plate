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
        'classic': (TurkmenistanPlates.classic, TurkmenistanThemes.classic, 'N 29 38 LB'),
        'private': (TurkmenistanPlates.private, TurkmenistanThemes.private, 'AT 0123 AG'),
        'trailer': (TurkmenistanPlates.trailer, TurkmenistanThemes.private, 'AG 0123 TR'),
        'foreign': (TurkmenistanPlates.foreign, TurkmenistanThemes.foreign, '1 H 01234'),
        'foreign_trailer': (
          TurkmenistanPlates.foreignTrailer,
          TurkmenistanThemes.foreign,
          '1 HT 2345',
        ),
        'export': (TurkmenistanPlates.export, TurkmenistanThemes.foreign, 'TDG 0123'),
        'diplomatic': (TurkmenistanPlates.diplomatic, TurkmenistanThemes.diplomatic, '01 CD 234'),
        'government': (TurkmenistanPlates.government, TurkmenistanThemes.government, '0123 AGA'),
        'military': (TurkmenistanPlates.military, TurkmenistanThemes.government, '0123 GM'),
        'ceremony': (TurkmenistanPlates.ceremony, TurkmenistanThemes.government, 'DABARA 1'),
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
                    country: TurkmenistanCountry.turkmenistan,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
      await tester.pumpAndSettle();
      await expectLater(find.byType(PlateView), matchesGoldenFile('goldens/tm_${c.key}.png'));
      await tester.pumpWidget(const SizedBox.shrink());
      controller.dispose();
    });
  }
}
