import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'oman_alphabets.dart';
import 'oman_country.dart';

/// Three panels side by side — number, letters, `عمان` — split by two dark
/// dividers. The geometry differs by digit count because the two sources do:
/// the artwork (`Оман1/2.gif`, four digits, two letters) gives the panels
/// 172 / 154 / 172 wide, the 2001 photograph (five digits, one letter) gives
/// 217 / 111 / 176 with thin dividers. Each is the source's field normalised
/// to 520×110 (the article's 520×110 mm), x and y scaled separately.
abstract final class _Layout {
  static const double width = 520;
  static const double height = 110;

  /// A digit row. Reference digit ink is 73.3 tall (artwork, y 19.9..93.2) and
  /// 81 (photo, 11.5..92.7). A slot scales its glyph down to the cell's width,
  /// so with the app's Vazirmatn at the 38–41 pitch ink is width-bound at 48
  /// (65% of the artwork's) however tall the box is. The box is 92 so that it
  /// can be centred on [_Panels.digitCentre] and still end inside the canvas.
  static const double digitHeight = 92;

  /// The name label's row: the full plate height, ink centred by its box.
  static const double rowTop = 3;
  static const double rowHeight = 106;

  /// Latin letter row: caps 38 tall, y 61.9..100.1, centre 81. A 58 box
  /// centred there is the largest that fits under the canvas (bottom 110),
  /// ~32 of ink — 84% of the reference.
  static const double latinTop = 52;
  static const double latinHeight = 58;

  /// Arabic letter row: ink y 8.4..54.2 (artwork, the tall `ك`), centre 31;
  /// both columns span x 202..325 in the golden against 200.5..327.2. The
  /// ink is ~25 tall in Vazirmatn (ref 46), centred on 29.5 (ref 31): the
  /// reference letters are drawn taller than the face's.
  static const double arabicTop = 0;
  static const double arabicHeight = 44;
  static const double arabicGlyph = 52;

  /// `عمان` is a calligraphic word in the reference (71 tall, 123 wide in the
  /// artwork); Vazirmatn is far squatter, so the glyph is sized to the
  /// reference's *width* and the height comes out ~58%.
  static const double nameWidth = 170;
}

/// What differs between the two measured geometries.
class _Panels {
  const _Panels({
    required this.dividerA,
    required this.dividerB,
    required this.thickness,
    required this.digitsLeft,
    required this.digitPitch,
    required this.letterCentre,
    required this.letterPitch,
    required this.letterCell,
    required this.nameCentre,
    required this.nameGlyph,
    required this.digitCentre,
  });

  /// Divider centres, x, and their thickness.
  final double dividerA, dividerB, thickness;

  final double digitsLeft, digitPitch;

  /// Centre of the letters panel, the distance between two letters' centres,
  /// and one letter cell's width.
  final double letterCentre, letterPitch, letterCell;

  final double nameCentre, nameGlyph;

  /// y of the digit ink's centre.
  final double digitCentre;

  /// The photograph's geometry, the widest of the two sources: panels 4.4..221.2 | 224.4..335.8 | 339.3..515.3, dividers at
  /// 222.8 and 337.5, 3.3 thick. Digits `91169`: first `9` centre 34.3, last
  /// 200.3, so pitch 41.5 — but the left edge is 10.8, not the 13.5 that gives:
  /// a slot shrinks Roboto's `9` to its cell, and 13.5 inked 2.7 right of the
  /// photograph's (measured on the golden). One letter, `A`, centred 280.1.
  /// Two letters are not photographed; they are placed 50 apart, as wide as
  /// the panel allows. Name ink 347..503 (156 wide), centre 425; digit ink y centre 52.
  static const _Panels photo = _Panels(
    dividerA: 222.8,
    dividerB: 337.5,
    thickness: 3.3,
    digitsLeft: 10.8,
    digitPitch: 41.5,
    letterCentre: 280.1,
    letterPitch: 50,
    letterCell: 50,
    nameCentre: 425,
    nameGlyph: 90,
    digitCentre: 59.5,
  );
}

/// The 2001 series. Colour lives on `OmanThemes`: private is black on yellow,
/// taxi white on red, the same design.
///
/// Only the current series is implemented; the 1980s plate and the old
/// black-on-white district-lettered plate (`99999 X`) are not. The article
/// lists other classes (government, diplomatic, tractor, export, …) without
/// artwork, so none is implemented.
abstract final class OmanPlates {
  /// `1234 AB`: a number of four or five digits and one or two letters. The
  /// letters are picked from a list, so each is its own slot, and the plate
  /// comes in two forms by letter count. The Arabic row above is an editable
  /// mirror of each letter, and reads in the opposite order (`BM` prints `م`
  /// over `B` and `ب` over `M`). Four digits with two letters, and five with
  /// one, are the formats photographed or drawn; the others use the same rule.
  /// A four-digit number sits centred in the box laid out for five.
  static final PlateSpec oneLetter = _standard(1);
  static final PlateSpec twoLetters = _standard(2);

  static PlateSpec _standard(int letters) {
    const p = _Panels.photo;
    final first = p.letterCentre - (letters - 1) * p.letterPitch / 2;
    double cellLeft(int i) => first + i * p.letterPitch - p.letterCell / 2;

    return PlateSpec(
      id: 'om.letters$letters',
      country: OmanCountry.oman,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
      noPanel: true,
      background: PlateSection.columns(<PlatePart>[
        PlatePart(PlateSection.plain, end: p.dividerA, divider: p.thickness),
        PlatePart(PlateSection.plain, end: p.dividerB, divider: p.thickness),
        const PlatePart(PlateSection.plain),
      ]),
      slots: <PlateSlot>[
        PlateSlot(
          alphabet: OmanAlphabets.digits,
          box: PlateBox(
            p.digitsLeft,
            p.digitCentre - _Layout.digitHeight / 2,
            5 * p.digitPitch,
            _Layout.digitHeight,
          ),
          length: 5,
          minLength: 4,
        ),
        for (var i = 0; i < letters; i++)
          PlateSlot(
            alphabet: OmanAlphabets.letters,
            box: PlateBox(cellLeft(i), _Layout.latinTop, p.letterCell, _Layout.latinHeight),
          ),
      ],
      mirrors: <PlateMirror>[
        for (var i = 0; i < letters; i++)
          PlateMirror(
            source: letters - i,
            box: PlateBox(cellLeft(i), _Layout.arabicTop, p.letterCell, _Layout.arabicHeight),
            glyphHeight: _Layout.arabicGlyph,
            alphabet: OmanAlphabets.lettersArabic,
            editable: true,
          ),
      ],
      labels: <PlateLabel>[
        PlateLabel(
          text: 'عُمان',
          box: PlateBox(
            p.nameCentre - _Layout.nameWidth / 2,
            _Layout.rowTop,
            _Layout.nameWidth,
            _Layout.rowHeight,
          ),
          glyphHeight: p.nameGlyph,
        ),
      ],
      textGroups: <PlateTextGroup>[
        const PlateTextGroup(<int>[0], key: 'number'),
        PlateTextGroup(<int>[for (var i = 0; i < letters; i++) 1 + i], key: 'letters'),
      ],
    );
  }

  static final List<PlateSpec> all = <PlateSpec>[oneLetter, twoLetters];
}
