import 'package:core_plate/core_plate.dart';

import 'iraq_colors.dart';

/// The governorate codes the 2022/2024 series prints as the first two digits,
/// transcribed from the code table in Wikipedia's "Vehicle registration plates
/// of Iraq".
///
/// This format is the first to give Halabja (23) a code of its own; before it,
/// the governorate was written out in Arabic rather than numbered.
abstract final class IraqGovernorates {
  static const Map<String, String> byCode = <String, String>{
    '11': 'Baghdad',
    '12': 'Nineveh',
    '13': 'Maysan',
    '14': 'Basra',
    '15': 'Al Anbar',
    '16': 'Al-Qadisiyyah',
    '17': 'Muthanna',
    '18': 'Babil',
    '19': 'Karbala',
    '20': 'Diyala',
    '21': 'Sulaymaniyah',
    '22': 'Erbil',
    '23': 'Halabja',
    '24': 'Duhok',
    '25': 'Kirkuk',
    '26': 'Saladin',
    '27': 'Dhi Qar',
    '28': 'Najaf',
    '29': 'Wasit',
  };

  /// Codes 21-24 are the governorates under the Kurdistan Regional
  /// Government. Plates registered in them carry a second, smaller "KR" under
  /// the "IRQ" in the band — the one way the two regional designs differ.
  static const Set<String> kurdistan = <String>{'21', '22', '23', '24'};

  /// Whether [code] names a governorate in the Kurdistan Region, and so takes
  /// the `*Kurdistan` specs rather than the plain ones.
  static bool isKurdistan(String code) => kurdistan.contains(code);
}

/// The left band an Iraqi plate carries, one constant per vehicle class.
///
/// The band is a [PlatePanel] rather than a [PlateBand] so its colour is the
/// country's rather than the spec's: `PlateCanvas.country` overrides
/// `PlateSpec.country` at render time, so the six classes share four specs
/// instead of multiplying into twenty-four. The "IRQ"/"KR" lettering is
/// geometry, so it lives in the spec as labels and [captionLines] stays empty.
///
/// **Every constant has `code: 'iq'`, so they all compare equal** — the same
/// contract the other countries in this package keep. Which band a host is
/// holding is a question for the spec, not for the code.
abstract final class IraqCountry {
  static const PlateCountry _band = PlateCountry(
    code: 'iq',
    captionLines: <String>[],
    panelColor: IraqColors.field,
    panelTextColor: IraqColors.ink,
  );

  /// Private vehicle: a white band, so only the divider separates it from the
  /// field.
  static const PlateCountry private = _band;

  /// Vehicle for hire, bus, taxi: red band.
  static const PlateCountry hire = PlateCountry(
    code: 'iq',
    captionLines: <String>[],
    panelColor: IraqColors.hireBand,
    panelTextColor: IraqColors.ink,
  );

  /// Governmental: blue band.
  static const PlateCountry government = PlateCountry(
    code: 'iq',
    captionLines: <String>[],
    panelColor: IraqColors.governmentBand,
    panelTextColor: IraqColors.ink,
  );

  /// Trade — trucks, tractors, cranes: yellow band.
  static const PlateCountry trade = PlateCountry(
    code: 'iq',
    captionLines: <String>[],
    panelColor: IraqColors.tradeBand,
    panelTextColor: IraqColors.ink,
  );

  /// Agricultural: green band.
  static const PlateCountry agricultural = PlateCountry(
    code: 'iq',
    captionLines: <String>[],
    panelColor: IraqColors.agriculturalBand,
    panelTextColor: IraqColors.ink,
  );

  /// Temporary: a white band like [private], but the plate prints in red
  /// throughout — which is the theme's business, not the band's.
  static const PlateCountry temporary = PlateCountry(
    code: 'iq',
    captionLines: <String>[],
    panelColor: IraqColors.field,
    panelTextColor: IraqColors.temporaryInk,
  );
}
