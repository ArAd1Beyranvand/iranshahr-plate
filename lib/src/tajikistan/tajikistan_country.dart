import 'package:plate_core/plate_core.dart';

import 'package:flutter/widgets.dart' show Color;

/// The flag over `TJ`, printed straight on the field: the block is transparent
/// and its `TJ` takes the theme's ink, so one block serves the white, amber and
/// blue liveries `TajikistanThemes.byLetters` switches between.
///
/// The flagless designs (foreign, diplomatic, governmental) name it too but
/// declare [PlateSpec.noPanel].
abstract final class TajikistanCountry {
  static const PlateCountry civilian = PlateCountry(
    code: 'tj',
    captionLines: <String>['TJ'],
    panelColor: Color(0x00000000),
    panelTextColor: null,
    flagAspectRatio: 2, // the flag's official 1:2
    flag: SvgPlateAsset(
      'assets/flags/Flag_of_Tajikistan.svg',
      package: 'iranshahr_plate',
    ),
  );
}
