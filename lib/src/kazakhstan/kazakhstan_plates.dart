import 'dart:math';

import 'package:flutter/widgets.dart' show AssetImage, EdgeInsets;
import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'kazakhstan_country.dart';
import 'kazakhstan_missions.dart';

/// Where the ink sits, in plate units (520 × 110 mm, the article's size).
///
/// Measured off `.plateref/kz/flat__2012-01.png` (the 2012 private plate,
/// flattened to 520 × 110) by connected components of the ink: digits ink
/// y 18.2–93, letters 34.5–93, region 17.5–92.8; divider x 391.5–394.25
/// running edge to edge; flag x 21.5–72.5 y 18–52.5 and `KZ` ink x 22.5–72.8
/// y 67.2–93.2. The non-private reference (`flat__2012-02`) is a pale photo
/// whose ink cannot be thresholded; it is the same design with two letters, so
/// it takes the same layout (its two letters are centred on the three-letter
/// span, an estimate).
///
/// A slot's ink is about 55% of its box height (`glyphStyle` is 0.72 of the
/// box, a bold cap 0.75 of that), so each register's box is ink / 0.55 centred
/// on the measured ink, shrunk where it would leave the canvas. The digits'
/// 75 of ink would need a 136 box on 110 and land near 60 (about 80%).
abstract final class _Layout {
  static const double width = 520, height = 110;

  static const double dividerCx = 392.9, dividerThickness = 2.75;

  // Cell pitches are the means of the measured glyph centres (the reference
  // font is proportional): digits 112.4, 164.4, 213.1; letters 263.5, 312.3,
  // 365; region 421.6, 469.6.
  static const _Run digits = _Run(112.7, 50.35, 18.2, 93);
  static const _Run letters = _Run(263.3, 50.75, 34.5, 93);
  static const _Run nonPrivateLetters = _Run(288.7, 50.75, 34.5, 93);
  static const _Run region = _Run(421.6, 48, 17.5, 92.8);

  // Diplomatic (`.plateref/kz/diplomatic.png`, a photo of `D 001618`
  // normalised from its orange field to 520 x 110): class ink x 48.1-107 (D
  // centre 77.5), the six digits at centres 193.4 247 298 347 398.7 447.6
  // (pitch 50.84), ink y 15-96. No flag, no divider, no `KZ`.
  static const _Run diplomaticClass = _Run(77.5, 59, 15, 96);
  static const _Run mission = _Run(193.4, 50.84, 15, 96);
  static const _Run missionNumber = _Run(345.8, 50.84, 15, 96);

  static const PlateBox flag = PlateBox(21.5, 22.5, 51, 25.5);
  static const PlateBox kz = PlateBox(20, 61, 55, 38);
  static const double kzGlyph = 47;
}

final class _Run {
  const _Run(this.firstCx, this.pitch, this.inkTop, this.inkBottom);
  final double firstCx, pitch, inkTop, inkBottom;
}

PlateSlot _field(PlateAlphabet alphabet, _Run run, int count) {
  final double centre = (run.inkTop + run.inkBottom) / 2;
  final double fit = 2 * (centre < _Layout.height - centre ? centre : _Layout.height - centre);
  final double wanted = (run.inkBottom - run.inkTop) / 0.55;
  final double height = wanted < fit ? wanted : fit;
  return PlateSlot(
    alphabet: alphabet,
    box: PlateBox(run.firstCx - run.pitch / 2, centre - height / 2, count * run.pitch, height),
    length: count,
    spacing: max(0, run.pitch - 0.6 * 0.72 * height),
  );
}

const AssetImage _flagImage = AssetImage(
  // Commons: File:Flag_of_Kazakhstan.svg; assets/icons/kazakhstan_flag.svg is
  // the vector.
  'assets/icons/kazakhstan_flag.png',
  package: 'iranshahr_plate',
);

final class _Register {
  const _Register(this.key, this.alphabet, this.run, this.count);
  final String key;
  final PlateAlphabet alphabet;
  final _Run run;
  final int count;
}

PlateSpec _spec(
  String id,
  List<_Register> registers, {
  PlateSection background = PlateSection.plain,
  List<PlateLabel> labels = const <PlateLabel>[],
  List<PlateDecal> decals = const <PlateDecal>[],
  List<PlateRestriction> restrictions = const <PlateRestriction>[],
}) {
  final List<PlateSlot> slots = <PlateSlot>[];
  final List<PlateTextGroup> groups = <PlateTextGroup>[];
  for (final _Register r in registers) {
    groups.add(PlateTextGroup(<int>[slots.length], key: r.key));
    slots.add(_field(r.alphabet, r.run, r.count));
  }
  return PlateSpec(
    id: id,
    country: KazakhstanCountry.kazakhstan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    noPanel: true,
    background: background,
    slots: slots,
    labels: labels,
    decals: decals,
    textGroups: groups,
    restrictions: restrictions,
  );
}

/// `573 ABX | 15`: the flag over `KZ` at the left, three digits, letters, then
/// the two-digit region code behind an edge-to-edge divider.
PlateSpec _registration(String id, _Run letters, int letterCount) => _spec(
  id,
  <_Register>[
    const _Register('number', KazakhstanAlphabets.digits, _Layout.digits, 3),
    _Register('letters', KazakhstanAlphabets.letters, letters, letterCount),
    const _Register('region', KazakhstanAlphabets.digits, _Layout.region, 2),
  ],
  background: PlateSection.columns(<PlatePart>[
    PlatePart(PlateSection.plain, end: _Layout.dividerCx, divider: _Layout.dividerThickness),
    PlatePart(PlateSection.plain),
  ]),
  labels: const <PlateLabel>[PlateLabel(text: 'KZ', box: _Layout.kz, glyphHeight: _Layout.kzGlyph)],
  decals: const <PlateDecal>[PlateDecal(image: _flagImage, box: _Layout.flag)],
);

/// The Kazakh plates since 2012 (`111AAA 01`).
///
/// - [private]: three digits, three letters, region.
/// - [nonPrivate]: the same with two letters.
/// - [diplomatic]: `D 001 618`, a class letter, a three-digit mission code
///   and three digits, white on orange-red.
///
/// Not implemented: the pre-2012 `A 553 ZYM` / `Z 313 ZZ` plates (superseded),
/// and the yellow foreign-owner plate, which the article describes only in
/// prose. Mission code `007` (Israel) is refused.
abstract final class KazakhstanPlates {
  static final PlateSpec private = _registration('kz.private', _Layout.letters, 3);

  static final PlateSpec nonPrivate = _registration('kz.non_private', _Layout.nonPrivateLetters, 2);

  /// `D 001 618`, white on orange-red. The mission code is refused for Israel
  /// (`007`) by [KazakhstanMissions.restriction].
  static final PlateSpec diplomatic = _spec(
    'kz.diplomatic',
    const <_Register>[
      _Register('class', KazakhstanAlphabets.letters, _Layout.diplomaticClass, 1),
      _Register('mission', KazakhstanAlphabets.digits, _Layout.mission, 3),
      _Register('number', KazakhstanAlphabets.digits, _Layout.missionNumber, 3),
    ],
    restrictions: const <PlateRestriction>[KazakhstanMissions.restriction],
  );

  static List<PlateSpec> get all => <PlateSpec>[private, nonPrivate, diplomatic];
}
