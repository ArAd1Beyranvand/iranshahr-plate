import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'bahrain_colors.dart';

/// Every constant has `code: 'bh'`, so they compare equal; a host asks the spec,
/// not the code, which block it holds.
///
/// Civilian plates ([civilian]) print no coloured block: the flag sits on the
/// white field, so the panel is the flag's rectangle in the field colour. The
/// special plates ([diplomatic], [police]) print a coloured band and no flag.
/// All wording is [PlateLabel]s placed on the face, not captions, because a
/// caption is one column under the flag and no Bahraini plate sets it so.
abstract final class BahrainCountry {
  static const PlateDrawing _flag = PlateDrawing(500, 300, <PlateShape>[
    PlateRectShape(0, 0, 500, 300, Color(0xFFFFFFFF)),
    PlateRectShape(180, 0, 320, 300, Color(0xFFCE1126)),
    PlatePolygonShape(<Offset>[
      Offset(120, 0),
      Offset(180, 30),
      Offset(120, 60),
      Offset(180, 90),
      Offset(120, 120),
      Offset(180, 150),
      Offset(120, 180),
      Offset(180, 210),
      Offset(120, 240),
      Offset(180, 270),
      Offset(120, 300),
      Offset(180, 300),
      Offset(180, 0),
    ], Color(0xFFCE1126)),
  ]);

  static const double _flagAspectRatio = 5 / 3;

  static const PlateCountry civilian = PlateCountry(
    code: 'bh',
    captionLines: <String>[],
    // The field colour, so the panel is invisible.
    panelColor: BahrainColors.field,
    panelTextColor: BahrainColors.blue,
    flagAspectRatio: _flagAspectRatio,
    flag: _flag,
    // A fine line around the flag, distinct from the plate frame. // CALIBRATE
    flagBorderColor: BahrainColors.darkInk,
  );

  /// Green band; its labels are reversed out white.
  static const PlateCountry diplomatic = PlateCountry(
    code: 'bh',
    captionLines: <String>[],
    panelColor: BahrainColors.diplomaticGreen,
    panelTextColor: BahrainColors.onDiplomaticGreen,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Pale blue band; its labels are dark.
  static const PlateCountry police = PlateCountry(
    code: 'bh',
    captionLines: <String>[],
    panelColor: BahrainColors.policeBlue,
    panelTextColor: BahrainColors.onPoliceBlue,
    flagAspectRatio: _flagAspectRatio,
  );
}
