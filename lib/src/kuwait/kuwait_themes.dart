import 'package:core_plate/core_plate.dart';

import 'kuwait_colors.dart';

/// The `PlateTheme`s a Kuwaiti plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: KuwaitPlates.civilian,
///   country: KuwaitCountry.civilian,
///   theme: KuwaitThemes.civilian,
///   ...
/// )
/// ```
///
/// Kuwait's colour palette is tied to vehicle class: civilian white with black
/// text, public transport yellow with black text, police red with white text,
/// and so on. These themes capture that pattern.
abstract final class KuwaitThemes {
  /// Frame thickness as a fraction of plate height. // CALIBRATE
  static const double _borderWidthRatio = 0.04;

  /// Slightly rounded corners — less generous than Bahrain's, more generous
  /// than standard European plates. // CALIBRATE
  static const double _plateRadiusRatio = 0.08;

  /// Civilian private vehicles: black text on white field, dark frame.
  static const PlateTheme civilian = PlateTheme(
    plateBackground: KuwaitColors.civField,
    plateBorder: KuwaitColors.darkInk,
    ink: KuwaitColors.darkInk,
    dividerColor: KuwaitColors.darkInk,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.darkInk,
    inactiveColor: KuwaitColors.inactiveOnLight,
  );

  /// Public transport vehicles: black text on yellow field, dark frame.
  static const PlateTheme transport = PlateTheme(
    plateBackground: KuwaitColors.transField,
    plateBorder: KuwaitColors.darkInk,
    ink: KuwaitColors.darkInk,
    dividerColor: KuwaitColors.darkInk,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.darkInk,
    inactiveColor: KuwaitColors.inactiveOnLight,
  );

  /// Police vehicles: white text on red field, red frame.
  static const PlateTheme police = PlateTheme(
    plateBackground: KuwaitColors.policeField,
    plateBorder: KuwaitColors.policeField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );

  /// Government and diplomatic vehicles: white text on blue field, blue frame.
  static const PlateTheme government = PlateTheme(
    plateBackground: KuwaitColors.govField,
    plateBorder: KuwaitColors.govField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );

  /// National guard vehicles: white text on green field, green frame.
  static const PlateTheme nationalGuard = PlateTheme(
    plateBackground: KuwaitColors.guardField,
    plateBorder: KuwaitColors.guardField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );

  /// Army vehicles: black text on beige field, beige frame.
  static const PlateTheme army = PlateTheme(
    plateBackground: KuwaitColors.armyField,
    plateBorder: KuwaitColors.darkInk,
    ink: KuwaitColors.darkInk,
    dividerColor: KuwaitColors.darkInk,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.darkInk,
    inactiveColor: KuwaitColors.inactiveOnLight,
  );

  /// Commercial vehicles: black text on pink field, dark frame.
  static const PlateTheme commercial = PlateTheme(
    plateBackground: KuwaitColors.commField,
    plateBorder: KuwaitColors.darkInk,
    ink: KuwaitColors.darkInk,
    dividerColor: KuwaitColors.darkInk,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.darkInk,
    inactiveColor: KuwaitColors.inactiveOnLight,
  );

  /// Construction vehicles: black text on orange field, dark frame.
  static const PlateTheme construction = PlateTheme(
    plateBackground: KuwaitColors.constructField,
    plateBorder: KuwaitColors.darkInk,
    ink: KuwaitColors.darkInk,
    dividerColor: KuwaitColors.darkInk,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.darkInk,
    inactiveColor: KuwaitColors.inactiveOnLight,
  );

  /// Firefighting vehicles: white text on red field, red frame.
  static const PlateTheme firefighting = PlateTheme(
    plateBackground: KuwaitColors.fireField,
    plateBorder: KuwaitColors.fireField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );

  /// Export/goods export vehicles: white text on green field, green frame.
  static const PlateTheme export = PlateTheme(
    plateBackground: KuwaitColors.exportField,
    plateBorder: KuwaitColors.exportField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );

  /// Temporary/customs vehicles: white text on purple field, purple frame.
  static const PlateTheme customs = PlateTheme(
    plateBackground: KuwaitColors.customsField,
    plateBorder: KuwaitColors.customsField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );

  /// Emiri Bureau vehicles: white text on blue field, blue frame.
  static const PlateTheme emiri = PlateTheme(
    plateBackground: KuwaitColors.govField,
    plateBorder: KuwaitColors.govField,
    ink: KuwaitColors.whiteText,
    dividerColor: KuwaitColors.whiteText,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: KuwaitColors.whiteText,
    inactiveColor: KuwaitColors.inactiveOnDark,
  );
}
