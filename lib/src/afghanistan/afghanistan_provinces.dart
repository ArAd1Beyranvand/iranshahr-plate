import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'afghanistan_colors.dart';

/// The thirty-four provinces of Afghanistan, and the block each one prints at
/// the hoist end of a plate registered in it.
///
/// Every Afghan plate names its province three times over in one column: the
/// name in Persian or Pashto at the top, the Darul Aman emblem under it, and a
/// three-letter Latin code at the bottom. That column is the plate's
/// [PlateCountry] and not part of its [PlateSpec] — geometry is the same in
/// Herat as in Kabul, and a spec per province would be thirty-four copies of
/// one design differing in two strings.
///
/// So this enum is the runtime axis, and [country] is how it reaches a
/// renderer:
///
/// ```dart
/// PlateCanvas(
///   spec: AfghanistanPlates.car5,
///   theme: AfghanistanThemes.civilian,
///   country: AfghanistanProvince.herat.country(),
/// )
/// ```
///
/// Names and codes are the Wikipedia table for
/// *Vehicle registration plates of Afghanistan*, transcribed as printed —
/// including `هملند` for Helmand, which is how the source spells it.
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

  /// The province's name in English. Never printed on a plate — this is for a
  /// picker's label and for a log.
  final String englishName;

  /// The name as the top line of the plate's block prints it, in Persian or
  /// Pashto.
  final String localName;

  /// The three-letter Latin code the bottom line of the block prints, e.g.
  /// `HRT`. Unique across the thirty-four, and the key [fromCode] looks up.
  final String code;

  /// The province whose [code] is [code], case-insensitively, or null when no
  /// province carries it.
  ///
  /// Null rather than a throw: this is what a host reaches for after reading a
  /// code off a plate or out of a saved record, and an unknown code is a bad
  /// input to report, not a programming error to crash on.
  static AfghanistanProvince? fromCode(String code) {
    final wanted = code.toUpperCase();
    for (final p in values) {
      if (p.code == wanted) return p;
    }
    return null;
  }

  /// This province's block, ready to hand to `PlateCanvas.country`.
  ///
  /// [ink] is which of the two emblem assets to draw and which colour the two
  /// lines of wording take: [AfghanistanPanelInk.dark] for a white, yellow or
  /// blue field, [AfghanistanPanelInk.light] for the diplomatic red and
  /// governmental black ones. It is a parameter and not a lookup from the
  /// theme because a [PlateCountry] is data a renderer is handed, and nothing
  /// hands it the theme.
  ///
  /// [showCode] prints the block's bottom line. The temporary plate sets it
  /// false: it replaces the province code with `موقت` in red, which is a label
  /// on the face rather than a caption in the block, because the block carries
  /// one ink for both its lines and that word is the one thing on the plate
  /// printed in another.
  ///
  /// A fresh value per call. [PlateCountry] equality is over [PlateCountry.code]
  /// alone and these ids are stable — `af.hrt`, `af.hrt.light`, `af.hrt.bare` —
  /// so two blocks built for the same province in the same livery compare equal
  /// without being canonicalised.
  PlateCountry country({
    AfghanistanPanelInk ink = AfghanistanPanelInk.dark,
    bool showCode = true,
  }) {
    return PlateCountry(
      code:
          'af.${code.toLowerCase()}${ink == AfghanistanPanelInk.light ? '.light' : ''}${showCode ? '' : '.bare'}',
      headingLines: <String>[localName],
      captionLines: showCode ? <String>[code] : const <String>[],
      // Transparent, and that is the design rather than a default left unset.
      // An Afghan plate has no country block as a *rectangle*: the name, the
      // emblem and the code are printed straight onto the field, whatever
      // colour the field is. Bahrain and Azerbaijan reach the same look by
      // painting a white block on a white plate, which works because their
      // civilian field is the only one the block ever sits on. This block sits
      // on five — white, taxi yellow, diplomatic red, governmental black, UN
      // blue — so naming any one of them would show as a patch on the other
      // four.
      panelColor: const Color(0x00000000),
      panelTextColor: ink.ink,
      flagAspectRatio: _emblemAspectRatio,
      flag: ink.emblem,
    );
  }

  /// The emblem SVG is drawn on a 200×128 viewBox — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 1.5625.
  static const double _emblemAspectRatio = 200 / 128;
}

/// Which of the two emblem assets a block draws, and the ink its wording takes.
///
/// An Afghan block is printed in the plate's own ink on the plate's own field —
/// black on white, black on taxi yellow, white on diplomatic red, white on
/// governmental black — and the emblem is line art, so it has to change colour
/// with the rest. `PlateFlag` paints the asset a country ships exactly as it is
/// and takes no colour filter, deliberately: a flag is never recoloured. An
/// emblem that must be is therefore two assets and this two-valued choice
/// between them, rather than a hole in that rule.
enum AfghanistanPanelInk {
  /// Black line art on the plate's field: the private, lorry, motorcycle,
  /// rickshaw, duplicate, temporary, bus, taxi and UN plates.
  dark(
    AfghanistanColors.ink,
    SvgPlateAsset('assets/emblems/Darul_Aman_dark.svg', package: _package),
  ),

  /// White line art: the diplomatic red and governmental black plates.
  light(
    AfghanistanColors.onDiplomaticRed,
    SvgPlateAsset('assets/emblems/Darul_Aman_light.svg', package: _package),
  );

  const AfghanistanPanelInk(this.ink, this.emblem);

  /// The package that declares the two emblem assets — this one.
  static const String _package = 'iranshahr_plate';

  /// The wording's colour, and the colour the emblem is drawn in.
  final Color ink;

  /// The emblem asset this ink draws.
  final PlateAsset emblem;
}
