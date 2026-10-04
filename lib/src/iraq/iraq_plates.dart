import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'iraq_alphabets.dart';
import 'iraq_country.dart';

/// Where the ink sits on an Iraqi plate, in plate coordinates.
///
/// Measured off the reference artwork for the 2022/2024 series on Wikimedia
/// Commons — `Iraq_-_License_Plate_-_{Private,Bus_and_Taxi,Governmental,Truck,
/// Agricultural}.png`, the matching `Iraq_-_Kurdistan_-_*` files, their
/// `-_Small_-` variants and
/// `Iraq_-_Kurdistan_-_License_Plate_-_Temporary_-_Erbil_-_Sulimaniyah.png` —
/// by normalising each file's plate rectangle to the physical size the article
/// gives and projecting the ink onto each axis. Within a size the files agree
/// to a tenth of a unit, which is why two templates cover all six classes.
///
/// Both canvases are the article's millimetres, not the artwork's aspect: the
/// 520x110 files are drawn at 4.635:1 against a true 4.727:1, and the 335x155
/// files at 2.000:1 against a true 2.161:1. Laying out proportionally inside
/// the documented size keeps Iraq consistent with every other package here.
abstract final class _Layout {
  // ---------------------------------------------------------------------
  // 520x110 — "Standard European size", the plate almost every vehicle gets.
  // One row: governorate code, class letter, five-digit serial.
  // ---------------------------------------------------------------------

  static const double largeWidth = 520;
  static const double largeHeight = 110;

  /// The band runs from the frame to the divider, the full height inside the
  /// frame. Measured x 4.8..44.1, y 4.7..105.3. The red is a background
  /// region running out under the frame, so these numbers only place the
  /// "IRQ" stack on it; the region itself ends at the divider.
  static const PlateBox largeBand = PlateBox(4.8, 4.7, 39.3, 100.6);

  /// The divider is the frame's own width and runs edge to edge — top frame to
  /// bottom frame, with no field showing past either end. Measured x
  /// 44.1..48.4, ink contiguous over the full 0..110.
  static const double largeDivider = 4.3;
  static const double largeBandEnd = 44.1 + largeDivider / 2;

  /// Serial row. The reference ink is 66.7 units tall on a 110-unit plate —
  /// 61% of the plate's whole height. A slot's box *is* its glyph height and
  /// has to fit the canvas, and core prints about 0.525 of that box as ink, so
  /// matching it would need a 127-unit box. 106 is the tallest that keeps the
  /// ink centred where the reference puts it (y 53.7) and still fits, which
  /// lands the digits at about 78% of reference size.
  ///
  /// The top is 1.4 rather than the 0.7 that would centre the *box* on 53.7:
  /// the rendered ink sits 0.7 above its box's centre, measured off the
  /// golden, because a cap occupies the upper part of the line box.
  static const double largeRowTop = 1.4;
  static const double largeRowHeight = 106;

  /// Governorate pair: ink centres 81.8 and 131.1, so a 49.3 pitch.
  static const double largeCodeLeft = 57.15;
  static const double largeCodeCell = 49.3;

  /// Class letter: ink 187.7..228.6, centre 208.15.
  static const PlateBox largeLetter = PlateBox(
    184.15,
    largeRowTop,
    48,
    largeRowHeight,
  );

  /// Serial: ink centres 284.2..477.5, so a 48.3 pitch from a 260.05 left.
  static const double largeSerialLeft = 260.05;
  static const double largeSerialCell = 48.3;

  /// "IRQ" set as three stacked upright letters, not rotated text, centred on
  /// the band. Reference cap height 20.9 at a 34.9 line pitch; core prints
  /// 0.525 of [largeStackGlyph] as ink and steps lines by `0.72 * glyph *
  /// lineHeight`.
  static const double largeStackGlyph = 39.8;
  static const double largeStackLineHeight = 1.22;

  /// Kurdistan tightens the "IRQ" stack and lifts it to make room for "KR":
  /// the three letters keep their 20.9 cap but step by 23.95, and the group
  /// centres on y 43.8 rather than 54.75.
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

