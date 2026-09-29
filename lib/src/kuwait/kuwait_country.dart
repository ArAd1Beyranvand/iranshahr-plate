import 'package:core_plate/core_plate.dart';

import 'kuwait_colors.dart';

/// The blocks that go in a Kuwaiti plate's [PlateSpec.panel].
///
/// **Every constant here has `code: 'kw'`, so they all compare equal.** That is
/// the same contract the other country packages in this workspace keep: the
/// code identifies the country, and the rest of the value is how that country's
/// block is printed on one class of plate. A host that wants to know which
/// block it is holding asks the spec, not the code.
///
/// Captions and colours are transcribed from the "Vehicle types" table on
/// Wikipedia's "Vehicle registration plates of Kuwait" article, one row per
/// constant below.
abstract final class KuwaitCountry {
  /// Official ratio of the flag of Kuwait is 1:2 — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 2/1.
  static const double _flagAspectRatio = 2 / 1;

  /// Private: black on white, "دولة الكويت" (codes 1-89).
  static const PlateCountry civilian = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.civField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// Public: black on yellow, "دولة الكويت" (codes 90-99: 91 general, 92 buses,
  /// 93 taxis, 95 goods export).
  static const PlateCountry transport = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.transField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// Police: white on black, "POLICE شرطة".
  static const PlateCountry police = PlateCountry(
    code: 'kw',
    captionLines: <String>['POLICE', 'شرطة'],
    panelColor: KuwaitColors.policeField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Police motorcycle: white on black, "شرطة" only.
  static const PlateCountry policeMotorcycle = PlateCountry(
    code: 'kw',
    captionLines: <String>['شرطة'],
    panelColor: KuwaitColors.policeField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Government: black on blue, "دولة الكويت — حكومة".
  static const PlateCountry government = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'حكومة'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// Corps Diplomatique: blue text on white field, red band along the bottom,
  /// "هيئة دبلوماسية / C.D".
  static const PlateCountry diplomatic = PlateCountry(
    code: 'kw',
    captionLines: <String>['هيئة دبلوماسية', 'C.D'],
    panelColor: KuwaitColors.civField,
    panelTextColor: KuwaitColors.govField,
    flagAspectRatio: _flagAspectRatio,
  );

  /// National guard: yellow on green, "الحرس الوطني".
  static const PlateCountry nationalGuard = PlateCountry(
    code: 'kw',
    captionLines: <String>['الحرس الوطني'],
    panelColor: KuwaitColors.guardField,
    panelTextColor: KuwaitColors.transField,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// Army: black on beige, "الجيش الكويتي".
  static const PlateCountry army = PlateCountry(
    code: 'kw',
    captionLines: <String>['الجيش الكويتي'],
    panelColor: KuwaitColors.armyField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Commercial: black on pink, "دولة الكويت — تجاري".
  static const PlateCountry commercial = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'تجاري'],
    panelColor: KuwaitColors.commField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Construction: black on orange, "دولة الكويت — إنشاءت".
  static const PlateCountry construction = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'إنشاءت'],
    panelColor: KuwaitColors.constructField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// General Firefighting: black on red, "FIRE — الإطفاء العام".
  static const PlateCountry firefighting = PlateCountry(
    code: 'kw',
    captionLines: <String>['FIRE', 'الإطفاء العام'],
    panelColor: KuwaitColors.fireField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Export: black on green, "دولة الكويت — تصدير".
  static const PlateCountry export = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'تصدير'],
    panelColor: KuwaitColors.exportField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Temporary Customs: black on purple, "دولة الكويت — جمرك مؤقت".
  static const PlateCountry customs = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'جمرك مؤقت'],
    panelColor: KuwaitColors.customsField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Emiri Bureau: white on blue, "دولة الكويت — الديوان الأميري".
  static const PlateCountry emiri = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'الديوان الأميري'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Emiri Guard: white on blue, "الحرس — الأميري".
  static const PlateCountry emiriGuard = PlateCountry(
    code: 'kw',
    captionLines: <String>['الحرس', 'الأميري'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );
}
