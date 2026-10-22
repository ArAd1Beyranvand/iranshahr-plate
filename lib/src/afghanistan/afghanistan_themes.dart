import 'package:plate_core/plate_core.dart';

import 'afghanistan_colors.dart';

/// Five liveries over eleven classes: colour is coarser than class, so a bus
/// and a taxi share [transport] and a car, lorry, motorcycle, rickshaw,
/// duplicate and temporary plate share [civilian], each told apart by its class
/// register. All are monochrome; the temporary plate's red wording is carried
/// by its labels (see `AfghanistanColors.temporaryRed`).
///
/// The province block's ink is not themed here: pick it with
/// `AfghanistanProvince.country(ink:)` to match the field.
abstract final class AfghanistanThemes {
  static const double _borderWidthRatio = 0.035; // CALIBRATE

  static const double _plateRadiusRatio = 0.09; // CALIBRATE

  /// Black on white.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: AfghanistanColors.field,
    ink: AfghanistanColors.ink,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Black on yellow.
  static const PlateTheme transport = PlateTheme.monochrome(
    field: AfghanistanColors.transportYellow,
    ink: AfghanistanColors.onTransportYellow,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// White on red.
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: AfghanistanColors.diplomaticRed,
    ink: AfghanistanColors.onDiplomaticRed,
    inactive: AfghanistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// White on black.
  static const PlateTheme governmental = PlateTheme.monochrome(
    field: AfghanistanColors.governmentalBlack,
    ink: AfghanistanColors.onGovernmentalBlack,
    inactive: AfghanistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Black on blue.
  static const PlateTheme un = PlateTheme.monochrome(
    field: AfghanistanColors.unBlue,
    ink: AfghanistanColors.onUnBlue,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
