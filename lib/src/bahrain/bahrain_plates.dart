import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'bahrain_colors.dart';
import 'bahrain_country.dart';

/// Five specs sharing three ideas:
///
/// 1. A grey vertical security band, a [PlateRule] painted in
///    [PlateTheme.dividerColor] (hence no monochrome theme). On the American
///    size it stands clear of the right frame; elsewhere it runs full height
///    against the edge.
/// 2. A flag or a coloured band in [PlateSpec.panel], never both: civilian
///    plates paint the flag's rectangle in the field colour, diplomatic and
///    police plates paint a head band.
/// 3. Wording as [PlateLabel]s, since a caption (one column under the flag)
///    cannot put the Arabic and Latin at opposite ends. Labels on the
///    coloured bands carry their own colour.
///
/// Every coordinate is sampled by eye and is a calibration target.
abstract final class BahrainPlates {
  /// The long civilian plate: flag, six digits, `البحرين` over `BAHRAIN`, then
  /// the security band at the right edge.
  static final PlateSpec eu = PlateSpec(
    id: 'bh.eu',
    country: BahrainCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    // Zero padding makes the flag fill the box: 55 × 33 is the flag's 3:5.
    panel: const PlatePanel(box: PlateBox(12, 38.5, 55, 33), padding: EdgeInsets.zero),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 6,
        left: 80,
        top: 10,
        width: 50,
        height: 90,
        pitch: 55,
      ),
    ],
    // x 502.5..511.5, top to bottom.
    background: const PlateSection.columns([
      PlatePart(PlateSection.plain, end: 507, divider: 9),
      PlatePart(PlateSection.plain),
    ]),
    labels: const [
      PlateLabel(text: 'البحرين', box: PlateBox(408, 14, 98, 30), glyphHeight: 30),
      // Seven wide capitals need a smaller glyph to hold one line.
      PlateLabel(text: 'BAHRAIN', box: PlateBox(408, 62, 98, 28), glyphHeight: 27),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// The short civilian plate: wording and flag in a head row, the serial
  /// across the width beneath.
  static final PlateSpec us = PlateSpec(
    id: 'bh.us',
    country: BahrainCountry.civilian,
    canvasWidth: 300,
    canvasHeight: 150,
    panel: const PlatePanel(box: PlateBox(108, 14, 45, 27), padding: EdgeInsets.zero),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 6,
        left: 16,
        top: 52,
        width: 38,
        height: 84,
        pitch: 42,
      ),
    ],
    // x 282.5..291.5, top to bottom.
    background: const PlateSection.columns([
      PlatePart(PlateSection.plain, end: 287, divider: 9),
      PlatePart(PlateSection.plain),
    ]),
    labels: const [
      PlateLabel(text: 'BAHRAIN', box: PlateBox(12, 14, 88, 24), glyphHeight: 24),
      PlateLabel(text: 'البحرين', box: PlateBox(163, 12, 108, 30), glyphHeight: 28),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Four digits, `BRN` and a bicycle mark in the head row; unlike [us], the
  /// security band runs full height against the right edge.
  static final PlateSpec bicycle = PlateSpec(
    id: 'bh.bicycle',
    country: BahrainCountry.civilian,
    canvasWidth: 260,
    canvasHeight: 120,
    panel: const PlatePanel(box: PlateBox(106, 12, 35, 21), padding: EdgeInsets.zero),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 34,
        top: 48,
        width: 42,
        height: 62,
        pitch: 48,
      ),
    ],
    // Run out under the frame, so no field shows between band and frame.
    background: const PlateSection.columns([
      PlatePart(PlateSection.plain, end: 244),
      PlatePart(PlateSection.fill(PlateFill.divider)),
    ]),
    labels: const [
      PlateLabel(text: 'BRN', box: PlateBox(10, 12, 54, 26), glyphHeight: 26),
      // An emoji glyph, so no asset is needed.
      PlateLabel(text: '🚲', box: PlateBox(68, 8, 32, 30), glyphHeight: 30),
      PlateLabel(text: 'البحرين', box: PlateBox(148, 8, 92, 28), glyphHeight: 26),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// The panel colour across the top, [height] deep, and the security band from
  /// x 234, both run out under the frame.
  static PlateSection _headBand(double height) => PlateSection.columns([
    PlatePart(
      PlateSection.rows([
        PlatePart(const PlateSection.fill(PlateFill.panel), end: height),
        const PlatePart(PlateSection.plain),
      ]),
      end: 234,
    ),
    const PlatePart(PlateSection.fill(PlateFill.divider)),
  ]);

  /// A three-digit serial under a green head band carrying `BAHRAIN` / `C.D.`
  /// and `البحرين` / `هيئة دبلوماسية`, reversed out white.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'bh.diplomatic',
    country: BahrainCountry.diplomatic,
    canvasWidth: 250,
    canvasHeight: 110,
    // A colour and nothing else: flagScale 0 says there is no flag.
    panel: const PlatePanel(box: PlateBox(0, 0, 234, 54), flagScale: 0, padding: EdgeInsets.zero),
    background: _headBand(54),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 60,
        top: 60,
        width: 34,
        height: 45,
        pitch: 40,
      ),
    ],
    labels: const [
      PlateLabel(
        text: 'BAHRAIN',
        box: PlateBox(8, 5, 76, 20),
        glyphHeight: 20,
        color: BahrainColors.onDiplomaticGreen,
      ),
      PlateLabel(
        text: 'C.D.',
        box: PlateBox(8, 29, 76, 22),
        glyphHeight: 22,
        color: BahrainColors.onDiplomaticGreen,
      ),
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
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// A four-digit serial under a pale blue head band reading `POLICE` /
  /// `الشرطة`. The gap between the words is left for the force's roundel.
  static final PlateSpec police = PlateSpec(
    id: 'bh.police',
    country: BahrainCountry.police,
    canvasWidth: 250,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(0, 0, 234, 44), flagScale: 0, padding: EdgeInsets.zero),
    background: _headBand(44),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 40,
        top: 50,
        width: 34,
        height: 52,
        pitch: 40,
      ),
    ],
    labels: const [
      // Dark, since white would not read on the pale band.
      PlateLabel(
        text: 'POLICE',
        box: PlateBox(8, 10, 76, 24),
        glyphHeight: 24,
        color: BahrainColors.onPoliceBlue,
      ),
      PlateLabel(
        text: 'الشرطة',
        box: PlateBox(146, 8, 82, 28),
        glyphHeight: 26,
        color: BahrainColors.onPoliceBlue,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    eu,
    us,
    bicycle,
    diplomatic,
    police,
  ]);
}
