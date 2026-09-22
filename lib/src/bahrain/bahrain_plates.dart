import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'bahrain_colors.dart';
import 'bahrain_country.dart';

/// The Bahraini plate designs.
///
/// Five specs, and between them exactly three ideas:
///
/// 1. **A grey vertical security band.** Every Bahraini plate carries one. On
///    the American size it stands clear of the right frame with the wording
///    outboard of it; on the European, bicycle, diplomatic and police plates it
///    runs the full height hard against the right edge. It is a [PlateRule], so
///    core paints it in [PlateTheme.dividerColor] — which is why no Bahraini
///    theme is a [PlateTheme.monochrome]; see `BahrainThemes`.
/// 2. **A flag, or a coloured band, in [PlateSpec.panel] — never both.**
///    Civilian plates put the flag on the white field, so the panel is the
///    flag's own rectangle painted in the field colour. Diplomatic and police
///    plates print a colour across the head and no flag, so the panel is that
///    band. Both are [BahrainCountry] values; neither uses a caption.
/// 3. **Wording as [PlateLabel]s.** `البحرين` and its Latin partner sit at
///    opposite ends of the plate on every design, which a caption — one
///    left-aligned column under the flag — cannot express. Labels on the
///    coloured bands carry their own [PlateLabel.color], because the band's ink
///    is not the serial's.
///
/// `final`, not `const`: the serials are built by [plateRegister], and a
/// `const` constructor cannot run a loop. Initialised lazily, once per isolate;
/// [PlateSpec] equality is over `id` alone, so nothing here depended on const
/// canonicalisation.
///
/// Every coordinate below is sampled by eye from plate photographs and is a
/// calibration target.
abstract final class BahrainPlates {
  /// The long European-size civilian plate (520×110): flag at the hoist end,
  /// six digits across the middle, `البحرين` over `BAHRAIN`, then the security
  /// band outboard of the wording at the right edge.
  static final PlateSpec eu = PlateSpec(
    id: 'bh.eu',
    country: BahrainCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    // The flag's rectangle, in the field colour — see BahrainCountry.civilian.
    // Zero padding and a flagScale of 1 make the flag fill the box exactly, so
    // the box IS the flag: 55 × 33 is the official 3:5 at this height.
    panel: const PlatePanel(box: PlateBox(12, 38.5, 55, 33), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 6,
        left: 80,
        top: 10,
        width: 50,
        height: 90,
        pitch: 55,
      ),
    ],
    // Full height and hard against the right edge, outboard of the wording —
    // the bicycle/diplomatic/police arrangement rather than the band-then-
    // wording one this size used to carry. It runs under the frame top, bottom
    // and right, and is clipped back to the rounded face, so it meets the
    // frame with no seam.
    rules: const [PlateRule(box: PlateBox(502.5, 0, 9, 110))],
    labels: const [
      PlateLabel(text: 'البحرين', box: PlateBox(408, 14, 98, 30), glyphHeight: 30),
      // Seven wide Latin capitals against six Arabic letters: the Latin still
      // needs the smaller glyph to hold one line, but the 98pt column this
      // arrangement frees lets it sit much closer to the Arabic's weight than
      // the 76pt one did.
      PlateLabel(text: 'BAHRAIN', box: PlateBox(408, 62, 98, 28), glyphHeight: 27),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4, 5], key: 'serial'),
    ],
  );

  /// The short American-size civilian plate (300×150). Same six digits and the
  /// same two words, re-laid in two bands: the wording and the flag move up
  /// into a head row and the serial takes the whole width beneath them.
  static final PlateSpec us = PlateSpec(
    id: 'bh.us',
    country: BahrainCountry.civilian,
    canvasWidth: 300,
    canvasHeight: 150,
    panel: const PlatePanel(box: PlateBox(108, 14, 45, 27), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 6,
        left: 16,
        top: 52,
        width: 38,
        height: 84,
        pitch: 42,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(282.5, 0, 9, 150))],
    labels: const [
      PlateLabel(text: 'BAHRAIN', box: PlateBox(12, 14, 88, 24), glyphHeight: 24),
      PlateLabel(text: 'البحرين', box: PlateBox(163, 12, 108, 30), glyphHeight: 28),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4, 5], key: 'serial'),
    ],
  );

  /// The bicycle plate (260×120): four digits, `BRN` and a bicycle mark in the
  /// head row, and — the change that makes this design its own spec rather than
  /// a shorter [us] — a security band run full height hard against the right
  /// edge instead of standing clear of it.
  static final PlateSpec bicycle = PlateSpec(
    id: 'bh.bicycle',
    country: BahrainCountry.civilian,
    canvasWidth: 260,
    canvasHeight: 120,
    panel: const PlatePanel(box: PlateBox(106, 12, 35, 21), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 34,
        top: 48,
        width: 42,
        height: 62,
        pitch: 48,
      ),
    ],
    rules: const [
      // Flush to the right edge and the full height of the canvas: it runs
      // under the frame at top, bottom and right, and is clipped back to the
      // rounded face, so it meets the frame with no seam.
      PlateRule(box: PlateBox(244, 0, 16, 120)),
    ],
    labels: const [
      PlateLabel(text: 'BRN', box: PlateBox(10, 12, 54, 26), glyphHeight: 26),
      // The mark, as text rather than as a PlateDecal: an emoji is a glyph, and
      // a glyph needs no asset, no pubspec entry and no package to own it.
      PlateLabel(text: '🚲', box: PlateBox(68, 8, 32, 30), glyphHeight: 30),
      PlateLabel(text: 'البحرين', box: PlateBox(148, 8, 92, 28), glyphHeight: 26),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
    ],
  );

  /// Diplomatic corps (250×110): a three-digit serial under a green head band
  /// carrying `BAHRAIN` / `C.D.` and `البحرين` / `هيئة دبلوماسية`, reversed out
  /// white. The band is the panel; the security band is the same full-height
  /// right-edge rule the bicycle plate uses.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'bh.diplomatic',
    country: BahrainCountry.diplomatic,
    canvasWidth: 250,
    canvasHeight: 110,
    // A colour and nothing else: flagScale 0 says so in data, rather than
    // leaving a flag box to be computed for a country that has no flag. It
    // overlaps the frame on the left and top and stops at the security band on
    // the right; the face clip trims it back to the rounded corner.
    panel: const PlatePanel(box: PlateBox(0, 0, 234, 54), flagScale: 0, padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 60,
        top: 60,
        width: 34,
        height: 45,
        pitch: 40,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(234, 0, 16, 110))],
    labels: const [
      PlateLabel(text: 'BAHRAIN', box: PlateBox(8, 5, 76, 20), glyphHeight: 20, color: BahrainColors.onDiplomaticGreen),
      PlateLabel(text: 'C.D.', box: PlateBox(8, 29, 76, 22), glyphHeight: 22, color: BahrainColors.onDiplomaticGreen),
      PlateLabel(
        text: 'البحرين',
        box: PlateBox(120, 3, 108, 22),
        glyphHeight: 22,
        color: BahrainColors.onDiplomaticGreen,
      ),
      PlateLabel(
        text: 'هيئة دبلوماسية',
        box: PlateBox(108, 28, 120, 22),
        glyphHeight: 20,
        color: BahrainColors.onDiplomaticGreen,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'serial'),
    ],
  );

  /// Police (250×110): a four-digit serial under a pale blue head band reading
  /// `POLICE` / `الشرطة`.
  ///
  /// The gap between the two words is deliberate — the force's roundel goes
  /// there, and it will be a [PlateDecal] over `assets/` once the artwork
  /// exists. Nothing else about this spec changes when it lands.
  static final PlateSpec police = PlateSpec(
    id: 'bh.police',
    country: BahrainCountry.police,
    canvasWidth: 250,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(0, 0, 234, 44), flagScale: 0, padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 40,
        top: 50,
        width: 34,
        height: 52,
        pitch: 40,
      ),
    ],
    rules: const [PlateRule(box: PlateBox(234, 0, 16, 110))],
    labels: const [
      // Printed dark, not reversed out: the band is pale enough that white
      // wording on it would not read.
      PlateLabel(text: 'POLICE', box: PlateBox(8, 10, 76, 24), glyphHeight: 24, color: BahrainColors.onPoliceBlue),
      PlateLabel(text: 'الشرطة', box: PlateBox(146, 8, 82, 28), glyphHeight: 26, color: BahrainColors.onPoliceBlue),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
    ],
  );

  /// Every Bahraini design, in the order they are introduced above. A picker
  /// iterates this rather than naming five constants.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[eu, us, bicycle, diplomatic, police]);
}
