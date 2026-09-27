import 'package:core_plate/core_plate.dart';

import 'tajikistan_colors.dart';

/// The `PlateTheme`s a Tajik plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host passes
/// one:
///
/// ```dart
/// PlateCanvas(
///   spec: TajikistanPlates.car,          // the same geometry ...
///   theme: TajikistanThemes.civilian,    // ... printed as a private car's plate
///   ...
/// )
/// ```
///
/// Every Tajik theme is a [PlateTheme.monochrome]: the plate is a field, an ink,
/// and nothing between them — no security band, no divider that takes a third
/// colour. The one design with a boxed-off region, the governmental plate, draws
/// its divider in the ink itself, which is exactly what `monochrome` sets the
/// divider to.
abstract final class TajikistanThemes {
  /// Frame thickness as a fraction of plate height. // CALIBRATE
  static const double _borderWidthRatio = 0.035;

  /// // CALIBRATE
  static const double _plateRadiusRatio = 0.10;

  /// Private cars, trailers and motorcycles: black on white.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: TajikistanColors.field,
    ink: TajikistanColors.ink,
    inactive: TajikistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Public transport: black on amber, on the plate that prints the fixed `TT`.
  static const PlateTheme transport = PlateTheme.monochrome(
    field: TajikistanColors.transportAmber,
    ink: TajikistanColors.onTransportAmber,
    inactive: TajikistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Vehicles of foreign citizens and companies: black on yellow.
  static const PlateTheme foreign = PlateTheme.monochrome(
    field: TajikistanColors.foreignYellow,
    ink: TajikistanColors.onForeignYellow,
    inactive: TajikistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// The diplomatic corps: white on red.
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: TajikistanColors.diplomaticRed,
    ink: TajikistanColors.onDiplomaticRed,
    inactive: TajikistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// The police: white on blue.
  static const PlateTheme police = PlateTheme.monochrome(
    field: TajikistanColors.policeBlue,
    ink: TajikistanColors.onPoliceBlue,
    inactive: TajikistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Governmental vehicles: white on black. The divider that boxes off the
  /// region comes out of the ink, which is what `monochrome` sets it to.
  static const PlateTheme governmental = PlateTheme.monochrome(
    field: TajikistanColors.governmentBlack,
    ink: TajikistanColors.onGovernmentBlack,
    inactive: TajikistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
