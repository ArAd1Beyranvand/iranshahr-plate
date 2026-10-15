import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'qatar_clippers.dart';
import 'qatar_colors.dart';
import 'qatar_country.dart';

/// The Qatari plate designs.
///
/// One idea carries the country, and it is the reason this package needed
/// [PlatePanel.shape] at all: **the country block is the flag, not a box with a
/// flag in it.** A Qatari plate opens with a maroon column whose inboard edge is
/// the nine-point serration of the national flag, with `QATAR` reversed out of
/// it one letter per line. There is no flag rectangle and no caption — the block
/// is cut to the flag's own shape by [QatarFlagEdgeClipper] and the wording is a
/// rotated [PlateLabel] stacked down it.
///
/// After the block the plate is plain: `قطر` in the middle distance, then the
/// serial. Qatar prints up to five digits — single digits belong to the royal
/// family — and the design does not change with the count, so [civilian] is
/// one spec whose serial is a field of three to five digits.
///
/// The exception is [motorcycle], which is a different plate and not a shorter
/// one: near-square, three bands, and no hoist block at all.
///
/// Every coordinate below is read off the reference photograph on Wikipedia's
/// "Vehicle registration plates of Qatar" article (1000 × 221 px, scaled to this
/// 520 × 110 canvas) and is a calibration target.
abstract final class QatarPlates {
  /// Where the maroon block sits, and the shape it is cut to. Shared by the two
  /// civilian sizes, which differ only in how many digits follow it.
  ///
  /// The block itself is the background's first column, [_hoistBackground],
  /// run out under the frame at top, left and bottom so the frame is drawn
  /// over it. The panel only places the (absent) flag and caption: zero
  /// padding and `flagScale: 0` say the block holds no flag — it *is* the
  /// flag; see [QatarCountry].
  static const PlatePanel _hoist = PlatePanel(
    box: PlateBox(0, 0, 54, 110),
    flagScale: 0,
    padding: EdgeInsets.zero,
    shape: QatarFlagEdgeClipper(),
  );

  static const PlateSection _hoistBackground = PlateSection.columns([
    PlatePart(
      PlateSection.fill(PlateFill.panel, shape: QatarFlagEdgeClipper()),
      end: 54,
    ),
    PlatePart(PlateSection.plain),
  ]);

  /// `QATAR`, reversed out of the maroon block, one letter per line.
  ///
  /// Set on the valley side of the serration — the block runs out to 54 but the
  /// letters stop at the spine near 42 — so no letter lands in a notch where the
  /// white field shows through. [PlateLabel.lineHeight] opens the gaps so five
  /// letters fill the column instead of bunching at its middle.
  static const PlateLabel _qatarLetters = PlateLabel(
    text: 'Q\nA\nT\nA\nR',
    box: PlateBox(4, 8, 34, 94),
    glyphHeight: 15,
    lineHeight: 1.25,
    color: QatarColors.onMaroon,
  );

  /// `قطر`, between the block and the serial.
  static const PlateLabel _qatarArabic = PlateLabel(
    text: 'قطر',
    box: PlateBox(78, 26, 94, 60),
    glyphHeight: 58,
  );

  /// The civilian serial's room: from [_serialLeft] to the right edge of the
  /// face, less the same margin. Every civilian size below fills exactly this
  /// span, which is what makes three, four and five digits read as one design
  /// at three lengths rather than as a plate with a gap in it.
  static const double _serialLeft = 209;
  static const double _serialRight = 500;

  /// The civilian serial: one field of three to five digits across the room
  /// between [_serialLeft] and [_serialRight]. A shorter serial sits centred
  /// in it, its figures set at the same size.
  static const PlateSlot _civilianSerial = PlateSlot(
    alphabet: PlateAlphabet.latinDigits,
    box: PlateBox(_serialLeft, 20, _serialRight - _serialLeft, 68),
    length: 5,
    minLength: 3,
  );

  /// The civilian plate (520 × 110): the maroon hoist block, `قطر`, then a
  /// serial of three to five digits — the longest Qatar issues, and the
  /// everyday registration at five. The article notes single digits are the
  /// royal family's, so three is the shortest an ordinary registration reaches.
  static final PlateSpec civilian = PlateSpec(
    id: 'qa.civilian',
    country: QatarCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _hoist,
    background: _hoistBackground,
    slots: const <PlateSlot>[_civilianSerial],
    labels: const [_qatarLetters, _qatarArabic],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// The motorcycle plate (300 × 220): near-square, and the one civilian
  /// design with no maroon block on it at all.
  ///
  /// The two-wheeler plate is not a shrunk car plate — it is laid out in three
  /// bands, and it is the only Qatari plate that prints the country's name in
  /// both scripts and nothing else: `قطر` across the head, the serial across
  /// the middle at the full width of the face, and `QATAR` along the foot. So
  /// there is no hoist block to serrate, which is why this spec declares
  /// [PlateSpec.noPanel] and carries its wording as labels.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'qa.motorcycle',
    country: QatarCountry.civilian,
    canvasWidth: 300,
    canvasHeight: 220,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), flagScale: 0),
    slots: const [
      PlateSlot(
        alphabet: PlateAlphabet.latinDigits,
        box: PlateBox(22, 62, 4 * 52 + 46, 94),
        length: 5,
        spacing: 11.4,
      ),
    ],
    labels: const [
      // The head row's `قطر` is set wide and shallow — the reference photograph
      // draws it with a long kashida joining the letters, so it spans much more
      // of the width than the three glyphs alone would.
      PlateLabel(text: 'قطر', box: PlateBox(84, 10, 132, 44), glyphHeight: 40),
      PlateLabel(
        text: 'QATAR',
        box: PlateBox(70, 168, 160, 40),
        glyphHeight: 36,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// The police plate (330 × 165): a four-digit serial over a two-cell head row
  /// reading `قطر` and `شرطة`, all reversed out white on blue.
  ///
  /// No maroon block and no serration — the whole face is blue and the wording
  /// sits on it — so this spec declares [PlateSpec.noPanel] and carries its own
  /// arrangement, the way Tajikistan's flagless coloured classes do. The two
  /// rules are the white boxes ruled around the head row's two cells.
  static final PlateSpec police = PlateSpec(
    id: 'qa.police',
    country: QatarCountry.police,
    canvasWidth: 330,
    canvasHeight: 165,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), flagScale: 0),
    slots: const [
      PlateSlot(
        alphabet: PlateAlphabet.latinDigits,
        box: PlateBox(88, 18, 3 * 42 + 38, 56),
        length: 4,
        spacing: 17.8,
      ),
    ],
    // The white rules the real plate is ruled with: the box around the serial
    // row, then the divider that splits the head row into its two cells.
    rules: const [
      PlateRule(box: PlateBox(12, 10, 306, 2)),
      PlateRule(box: PlateBox(12, 82, 306, 2)),
      PlateRule(box: PlateBox(165, 84, 2, 70)),
    ],
    labels: const [
      PlateLabel(
        text: 'قطر',
        box: PlateBox(24, 92, 128, 56),
        glyphHeight: 52,
        color: QatarColors.onPoliceBlue,
      ),
      PlateLabel(
        text: 'شرطة',
        box: PlateBox(178, 92, 128, 56),
        glyphHeight: 52,
        color: QatarColors.onPoliceBlue,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Every Qatari design, in the order they are introduced above. A picker
  /// iterates this rather than naming three constants.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    civilian,
    motorcycle,
    police,
  ]);
}
