import 'dart:io';

import 'package:plate_core/plate_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

/// Goldens for every UAE spec: seven emirates, two sizes each.
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
      'ae_abudhabi_long',
      UaePlates.abuDhabiLong,
      UaeThemes.long,
      UaeCountry.uae,
      '1223456',
    ),
    (
      'ae_abudhabi_short',
      UaePlates.abuDhabiShort,
      UaeThemes.short,
      UaeCountry.uae,
      '1223456',
    ),
    (
      'ae_ajman_long',
      UaePlates.ajmanLong,
      UaeThemes.long,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_ajman_short',
      UaePlates.ajmanShort,
      UaeThemes.short,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_dubai_long',
      UaePlates.dubaiLong,
      UaeThemes.long,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_dubai_short',
      UaePlates.dubaiShort,
      UaeThemes.short,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_fujairah_long',
      UaePlates.fujairahLong,
      UaeThemes.long,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_fujairah_short',
      UaePlates.fujairahShort,
      UaeThemes.short,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_rasalkhaimah_long',
      UaePlates.rasAlKhaimahLong,
      UaeThemes.long,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_rasalkhaimah_short',
      UaePlates.rasAlKhaimahShort,
      UaeThemes.short,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_sharjah_long',
      UaePlates.sharjahLong,
      UaeThemes.long,
      UaeCountry.uae,
      '123456',
    ),
    (
      'ae_sharjah_short',
      UaePlates.sharjahShort,
      UaeThemes.short,
      UaeCountry.uae,
      '123456',
    ),
    (
      'ae_ummalquwain_long',
      UaePlates.ummAlQuwainLong,
      UaeThemes.long,
      UaeCountry.uae,
      'A23456',
    ),
    (
      'ae_ummalquwain_short',
      UaePlates.ummAlQuwainShort,
      UaeThemes.short,
      UaeCountry.uae,
      'A23456',
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
