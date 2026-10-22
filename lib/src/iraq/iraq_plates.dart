import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import '../plate_field.dart';
import 'iraq_alphabets.dart';
import 'iraq_country.dart';

/// Where the ink sits, in plate coordinates.
///
/// Measured off the 2022/2024 reference artwork on Wikimedia Commons by
/// normalising each plate rectangle to the article's physical size and
/// projecting the ink onto each axis; within a size the files agree to a tenth of
/// a unit, so two templates cover all six classes.
///
/// Both canvases are the article's millimetres, not the artwork's aspect (4.635:1
/// against a true 4.727:1, and 2.000:1 against 2.161:1).
abstract final class _Layout {
  // ---------------------------------------------------------------------
  // 520x110 — "Standard European size", the plate almost every vehicle gets.
  // One row: governorate code, class letter, five-digit serial.
  // ---------------------------------------------------------------------

  static const double largeWidth = 520;
  static const double largeHeight = 110;

  /// The band's size; the red is a background region running out under the frame.
  static const PlateBox largeBand = PlateBox(4.8, 4.7, 39.3, 100.6);

  /// The divider is the frame's width, edge to edge.
  static const double largeDivider = 4.3;
  static const double largeBandEnd = 44.1 + largeDivider / 2;

  /// Serial row. The reference ink is 61% of the plate's height, but a slot's box is
  /// its glyph height and core prints ~0.525 of it as ink, so matching it would need
  /// a 127-unit box. 106 is the tallest that fits and keeps the ink centred, landing
  /// at ~78% of reference. The top is 1.4, not 0.7: a cap sits 0.7 above its line
  /// box's centre.
  static const double largeRowTop = 1.4;
  static const double largeRowHeight = 106;

  /// Governorate pair: ink centres 81.8 and 131.1, so a 49.3 pitch.
  static const double largeCodeLeft = 57.15;
  static const double largeCodeCell = 49.3;

  /// Class letter: ink 187.7..228.6, centre 208.15.
  static const PlateBox largeLetter = PlateBox(184.15, largeRowTop, 48, largeRowHeight);

  /// Serial: ink centres 284.2..477.5, so a 48.3 pitch from a 260.05 left.
  static const double largeSerialLeft = 260.05;
  static const double largeSerialCell = 48.3;

  /// "IRQ" set as three stacked upright letters, not rotated text, centred on
  /// the band. Reference cap height 20.9 at a 34.9 line pitch; core prints
  /// 0.525 of [largeStackGlyph] as ink and steps lines by `0.72 * glyph *
  /// lineHeight`.
  static const double largeStackGlyph = 39.8;
  static const double largeStackLineHeight = 1.22;

  /// Kurdistan tightens the "IRQ" stack and lifts it to make room for "KR".
  static const double largeStackLineHeightKr = 0.835;
  static const PlateBox largeStackKr = PlateBox(4.8, 3.8, 39.3, 80);

  /// "KR": cap height 16.7, centred on y 91.25.
  static const PlateBox largeKrBox = PlateBox(4.8, 76.25, 39.3, 30);
  static const double largeKrGlyph = 31.8;

  // ---------------------------------------------------------------------
  // 335x155 — issued on request for vehicles whose mounting cannot take the
  // European plate. Two rows: code and letter over the serial.
  // ---------------------------------------------------------------------

  static const double smallWidth = 335;
  static const double smallHeight = 155;

  /// Measured x 4.2..38.6, y 3.9..151.1; a background region, as [largeBand].
  static const PlateBox smallBand = PlateBox(4.2, 3.9, 34.4, 147.2);

  /// Edge to edge again, at the frame's width. Measured x 38.6..42.3.
  static const double smallDivider = 3.7;
  static const double smallBandEnd = 38.6 + smallDivider / 2;

  /// Both rows print at one height, so the box-inside-the-canvas limit binds
  /// (84 and 82.2 at most), at ~78% of reference. The bottom row cannot take the
  /// 1.3 cap correction of [largeRowTop]: 73 is the last top that fits, so the 1.4
  /// is the canvas running out.
  static const double smallRowHeight = 82;
  static const double smallTopRowTop = 2.3;
  static const double smallBottomRowTop = 73.0;

