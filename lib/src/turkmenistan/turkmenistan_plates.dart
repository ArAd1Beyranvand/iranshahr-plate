import 'dart:math';

import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'turkmenistan_country.dart';

/// Where the ink sits, in plate units.
///
/// Every figure was measured off `.plateref/tm`: connected components of the
/// ink in the flats (yellow, blue, classic) and in the clean originals (white,
/// trailer and the green plates, whose flats are warped or cut), each plate
/// normalised to the 520 × 110 mm the article gives. A cell's centre is the
/// ink centre of the first glyph of its run and its pitch the span to the
/// last, so a narrow `1` sits a few units off its cell, as the typeface sets it.
///
/// A slot's ink is about 55% of its box height (`glyphStyle` is 0.72 of the
/// box, a bold cap 0.75 of that), so [_field] boxes each register at
/// ink / 0.55 centred on the measured ink, and shrinks it where it would leave
/// the canvas. The yellow and classic plates' ~80 of ink would need a box of
/// 145 on a 110-high plate and land near 59 (about 74%); the others fit
/// within a few units of the reference.
abstract final class _Layout {
  static const double width = 520, height = 110;

  // White private `AT 0123 AG` (Pelak_shakhsi-TM original): ink y 22.4–85.4.
  static const double whiteTop = 22.4, whiteBottom = 85.4;
  static const _Run privateSeries = _Run(118.6, 47.6, whiteTop, whiteBottom);
  static const _Run privateNumber = _Run(223.65, 41.97, whiteTop, whiteBottom);
  static const _Run privateRegion = _Run(415.9, 54.85, whiteTop, whiteBottom);

  // Trailer `AG 0123 TR` (Pelak_tereyli-TM original): ink y 19.2–82.4.
  static const double trailerTop = 19.2, trailerBottom = 82.4;
  static const _Run trailerSeries = _Run(104.1, 55, trailerTop, trailerBottom);
  static const _Run trailerNumber = _Run(
    228.3,
    44.57,
    trailerTop,
    trailerBottom,
  );
  static const _Run trailerLetters = _Run(
    428.05,
    51.8,
    trailerTop,
    trailerBottom,
  );

  // Classic `N 29 38 LB` (License_plate_of_Turkmenistan): ink y 14.8–96.2.
  static const double classicTop = 14.8, classicBottom = 96.2;
  static const _Run classicSeries = _Run(119.75, 40, classicTop, classicBottom);
  static const _Run classicFirst = _Run(
    180.5,
    50.15,
    classicTop,
    classicBottom,
  );
  static const _Run classicSecond = _Run(
    302.7,
    53.95,
    classicTop,
    classicBottom,
  );
  static const _Run classicRegion = _Run(419, 41.8, classicTop, classicBottom);

  // Foreign `1 H 01234` (Pelak_khareji-TM): ink y 16.3–96.2.
  static const _Run foreignClass = _Run(94.6, 40, 16.3, 96.2);
  static const _Run foreignLetter = _Run(177.6, 60, 16.3, 96.2);
  static const _Run foreignNumber = _Run(269, 50.35, 16.3, 96.2);

  // Foreign trailer `1 HT 2345` (Pelak_tereyli_khareji-TM): ink y 13.0–91.3.
  static const _Run foreignTrailerClass = _Run(89.35, 40, 13, 91.3);
  static const _Run foreignTrailerLetters = _Run(170.35, 63.15, 13, 91.3);
  static const _Run foreignTrailerNumber = _Run(314.1, 52.9, 13, 91.3);

  // Export `TDG 0123` (Pelak_saderat-TM): ink y 16.7–95.0.
  static const _Run exportLetters = _Run(110.25, 65.2, 16.7, 95);
  static const _Run exportNumber = _Run(327.25, 46.9, 16.7, 95);

  // Diplomatic `01 CD 234` (Turkmenistan_diplomatic_license_plate): ink y
  // 19.2–89.3.
  static const _Run diplomaticEmbassy = _Run(112.65, 40.35, 19.2, 89.3);
  static const _Run diplomaticLetters = _Run(223.15, 57.25, 19.2, 89.3);
  static const _Run diplomaticNumber = _Run(357.1, 47.75, 19.2, 89.3);

  // Government `0123 AGA` (Pelak_dolati-TM original): ink y 24.4–86.4.
  static const _Run governmentNumber = _Run(148.95, 45.4, 24.4, 86.4);
  static const _Run governmentLetters = _Run(357, 55.6, 24.4, 86.4);

  // Military `01 23 GM` (Pelak_nezami-TM original): ink y 20.4–87.4.
  static const _Run militaryNumber = _Run(159.65, 49.3, 20.4, 87.4);
  static const _Run militaryLetters = _Run(385.85, 66.55, 20.4, 87.4);

  // Ceremony `DABARA 1` (Pelak_marasem-TM original): ink y 20.9–82.8.
  static const _Run ceremonyLetters = _Run(150.8, 55.4, 20.9, 82.1);
  static const _Run ceremonyNumber = _Run(481, 55, 21.5, 82.8);

