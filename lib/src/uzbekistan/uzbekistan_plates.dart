import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:plate_alphabet/plate_alphabet.dart';

import 'uzbekistan_country.dart';
import 'uzbekistan_missions.dart';
import 'uzbekistan_themes.dart';

/// Where the ink sits, in plate coordinates. Measured off the article's
/// artwork (the flattened references for the passenger and trailer plates,
/// the originals scaled to 520×110 for the one-row plates) by normalising
/// each plate to its canvas.
///
/// One-row plates: 520×110 as the article says. Trailer (280×152, the
/// photo's 1.84) and motorcycle (200×160, the artwork's 1.25) have no
/// documented size; those canvases are the artwork's aspect at a round width.
///
/// `glyphStyle` paints ink at ~0.55 of the box. Reference caps are 65 of 110
/// on the one-row plates, which would need a 118 box; the 106 box used paints
/// ~58 (~89%). The trailer and motorcycle rows are likewise limited by the
/// canvas edge, each box as tall as it can be centred on the reference ink.
abstract final class _Layout {
  static const double width = 520;
  static const double height = 110;

  /// Digit pitch 47.3 on every one-row plate; ink y 21..86.
  static const double rowTop = 2;
  static const double rowHeight = 106;
  static const double pitch = 47.3;

  /// Fixed prefix letters are labels; a label sits ~4 higher than a slot's
  /// ink, so its box drops by 10 and shrinks by 12 to share the baseline.
  static const double labelTop = 12;
  static const double labelHeight = 94;
  static const double labelGlyph = 106;

  static const double borderlessDivider = 3.6;

  /// Passenger: region ink 37.7..114.4, divider x 128.7, `A` centre 176.8,
  /// `123` 207.3..336, `NN` 345..428.2; digit ink y 32.8..89 (centre 61).
  static const double passengerTop = 12;
  static const double passengerHeight = 98;
  static const double passengerDivider = 128.7;

  /// Flag x 446..494, `UZ` ink y 68..96.5.
  static const PlatePanel passengerPanel = PlatePanel(
    box: PlateBox(441, 12, 58, 88),
    padding: EdgeInsets.zero,
    captionScale: 1.4,
  );

  static const PlatePanel none = PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero);

  /// Trailer canvas 280×152; ink rows: digits y 6.3..68, letters 80.5..141,
  /// region 83..129.6. Block corner at x 147, y 71.7; flag x 229.6..271.6.
  static const double trailerWidth = 280;
  static const double trailerHeight = 152;
  static const double trailerRowEnd = 71.7;
  static const double trailerBlockEnd = 147;
  static const double trailerRule = 2.5;
  static const PlatePanel trailerPanel = PlatePanel(
    box: PlateBox(224, 76, 52, 72),
    padding: EdgeInsets.zero,
    captionScale: 1.4,
  );

  /// Motorcycle canvas 200×160: digit ink y 15..63.5, letters 88..136.5,
  /// region 22.4..50.5; dividers x 131 and (right column) y 68.
  static const double motoWidth = 200;
  static const double motoHeight = 160;
  static const double motoColumnEnd = 131;
  static const double motoRowEnd = 68;
  static const double motoRule = 3;
  static const PlatePanel motoPanel = PlatePanel(
    box: PlateBox(140, 74, 52, 78),
    padding: EdgeInsets.zero,
    captionScale: 1.4,
  );
}

/// The designs, in colours the host's `UzbekistanThemes` supplies.
abstract final class UzbekistanPlates {
  /// One field of [count] cells printed from [left] to [right].
  static PlateSlot _across(
    PlateAlphabet a,
    int count,
    double left,
    double right,
    double top,
    double height,
  ) => PlateSlot(
    alphabet: a,
    box: PlateBox(left, top, right - left, height),
    length: count,
    spacing: max(0, (right - left) / count - 0.6 * 0.72 * height),
  );

  static PlateSlot _cell(PlateAlphabet a, double centre, double w, double top, double h) =>
      PlateSlot(alphabet: a, box: PlateBox(centre - w / 2, top, w, h));

  static PlateLabel _prefix(String text, double centre, double w) => PlateLabel(
    text: text,
    box: PlateBox(centre - w / 2, _Layout.labelTop, w, _Layout.labelHeight),
    glyphHeight: _Layout.labelGlyph,
  );

  /// A divider with the region on one side, plain field either side.
  static PlateSection _split(double at, {double rule = _Layout.borderlessDivider}) =>
      PlateSection.columns([
        PlatePart(PlateSection.plain, end: at, divider: rule),
        const PlatePart(PlateSection.plain),
      ]);

