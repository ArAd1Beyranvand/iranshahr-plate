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
/// Kuwait has a simple design pattern: the country block at the left always
/// displays "دولة الكويت" (State of Kuwait) with the flag in a coloured field
/// that varies by vehicle class. The panel's background colour identifies the
/// plate type: white for civilian, yellow for taxis and buses, red for police,
/// blue for government and diplomatic, etc.
abstract final class KuwaitCountry {
  /// Official ratio of the flag of Kuwait is 1:2 — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 2/1.
  static const double _flagAspectRatio = 2 / 1;

  /// The flag on white: civilian private vehicles (codes 1-89).
  static const PlateCountry civilian = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.civField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// The flag on yellow: public transport vehicles — taxis, buses, goods export
  /// (codes 90-99).
  static const PlateCountry transport = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.transField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// The flag on red: police vehicles. White text reversed out on the red band.
  static const PlateCountry police = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'الشرطة'],
    panelColor: KuwaitColors.policeField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// The flag on blue: government vehicles and diplomatic corps. White text on
  /// the blue band.
  static const PlateCountry government = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// The flag on blue: diplomatic corps vehicles. White text on the blue band.
  static const PlateCountry diplomatic = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'دبلوماسي'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// The flag on green: national guard vehicles. White text on the green band.
  static const PlateCountry nationalGuard = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'الحرس الوطني'],
    panelColor: KuwaitColors.guardField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Kuwait.svg', package: 'iranshahr_plate'),
  );

  /// Plain coloured band, no flag: military/army vehicles on beige background.
  static const PlateCountry army = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'الجيش'],
    panelColor: KuwaitColors.armyField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Commercial vehicles on pink background.
  static const PlateCountry commercial = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.commField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Construction vehicles on orange background.
  static const PlateCountry construction = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.constructField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Firefighting vehicles on red background.
  static const PlateCountry firefighting = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'الإطفاء'],
    panelColor: KuwaitColors.fireField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Export/goods export vehicles on green background.
  static const PlateCountry export = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.exportField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Temporary/customs vehicles on purple background.
  static const PlateCountry customs = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.customsField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Emiri Bureau vehicles on blue background.
  static const PlateCountry emiri = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'الديوان الأميري'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );
}
