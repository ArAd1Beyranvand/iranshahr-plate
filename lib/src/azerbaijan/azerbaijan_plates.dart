import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'azerbaijan_country.dart';

/// The Azerbaijani plate designs.
///
/// Structurally these are European plates — a country block at the hoist end,
/// then Latin groups read left to right — and they are the plainest set in this
/// workspace. There is no divider, no security band, no sticker and no printed
/// wording beyond the `AZ` under the flag. What a plate *is* comes from two
/// places and two only:
///
/// 1. **The grouping of the serial**, which is the spec — and the reason there
///    are four of these rather than one. A civilian number is two digits, two
///    letters and three digits; a motorcycle's is the same characters re-laid
///    in two rows; a diplomat's is three digits, a class letter and three
///    digits; a foreign-owned company's is the class letter first and then six
///    digits in two threes.
/// 2. **The colour of the field**, which is the theme. A bus or taxi plate is
///    [car] printed in `AzerbaijanThemes.transport` — the blue plate carries a
///    civilian number in a civilian layout, so it is one design in two inks,
///    not two designs. Minting an `az.transport` spec identical to [car] but
///    for its id would be putting colour on geometry, which is the one thing a
///    [PlateSpec] never carries.
///
/// So: four specs, four themes, five plates on the road.
///
/// The country block is [AzerbaijanCountry.azerbaijan] on every one of them,
/// including the coloured ones — see that class for why it never varies. Its
/// [PlatePanel.box] stays clear of the frame rather than overlapping it the way
/// an Iranian or German panel does: those panels are darker than their frame
/// and hide the seam under it, but this one is white, and a white block run out
/// under a black frame would rub the frame out.
///
/// `final`, not `const`: the digit runs are built by [plateRegister], and a
/// `const` constructor cannot run a loop. Initialised lazily, once per isolate;
/// [PlateSpec] equality is over `id` alone, so nothing here depended on const
/// canonicalisation.
///
/// Every coordinate below is sampled by eye from plate photographs and is a
/// calibration target.
abstract final class AzerbaijanPlates {
  /// The country block, which is the same rectangle in the same place on all
  /// three full-size designs: the flag at the top, `AZ` beneath it, in a white
  /// block inset from the frame.
  ///
  /// Zero padding and a [PlatePanel.flagScale] of 1 make the flag fill the
  /// box's width exactly, so 44 wide at 1:2 is 22 deep and the remaining 38
  /// belongs to the caption. [PlatePanel.captionScale] is set past what will
  /// fit on purpose: `CountryPanel` puts the caption in a `BoxFit.scaleDown`,
  /// so a value too big means "as large as the block allows" and a value too
  /// small would silently leave the block half empty.
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 26, 44, 60),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// The standard civilian plate (520×110), e.g. `88-BE-114`: a two-digit
  /// regional code, two Latin letters, a three-digit serial, hyphenated.
  ///
  /// Printed in `AzerbaijanThemes.transport` instead, this same spec is the
  /// blue bus-and-taxi plate.
  static final PlateSpec car = PlateSpec(
    id: 'az.car',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 78, top: 17, width: 46, height: 76, pitch: 54),
      // Wider cells on a wider pitch: a letter is broader than a digit, so the
      // pair is its own register rather than a continuation of the one before.
      ...plateRegister(
        alphabet: PlateAlphabet.latinUppercase,
        count: 2,
        left: 204,
        top: 17,
        width: 50,
        height: 76,
        pitch: 58,
      ),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 3, left: 340, top: 17, width: 46, height: 76, pitch: 54),
    ],
    // The two hyphens, centred in the gaps the registers leave for them. A
    // hyphen is printed in the serial's own ink at the serial's own size, so it
    // is a PlateLabel at the slots' glyph height rather than a PlateRule — it
    // is a character, and a rule would be painted in the divider colour.
    //
    // A label is laid out from the top of its box while a slot centres its
    // glyph, so these tops are not the slots' 17: 17 + 76/2 - 0.72*76/2 = 27.6,
    // which puts the hyphen's line box on the digits' own centre line.
    labels: const [
      PlateLabel(text: '-', box: PlateBox(181, 27.6, 22, 76), glyphHeight: 76),
      PlateLabel(text: '-', box: PlateBox(314, 27.6, 22, 76), glyphHeight: 76),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'region'),
      PlateTextGroup([2, 3], key: 'letters'),
      PlateTextGroup([4, 5, 6], key: 'serial'),
    ],
  );

  /// The motorcycle plate (200×150), e.g. `07` over `T-096`.
  ///
  /// The same characters as [car] in the same order — a regional pair, letters,
  /// a serial — but broken across two rows, with the country block and the
  /// regional pair sharing the head row and one letter leading the serial
  /// instead of two. The letters group is one cell wide here, which is why the
  /// two plates cannot share a spec however alike they read.
  static final PlateSpec bicycle = PlateSpec(
    id: 'az.bicycle',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 200,
    canvasHeight: 150,
    // Shallower than the full-size block, and its own value rather than
    // _euPanel: this panel shares the head row with the regional pair, so it
    // gets that row's depth and not the plate's.
    panel: const PlatePanel(box: PlateBox(14, 16, 40, 52), padding: EdgeInsets.zero, captionScale: 1.5),
    slots: [
      // Head row: the regional pair, smaller than the serial below it.
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 2, left: 100, top: 20, width: 34, height: 46, pitch: 42),
      // Lower row: the letter, then the serial, across the full width.
      const PlateSlot(alphabet: PlateAlphabet.latinUppercase, box: PlateBox(14, 82, 36, 54)),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 3, left: 72, top: 82, width: 34, height: 54, pitch: 40),
    ],
    // 82 + 54/2 - 0.72*54/2 = 89.6. See car.
    labels: const [PlateLabel(text: '-', box: PlateBox(52, 89.6, 18, 54), glyphHeight: 54)],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'region'),
      PlateTextGroup([2], key: 'letters'),
      PlateTextGroup([3, 4, 5], key: 'serial'),
    ],
  );

  /// The diplomatic plate (520×110), e.g. `013 D 004`: the mission's country
  /// code, the class letter, and the serial — printed white on red by
  /// `AzerbaijanThemes.diplomatic`.
  ///
  /// No hyphens. The groups are told apart by the gaps alone, which are wider
  /// than [car]'s for exactly that reason. The class letter is a slot and not a
  /// label because `D` is not the only one an Azerbaijani mission is issued.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'az.diplomatic',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 3, left: 94, top: 17, width: 46, height: 76, pitch: 54),
      const PlateSlot(alphabet: PlateAlphabet.latinUppercase, box: PlateBox(262, 17, 50, 76)),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 3, left: 326, top: 17, width: 46, height: 76, pitch: 54),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'mission'),
      PlateTextGroup([3], key: 'class'),
      PlateTextGroup([4, 5, 6], key: 'serial'),
    ],
  );

  /// The foreign-owned company plate (520×110), e.g. `H 023 149`: the class
  /// letter first, then six digits in two threes — printed black on yellow by
  /// `AzerbaijanThemes.foreign`.
  ///
  /// The six digits are two registers and two groups, not one of six. They are
  /// set as two blocks with a gap, and a single register cannot express a gap:
  /// its cells are evenly pitched by construction, and `debugValidateSpec`
  /// checks that they are.
  static final PlateSpec foreign = PlateSpec(
    id: 'az.foreign',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      const PlateSlot(alphabet: PlateAlphabet.latinUppercase, box: PlateBox(94, 17, 50, 76)),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 3, left: 158, top: 17, width: 46, height: 76, pitch: 54),
      ...plateRegister(alphabet: PlateAlphabet.latinDigits, count: 3, left: 326, top: 17, width: 46, height: 76, pitch: 54),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'class'),
      PlateTextGroup([1, 2, 3], key: 'series'),
      PlateTextGroup([4, 5, 6], key: 'serial'),
    ],
  );

  /// Every Azerbaijani design, in the order they are introduced above. A picker
  /// iterates this rather than naming four constants.
  ///
  /// Four, not five: the blue transport plate is [car] under another theme, and
  /// a theme is not a member of this list. A picker that wants to offer it
  /// offers `(car, AzerbaijanThemes.transport)`.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[car, bicycle, diplomatic, foreign]);
}