  /// Passenger car, `01 A123BC`.
  static final PlateSpec passenger = PlateSpec(
    id: 'uz.passenger',
    country: UzbekistanCountry.uzbekistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _Layout.passengerPanel,
    background: _split(_Layout.passengerDivider),
    slots: [
      _across(
        UzbekistanAlphabets.digits,
        2,
        33.8,
        117.6,
        _Layout.passengerTop,
        _Layout.passengerHeight,
      ),
      _cell(UzbekistanAlphabets.letters, 176.8, 44, _Layout.passengerTop, _Layout.passengerHeight),
      _across(
        UzbekistanAlphabets.digits,
        3,
        207.3,
        336,
        _Layout.passengerTop,
        _Layout.passengerHeight,
      ),
      _across(
        UzbekistanAlphabets.letters,
        2,
        345,
        428.2,
        _Layout.passengerTop,
        _Layout.passengerHeight,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'series', prefix: ' '),
      PlateTextGroup([2], key: 'serial'),
      PlateTextGroup([3], key: 'letters'),
    ],
  );

  /// Foreign citizen `01 H012345` (black on yellow) or foreign company
  /// `10 M012345` (white on green); [UzbekistanThemes.byClass] reads the
  /// colour off the letter. Region ink 28.6..93.1, divider x 120.4, letter
  /// centre 160.7, digits from 207.5, off the citizen plate.
  static final PlateSpec foreign = PlateSpec(
    id: 'uz.foreign',
    country: UzbekistanCountry.uzbekistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _Layout.none,
    noPanel: true,
    background: _split(120.4),
    slots: [
      _across(UzbekistanAlphabets.digits, 2, 26.9, 94.9, _Layout.rowTop, _Layout.rowHeight),
      _cell(UzbekistanAlphabets.foreignClass, 160.7, 64, _Layout.rowTop, _Layout.rowHeight),
      _across(
        UzbekistanAlphabets.digits,
        6,
        203.3,
        203.3 + 6 * _Layout.pitch,
        _Layout.rowTop,
        _Layout.rowHeight,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'class', prefix: ' '),
      PlateTextGroup([2], key: 'serial'),
    ],
    resolveTheme: UzbekistanThemes.byClass,
  );

  /// Temporary and export, `T012345 01`; the region sits right of the divider.
  /// `T` centre 48.7, digits from 93.1, divider x 398.6, region ink 424.8..488.8.
  static final PlateSpec temporary = PlateSpec(
    id: 'uz.temporary',
    country: UzbekistanCountry.uzbekistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _Layout.none,
    noPanel: true,
    background: _split(398.6),
    slots: [
      _across(
        UzbekistanAlphabets.digits,
        6,
        88.7,
        88.7 + 6 * _Layout.pitch,
        _Layout.rowTop,
        _Layout.rowHeight,
      ),
      _across(UzbekistanAlphabets.digits, 2, 422.8, 490.8, _Layout.rowTop, _Layout.rowHeight),
    ],
    labels: [_prefix('T', 48.7, 50)],
    textGroups: const [
      PlateTextGroup([0], key: 'serial', prefix: 'T'),
      PlateTextGroup([1], key: 'region', prefix: ' '),
    ],
  );

  /// Mission code + serial, the shape the diplomatic plates share.
  static PlateSpec _diplomatic({
    required String id,
    required List<PlateSlot> status,
    required List<PlateLabel> labels,
    required double digitsLeft,
    required double digitsRight,
  }) {
    final n = status.length;
    final middle = (digitsLeft + digitsRight) / 2;
    return PlateSpec(
      id: id,
      country: UzbekistanCountry.uzbekistan,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: _Layout.none,
      noPanel: true,
      slots: [
        ...status,
        _across(
          UzbekistanAlphabets.digits,
          3,
          digitsLeft,
          middle,
          _Layout.rowTop,
          _Layout.rowHeight,
        ),
        _across(
          UzbekistanAlphabets.digits,
          3,
          middle,
          digitsRight,
          _Layout.rowTop,
          _Layout.rowHeight,
        ),
      ],
      labels: labels,
      textGroups: [
        if (n > 0) PlateTextGroup([0], key: 'status'),
        PlateTextGroup([n], key: 'mission', prefix: n > 0 ? '' : 'CMD'),
        PlateTextGroup([n + 1], key: 'serial', prefix: ' '),
      ],
      restrictions: const [UzbekistanMissions.restriction],
    );
  }

