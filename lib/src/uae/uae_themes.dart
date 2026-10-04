import 'package:plate_core/core_plate.dart';

import 'uae_colors.dart';

/// The `PlateTheme`s a UAE plate is printed in: black on white, one theme per
/// canvas, since the frame's width and corner radius are ratios of the plate
/// height. Abu Dhabi's red is geometry, in its spec's background, and
/// Sharjah's heavier frame is its spec's `borderWidthRatioOverride`.
abstract final class UaeThemes {
  static PlateTheme _theme({
    required double borderWidthRatio,
    required double plateRadiusRatio,
  }) => PlateTheme(
    plateBackground: UaeColors.field,
    plateBorder: UaeColors.ink,
    ink: UaeColors.ink,
    dividerColor: UaeColors.ink,
    borderWidthRatio: borderWidthRatio,
    plateRadiusRatio: plateRadiusRatio,
    activeColor: UaeColors.ink,
    inactiveColor: UaeColors.inactiveOnLight,
  );

  /// 520x110: a 4.8 mm frame and an 11 mm corner radius, measured off the
  /// reference artwork.
  static final PlateTheme long = _theme(
    borderWidthRatio: 4.8 / 110,
    plateRadiusRatio: 11 / 110,
  );

  /// 335x155: a 3 mm frame and a 10.4 mm corner radius, same source.
  static final PlateTheme short = _theme(
    borderWidthRatio: 3 / 155,
    plateRadiusRatio: 10.4 / 155,
  );
}
