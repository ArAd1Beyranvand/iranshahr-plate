import 'package:plate_core/core_plate.dart';

import 'armenia_colors.dart';

/// The `PlateTheme`s an Armenian plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: ArmeniaPlates.car,          // the same geometry ...
///   theme: ArmeniaThemes.civilian,    // ... printed as a private car's plate
///   ...
/// )
/// ```
///
/// Four of the five are [PlateTheme.monochrome] and [civilian] is not, and the
/// difference is one strip of silver. The 2014 redesign put a holographic
/// identifier band immediately to the right of the flag; it is a
/// [PlateSpec.rules] entry, which takes [PlateTheme.dividerColor], and
/// `monochrome` sets the divider to the ink. A monochrome civilian theme would
/// print that band solid black. So [civilian] is written out in full for the
/// sake of one field, and the other four — none of which carries a band — say
/// what they are in five lines.
abstract final class ArmeniaThemes {
  /// Frame thickness as a fraction of plate height. // CALIBRATE
  static const double _borderWidthRatio = 0.035;

  /// // CALIBRATE
  static const double _plateRadiusRatio = 0.10;

  /// Private cars, motorcycles, trailers and public numbers: black on white,
  /// with the silver identifier band.
  ///
  /// The band only appears on the plates whose spec declares the rule, so this
  /// is also the trailer's theme: `ArmeniaPlates.trailer` is a pre-2014 design
  /// with no band, and a divider colour it never paints costs it nothing.
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

  /// Buses and long-range coaches: black on yellow, on
  /// [ArmeniaPlates.bus]'s geometry.
  static const PlateTheme bus = PlateTheme.monochrome(
    field: ArmeniaColors.busYellow,
    ink: ArmeniaColors.onBusYellow,
    inactive: ArmeniaColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// The diplomatic corps: white on red, on [ArmeniaPlates.diplomatic].
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: ArmeniaColors.diplomaticRed,
    ink: ArmeniaColors.onDiplomaticRed,
    inactive: ArmeniaColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// A United Nations office: white on blue, on [ArmeniaPlates.un].
  static const PlateTheme un = PlateTheme.monochrome(
    field: ArmeniaColors.unBlue,
    ink: ArmeniaColors.onUnBlue,
    inactive: ArmeniaColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// The Ministry of Defence: white on black, on [ArmeniaPlates.military].
  static const PlateTheme military = PlateTheme.monochrome(
    field: ArmeniaColors.militaryBlack,
    ink: ArmeniaColors.onMilitaryBlack,
    inactive: ArmeniaColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