  /// Both rows sit on one five-column grid: ink centres 84.0..282.7, a 49.7
  /// pitch. The code takes columns 0 and 1 and the serial takes all five.
  static const double smallGridLeft = 59.15;
  static const double smallGridCell = 49.7;

  /// The class letter is the one cell off the grid: its ink centres on 235.65,
  /// not on column 3's 233.1.
  static const PlateBox smallLetter = PlateBox(211.65, smallTopRowTop, 48, smallRowHeight);

  /// "IRQ" at a 22.0 cap; Kurdistan does not move it here, only adds "KR" below.
  static const PlateBox smallStack = PlateBox(4.2, 4.5, 32.5, 110);
  static const double smallStackGlyph = 41.9;
  static const double smallStackLineHeight = 1.08;

  /// "KR": cap height 15.1, centred on y 129.8.
  static const PlateBox smallKrBox = PlateBox(4.2, 115.8, 32.5, 28);
  static const double smallKrGlyph = 28.8;

  /// Temporary plates put a governorate code, a dash and a two-digit year on
  /// the top row instead of a code and a letter: five evenly pitched cells of
  /// their own, ink centres 87.7..278.5 at a 47.7 pitch.
  static const double temporaryGridLeft = 63.85;
  static const double temporaryGridCell = 47.7;
}

