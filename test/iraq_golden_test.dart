import 'dart:io';

import 'package:plate_core/plate_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

/// Goldens for every Iraqi plate, one image per spec and per band colour.
///
/// These exist to be looked at. The class of an Iraqi plate is carried
/// entirely by the colour of the left band, which is the `PlateCountry`'s and
/// not the spec's, so the specs alone would render five near-identical white
/// plates. The cases below pair each spec with a band so that the thing the
/// classes actually differ in is what the goldens show.
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
  // flutter_test's default font draws every glyph as a box, which hides
  // exactly what these goldens exist to show. Both faces go into the one
  // family the theme resolves to so glyphs fall back per character.
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
    required String value,
    required String name,
  }) async {
    // One field after another: each takes as many characters as it holds.
    var at = 0;
    final values = <String?>[for (final slot in spec.slots) value.substring(at, at += slot.length)];
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
                child: PlateView(controller: controller, theme: theme, country: country),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await expectLater(find.byType(PlateView), matchesGoldenFile('goldens/$name.png'));

    await tester.pumpWidget(const SizedBox.shrink());
    controller.dispose();
  }

  // The reference artwork prints "14 G 34567" outside Kurdistan and
  // "21 G 34567" inside it, so the goldens use the same values and can be
  // compared with it directly. 21 is Sulaymaniyah, 14 is Basra.
  const rest = '14G34567';
  const kurd = '21G34567';

  final cases = <(String, PlateSpec, PlateTheme, PlateCountry, String)>[
    // 520x110, rest of Iraq: one spec, each of the five permanent bands.
    ('iq_large_private', IraqPlates.large, IraqThemes.large, IraqCountry.private, rest),
    ('iq_large_hire', IraqPlates.large, IraqThemes.large, IraqCountry.hire, rest),
    ('iq_large_government', IraqPlates.large, IraqThemes.large, IraqCountry.government, rest),
    ('iq_large_trade', IraqPlates.large, IraqThemes.large, IraqCountry.trade, rest),
    ('iq_large_agricultural', IraqPlates.large, IraqThemes.large, IraqCountry.agricultural, rest),
    // 520x110, Kurdistan Region.
    ('iq_large_kr_private', IraqPlates.largeKurdistan, IraqThemes.large, IraqCountry.private, kurd),
    ('iq_large_kr_hire', IraqPlates.largeKurdistan, IraqThemes.large, IraqCountry.hire, kurd),
    (
      'iq_large_kr_government',
      IraqPlates.largeKurdistan,
      IraqThemes.large,
      IraqCountry.government,
      kurd,
    ),
    ('iq_large_kr_trade', IraqPlates.largeKurdistan, IraqThemes.large, IraqCountry.trade, kurd),
    (
      'iq_large_kr_agricultural',
      IraqPlates.largeKurdistan,
      IraqThemes.large,
      IraqCountry.agricultural,
      kurd,
    ),
    // 335x155, both regions.
    ('iq_small_private', IraqPlates.small, IraqThemes.small, IraqCountry.private, rest),
    ('iq_small_hire', IraqPlates.small, IraqThemes.small, IraqCountry.hire, rest),
    ('iq_small_government', IraqPlates.small, IraqThemes.small, IraqCountry.government, rest),
    ('iq_small_trade', IraqPlates.small, IraqThemes.small, IraqCountry.trade, rest),
    ('iq_small_agricultural', IraqPlates.small, IraqThemes.small, IraqCountry.agricultural, rest),
    ('iq_small_kr_private', IraqPlates.smallKurdistan, IraqThemes.small, IraqCountry.private, kurd),
    ('iq_small_kr_hire', IraqPlates.smallKurdistan, IraqThemes.small, IraqCountry.hire, kurd),
    (
      'iq_small_kr_government',
      IraqPlates.smallKurdistan,
      IraqThemes.small,
      IraqCountry.government,
      kurd,
    ),
    ('iq_small_kr_trade', IraqPlates.smallKurdistan, IraqThemes.small, IraqCountry.trade, kurd),
    (
      'iq_small_kr_agricultural',
      IraqPlates.smallKurdistan,
      IraqThemes.small,
      IraqCountry.agricultural,
      kurd,
    ),
    // Temporary: governorate 21, expiring in 22, serial 34567.
    (
      'iq_small_temporary',
      IraqPlates.smallTemporary,
      IraqThemes.temporary,
      IraqCountry.temporary,
      '212234567',
    ),
  ];

  for (final (name, spec, theme, country, value) in cases) {
    testWidgets(name, (tester) async {
      await renderGolden(
        tester,
        spec: spec,
        theme: theme,
        country: country,
        value: value,
        name: name,
      );
    });
  }
}