  /// Ambassador, `CMD 012345`: the status is fixed print. `CMD` ink 37.5..195.5
  /// (scaled so the six digits fit the frame), digits from 221 at pitch 44.
  static final PlateSpec ambassador = _diplomatic(
    id: 'uz.ambassador',
    status: const [],
    labels: [_prefix('CMD', 116.5, 170)],
    digitsLeft: 221,
    digitsRight: 485,
  );

  /// Diplomat (`D`) or technical staff (`T`), `D 012345`: letter centre 105.9,
  /// digits 152.9.. at pitch 47.3 (ink ends 428).
  static final PlateSpec diplomat = _diplomatic(
    id: 'uz.diplomat',
    status: [
      _cell(UzbekistanAlphabets.diplomaticStatus, 105.9, 47, _Layout.rowTop, _Layout.rowHeight),
    ],
    labels: const [],
    digitsLeft: 148.5,
    digitsRight: 432.3,
  );

  /// United Nations, `UN 0123`, white on blue. `UN` ink 103..194, digits
  /// from 220.5 at pitch 47.3.
  static final PlateSpec unitedNations = PlateSpec(
    id: 'uz.united_nations',
    country: UzbekistanCountry.uzbekistan,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    panel: _Layout.none,
    noPanel: true,
    slots: [_across(UzbekistanAlphabets.digits, 4, 216, 405.2, _Layout.rowTop, _Layout.rowHeight)],
    labels: [_prefix('UN', 148.5, 100)],
    textGroups: const [
      PlateTextGroup([0], key: 'serial', prefix: 'UN'),
    ],
  );

  /// The block's outline is an L: the rule over it runs from the vertical to
  /// the right edge, the vertical from the rule to the bottom edge. Both are
  /// divider-coloured strips of the background, not boxes on the face.
  static const double _rule = _Layout.trailerRule;
  static const PlateSection _trailerBackground = PlateSection.rows([
    PlatePart(PlateSection.plain, end: _Layout.trailerRowEnd - _rule / 2),
    PlatePart(
      PlateSection.columns([
        PlatePart(PlateSection.plain, end: _Layout.trailerBlockEnd + _rule / 2),
        PlatePart(PlateSection.fill(PlateFill.divider)),
      ]),
      end: _Layout.trailerRowEnd + _rule / 2,
    ),
    PlatePart(
      PlateSection.columns([
        PlatePart(PlateSection.plain, end: _Layout.trailerBlockEnd - _rule / 2),
        PlatePart(PlateSection.fill(PlateFill.divider), end: _Layout.trailerBlockEnd + _rule / 2),
        PlatePart(PlateSection.plain),
      ]),
    ),
  ]);

  /// Trailer, `0123 AB 01`: digits over letters, region and flag in a block
  /// at the bottom right.
  static final PlateSpec trailer = PlateSpec(
    id: 'uz.trailer',
    country: UzbekistanCountry.uzbekistan,
    canvasWidth: _Layout.trailerWidth,
    canvasHeight: _Layout.trailerHeight,
    panel: _Layout.trailerPanel,
    background: _trailerBackground,
    slots: [
      _across(UzbekistanAlphabets.digits, 4, 41.6, 218.2, 2.2, 70),
      _across(UzbekistanAlphabets.letters, 2, 33, 125, 70, 82),
      _across(UzbekistanAlphabets.digits, 2, 154.7, 224.7, 63.8, 85),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters', prefix: ' '),
      PlateTextGroup([2], key: 'region', prefix: ' '),
    ],
  );

  /// Motorcycle, `123 AB 01`: digits over letters on the left, region over
  /// flag in a right column.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'uz.motorcycle',
    country: UzbekistanCountry.uzbekistan,
    canvasWidth: _Layout.motoWidth,
    canvasHeight: _Layout.motoHeight,
    panel: _Layout.motoPanel,
    background: PlateSection.columns([
      const PlatePart(PlateSection.plain, end: _Layout.motoColumnEnd, divider: _Layout.motoRule),
      PlatePart(
        PlateSection.rows([
          const PlatePart(PlateSection.plain, end: _Layout.motoRowEnd, divider: _Layout.motoRule),
          const PlatePart(PlateSection.plain),
        ]),
      ),
    ]),
    slots: [
      _across(UzbekistanAlphabets.digits, 3, 12.2, 118.8, 2, 75),
      _across(UzbekistanAlphabets.letters, 2, 36.4, 107.6, 67, 90),
      _across(UzbekistanAlphabets.digits, 2, 142.2, 187, 11, 51),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters', prefix: ' '),
      PlateTextGroup([2], key: 'region', prefix: ' '),
    ],
  );
}