  /// Both rows print at the same 55.5-unit cap, centred on y 42.0 and y
  /// 113.9. The same box-inside-the-canvas limit as [largeRowHeight] binds
  /// here and harder, because the rows sit near the edges: the top row can be
  /// at most 84 units and the bottom at most 82.2. One height for both keeps
  /// the two rows the same size, as the reference has them, at about 78% of
  /// reference, and at about 80% of it.
  ///
  /// The tops carry the same 1.3-unit correction as [largeRowTop] for where a
  /// cap sits inside its line box. The bottom row cannot take it: 73 is the
  /// last top that keeps an 82-unit box on a 155-unit canvas, so its ink
  /// centres on 112.5 against the reference's 113.9. The 1.4 is the canvas
  /// running out, not a free choice.
  static const double smallRowHeight = 82;
  static const double smallTopRowTop = 2.3;
  static const double smallBottomRowTop = 73.0;

  /// Both rows sit on one five-column grid: ink centres 84.0..282.7, a 49.7
  /// pitch. The code takes columns 0 and 1 and the serial takes all five.
  static const double smallGridLeft = 59.15;
  static const double smallGridCell = 49.7;

  /// The class letter is the one cell off the grid: its ink centres on 235.65,
  /// not on column 3's 233.1.
  static const PlateBox smallLetter = PlateBox(
    211.65,
    smallTopRowTop,
    48,
    smallRowHeight,
  );

  /// "IRQ" again, at a 22.0 cap and a 32.6 line pitch, centred on (20.45,
  /// 59.5). Unlike the large plate, Kurdistan does not move it — the reference
  /// puts the three letters at the same y in both regional designs and simply
  /// adds "KR" below.
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

/// The Iraqi plate designs.
///
/// Only the current series is here. Iraq has had four: 1988-2001, 2001-2008,
/// 2008-2024, and the 2022/2024 unification — the Kurdistan Region kept the
/// 1988 format until 2022 while the rest of the country moved on twice. The
/// earlier four are Arabic script and eastern Arabic numerals and share no
/// geometry with these; they are deliberately not implemented.
///
/// The current series was negotiated between the Federal Government and the
/// Kurdistan Regional Government to unify the design. It reached the four
/// Kurdistan governorates in April 2022 and the rest of Iraq in June 2024.
/// The format is `GG X #####`: a two-digit governorate code, a class letter,
/// and a five-digit serial.
///
/// **What varies is not what you would guess from the article's table.** That
/// table's "Colour" column names the *band* down the left-hand edge, not the
/// field: all six classes are black on white, and private vehicles get a white
/// band that the divider alone separates from the face. So the class is a
/// colour, the colour is the band's, the band's colour is the country's — and
/// six classes need no specs of their own at all. What does need a spec is the
/// canvas (two sizes) and the region (Kurdistan adds "KR" under the "IRQ").
///
/// The security hologram the artwork shows between the code and the letter is
/// not reproduced: it is a physical anti-counterfeiting sticker rather than
/// part of the registration, and there is no licensed artwork for it here.
abstract final class IraqPlates {
  /// The 520x110 template: band, edge-to-edge divider, then the code, the
  /// class letter and the serial across one row.
  ///
  /// [kurdistan] adds the smaller "KR" beneath the "IRQ" and retightens the
  /// stack above it, which is the whole of the difference between the two
  /// regional designs.
  static PlateSpec _large({required String id, required bool kurdistan}) =>
      PlateSpec(
        id: id,
        country: IraqCountry.private,
        canvasWidth: _Layout.largeWidth,
        canvasHeight: _Layout.largeHeight,
        panel: const PlatePanel(
          box: _Layout.largeBand,
          flagScale: 0,
          padding: EdgeInsets.zero,
        ),
        slots: <PlateSlot>[
          ...plateRegister(
            alphabet: IraqAlphabets.digits,
            count: 2,
            left: _Layout.largeCodeLeft,
            top: _Layout.largeRowTop,
            width: _Layout.largeCodeCell,
            height: _Layout.largeRowHeight,
          ),
          const PlateSlot(
            alphabet: IraqAlphabets.letters,
            box: _Layout.largeLetter,
          ),
          ...plateRegister(
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
            lineHeight: kurdistan
                ? _Layout.largeStackLineHeightKr
                : _Layout.largeStackLineHeight,
          ),
          if (kurdistan)
            const PlateLabel(
              text: 'KR',
              box: _Layout.largeKrBox,
              glyphHeight: _Layout.largeKrGlyph,
            ),
        ],
        textGroups: const <PlateTextGroup>[
          PlateTextGroup(<int>[0, 1], key: 'governorate'),
          PlateTextGroup(<int>[2], key: 'letter'),
          PlateTextGroup(<int>[3, 4, 5, 6, 7], key: 'serial'),
        ],
      );