  // Badge: the flag (green field) and `TM` (ink box), per colour scheme.
  static const PlateBox flag = PlateBox(13.2, 13, 51.6, 34.4);
  static const PlateBox blueFlag = PlateBox(12, 12, 52.2, 34.8);
  // The classic photograph stretches the flag to 60 × 31; kept at 3:2 here.
  static const PlateBox classicFlag = PlateBox(18.2, 13, 46.8, 31.2);

  static const _Ink whiteTm = _Ink(7.4, 61.3, 69.5, 96.3);
  static const _Ink yellowTm = _Ink(7.8, 62.2, 67.8, 94.2);
  static const _Ink blueTm = _Ink(9.5, 63.8, 67.8, 94.2);
  static const _Ink classicTm = _Ink(18.2, 77.8, 66.5, 95.8);
  static const _Ink greenTm = _Ink(58.8, 112.3, 69.2, 94.6);

  // Green plates: the carpet strip (red x 26.5–53, y 7–102) and the crescent
  // with its five stars (white x 56.5–112.8, y 12.8–60.2).
  static const PlateBox strip = PlateBox(26.9, 7, 25.7, 95);
  static const PlateBox crescent = PlateBox(58.6, 12.8, 52.1, 47.4);
}

/// One register as a single field: the first at [firstCx], each [pitch] wide and apart,
/// with the ink spanning [inkTop]–[inkBottom].
final class _Run {
  const _Run(this.firstCx, this.pitch, this.inkTop, this.inkBottom);
  final double firstCx, pitch, inkTop, inkBottom;
}

/// The ink rectangle of a printed word, which [_label] turns into a box.
final class _Ink {
  const _Ink(this.left, this.right, this.top, this.bottom);
  final double left, right, top, bottom;
}

/// A named register, so the text groups come out of the order it is listed in.
final class _Register {
  _Register(this.key, PlateAlphabet alphabet, _Run run, int count)
    : slot = _field(alphabet, run, count);
  final String key;
  final PlateSlot slot;
}

PlateSlot _field(PlateAlphabet alphabet, _Run run, int count) {
  final double centre = (run.inkTop + run.inkBottom) / 2;
  final double room = _Layout.height - centre;
  final double fit = 2 * (centre < room ? centre : room);
  final double wanted = (run.inkBottom - run.inkTop) / 0.55;
  final double height = wanted < fit ? wanted : fit;
  return PlateSlot(
    alphabet: alphabet,
    box: PlateBox(
      run.firstCx - run.pitch / 2,
      centre - height / 2,
      run.pitch * count,
      height,
    ),
    length: count,
    spacing: count == 1 ? 0 : max(0, run.pitch - 0.6 * 0.72 * height),
  );
}

PlateLabel _label(String text, _Ink ink) {
  final double glyph = (ink.bottom - ink.top) / 0.55;
  final double width = ink.right - ink.left;
  final double cx = (ink.left + ink.right) / 2;
  final double cy = (ink.top + ink.bottom) / 2;
  return PlateLabel(
    text: text,
    box: PlateBox(cx - width / 2, cy - glyph / 2, width, glyph),
    glyphHeight: glyph,
  );
}

// Commons: File:Flag_of_Turkmenistan.svg, green recoloured to the plates'
// 28AE66; assets/icons/turkmenistan_flag.svg is the vector. The strip and the
// crescent are crops of it (carpet göls; crescent with five stars).
const AssetImage _flag = AssetImage(
  'assets/icons/turkmenistan_flag.png',
  package: 'iranshahr_plate',
);
const AssetImage _strip = AssetImage(
  'assets/icons/turkmenistan_strip.png',
  package: 'iranshahr_plate',
);
const AssetImage _crescent = AssetImage(
  'assets/icons/turkmenistan_crescent.png',
  package: 'iranshahr_plate',
);

/// What the left of a plate carries.
final class _Badge {
  const _Badge(this.decals, this.label);
  final List<PlateDecal> decals;
  final PlateLabel label;
}

PlateSpec _spec(String id, _Badge badge, List<_Register> registers) {
  final List<PlateSlot> slots = <PlateSlot>[];
  final List<PlateTextGroup> groups = <PlateTextGroup>[];
  for (final _Register r in registers) {
    groups.add(PlateTextGroup(<int>[slots.length], key: r.key));
    slots.add(r.slot);
  }
  return PlateSpec(
    id: id,
    country: TurkmenistanCountry.turkmenistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(
      box: PlateBox(0, 0, 0, 0),
      padding: EdgeInsets.zero,
    ),
    noPanel: true,
    slots: slots,
    labels: <PlateLabel>[badge.label],
    decals: badge.decals,
    textGroups: groups,
  );
}

_Register _digits(String key, _Run run, int count) =>
    _Register(key, TurkmenistanAlphabets.digits, run, count);

_Register _letters(String key, _Run run, int count) =>
    _Register(key, TurkmenistanAlphabets.letters, run, count);

final _Badge _whiteBadge = _Badge(const <PlateDecal>[
  PlateDecal(image: _flag, box: _Layout.flag),
], _label('TM', _Layout.whiteTm));

