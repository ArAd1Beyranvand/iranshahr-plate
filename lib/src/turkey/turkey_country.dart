import 'package:plate_core/plate_core.dart';

import 'turkey_colors.dart';

/// The block a Turkish plate would put in its panel. None has one: the TR
/// strip is a region of the spec's background with "TR" set as a label, so
/// every spec is `noPanel` and this exists only because `PlateCanvas` takes a
/// country.
abstract final class TurkeyCountry {
  static const PlateCountry turkey = PlateCountry(
    code: 'tr',
    captionLines: <String>['TR'],
    panelColor: TurkeyColors.stripBlue,
    panelTextColor: TurkeyColors.white,
  );
}