/// Only the current series: the earlier four (1988-2001, 2001-2008, 2008-2024,
/// and the Kurdistan Region's 1988 format until 2022) share no geometry with
/// it and are not implemented.
///
/// The format is `GG X #####`: governorate code, class letter, five-digit serial.
/// The article's "Colour" column names the band down the left edge, not the
/// field: all six classes are black on white, so the class is the band colour
/// (the country's) and needs no spec. What needs a spec is the canvas (two
/// sizes) and the region (Kurdistan adds "KR" under "IRQ").
///
/// The security hologram between the code and the letter is a physical sticker
/// and is not reproduced.
abstract final class IraqPlates {
  /// The 520x110 template. [kurdistan] adds "KR" beneath "IRQ" and retightens the stack.
  static PlateSpec _large({required String id, required bool kurdistan}) => PlateSpec(
    id: id,
    country: IraqCountry.private,
    canvasWidth: _Layout.largeWidth,
    canvasHeight: _Layout.largeHeight,
    panel: const PlatePanel(box: _Layout.largeBand, flagScale: 0, padding: EdgeInsets.zero),
    slots: <PlateSlot>[
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 2,
        left: _Layout.largeCodeLeft,
        top: _Layout.largeRowTop,
        width: _Layout.largeCodeCell,
        height: _Layout.largeRowHeight,
      ),
      const PlateSlot(alphabet: IraqAlphabets.letters, box: _Layout.largeLetter),
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 5,
        left: _Layout.largeSerialLeft,
        top: _Layout.largeRowTop,
        width: _Layout.largeSerialCell,
        height: _Layout.largeRowHeight,
      ),
    ],
    background: _largeBackground,
    labels: <PlateLabel>[
      PlateLabel(
        text: 'I\nR\nQ',
        box: kurdistan ? _Layout.largeStackKr : _Layout.largeBand,
        glyphHeight: _Layout.largeStackGlyph,
        lineHeight: kurdistan ? _Layout.largeStackLineHeightKr : _Layout.largeStackLineHeight,
      ),
      if (kurdistan)
        const PlateLabel(text: 'KR', box: _Layout.largeKrBox, glyphHeight: _Layout.largeKrGlyph),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'governorate'),
      PlateTextGroup(<int>[1], key: 'letter'),
      PlateTextGroup(<int>[2], key: 'serial'),
    ],
  );

  /// The 335x155 template: code and letter over the serial.
  static PlateSpec _small({required String id, required bool kurdistan}) => PlateSpec(
    id: id,
    country: IraqCountry.private,
    canvasWidth: _Layout.smallWidth,
    canvasHeight: _Layout.smallHeight,
    panel: const PlatePanel(box: _Layout.smallBand, flagScale: 0, padding: EdgeInsets.zero),
    slots: <PlateSlot>[
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 2,
        left: _Layout.smallGridLeft,
        top: _Layout.smallTopRowTop,
        width: _Layout.smallGridCell,
        height: _Layout.smallRowHeight,
      ),
      const PlateSlot(alphabet: IraqAlphabets.letters, box: _Layout.smallLetter),
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 5,
        left: _Layout.smallGridLeft,
        top: _Layout.smallBottomRowTop,
        width: _Layout.smallGridCell,
        height: _Layout.smallRowHeight,
      ),
    ],
    background: _smallBackground,
    labels: <PlateLabel>[_smallStack, if (kurdistan) _smallKr],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'governorate'),
      PlateTextGroup(<int>[1], key: 'letter'),
      PlateTextGroup(<int>[2], key: 'serial'),
    ],
  );

  static const PlateSection _largeBackground = PlateSection.columns(<PlatePart>[
    PlatePart(
      PlateSection.fill(PlateFill.panel),
      end: _Layout.largeBandEnd,
      divider: _Layout.largeDivider,
    ),
    PlatePart(PlateSection.plain),
  ]);

  static const PlateSection _smallBackground = PlateSection.columns(<PlatePart>[
    PlatePart(
      PlateSection.fill(PlateFill.panel),
      end: _Layout.smallBandEnd,
      divider: _Layout.smallDivider,
    ),
    PlatePart(PlateSection.plain),
  ]);

  static const PlateLabel _smallStack = PlateLabel(
    text: 'I\nR\nQ',
    box: _Layout.smallStack,
    glyphHeight: _Layout.smallStackGlyph,
    lineHeight: _Layout.smallStackLineHeight,
  );

  static const PlateLabel _smallKr = PlateLabel(
    text: 'KR',
    box: _Layout.smallKrBox,
    glyphHeight: _Layout.smallKrGlyph,
  );

  /// 520x110, outside the Kurdistan Region: "IRQ" alone in the band.
  static final PlateSpec large = _large(id: 'iq.large', kurdistan: false);

  /// 520x110, Kurdistan Region (governorates 21-24): "IRQ" over "KR".
  static final PlateSpec largeKurdistan = _large(id: 'iq.large.kr', kurdistan: true);

  /// 335x155, outside the Kurdistan Region.
  static final PlateSpec small = _small(id: 'iq.small', kurdistan: false);

  /// 335x155, Kurdistan Region.
  static final PlateSpec smallKurdistan = _small(id: 'iq.small.kr', kurdistan: true);

  /// 335x155 temporary, red on white. Its own spec because the top row is a
  /// governorate code, a dash and the two-digit expiry year on five evenly pitched
  /// cells, not a code and a class letter. Documented only for the Kurdistan
  /// Region, so it carries "KR".
  static final PlateSpec smallTemporary = PlateSpec(
    id: 'iq.small.temporary',
    country: IraqCountry.temporary,
    canvasWidth: _Layout.smallWidth,
    canvasHeight: _Layout.smallHeight,
    panel: const PlatePanel(box: _Layout.smallBand, flagScale: 0, padding: EdgeInsets.zero),
    slots: <PlateSlot>[
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 2,
        left: _Layout.temporaryGridLeft,
        top: _Layout.smallTopRowTop,
        width: _Layout.temporaryGridCell,
        height: _Layout.smallRowHeight,
      ),
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 2,
        left: _Layout.temporaryGridLeft + 3 * _Layout.temporaryGridCell,
        top: _Layout.smallTopRowTop,
        width: _Layout.temporaryGridCell,
        height: _Layout.smallRowHeight,
      ),
      plateField(
        alphabet: IraqAlphabets.digits,
        count: 5,
        left: _Layout.smallGridLeft,
        top: _Layout.smallBottomRowTop,
        width: _Layout.smallGridCell,
        height: _Layout.smallRowHeight,
      ),
    ],
    background: _smallBackground,
    labels: <PlateLabel>[
      _smallStack,
      _smallKr,
      // The dash sits in the grid cell between the code and the year, at the
      // row's own glyph height, so it prints at the weight the digits do.
      const PlateLabel(
        text: '-',
        box: PlateBox(
          _Layout.temporaryGridLeft + 2 * _Layout.temporaryGridCell,
          _Layout.smallTopRowTop,
          _Layout.temporaryGridCell,
          _Layout.smallRowHeight,
        ),
        glyphHeight: _Layout.smallRowHeight,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'governorate'),
      PlateTextGroup(<int>[1], key: 'year'),
      PlateTextGroup(<int>[2], key: 'serial'),
    ],
  );

  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    large,
    largeKurdistan,
    small,
    smallKurdistan,
    smallTemporary,
  ]);
}
