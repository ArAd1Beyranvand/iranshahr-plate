import 'dart:io';
import 'dart:math' as math;

import 'package:plate_core/plate_core.dart';
import 'package:plate_core/testing.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

/// Goldens for every Kuwaiti spec, one image per category.
///
/// These exist to be looked at. The Kuwait designs were rebuilt against the
/// reference artwork on Wikimedia Commons, and a golden per category is the
/// only way a later change to the shared `_Layout` constants shows up as
/// something reviewable rather than as sixteen silently shifted plates.
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  // flutter_test's default font draws every glyph as a box, which hides
  // exactly what these goldens exist to show: whether a caption fits its row.
  // Noto is the system fallback the plates render with in a real app.
  // Both faces go into the one family the theme resolves to, in Latin-then-
  // Arabic order, so a caption falls back per glyph the way it would on a
  // device rather than dropping to tofu.
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
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

  Future<void> renderGolden(
    WidgetTester tester, {
    required PlateSpec spec,
    required PlateTheme theme,
    required PlateCountry country,
    required String digits,
    required String name,
    String? caption,
  }) async {
    var at = 0;
    final values = <String?>[
      if (caption != null) ...[
        digits,
        caption,
      ] else
        for (final slot in spec.slots)
          if (at < digits.length)
            digits.substring(at, at = math.min(at + slot.length, digits.length))
          else
            '0' * slot.length,
    ];
    final controller = PlateController.fromValues(spec, values);

    await pumpPlateGolden(
      tester,
      controller,
      'goldens/$name.png',
      theme: theme,
      country: country,
      stage: Size(520, 520 * spec.canvasHeight / spec.canvasWidth),
    );
  }

  final cases = <(String, PlateSpec, PlateTheme, PlateCountry, String)>[
    (
      'kw_civilian',
      KuwaitPlates.civilian,
      KuwaitThemes.civilian,
      KuwaitCountry.civilian,
      '1023456',
    ),
    (
      'kw_transport',
      KuwaitPlates.transport,
      KuwaitThemes.transport,
      KuwaitCountry.transport,
      '9323456',
    ),
    (
      'kw_police',
      KuwaitPlates.police,
      KuwaitThemes.police,
      KuwaitCountry.police,
      '23456',
    ),
    (
      'kw_policemotorcycle',
      KuwaitPlates.policeMotorcycle,
      KuwaitThemes.police,
      KuwaitCountry.policeMotorcycle,
      '2345',
    ),
    (
      'kw_diplomatic',
      KuwaitPlates.diplomatic,
      KuwaitThemes.diplomatic,
      KuwaitCountry.diplomatic,
      '123456',
    ),
    (
      'kw_nationalguard',
      KuwaitPlates.nationalGuard,
      KuwaitThemes.nationalGuard,
      KuwaitCountry.nationalGuard,
      '23456',
    ),
    (
      'kw_motorcycle',
      KuwaitPlates.motorcycle,
      KuwaitThemes.civilian,
      KuwaitCountry.civilian,
      '10234',
    ),
  ];

  const captioned = <String>[
    'government',
    'army',
    'commercial',
    'construction',
    'firefighting',
    'export',
    'customs',
    'emiri',
    'emiriguard',
  ];
  for (var i = 0; i < captioned.length; i++) {
    testWidgets('kw_${captioned[i]}', (tester) async {
      await renderGolden(
        tester,
        spec: KuwaitPlates.standard,
        theme: KuwaitThemes.government,
        country: KuwaitCountry.government,
        digits: '23456',
        caption: KuwaitThemes.captions.characters[i],
        name: 'kw_${captioned[i]}',
      );
    });
  }

  for (final (name, spec, theme, country, digits) in cases) {
    testWidgets(name, (tester) async {
      await renderGolden(
        tester,
        spec: spec,
        theme: theme,
        country: country,
        digits: digits,
        name: name,
      );
    });
  }
}