  /// The 335x155 template: the same band and divider, the code and letter on
  /// the top row, the serial on the bottom.
  static PlateSpec _small({required String id, required bool kurdistan}) =>
      PlateSpec(
        id: id,
        country: IraqCountry.private,
        canvasWidth: _Layout.smallWidth,
        canvasHeight: _Layout.smallHeight,
        panel: const PlatePanel(
          box: _Layout.smallBand,
          flagScale: 0,
          padding: EdgeInsets.zero,
        ),
        slots: <PlateSlot>[
          ...plateRegister(
            alphabet: IraqAlphabets.digits,
            count: 2,
            left: _Layout.smallGridLeft,
            top: _Layout.smallTopRowTop,
            width: _Layout.smallGridCell,
            height: _Layout.smallRowHeight,
          ),
          const PlateSlot(
            alphabet: IraqAlphabets.letters,
            box: _Layout.smallLetter,
          ),
          ...plateRegister(
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
          PlateTextGroup(<int>[0, 1], key: 'governorate'),
          PlateTextGroup(<int>[2], key: 'letter'),
          PlateTextGroup(<int>[3, 4, 5, 6, 7], key: 'serial'),
        ],
      );

  /// The band in the panel colour, which [IraqCountry] varies by category,
  /// then the field, with the divider on the boundary.
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
  static final PlateSpec largeKurdistan = _large(
    id: 'iq.large.kr',
    kurdistan: true,
  );

  /// 335x155, outside the Kurdistan Region.
  static final PlateSpec small = _small(id: 'iq.small', kurdistan: false);

  /// 335x155, Kurdistan Region.
  static final PlateSpec smallKurdistan = _small(
    id: 'iq.small.kr',
    kurdistan: true,
  );

  /// 335x155 temporary, printed in red on white rather than black.
  ///
  /// Its own spec rather than a flag on [_small], because the top row is a
  /// different thing: a governorate code, a dash and the two-digit expiry
  /// year, on five evenly pitched cells of their own, where the permanent
  /// plates put a code and a class letter on the shared grid. The article
  /// documents it only for the Kurdistan Region, so it carries "KR".
  static final PlateSpec smallTemporary = PlateSpec(
    id: 'iq.small.temporary',
    country: IraqCountry.temporary,
    canvasWidth: _Layout.smallWidth,
    canvasHeight: _Layout.smallHeight,
    panel: const PlatePanel(
      box: _Layout.smallBand,
      flagScale: 0,
      padding: EdgeInsets.zero,
    ),
    slots: <PlateSlot>[
      ...plateRegister(
        alphabet: IraqAlphabets.digits,
        count: 2,
        left: _Layout.temporaryGridLeft,
        top: _Layout.smallTopRowTop,
        width: _Layout.temporaryGridCell,
        height: _Layout.smallRowHeight,
      ),
      ...plateRegister(
        alphabet: IraqAlphabets.digits,
        count: 2,
        left: _Layout.temporaryGridLeft + 3 * _Layout.temporaryGridCell,
        top: _Layout.smallTopRowTop,
        width: _Layout.temporaryGridCell,
        height: _Layout.smallRowHeight,
      ),
      ...plateRegister(
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
      PlateTextGroup(<int>[0, 1], key: 'governorate'),
      PlateTextGroup(<int>[2, 3], key: 'year'),
      PlateTextGroup(<int>[4, 5, 6, 7, 8], key: 'serial'),
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
