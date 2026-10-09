import 'package:plate_core/plate_core.dart';

import 'turkmenistan_colors.dart';

/// Turkmenistan as a `PlateCountry`. There is no country panel: the flag and
/// `TM` are drawn by the spec.
abstract final class TurkmenistanCountry {
  static const PlateCountry turkmenistan = PlateCountry(
    code: 'tm',
    captionLines: <String>[],
    panelColor: TurkmenistanColors.green,
    panelTextColor: TurkmenistanColors.white,
  );
}
