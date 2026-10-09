import 'package:plate_core/plate_core.dart';

import 'kazakhstan_colors.dart';

/// Kazakhstan as a `PlateCountry`. There is no country panel: the flag and
/// `KZ` are placed by the spec; this carries the flag for hosts that list
/// countries.
abstract final class KazakhstanCountry {
  static const PlateCountry kazakhstan = PlateCountry(
    code: 'kz',
    captionLines: <String>[],
    panelColor: KazakhstanColors.flagBlue,
    panelTextColor: KazakhstanColors.black,
    flagAspectRatio: 2,
    flag: SvgPlateAsset(
      'assets/icons/kazakhstan_flag.svg',
      package: 'iranshahr_plate',
    ),
  );
}
