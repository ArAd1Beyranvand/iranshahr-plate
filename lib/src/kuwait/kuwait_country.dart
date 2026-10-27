import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'kuwait_colors.dart';

/// The blocks that go in a Kuwaiti plate's [PlateSpec.panel].
///
/// **Every constant here has `code: 'kw'`, so they all compare equal.** That is
/// the same contract the other country packages in this workspace keep: the
/// code identifies the country, and the rest of the value is how that country's
/// block is printed on one class of plate. A host that wants to know which
/// block it is holding asks the spec, not the code.
///
/// Captions and colours are transcribed from the "Vehicle types" table on
/// Wikipedia's "Vehicle registration plates of Kuwait" article, one row per
/// constant below.
abstract final class KuwaitCountry {
  static const PlateDrawing _flag = PlateDrawing(600, 300, <PlateShape>[
    PlateRectShape(0, 0, 600, 300, Color(0xFF007A3D)),
    PlateRectShape(0, 100, 600, 200, Color(0xFFFFFFFF)),
    PlateRectShape(0, 200, 600, 100, Color(0xFFCE1126)),
    PlatePolygonShape(<Offset>[
      Offset(0, 0),
      Offset(150, 100),
      Offset(150, 200),
      Offset(0, 300),
    ], Color(0xFF000000)),
  ]);

  /// Official ratio of the flag of Kuwait is 1:2 — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 2/1.
  static const double _flagAspectRatio = 2 / 1;

  /// Private: black on white, "دولة الكويت" (codes 1-89).
  static const PlateCountry civilian = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.civField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: _flag,
  );

  /// Public: black on yellow, "دولة الكويت" (codes 90-99: 91 general, 92 buses,
  /// 93 taxis, 95 goods export).
  static const PlateCountry transport = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت'],
    panelColor: KuwaitColors.transField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: _flag,
  );

  /// Police: white on black, "POLICE شرطة".
  static const PlateCountry police = PlateCountry(
    code: 'kw',
    captionLines: <String>['POLICE', 'شرطة'],
    panelColor: KuwaitColors.policeField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Police motorcycle: white on black, "شرطة" only.
  static const PlateCountry policeMotorcycle = PlateCountry(
    code: 'kw',
    captionLines: <String>['شرطة'],
    panelColor: KuwaitColors.policeField,
    panelTextColor: KuwaitColors.whiteText,
    flagAspectRatio: _flagAspectRatio,
  );

  /// Government: black on blue, "دولة الكويت — حكومة".
  static const PlateCountry government = PlateCountry(
    code: 'kw',
    captionLines: <String>['دولة الكويت', 'حكومة'],
    panelColor: KuwaitColors.govField,
    panelTextColor: KuwaitColors.darkInk,
    flagAspectRatio: _flagAspectRatio,
    flag: _flag,
  );

  /// Corps Diplomatique: blue text on white field, red band along the bottom,
  /// "هيئة دبلوماسية / C.D".
  static const PlateCountry diplomatic = PlateCountry(
    code: 'kw',
    captionLines: <String>['هيئة دبلوماسية', 'C.D'],
    panelColor: KuwaitColors.civField,
    panelTextColor: KuwaitColors.govField,
    flagAspectRatio: _flagAspectRatio,
  );

  /// National guard: yellow on teal, "الحرس الوطني".
  static const PlateCountry nationalGuard = PlateCountry(
    code: 'kw',
    captionLines: <String>['الحرس الوطني'],
    panelColor: KuwaitColors.guardField,
    panelTextColor: KuwaitColors.transField,
    flagAspectRatio: _flagAspectRatio,
    flag: _flag,
  );

}
