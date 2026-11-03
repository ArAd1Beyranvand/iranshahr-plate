import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

/// The thirty-four provinces whose name and Latin code frame the emblem at the
/// hoist end of a plate. Names and codes follow the Wikipedia table, including
/// `هملند` for Helmand as the source spells it.
enum AfghanistanProvince {
  badakhshan('Badakhshan', 'بدخشان', 'BDN'),
  badghis('Badghis', 'بادغیس', 'BDS'),
  baghlan('Baghlan', 'بغلان', 'BAG'),
  balkh('Balkh', 'بلخ', 'BLH'),
  bamyan('Bamyan', 'بامیان', 'BMN'),
  daykundi('Daykundi', 'دایکندی', 'DYK'),
  farah('Farah', 'فراه', 'FRH'),
  faryab('Faryab', 'فاریاب', 'FRB'),
  ghazni('Ghazni', 'غزنی', 'GZN'),
  ghor('Ghor', 'غور', 'GHR'),
  helmand('Helmand', 'هملند', 'HEL'),
  herat('Herat', 'هرات', 'HRT'),
  jowzjan('Jowzjan', 'جوزجان', 'JZJ'),
  kabul('Kabul', 'کابل', 'KBL'),
  kandahar('Kandahar', 'کندهار', 'KDR'),
  kapisa('Kapisa', 'کپیسا', 'KAP'),
  khost('Khost', 'خوست', 'KST'),
  kunar('Kunar', 'کونر', 'KNR'),
  kunduz('Kunduz', 'کندوز', 'KDZ'),
  laghman('Laghman', 'لغمان', 'LGM'),
  logar('Logar', 'لوگر', 'LGR'),
  nangarhar('Nangarhar', 'ننگرهار', 'NGR'),
  nimruz('Nimruz', 'نیمروز', 'NRZ'),
  nuristan('Nuristan', 'نورستان', 'NUR'),
  paktia('Paktia', 'پکتیا', 'PAK'),
  paktika('Paktika', 'پکتیکا', 'PKT'),
  panjshir('Panjshir', 'پنجیشیر', 'PJR'),
  parwan('Parwan', 'پروان', 'PRN'),
  samangan('Samangan', 'سمنگان', 'SAM'),
  sarePol('Sar-e Pol', 'سرپل', 'SPL'),
  takhar('Takhar', 'تخار', 'TAK'),
  urozgan('Urozgan', 'اروزگان', 'ORZ'),
  wardak('Wardak', 'وردک', 'WDK'),
  zabul('Zabul', 'زابل', 'ZBL');

  const AfghanistanProvince(this.englishName, this.localName, this.code);

  /// Never printed on a plate; for a picker's label.
  final String englishName;

  /// The top line of the block, in Persian or Pashto.
  final String localName;

  /// The three-letter Latin code on the block's bottom line; unique.
  final String code;

  /// Case-insensitive. Null rather than a throw: an unknown code is bad input
  /// to report, not a programming error.
  static AfghanistanProvince? fromCode(String code) =>
      values.where((p) => p.code == code.toUpperCase()).firstOrNull;

  /// The block's top line, a slot: stored as [code], printed as [localName].
  /// Chosen, since a name is not on a keyboard.
  static final PlateAlphabet names = PlateAlphabet(
    id: 'af.province',
    characters: <String>[for (final p in values) p.code],
    input: AlphabetInput.chosen,
    direction: TextDirection.rtl,
    glyphs: <String, String>{for (final p in values) p.code: p.localName},
  );

  /// The block's bottom line, a mirror of [names] printing the code itself.
  static final PlateAlphabet codes = PlateAlphabet(
    id: 'af.provinceCode',
    characters: <String>[for (final p in values) p.code],
    input: AlphabetInput.chosen,
  );
}

/// The emblem a block draws between the province name and code. The emblem is
/// line art that must change colour with the field, but flags are never
/// recoloured, so it ships as two assets.
enum AfghanistanPanelInk {
  /// Black line art, for white, yellow and blue fields.
  dark(
    'af',
    SvgPlateAsset('assets/emblems/Darul_Aman_dark.svg', package: _package),
  ),

  /// White line art, for the diplomatic red and governmental black fields.
  light(
    'af.light',
    SvgPlateAsset('assets/emblems/Darul_Aman_light.svg', package: _package),
  );

  const AfghanistanPanelInk(this._code, this._emblem);

  static const String _package = 'iranshahr_plate';

  final String _code;
  final PlateAsset _emblem;

  /// The emblem alone: the name and code around it are slots, so the province
  /// is part of the plate's value rather than of the rendered country.
  PlateCountry get country => PlateCountry(
    code: _code,
    // Transparent: the block is printed straight onto five different fields.
    panelColor: const Color(0x00000000),
    panelTextColor: const Color(0x00000000),
    flagAspectRatio: 200 / 128, // the SVG's viewBox
    flag: _emblem,
  );
}
