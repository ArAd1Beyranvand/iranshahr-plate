import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'uzbekistan_colors.dart';

/// One ink on one field, frame and dividers in the ink.
abstract final class UzbekistanThemes {
  /// Frame ~3.5% of the height (4 of 110), corners ~8%, off the artwork.
  static PlateTheme _mono(Color field, Color ink, Color inactive) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    inactive: inactive,
    borderWidthRatio: 0.035,
    plateRadiusRatio: 0.08,
  );

  static final PlateTheme passenger = _mono(
    UzbekistanColors.white,
    UzbekistanColors.black,
    UzbekistanColors.inactiveOnLight,
  );

  /// Temporary, trailer and motorcycle plates are black on white too.
  static final PlateTheme temporary = passenger;
  static final PlateTheme trailer = passenger;
  static final PlateTheme motorcycle = passenger;

  static final PlateTheme foreignCitizen = _mono(
    UzbekistanColors.yellow,
    UzbekistanColors.black,
    UzbekistanColors.inactiveOnLight,
  );

  static final PlateTheme foreignCompany = _mono(
    UzbekistanColors.green,
    UzbekistanColors.white,
    UzbekistanColors.inactiveOnDark,
  );

  /// Ambassadors, diplomats and staff share the green field.
  static final PlateTheme diplomatic = foreignCompany;

  static final PlateTheme unitedNations = _mono(
    UzbekistanColors.blue,
    UzbekistanColors.white,
    UzbekistanColors.inactiveOnDark,
  );
}
