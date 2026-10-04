import 'dart:io';

import 'package:plate_core/core_plate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

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
  }) async {
    final values = <String?>[
      for (var i = 0; i < spec.slotCount; i++)
        i < digits.length ? digits[i] : '0',
    ];
    final controller = PlateController.fromValues(spec, values);

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
                  country: country,
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
      'kw_government',
      KuwaitPlates.government,
      KuwaitThemes.government,
      KuwaitCountry.government,
      '23456',
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
      'kw_army',
      KuwaitPlates.army,
      KuwaitThemes.army,
      KuwaitCountry.army,
      '23456',
    ),
    (
      'kw_commercial',
      KuwaitPlates.commercial,
      KuwaitThemes.commercial,
      KuwaitCountry.commercial,
      '23456',
    ),
    (
      'kw_construction',
      KuwaitPlates.construction,
      KuwaitThemes.construction,
      KuwaitCountry.construction,
      '23456',
    ),
    (
      'kw_firefighting',
      KuwaitPlates.firefighting,
      KuwaitThemes.firefighting,
      KuwaitCountry.firefighting,
      '23456',
    ),
    (
      'kw_export',
      KuwaitPlates.exportPlate,
      KuwaitThemes.export,
      KuwaitCountry.export,
      '23456',
    ),
    (
      'kw_customs',
      KuwaitPlates.customs,
      KuwaitThemes.customs,
      KuwaitCountry.customs,
      '23456',
    ),
    (
      'kw_emiri',
      KuwaitPlates.emiri,
      KuwaitThemes.emiri,
      KuwaitCountry.emiri,
      '23456',
    ),
    (
      'kw_emiriguard',
      KuwaitPlates.emiriGuard,
      KuwaitThemes.emiriGuard,
      KuwaitCountry.emiriGuard,
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
