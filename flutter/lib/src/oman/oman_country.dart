import 'package:plate_core/plate_core.dart';

import 'oman_colors.dart';

/// Oman prints no flag or country block: the name is a label on the spec, set
/// in the plate's third panel. Every plate here sets `noPanel`.
abstract final class OmanCountry {
  static const PlateCountry oman = PlateCountry(
    code: 'om',
    captionLines: <String>[],
    panelColor: OmanColors.yellow,
    panelTextColor: OmanColors.black,
  );
}
