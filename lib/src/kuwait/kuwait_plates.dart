import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'kuwait_country.dart';

/// The Kuwaiti plate designs.
///
/// Kuwait adopted its current plate format in 2008. The standard format is
/// "12-45678" (2 digits, hyphen, 5 digits), with the country block at the hoist
/// end displaying "دولة الكويت" (State of Kuwait) and the flag on a coloured
/// field that varies by vehicle class.
///
/// The designs here follow a consistent pattern:
///
/// 1. **The country block at the hoist end.** A rectangle containing the flag
///    and caption on a field colour that identifies the plate type. The field
///    colour is the same as the plate's background on civilian plates (white on
///    white), but varies on special plates (yellow for taxis, red for police,
///    blue for government, etc.).
/// 2. **The serial in the centre and right.** A 2-digit regional/class code,
///    hyphen, and 5-digit serial number in the plate's own ink.
/// 3. **No dividers or security bands.** The design is clean and simple.
///
/// Kuwaiti plates measure 520×110 mm (20.5×4.3 in) for standard vehicles,
/// with minor adjustments for motorcycles and special vehicles.
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
  /// Format: [2-digit class code]-[5-digit serial]. The country block at the
  /// hoist end displays the flag and "دولة الكويت" on a white field.
  static final PlateSpec civilian = PlateSpec(
    id: 'kw.civilian',
    country: KuwaitCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    // The flag rectangle on the white field. The flag sits in a white box on
    // a white plate, so the box is defined but nearly invisible except for the
    // flag itself. Zero padding and flagScale 1.0 make the flag fill the box.
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      // 2-digit class/regional code
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      // 5-digit serial
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    // Hyphen between the two number groups
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The public transport plate (520×110): taxis, buses, and goods export.
  /// Same format as civilian but on a yellow field with a yellow country block.
  /// Category codes 90-99.
  static final PlateSpec transport = PlateSpec(
    id: 'kw.transport',
    country: KuwaitCountry.transport,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The police plate (520×110): red field with white text and flag. The country
  /// block displays "دولة الكويت" and "الشرطة" in white on the red band.
  static final PlateSpec police = PlateSpec(
    id: 'kw.police',
    country: KuwaitCountry.police,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The government plate (520×110): blue field with white text and flag. The
  /// country block displays "دولة الكويت" in white on the blue band.
  static final PlateSpec government = PlateSpec(
    id: 'kw.government',
    country: KuwaitCountry.government,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The diplomatic plate (520×110): blue field with white text. The country
  /// block displays "دولة الكويت" and "دبلوماسي" in white on the blue band.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'kw.diplomatic',
    country: KuwaitCountry.diplomatic,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The national guard plate (520×110): green field with white text and flag.
  static final PlateSpec nationalGuard = PlateSpec(
    id: 'kw.nationalguard',
    country: KuwaitCountry.nationalGuard,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The military/army plate (520×110): beige field with black text. No flag on
  /// this design, only the coloured field.
  static final PlateSpec army = PlateSpec(
    id: 'kw.army',
    country: KuwaitCountry.army,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
      PlateLabel(text: 'دولة الكويت', box: PlateBox(12, 30, 55, 30), glyphHeight: 24),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The commercial plate (520×110): pink field with black text and flag.
  static final PlateSpec commercial = PlateSpec(
    id: 'kw.commercial',
    country: KuwaitCountry.commercial,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The construction plate (520×110): orange field with black text and flag.
  static final PlateSpec construction = PlateSpec(
    id: 'kw.construction',
    country: KuwaitCountry.construction,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The firefighting plate (520×110): red field with white text and flag.
  static final PlateSpec firefighting = PlateSpec(
    id: 'kw.firefighting',
    country: KuwaitCountry.firefighting,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The export plate (520×110): green field with white text and flag.
  static final PlateSpec exportPlate = PlateSpec(
    id: 'kw.export',
    country: KuwaitCountry.export,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The temporary/customs plate (520×110): purple field with white text and flag.
  static final PlateSpec customs = PlateSpec(
    id: 'kw.customs',
    country: KuwaitCountry.customs,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The Emiri Bureau plate (520×110): blue field with white text and flag.
  static final PlateSpec emiri = PlateSpec(
    id: 'kw.emiri',
    country: KuwaitCountry.emiri,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: const PlatePanel(box: PlateBox(12, 25, 55, 60), padding: EdgeInsets.zero),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 85,
        top: 15,
        width: 48,
        height: 80,
        pitch: 54,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 270,
        top: 15,
        width: 42,
        height: 80,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: '-', box: PlateBox(235, 25, 30, 80), glyphHeight: 80),
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
