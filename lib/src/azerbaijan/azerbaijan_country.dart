import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'azerbaijan_colors.dart';

/// The flag over `AZ` on a white block, the same on every class: only the field
/// around it changes, and a field is a [PlateTheme]. The caption is always
/// [AzerbaijanColors.ink] because it sits on white, where the white ink of the
/// blue and red plates would vanish. On the civilian plate the block is white
/// on white, so the flag looks printed on the plate.
abstract final class AzerbaijanCountry {
  static const PlateDrawing _flag = PlateDrawing(600, 300, <PlateShape>[
    PlateRectShape(0, 0, 600, 300, Color(0xFF00B9E4)),
    PlateRectShape(0, 100, 600, 200, Color(0xFFED2939)),
    PlateRectShape(0, 200, 600, 100, Color(0xFF509E2F)),
    PlateCrescentShape(262, 150, 45, 15, 36, Color(0xFFFFFFFF)),
    PlateStarShape(322, 150, 30, Color(0xFFFFFFFF), points: 8, innerRatio: 0.4133),
  ]);

  static const PlateCountry azerbaijan = PlateCountry(
    code: 'az',
    captionLines: <String>['AZ'],
    panelColor: AzerbaijanColors.field,
    panelTextColor: AzerbaijanColors.ink,
    flagAspectRatio: 2,
    flag: _flag,
  );
}
