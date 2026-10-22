import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'turkmenistan_colors.dart';

/// The frame is 4.5 and the corner radius about 9 on the 110-high canvas,
/// measured on the yellow and blue flats (ring x 0.5–5.0; the top edge starts
/// 4.75 in at 1 unit down). The frame takes the ink colour on every plate.
abstract final class TurkmenistanThemes {
  /// Black on white: private and trailer.
  static final PlateTheme private = _theme(TurkmenistanColors.white, TurkmenistanColors.black);

  /// Dark slate on off-white: the 1994 series.
  static final PlateTheme classic = _theme(
    TurkmenistanColors.classicField,
    TurkmenistanColors.classicInk,
  );

  /// Black on yellow: foreign nationals, foreign trailers and export.
  static final PlateTheme foreign = _theme(TurkmenistanColors.yellow, TurkmenistanColors.black);

  /// White on blue: diplomatic.
  static final PlateTheme diplomatic = _theme(
    TurkmenistanColors.diplomaticBlue,
    TurkmenistanColors.white,
  );

  /// White on green: government, military and ceremony.
  static final PlateTheme government = _theme(TurkmenistanColors.green, TurkmenistanColors.white);
}

PlateTheme _theme(Color field, Color ink) => PlateTheme.monochrome(
  field: field,
  ink: ink,
  inactive: TurkmenistanColors.inactive,
  borderWidthRatio: 4.5 / 110,
  plateRadiusRatio: 9 / 110,
);
