import 'package:plate_core/plate_core.dart';

import 'armenia_colors.dart';

/// [civilian] is the only theme not written as a monochrome: the identifier
/// band is a [PlateSpec.rules] entry, which takes [PlateTheme.dividerColor], and
/// `monochrome` would set that to the ink and print the band black.
abstract final class ArmeniaThemes {
  static const double _borderWidthRatio = 0.035; // CALIBRATE
  static const double _plateRadiusRatio = 0.10; // CALIBRATE

  /// Black on white with the silver band. Also the trailer's theme: its spec
  /// declares no rule, so the divider colour is never painted.
  static const PlateTheme civilian = PlateTheme(
    plateBackground: ArmeniaColors.field,
    plateBorder: ArmeniaColors.ink,
    ink: ArmeniaColors.ink,
    dividerColor: ArmeniaColors.identifierBand,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: ArmeniaColors.ink,
    inactiveColor: ArmeniaColors.inactiveOnLight,
  );

  static const PlateTheme bus = PlateTheme.monochrome(
    field: ArmeniaColors.busYellow,
    ink: ArmeniaColors.onBusYellow,
    inactive: ArmeniaColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: ArmeniaColors.diplomaticRed,
    ink: ArmeniaColors.onDiplomaticRed,
    inactive: ArmeniaColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  static const PlateTheme un = PlateTheme.monochrome(
    field: ArmeniaColors.unBlue,
    ink: ArmeniaColors.onUnBlue,
    inactive: ArmeniaColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  static const PlateTheme military = PlateTheme.monochrome(
    field: ArmeniaColors.militaryBlack,
    ink: ArmeniaColors.onMilitaryBlack,
    inactive: ArmeniaColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
