import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'armenia_colors.dart';

/// The flag over `AM` on white. On the white civilian field the block cannot
/// be seen, so the flag and caption look printed straight on the plate.
///
/// The diplomatic, UN and military plates declare [PlateSpec.noPanel] and never
/// paint it. The micro-lettered `ARMENIA` security print is omitted: it is
/// illegible at plate scale.
abstract final class ArmeniaCountry {
  static const PlateDrawing _flag = PlateDrawing(600, 300, <PlateShape>[
    PlateRectShape(0, 0, 600, 300, Color(0xFFD90012)),
    PlateRectShape(0, 100, 600, 200, Color(0xFF0033A0)),
    PlateRectShape(0, 200, 600, 100, Color(0xFFF2A800)),
  ]);

  static const PlateCountry armenia = PlateCountry(
    code: 'am',
    captionLines: <String>['AM'],
    panelColor: ArmeniaColors.field,
    panelTextColor: ArmeniaColors.ink,
    flagAspectRatio: 2,
    flag: _flag,
  );
}
