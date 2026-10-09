import 'package:plate_core/plate_core.dart';

import 'uzbekistan_colors.dart';

/// The flag over `UZ` (in the flag's sky-blue), printed straight on the white
/// field. The flag is the vector at its true 2:1; the artwork's is squashed.
abstract final class UzbekistanCountry {
  static const PlateCountry uzbekistan = PlateCountry(
    code: 'uz',
    captionLines: <String>['UZ'],
    panelColor: UzbekistanColors.white,
    panelTextColor: UzbekistanColors.caption,
    flagAspectRatio: 2,
    flag: SvgPlateAsset(
      // https://commons.wikimedia.org/wiki/File:Flag_of_Uzbekistan.svg
      'assets/flags/Flag_of_Uzbekistan.svg',
      package: 'iranshahr_plate',
    ),
  );
}
