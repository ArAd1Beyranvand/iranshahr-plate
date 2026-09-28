import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'kuwait_colors.dart';
import 'kuwait_country.dart';

/// The Kuwaiti plate designs.
///
/// Kuwait adopted its current plate format in 2008. The standard format is
/// "12-45678" (2 digits, hyphen, 5 digits), positioned centrally on the plate.
/// The left side has a white or coloured band containing the Arabic text
/// "دولة الكويت" (State of Kuwait). The text size and positioning varies by
/// plate type.
///
/// The designs here follow a consistent pattern:
///
/// 1. **Left band with country text.** A vertical band on the left containing
///    "دولة الكويت" and optionally additional text lines below it, on a white
///    or coloured background.
/// 2. **The serial in the centre and right.** A 2-digit regional/class code,
///    hyphen, and 5-digit serial number in large digits, occupying most of
///    the remaining space.
/// 3. **Optional flag/emblem.** On some special plates, the flag may be
///    integrated into the left band.
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
  /// Left band: white background with black "دولة الكويت" text.
  static final PlateSpec civilian = PlateSpec(
    id: 'kw.civilian',
    country: KuwaitCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    // No panel needed - the text is on the plate itself via labels
    noPanel: true,
    panel: const PlatePanel(box: PlateBox(0, 0, 0, 0), padding: EdgeInsets.zero),
    slots: [
      // 2-digit class/regional code
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      // 5-digit serial
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    // Hyphen between the two number groups and country text on left
    labels: const [
      // Country text on left band
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28),
      // Hyphen divider
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The police plate (520×110): black field with white text.
  /// Left band: contains "دولة الكويت" and "الشرطة" in white text.
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
        count: 2,
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 10, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: 'الشرطة', box: PlateBox(10, 45, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The government plate (520×110): blue field with white text.
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'class'),
      PlateTextGroup([2, 3, 4, 5, 6], key: 'serial'),
    ],
  );

  /// The diplomatic plate (520×110): blue field with white text.
  /// Includes "دبلوماسي" designation below the country name.
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 8, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: 'دبلوماسي', box: PlateBox(10, 45, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 8, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: 'الحرس الوطني', box: PlateBox(10, 45, 95, 35), glyphHeight: 18, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 10, 95, 35), glyphHeight: 20),
      PlateLabel(text: 'الجيش', box: PlateBox(10, 45, 95, 35), glyphHeight: 20),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 8, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: 'الإطفاء', box: PlateBox(10, 45, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 20, 95, 70), glyphHeight: 28, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
        left: 120,
        top: 10,
        width: 52,
        height: 90,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 260,
        top: 10,
        width: 42,
        height: 90,
        pitch: 48,
      ),
    ],
    labels: const [
      PlateLabel(text: 'دولة الكويت', box: PlateBox(10, 8, 95, 35), glyphHeight: 20, color: KuwaitColors.whiteText),
      PlateLabel(text: 'الديوان الأميري', box: PlateBox(10, 45, 95, 35), glyphHeight: 18, color: KuwaitColors.whiteText),
      PlateLabel(text: '-', box: PlateBox(235, 15, 20, 80), glyphHeight: 80),
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
