import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'kuwait_colors.dart';
import 'kuwait_country.dart';

/// The Kuwaiti plate designs.
///
/// Kuwait adopted its current format in 2008. Plates come in two sizes:
/// - 520×110 mm (EU): Private vehicles in large format, "12-45678"
/// - 335×155 mm (US): Public, Police, Government, Diplomatic
/// - 155×155 mm: Motorcycles
///
/// All plates have left band with text/labels and main number area.
abstract final class KuwaitPlates {
  /// EU-size private vehicle (520×110): "دولة الكويت", black on white, "12-45678".
  static final PlateSpec civilian = PlateSpec(
    id: 'kw.civilian',
    country: KuwaitCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 100, top: 8, width: 56, height: 94, pitch: 64),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 250, top: 8, width: 42, height: 94, pitch: 48),
    ],
    rules: const [PlateRule(box: PlateBox(65, 0, 2, 110))],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size public transport (335×155): "دولة الكويت", black on yellow, codes 90-99.
  static final PlateSpec transport = PlateSpec(
    id: 'kw.transport',
    country: KuwaitCountry.transport,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(8, 40, 48, 70), glyphHeight: 12),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size police (335×155): "POLICE شرطة", white on black, digits only.
  static final PlateSpec police = PlateSpec(
    id: 'kw.police',
    country: KuwaitCountry.police,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 6, left: 85, top: 50, width: 32, height: 80, pitch: 38),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'POLICE\nشرطة', box: PlateBox(70, 30, 250, 80), glyphHeight: 14, color: KuwaitColors.whiteText),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4, 5], key: 'serial'),
    ],
  );

  /// US-size government (335×155): "دولة الكويت — حكومة", black on blue.
  static final PlateSpec government = PlateSpec(
    id: 'kw.government',
    country: KuwaitCountry.government,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'دولة الكويت\nحكومة', box: PlateBox(8, 35, 48, 80), glyphHeight: 11),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size diplomatic (335×155): "هيئة دبلوماسية / C.D", blue on white with RED BAND at bottom.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'kw.diplomatic',
    country: KuwaitCountry.diplomatic,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    rightBand: const PlateBand(box: PlateBox(0, 135, 335, 20), color: Color(0xFFCC0000)),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 25, width: 38, height: 90, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 25, width: 32, height: 90, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'ھيئة\nدبلوماسية', box: PlateBox(8, 30, 48, 80), glyphHeight: 11),
      PlateLabel(text: '-', box: PlateBox(160, 30, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size national guard (335×155): "الحرس الوطني", yellow on green.
  static final PlateSpec nationalGuard = PlateSpec(
    id: 'kw.nationalguard',
    country: KuwaitCountry.nationalGuard,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'الحرس الوطني', box: PlateBox(8, 45, 48, 60), glyphHeight: 11, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size army (335×155): "الجيش", black on beige.
  static final PlateSpec army = PlateSpec(
    id: 'kw.army',
    country: KuwaitCountry.army,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'الجيش', box: PlateBox(8, 50, 48, 50), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size commercial (335×155): "دولة الكويت", black on pink.
  static final PlateSpec commercial = PlateSpec(
    id: 'kw.commercial',
    country: KuwaitCountry.commercial,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(8, 45, 48, 60), glyphHeight: 12),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size construction (335×155): "دولة الكويت", black on orange.
  static final PlateSpec construction = PlateSpec(
    id: 'kw.construction',
    country: KuwaitCountry.construction,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(8, 45, 48, 60), glyphHeight: 12),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size firefighting (335×155): "الإطفاء", white on red.
  static final PlateSpec firefighting = PlateSpec(
    id: 'kw.firefighting',
    country: KuwaitCountry.firefighting,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'الإطفاء', box: PlateBox(8, 50, 48, 50), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size export (335×155): "دولة الكويت", white on green.
  static final PlateSpec exportPlate = PlateSpec(
    id: 'kw.export',
    country: KuwaitCountry.export,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(8, 45, 48, 60), glyphHeight: 12, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size customs (335×155): "دولة الكويت", white on purple.
  static final PlateSpec customs = PlateSpec(
    id: 'kw.customs',
    country: KuwaitCountry.customs,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(8, 45, 48, 60), glyphHeight: 12, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size Emiri Bureau (335×155): "الديوان الأميري", white on blue.
  static final PlateSpec emiri = PlateSpec(
    id: 'kw.emiri',
    country: KuwaitCountry.emiri,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 85, top: 35, width: 38, height: 100, pitch: 44),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 5, left: 180, top: 35, width: 32, height: 100, pitch: 36),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 2, 155))],
    labels: const [
      PlateLabel(text: 'الديوان الأميري', box: PlateBox(8, 40, 48, 70), glyphHeight: 10, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(160, 40, 15, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// Motorcycle plate (155×155): "دولة الكويت / دراجة", black on white, codes 1-10.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'kw.motorcycle',
    country: KuwaitCountry.civilian,
    canvasWidth: 155,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 4, left: 45, top: 90, width: 22, height: 50, pitch: 26),
    ],
    rules: const [PlateRule(box: PlateBox(42, 0, 1, 155))],
    labels: const [
      PlateLabel(text: 'دولة الكويت\nدراجة', box: PlateBox(5, 25, 35, 60), glyphHeight: 8),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
    ],
  );

  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    civilian,
    transport,
    police,
    government,
    diplomatic,
    nationalGuard,
    army,
    commercial,
    construction,
    firefighting,
    exportPlate,
    customs,
    emiri,
    motorcycle,
  ]);
}
