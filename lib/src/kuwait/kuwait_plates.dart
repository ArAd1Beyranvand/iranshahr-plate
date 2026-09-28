import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'kuwait_colors.dart';
import 'kuwait_country.dart';

/// The Kuwaiti plate designs.
///
/// Kuwait adopted its current plate format in 2008. The standard format is
/// "12-45678" (2 digits, hyphen, 5 digits), displayed centrally on the plate.
/// The LEFT SIDE has a narrow coloured band containing vertically stacked
/// "KUWAIT" letters and the Arabic text "دولة الكويت" (State of Kuwait).
///
/// The designs follow a consistent European-style pattern:
///
/// 1. **Left identifier band.** A narrow vertical band (~60px) on the left
///    containing stacked "K-U-W-A-I-T" letters and Arabic country text, on a
///    colored field matching the plate's vehicle class.
/// 2. **The serial in the centre and right.** A 2-digit regional/class code,
///    hyphen, and 5-digit serial number in large digits, occupying most of
///    the remaining space in the plate's background colour.
///
/// Kuwaiti plates measure 520×110 mm (20.5×4.3 in) for standard vehicles.
///
/// `final`, not `const`: the digit runs are built by [plateRegister], and a
/// `const` constructor cannot run a loop. Initialised lazily, once per isolate;
/// [PlateSpec] equality is over `id` alone, so nothing here depended on const
/// canonicalisation.
///
/// Every coordinate below is sampled by eye from plate photographs and is a
/// calibration target.
abstract final class KuwaitPlates {
  /// The standard private vehicle plate (520×110): civilian car registration.
  /// Format: [2-digit class code]-[5-digit serial].
  /// Left band: white background with black text and stacked KUWAIT letters.
  static final PlateSpec civilian = PlateSpec(
    id: 'kw.civilian',
    country: KuwaitCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      // 2-digit class/regional code
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      // 5-digit serial
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    // Vertical divider separating left band from digits
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    // Hyphen and left band text
    labels: const [
      // "KUWAIT" letters stacked vertically on left
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      // Arabic text on left band
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      // Hyphen divider between digit groups
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The public transport plate (520×110): taxis, buses, and goods export.
  /// Same format as civilian but on a yellow field.
  static final PlateSpec transport = PlateSpec(
    id: 'kw.transport',
    country: KuwaitCountry.transport,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The police plate (520×110): black field with white text.
  /// Left band: stacked "KUWAIT" in white, "POLICE" / "شرطة" labels.
  static final PlateSpec police = PlateSpec(
    id: 'kw.police',
    country: KuwaitCountry.police,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 6,
        left: 100,
        top: 30,
        width: 52,
        height: 50,
        pitch: 56,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'POLICE', box: PlateBox(75, 8, 250, 18), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'شرطة', box: PlateBox(75, 28, 250, 18), glyphHeight: 16, color: KuwaitColors.whiteText),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3, 4, 5], key: 'serial'),
    ],
  );

  /// The government plate (520×110): blue field with black text.
  static final PlateSpec government = PlateSpec(
    id: 'kw.government',
    country: KuwaitCountry.government,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The diplomatic plate (520×110): blue field with white text.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'kw.diplomatic',
    country: KuwaitCountry.diplomatic,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The national guard plate (520×110): green field with white text.
  static final PlateSpec nationalGuard = PlateSpec(
    id: 'kw.nationalguard',
    country: KuwaitCountry.nationalGuard,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The military/army plate (520×110): beige field with black text.
  static final PlateSpec army = PlateSpec(
    id: 'kw.army',
    country: KuwaitCountry.army,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The commercial plate (520×110): pink field with black text.
  static final PlateSpec commercial = PlateSpec(
    id: 'kw.commercial',
    country: KuwaitCountry.commercial,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The construction plate (520×110): orange field with black text.
  static final PlateSpec construction = PlateSpec(
    id: 'kw.construction',
    country: KuwaitCountry.construction,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The firefighting plate (520×110): red field with white text.
  static final PlateSpec firefighting = PlateSpec(
    id: 'kw.firefighting',
    country: KuwaitCountry.firefighting,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The export plate (520×110): green field with white text.
  static final PlateSpec exportPlate = PlateSpec(
    id: 'kw.export',
    country: KuwaitCountry.export,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The temporary/customs plate (520×110): purple field with white text.
  static final PlateSpec customs = PlateSpec(
    id: 'kw.customs',
    country: KuwaitCountry.customs,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The Emiri Bureau plate (520×110): blue field with white text.
  static final PlateSpec emiri = PlateSpec(
    id: 'kw.emiri',
    country: KuwaitCountry.emiri,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 8,
        width: 56,
        height: 94,
        pitch: 64,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 250,
        top: 8,
        width: 42,
        height: 94,
        pitch: 48,
      ),
    ],
    rules: const [
      PlateRule(box: PlateBox(65, 0, 2, 110)),
    ],
    labels: const [
      PlateLabel(text: 'K\nU\nW\nA\nI\nT', box: PlateBox(5, 5, 55, 100), glyphHeight: 16, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دولة\nالكويت', box: PlateBox(5, 40, 55, 60), glyphHeight: 14, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(225, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// Every Kuwaiti design, in the order they are introduced above. A picker
  /// iterates this rather than naming individual constants.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    civilian,
    transport,
    police,
    government,
    diplomatic,
    nationalGuard,
    army,
    commercial,
    construction,
    firefighting,
    exportPlate,
    customs,
    emiri,
  ]);
}
