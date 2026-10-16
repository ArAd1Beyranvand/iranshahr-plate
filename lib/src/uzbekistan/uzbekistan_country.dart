import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'uzbekistan_colors.dart';

/// The flag over `UZ` (in the flag's sky-blue), printed straight on the white
/// field. The flag is the vector at its true 2:1; the artwork's is squashed.
abstract final class UzbekistanCountry {
  static const PlateDrawing _flag = PlateDrawing(1000, 500, <PlateShape>[
    PlateRectShape(0, 0, 1000, 500, Color(0xFF1EB53A)),
    PlateRectShape(0, 0, 1000, 250, Color(0xFF0099B5)),
    PlateRectShape(0, 160, 1000, 180, Color(0xFFCE1126)),
    PlateRectShape(0, 170, 1000, 160, Color(0xFFFFFFFF)),
    PlateCrescentShape(140, 80, 60, 20, 60, Color(0xFFFFFFFF)),
    PlateStarShape(272, 32, 12, Color(0xFFFFFFFF)),
    PlateStarShape(320, 32, 12, Color(0xFFFFFFFF)),
    PlateStarShape(368, 32, 12, Color(0xFFFFFFFF)),
    PlateStarShape(224, 80, 12, Color(0xFFFFFFFF)),
    PlateStarShape(272, 80, 12, Color(0xFFFFFFFF)),
    PlateStarShape(320, 80, 12, Color(0xFFFFFFFF)),
    PlateStarShape(368, 80, 12, Color(0xFFFFFFFF)),
    PlateStarShape(176, 128, 12, Color(0xFFFFFFFF)),
    PlateStarShape(224, 128, 12, Color(0xFFFFFFFF)),
    PlateStarShape(272, 128, 12, Color(0xFFFFFFFF)),
    PlateStarShape(320, 128, 12, Color(0xFFFFFFFF)),
    PlateStarShape(368, 128, 12, Color(0xFFFFFFFF)),
  ]);

  static const PlateCountry uzbekistan = PlateCountry(
    code: 'uz',
    captionLines: <String>['UZ'],
    panelColor: UzbekistanColors.white,
    panelTextColor: UzbekistanColors.caption,
    flagAspectRatio: 2,
    flag: _flag,
  );
}
