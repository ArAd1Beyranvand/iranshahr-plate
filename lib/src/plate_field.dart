import 'dart:math' as math;

import 'package:flutter/widgets.dart' show Color;
import 'package:plate_core/plate_core.dart';

/// One field of [count] cells, the first [width] wide at [left], stepping by
/// [pitch] (default [width]): one box, one focus stop.
///
/// A fixed field is spaced so its run sits at the printed pitch; a variable one
/// ([minLength] set) has spacing 0 and its shorter runs sit centred in the box
/// laid out for the longest.
PlateSlot plateField({
  required PlateAlphabet alphabet,
  required int count,
  required double left,
  required double top,
  required double width,
  required double height,
  double? pitch,
  int? minLength,
  Color? color,
}) {
  final step = pitch ?? width;
  return PlateSlot(
    alphabet: alphabet,
    box: PlateBox(left, top, (count - 1) * step + width, height),
    length: count,
    minLength: minLength,
    color: color,
    spacing: count == 1 || minLength != null ? 0 : math.max(0, step - 0.6 * 0.72 * height),
  );
}
