import 'package:plate_core/plate_core.dart';

import 'kazakhstan_colors.dart';

/// Black on white, shared by every current plate.
///
/// The artwork's frame is 3.6 thick (x 3.75–7.4 of 520) and sits 3.75 in from
/// the canvas edge, behind a white margin the engine cannot inset; it is drawn
/// at the edge instead, so the frame is 3.75 further out than the reference.
/// Corner radius about 6.
abstract final class KazakhstanThemes {
  static final PlateTheme private = PlateTheme.monochrome(
    field: KazakhstanColors.white,
    ink: KazakhstanColors.black,
    inactive: KazakhstanColors.inactive,
    borderWidthRatio: 3.6 / 110,
    plateRadiusRatio: 6 / 110,
  );

  /// White on orange-red: diplomatic. The white outer rim of the photo is
  /// about 3.7 thick.
  static final PlateTheme diplomatic = PlateTheme.monochrome(
    field: KazakhstanColors.diplomaticOrange,
    ink: KazakhstanColors.white,
    inactive: KazakhstanColors.inactive,
    borderWidthRatio: 3.7 / 110,
    plateRadiusRatio: 6 / 110,
  );

  /// The non-private plate is the same black on white.
  static final PlateTheme nonPrivate = private;
}