final _Badge _yellowBadge = _Badge(const <PlateDecal>[
  PlateDecal(image: _flag, box: _Layout.flag),
], _label('TM', _Layout.yellowTm));

final _Badge _blueBadge = _Badge(const <PlateDecal>[
  PlateDecal(image: _flag, box: _Layout.blueFlag),
], _label('TM', _Layout.blueTm));

final _Badge _classicBadge = _Badge(const <PlateDecal>[
  PlateDecal(image: _flag, box: _Layout.classicFlag),
], _label('TM', _Layout.classicTm));

final _Badge _greenBadge = _Badge(const <PlateDecal>[
  PlateDecal(image: _strip, box: _Layout.strip),
  PlateDecal(image: _crescent, box: _Layout.crescent),
], _label('TM', _Layout.greenTm));

/// The Turkmen plates, in the designs the article shows. Every plate is 520 ×
/// 110, black or white ink on one field, with the flag (or, on the green
/// plates, the carpet strip and crescent) and `TM` at the left; they differ in
/// colour (the theme's) and in how the serial is cut into registers.
///
/// - [classic]: the 1994 series, `N 29 38 LB` (Latin serial letter, two pairs
///   of digits, province code).
/// - [private]: `AT 0123 AG`, the format since 2010 (two series letters, four
///   digits, province code); [trailer] `AG 0123 TR`.
/// - [foreign] `1 H 01234`, [foreignTrailer] `1 HT 2345`, [export]
///   `TDG 0123`: black on yellow.
/// - [diplomatic]: white on blue, `01 CD 234`.
/// - [government] `0123 AGA`, [military] `01 23 GM`, [ceremony] `DABARA 1`:
///   white on green.
///
/// Not implemented: the 1980–1993 Soviet `к 3361 АШ` plates (Cyrillic,
/// superseded). The screw heads in the photographs are not drawn. The groups
/// of digits the plates print as pairs (`01 23`) are one evenly pitched
/// field, so the gap between the pairs is not reproduced. The article gives
/// no text for the trailer, military or ceremony plates; their registers
/// follow the pictures. The ceremony word is typed, not fixed.
abstract final class TurkmenistanPlates {
  static final PlateSpec classic =
      _spec('tm.classic', _classicBadge, <_Register>[
        _letters('series', _Layout.classicSeries, 1),
        _digits('first', _Layout.classicFirst, 2),
        _digits('second', _Layout.classicSecond, 2),
        _letters('region', _Layout.classicRegion, 2),
      ]);

  static final PlateSpec private = _spec('tm.private', _whiteBadge, <_Register>[
    _letters('series', _Layout.privateSeries, 2),
    _digits('number', _Layout.privateNumber, 4),
    _letters('region', _Layout.privateRegion, 2),
  ]);

  static final PlateSpec trailer = _spec('tm.trailer', _whiteBadge, <_Register>[
    _letters('series', _Layout.trailerSeries, 2),
    _digits('number', _Layout.trailerNumber, 4),
    _letters('letters', _Layout.trailerLetters, 2),
  ]);

  static final PlateSpec foreign =
      _spec('tm.foreign', _yellowBadge, <_Register>[
        _digits('class', _Layout.foreignClass, 1),
        _letters('letter', _Layout.foreignLetter, 1),
        _digits('number', _Layout.foreignNumber, 5),
      ]);

  static final PlateSpec foreignTrailer =
      _spec('tm.foreign_trailer', _yellowBadge, <_Register>[
        _digits('class', _Layout.foreignTrailerClass, 1),
        _letters('letters', _Layout.foreignTrailerLetters, 2),
        _digits('number', _Layout.foreignTrailerNumber, 4),
      ]);

  static final PlateSpec export = _spec('tm.export', _yellowBadge, <_Register>[
    _letters('letters', _Layout.exportLetters, 3),
    _digits('number', _Layout.exportNumber, 4),
  ]);

  static final PlateSpec diplomatic =
      _spec('tm.diplomatic', _blueBadge, <_Register>[
        _digits('embassy', _Layout.diplomaticEmbassy, 2),
        _letters('letters', _Layout.diplomaticLetters, 2),
        _digits('number', _Layout.diplomaticNumber, 3),
      ]);

  static final PlateSpec government =
      _spec('tm.government', _greenBadge, <_Register>[
        _digits('number', _Layout.governmentNumber, 4),
        _letters('letters', _Layout.governmentLetters, 3),
      ]);

  static final PlateSpec military =
      _spec('tm.military', _greenBadge, <_Register>[
        _digits('number', _Layout.militaryNumber, 4),
        _letters('letters', _Layout.militaryLetters, 2),
      ]);

  static final PlateSpec ceremony =
      _spec('tm.ceremony', _greenBadge, <_Register>[
        _letters('letters', _Layout.ceremonyLetters, 6),
        _digits('number', _Layout.ceremonyNumber, 1),
      ]);

  static List<PlateSpec> get all => <PlateSpec>[
    classic,
    private,
    trailer,
    foreign,
    foreignTrailer,
    export,
    diplomatic,
    government,
    military,
    ceremony,
  ];
}
