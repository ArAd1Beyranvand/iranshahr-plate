import 'dart:io';

import 'package:core_plate/core_plate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iranshahr_plate/iranshahr.dart';

/// Goldens for every Iraqi spec, one image per category.
///
/// Iraqi plates have a coloured left band (white for private, blue for
/// governmental, red for for-hire, yellow for commercial/trucks, green for
/// agricultural), and share the same format: [Governorate code 2 digits] ·
/// [Vehicle type letter] [4-digit registration number].
///
/// Regenerate with `flutter test --update-goldens` after a deliberate change.
void main() {
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
    ('iq_private', IraqPlates.private_11, IraqThemes.privateVehicle, const PlateCountry(code: 'iq', captionLines: <String>[], panelColor: Color(0xFF7A7A7A), panelTextColor: Color(0xFF1A1A1A)), '11G3456'),
    ('iq_governmental', IraqPlates.governmental_11, IraqThemes.governmental, const PlateCountry(code: 'iq', captionLines: <String>[], panelColor: Color(0xFF0079C1), panelTextColor: Color(0xFFFFFFFF)), '11G3456'),
    ('iq_forhire', IraqPlates.forHire_11, IraqThemes.forHire, const PlateCountry(code: 'iq', captionLines: <String>[], panelColor: Color(0xFFED1C24), panelTextColor: Color(0xFFFFFFFF)), '11G3456'),
    ('iq_commercial', IraqPlates.commercial_11, IraqThemes.commercial, const PlateCountry(code: 'iq', captionLines: <String>[], panelColor: Color(0xFFFFC913), panelTextColor: Color(0xFF000000)), '11G3456'),
    ('iq_agricultural', IraqPlates.agricultural_11, IraqThemes.agricultural, const PlateCountry(code: 'iq', captionLines: <String>[], panelColor: Color(0xFF01A06A), panelTextColor: Color(0xFFFFFFFF)), '11G3456'),
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
