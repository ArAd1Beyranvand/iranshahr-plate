import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';
import 'package:plate_core/testing.dart';

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
        'passenger': (
          UzbekistanPlates.passenger,
          UzbekistanThemes.passenger,
          '01 A 123 BC',
        ),
        'foreign_citizen': (
          UzbekistanPlates.foreign,
          UzbekistanThemes.foreignCitizen,
          '01 H 012345',
        ),
        'foreign_company': (
          UzbekistanPlates.foreign,
          UzbekistanThemes.foreignCitizen,
          '10 M 012345',
        ),
        'temporary': (
          UzbekistanPlates.temporary,
          UzbekistanThemes.temporary,
          '012345 01',
        ),
        'ambassador': (
          UzbekistanPlates.ambassador,
          UzbekistanThemes.diplomatic,
          '012 345',
        ),
        'diplomat': (
          UzbekistanPlates.diplomat,
          UzbekistanThemes.diplomatic,
          'D 012 345',
        ),
        'united_nations': (
          UzbekistanPlates.unitedNations,
          UzbekistanThemes.unitedNations,
          '0123',
        ),
        'trailer': (
          UzbekistanPlates.trailer,
          UzbekistanThemes.trailer,
          '0123 AB 01',
        ),
        'motorcycle': (
          UzbekistanPlates.motorcycle,
          UzbekistanThemes.motorcycle,
          '123 AB 01',
        ),
      };

  for (final MapEntry<String, (PlateSpec, PlateTheme, String)> c
      in cases.entries) {
    testWidgets(c.key, (tester) async {
      final (PlateSpec spec, PlateTheme theme, String values) = c.value;
      final PlateController controller = PlateController.fromValues(
        spec,
        values.split(' '),
      );
      await pumpPlateGolden(
        tester,
        controller,
        'goldens/uz_${c.key}.png',
        theme: theme,
        country: UzbekistanCountry.uzbekistan,
        decodeDelay: const Duration(milliseconds: 300),
      );
    });
  }
}
