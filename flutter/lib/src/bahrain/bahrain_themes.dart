import 'package:plate_core/plate_core.dart';

import 'bahrain_colors.dart';

/// None is a [PlateTheme.monochrome]: the grey security band is on every plate,
/// so the divider colour cannot derive from the ink.
abstract final class BahrainThemes {
  static const double _borderWidthRatio = 0.03; // CALIBRATE
  static const double _plateRadiusRatio = 0.14; // CALIBRATE

  /// Blue on white, in every size.
  static const PlateTheme civilian = PlateTheme(
    plateBackground: BahrainColors.field,
    plateBorder: BahrainColors.blue,
    ink: BahrainColors.blue,
    dividerColor: BahrainColors.band,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: BahrainColors.blue,
    inactiveColor: BahrainColors.inactiveOnLight,
  );

  /// Near-black on white, in a green frame.
  static const PlateTheme diplomatic = PlateTheme(
    plateBackground: BahrainColors.field,
    plateBorder: BahrainColors.diplomaticGreen,
    ink: BahrainColors.darkInk,
    dividerColor: BahrainColors.band,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: BahrainColors.darkInk,
    inactiveColor: BahrainColors.inactiveOnLight,
  );

  /// Near-black on white, in the dark blue of the band's wording.
  static const PlateTheme police = PlateTheme(
    plateBackground: BahrainColors.field,
    plateBorder: BahrainColors.onPoliceBlue,
    ink: BahrainColors.darkInk,
    dividerColor: BahrainColors.band,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: BahrainColors.darkInk,
    inactiveColor: BahrainColors.inactiveOnLight,
  );
}
