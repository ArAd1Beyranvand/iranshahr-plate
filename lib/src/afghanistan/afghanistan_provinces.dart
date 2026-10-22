import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'afghanistan_colors.dart';

/// The thirty-four provinces and the block each prints at the hoist end of its
/// plates (name, emblem, Latin code).
///
/// The block is a [PlateCountry], not part of a [PlateSpec]: geometry is the
/// same in Herat as in Kabul. Names and codes follow the Wikipedia table,
/// including `هملند` for Helmand as the source spells it.
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

  /// This province's block, for `PlateCanvas.country`.
  ///
  /// [ink] picks the emblem asset and the wording colour: dark for a white,
  /// yellow or blue field, light for red or black. It is a parameter because
  /// nothing hands a [PlateCountry] the theme.
  ///
  /// [showCode] false drops the bottom line; the temporary plate prints `موقت`
  /// in red there as a label, since the block has one ink for both lines.
  ///
  /// [PlateCountry] equality is over [PlateCountry.code], so the ids
  /// (`af.hrt`, `af.hrt.light`, `af.hrt.bare`) make equal blocks compare equal.
  PlateCountry country({AfghanistanPanelInk ink = AfghanistanPanelInk.dark, bool showCode = true}) {
    return PlateCountry(
      code:
          'af.${code.toLowerCase()}${ink == AfghanistanPanelInk.light ? '.light' : ''}${showCode ? '' : '.bare'}',
      headingLines: <String>[localName],
      captionLines: showCode ? <String>[code] : const <String>[],
      // Transparent by design: the block is printed straight onto five
      // different fields, so naming any one colour would patch the others.
      panelColor: const Color(0x00000000),
      panelTextColor: ink.ink,
      flagAspectRatio: _emblemAspectRatio,
      flag: ink.emblem,
    );
  }

  /// The emblem SVG's 200×128 viewBox.
  static const double _emblemAspectRatio = 200 / 128;
}

/// The emblem asset a block draws and the ink of its wording. The emblem is
/// line art that must change colour with the field, but flags are never
/// recoloured, so it ships as two assets.
enum AfghanistanPanelInk {
  /// Black line art, for white, yellow and blue fields.
  dark(
    AfghanistanColors.ink,
    SvgPlateAsset('assets/emblems/Darul_Aman_dark.svg', package: _package),
  ),

  /// White line art, for the diplomatic red and governmental black fields.
  light(
    AfghanistanColors.onDiplomaticRed,
    SvgPlateAsset('assets/emblems/Darul_Aman_light.svg', package: _package),
  );

  const AfghanistanPanelInk(this.ink, this.emblem);

  static const String _package = 'iranshahr_plate';

  final Color ink;
  final PlateAsset emblem;
}
