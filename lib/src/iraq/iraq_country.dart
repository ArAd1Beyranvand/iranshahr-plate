import 'package:core_plate/core_plate.dart';

import 'iraq_colors.dart';

/// Governorates of Iraq with their registration codes (since 2022).
abstract final class IraqGovernorate {
  static const Map<int, String> codes = {
    11: 'Baghdad',
    12: 'Nineveh',
    13: 'Maysan',
    14: 'Basra',
    15: 'Al Anbar',
    16: 'Al-Qādisiyyah',
    17: 'Muthanna',
    18: 'Babil',
    19: 'Karbala',
    20: 'Diyala',
    21: 'Sulaymaniyah', // Kurdistan Region
    22: 'Erbil', // Kurdistan Region
    23: 'Halabja', // Kurdistan Region
    24: 'Duhok', // Kurdistan Region
    25: 'Kirkuk',
    26: 'Saladin',
    27: 'Dhi Qar',
    28: 'Najaf',
    29: 'Wasit',
  };
}

/// Iraq as a PlateCountry. The panel is suppressed (noPanel=true in specs),
/// so captionLines and panelColor are not used for display. They exist
/// to satisfy the PlateCountry constructor.
const PlateCountry iraqCountry = PlateCountry(
  code: 'iq',
  captionLines: <String>[],
  panelColor: IraqColors.whitePanel,
  panelTextColor: IraqColors.blackText,
  flag: null,
);
