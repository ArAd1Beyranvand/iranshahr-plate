import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'kuwait_colors.dart';
import 'kuwait_country.dart';

/// The Kuwaiti plate designs.
///
/// Kuwait adopted its current format in 2008. Geometry and text here follow
/// the "Vehicle types" table on Wikipedia's
/// "Vehicle registration plates of Kuwait" article:
/// - 520×110 mm (EU): Private in large format, "12-45678"
/// - 335×155 mm (US): everything else except motorcycles
/// - 155×155 mm: Motorcycle and Police Motorcycle
///
/// Only private, public and police carry the dash-split "class-serial"
/// number seen on the sample plate images; every other category prints a
/// plain 5-digit serial with no class prefix.
abstract final class KuwaitPlates {
  /// EU-size private vehicle (520×110): "دولة الكويت", black on white, "12-45678".
  static final PlateSpec civilian = PlateSpec(
    id: 'kw.civilian',
    country: KuwaitCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(65, 0, 3, 110))],
    labels: const [
      PlateLabel(text: 'KUWAIT', box: PlateBox(5, 8, 55, 24), glyphHeight: 16),
      PlateLabel(
        text: 'دولة\nالكويت',
        box: PlateBox(5, 38, 55, 62),
        glyphHeight: 26,
      ),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size public transport (335×155): "دولة الكويت", black on yellow, codes 90-99.
  ///
  /// The 2-digit class code sits top-left, the Arabic caption top-right, and
  /// the 5-digit serial runs along the bottom row.
  static final PlateSpec transport = PlateSpec(
    id: 'kw.transport',
    country: KuwaitCountry.transport,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 70,
        top: 10,
        width: 40,
        height: 50,
        pitch: 45,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 75,
        top: 78,
        width: 46,
        height: 70,
        pitch: 50,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(60, 0, 3, 155)),
      PlateRule(box: PlateBox(60, 68, 275, 2)),
    ],
    labels: const [
      PlateLabel(
        text: 'P\nU\nB',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 30,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'دولة\nالكويت',
        box: PlateBox(180, 8, 150, 55),
        glyphHeight: 26,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// US-size police (335×155): "POLICE شرطة", white on black, digits only.
  ///
  /// "POLICE" and the Arabic caption share the top row, "POLICE" to the
  /// left of "شرطة"; the digits fill the band below.
  static final PlateSpec police = PlateSpec(
    id: 'kw.police',
    country: KuwaitCountry.police,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 6,
        left: 75,
        top: 55,
        width: 38,
        height: 85,
        pitch: 42,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'K\nU\nW\nA\nI\nT',
        box: PlateBox(5, 8, 50, 110),
        glyphHeight: 13,
        color: KuwaitColors.whiteText,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'POLICE',
        box: PlateBox(65, 5, 100, 38),
        glyphHeight: 18,
        color: KuwaitColors.whiteText,
      ),
      PlateLabel(
        text: 'شرطة',
        box: PlateBox(165, 5, 165, 38),
        glyphHeight: 34,
        color: KuwaitColors.whiteText,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4, 5], key: 'serial'),
    ],
  );

  /// Motorcycle-size police (155×155): "شرطة" only, white on black, 4-digit
  /// serial, with the same vertical "KUWAIT" band as the other plates.
  static final PlateSpec policeMotorcycle = PlateSpec(
    id: 'kw.policemotorcycle',
    country: KuwaitCountry.policeMotorcycle,
    canvasWidth: 155,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 60,
        top: 20,
        width: 22,
        height: 50,
        pitch: 26,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(50, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'K\nU\nW\nA\nI\nT',
        box: PlateBox(5, 8, 40, 140),
        glyphHeight: 13,
        color: KuwaitColors.whiteText,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'شرطة',
        box: PlateBox(55, 95, 95, 45),
        glyphHeight: 26,
        color: KuwaitColors.whiteText,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
    ],
  );

  /// US-size government (335×155): "دولة الكويت — حكومة", black on blue, plain 5-digit serial.
  ///
  /// "GOVT" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec government = PlateSpec(
    id: 'kw.government',
    country: KuwaitCountry.government,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'G\nO\nV\nT',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 24,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'دولة الكويت - حكومة',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 24,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size Corps Diplomatique (335×155): "هيئة دبلوماسية / C.D", blue on white,
  /// red band at the bottom, "123-456" split serial.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'kw.diplomatic',
    country: KuwaitCountry.diplomatic,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    rightBand: const PlateBand(
      box: PlateBox(63, 115, 272, 40),
      color: KuwaitColors.fireField,
    ),
    innerBand: const PlateBand(
      box: PlateBox(127, 116, 81, 33),
      color: KuwaitColors.civField,
      topCornerRadius: 16,
      bottomCornerRadius: 16,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 85,
        top: 45,
        width: 34,
        height: 65,
        pitch: 40,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 217,
        top: 45,
        width: 34,
        height: 65,
        pitch: 40,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'K\nU\nW\nA\nI\nT',
        box: PlateBox(5, 5, 50, 105),
        glyphHeight: 12,
        color: KuwaitColors.govField,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'هيئة دبلوماسية',
        box: PlateBox(65, 5, 265, 38),
        glyphHeight: 24,
        color: KuwaitColors.govField,
      ),
      PlateLabel(
        text: '-',
        box: PlateBox(197, 45, 20, 65),
        glyphHeight: 58,
        color: KuwaitColors.govField,
      ),
      PlateLabel(
        text: 'C.D',
        box: PlateBox(140, 118, 55, 30),
        glyphHeight: 24,
        color: KuwaitColors.fireField,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'class'),
      PlateTextGroup([3, 4, 5], key: 'serial'),
    ],
  );

  /// US-size national guard (335×155): "الحرس الوطني", yellow on green, plain 5-digit serial.
  ///
  /// "GUARD" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec nationalGuard = PlateSpec(
    id: 'kw.nationalguard',
    country: KuwaitCountry.nationalGuard,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'G\nU\nA\nR\nD',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 19,
        color: KuwaitColors.transField,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'الحرس الوطني',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 32,
        color: KuwaitColors.transField,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size army (335×155): "الجيش الكويتي", black on beige, plain 5-digit serial.
  ///
  /// "ARMY" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec army = PlateSpec(
    id: 'kw.army',
    country: KuwaitCountry.army,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'A\nR\nM\nY',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 24,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'الجيش الكويتي',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 30,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size commercial (335×155): "دولة الكويت — تجاري", black on pink, plain 5-digit serial.
  ///
  /// "COMM" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec commercial = PlateSpec(
    id: 'kw.commercial',
    country: KuwaitCountry.commercial,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'C\nO\nM\nM',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 24,
        lineHeight: 2.0,
      ),
      PlateLabel(text: 'تجاري', box: PlateBox(65, 5, 265, 48), glyphHeight: 38),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size construction (335×155): "دولة الكويت — إنشاءت", black on orange, plain 5-digit serial.
  ///
  /// "CONST" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec construction = PlateSpec(
    id: 'kw.construction',
    country: KuwaitCountry.construction,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'C\nO\nN\nS\nT',
        box: PlateBox(5, 5, 50, 145),
        glyphHeight: 20,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'إنشاءت',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 38,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size general firefighting (335×155): "الإطفاء العام FIRE -", black on red, plain 5-digit serial.
  ///
  /// "FIRE" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec firefighting = PlateSpec(
    id: 'kw.firefighting',
    country: KuwaitCountry.firefighting,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'F\nI\nR\nE',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 24,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'الإطفاء العام FIRE -',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 26,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size export (335×155): "دولة الكويت — تصدير", black on green, plain 5-digit serial.
  ///
  /// "EXPORT" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec exportPlate = PlateSpec(
    id: 'kw.export',
    country: KuwaitCountry.export,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'E\nX\nP\nO\nR\nT',
        box: PlateBox(5, 5, 50, 145),
        glyphHeight: 17,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'دولة الكويت - تصدير',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 24,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size temporary customs (335×155): "دولة الكويت — جمرك مؤقت", black on purple, plain 5-digit serial.
  ///
  /// "CUSTOMS" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec customs = PlateSpec(
    id: 'kw.customs',
    country: KuwaitCountry.customs,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'C\nU\nS\nT\nO\nM\nS',
        box: PlateBox(5, 3, 50, 149),
        glyphHeight: 15,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'دولة الكويت - جمرك مؤقت',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 20,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size Emiri Bureau (335×155): "دولة الكويت — الديوان الأميري", white on blue, plain 5-digit serial.
  ///
  /// "EMIRI" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec emiri = PlateSpec(
    id: 'kw.emiri',
    country: KuwaitCountry.emiri,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'E\nM\nI\nR\nI',
        box: PlateBox(5, 5, 50, 145),
        glyphHeight: 20,
        color: KuwaitColors.whiteText,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'الديوان الأميري',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 28,
        color: KuwaitColors.whiteText,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// US-size Emiri Guard (335×155): "الحرس — الأميري", white on blue, plain 5-digit serial.
  ///
  /// "GUARD" stacked vertically on the left, Arabic caption across the top,
  /// digits below.
  static final PlateSpec emiriGuard = PlateSpec(
    id: 'kw.emiriguard',
    country: KuwaitCountry.emiriGuard,
    canvasWidth: 335,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 70,
        top: 58,
        width: 50,
        height: 90,
        pitch: 52,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(60, 0, 3, 155))],
    labels: const [
      PlateLabel(
        text: 'G\nU\nA\nR\nD',
        box: PlateBox(5, 8, 50, 140),
        glyphHeight: 19,
        color: KuwaitColors.whiteText,
        lineHeight: 2.0,
      ),
      PlateLabel(
        text: 'الحرس الأميري',
        box: PlateBox(65, 5, 265, 48),
        glyphHeight: 30,
        color: KuwaitColors.whiteText,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// Motorcycle plate (155×155): "دولة الكويت / دراجة", black on white, codes 1-10.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'kw.motorcycle',
    country: KuwaitCountry.civilian,
    canvasWidth: 155,
    canvasHeight: 155,
    noPanel: true,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 28,
        top: 58,
        width: 22,
        height: 50,
        pitch: 26,
      ),
    ],
    labels: const [
      PlateLabel(
        text: 'دولة الكويت',
        box: PlateBox(5, 8, 145, 35),
        glyphHeight: 24,
      ),
      PlateLabel(
        text: 'دراجة',
        box: PlateBox(5, 112, 145, 35),
        glyphHeight: 26,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
    ],
  );

  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    civilian,
    transport,
    police,
    policeMotorcycle,
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
    emiriGuard,
    motorcycle,
  ]);
}
