import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'iraq_colors.dart';

/// The `PlateTheme`s an Iraqi plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one, along with the [IraqCountry] that colours the band:
///
/// ```dart
/// PlateCanvas(
///   spec: IraqPlates.large,
///   country: IraqCountry.hire,
///   theme: IraqThemes.large,
///   ...
/// )
/// ```
///
/// There is one theme per *canvas*, not per class. The class is entirely in
/// the band colour, which is the country's; what the theme carries is the
/// frame, and the frame's width and corner radius are ratios of the canvas
/// height, so the 520x110 and 335x155 plates need different numbers to come
/// out the same few millimetres on the glass.
abstract final class IraqThemes {
  static PlateTheme _theme({
    required double borderWidthRatio,
    required double plateRadiusRatio,
    Color ink = IraqColors.ink,
  }) => PlateTheme(
    plateBackground: IraqColors.field,
    plateBorder: ink,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: borderWidthRatio,
    plateRadiusRatio: plateRadiusRatio,
    activeColor: ink,
    inactiveColor: IraqColors.inactiveOnLight,
  );

  /// 520x110: a 4.3 mm frame and an 8.0 mm corner radius, measured off the
  /// reference artwork.
  static final PlateTheme large = _theme(
    borderWidthRatio: 4.3 / 110,
    plateRadiusRatio: 8.0 / 110,
  );

  /// 335x155: a 3.7 mm frame and a 6.5 mm corner radius, same source. Both
  /// are close to [large] in millimetres and so far from it as a ratio — the
  /// frame is drawn at a constant physical width on a much shorter plate.
  static final PlateTheme small = _theme(
    borderWidthRatio: 3.7 / 155,
    plateRadiusRatio: 6.5 / 155,
  );

  /// 335x155 temporary: [small]'s geometry printed in red rather than black.
  /// The whole monochrome set changes — a red plate has a red rim and a red
  /// divider, which the reference confirms.
  static final PlateTheme temporary = _theme(
    borderWidthRatio: 3.7 / 155,
    plateRadiusRatio: 6.5 / 155,
    ink: IraqColors.temporaryInk,
  );
}
