import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'armenia_colors.dart';

/// The block that goes in an Armenian plate's [PlateSpec.panel].
///
/// **One value, for every class of plate that carries a block at all** — the
/// flag with `AM` set beneath it, on white. Nothing about it changes with the
/// class; on the civilian plate the white block sits on a white field and
/// cannot be seen, so the flag and the caption appear to be printed straight on
/// the plate. That is the same trick `AzerbaijanCountry.azerbaijan` plays, and
/// for the same reason.
///
/// Three Armenian designs carry no block: the diplomatic, UN and military
/// plates print their own wording where a flag would go and declare
/// [PlateSpec.noPanel]. They still name this country — a spec always has one —
/// and simply never paint it.
///
/// The word `ARMENIA` set in micro-lettering above the flag on the 2014 design
/// is not reproduced. It is a security feature a few tenths of a millimetre
/// tall, illegible at plate scale and illegible in every photograph of one; a
/// second caption line would print it at a size the real plate never does.
abstract final class ArmeniaCountry {
  static const PlateDrawing _flag = PlateDrawing(600, 300, <PlateShape>[
    PlateRectShape(0, 0, 600, 300, Color(0xFFD90012)),
    PlateRectShape(0, 100, 600, 200, Color(0xFF0033A0)),
    PlateRectShape(0, 200, 600, 100, Color(0xFFF2A800)),
  ]);

  /// Official ratio of the flag of Armenia is 1:2 — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 2.
  static const double _flagAspectRatio = 2;

  /// The flag over `AM`, on a white block: every Armenian plate in this package
  /// that has a block.
  static const PlateCountry armenia = PlateCountry(
    code: 'am',
    captionLines: <String>['AM'],
    panelColor: ArmeniaColors.field,
    panelTextColor: ArmeniaColors.ink,
    flagAspectRatio: _flagAspectRatio,
    flag: _flag,
  );
}
