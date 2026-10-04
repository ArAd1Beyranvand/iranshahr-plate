import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'tajikistan_alphabets.dart';
import 'tajikistan_country.dart';
import 'tajikistan_validators.dart';

/// The Tajik plate designs.
///
/// Structurally these are European plates — a country block at the hoist end,
/// then Latin groups read left to right — and the private number is
/// `NNNN LL NN`: a four-digit serial, two letters, a two-digit region code, with
/// no divider between the groups. They are told apart by the gaps alone.
///
/// Three things make the set what it is:
///
/// 1. **The flag block, and the colour behind it.** The private, transport and
///    police plates carry the flag over `TJ` at the hoist end. The block is the
///    same on all three, but the field behind it changes, so each takes the
///    matching [PlateCountry] — `civilian`, `transport` or `police` — that
///    prints its caption in the ink that reads on that colour. See
///    `TajikistanCountry`.
///
/// 2. **The flagless coloured classes.** The foreign, diplomatic and
///    governmental plates print no flag. They declare [PlateSpec.noPanel] and
///    carry their own arrangement: the foreign plate a bare `NNN L NNN`, the
///    diplomatic plate a class code, the governmental plate the old
///    Russian-derived layout with the region boxed off at the right by a
///    divider.
///
/// 3. **The two-row variants.** A vehicle with no room for a 520 mm plate takes
///    the same number broken across two rows — the trailer and the motorcycle —
///    which are their own specs because the boxes are what differ and the boxes
///    are the spec.
///
/// Colour is never here. A public-transport plate is [publicTransport] printed
/// in `TajikistanThemes.transport`, not a different class.
///
/// `final`, not `const`: the digit runs are built by [plateRegister], and a
/// `const` constructor cannot run a loop. Initialised lazily, once per isolate;
/// [PlateSpec] equality is over `id` alone, so nothing here depended on const
/// canonicalisation.
///
/// Every coordinate below is sampled by eye from the Wikipedia plate drawings
/// and is a calibration target.
abstract final class TajikistanPlates {
  /// The country block on the full-size plates: the flag at the top, `TJ`
  /// beneath it, in a block inset from the frame.
  ///
  /// Zero padding and a [PlatePanel.flagScale] of 1 make the flag fill the box's
  /// width exactly, so 48 wide at 1:2 is 24 deep and the remaining depth belongs
  /// to the caption. [PlatePanel.captionScale] is set past what will fit on
  /// purpose: `CountryPanel` puts the caption in a `BoxFit.scaleDown`, so a value
  /// too big means "as large as the block allows".
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 14, 48, 82),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// The standard private plate (520×110), e.g. `9999 MK 02`: a four-digit
  /// serial, two letters, a two-digit region code.
  ///
  /// The commonest plate in the country. The letters come from the
  /// fifteen-strong Latin/Cyrillic-shared register — see
  /// [TajikistanAlphabets.letters]; the article's lead drawing shows `WT`, but
  /// `W` is not in the issued set and the drawing is illustrative.
  static final PlateSpec car = PlateSpec(
    id: 'tj.car',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 72,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
      ...plateRegister(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 286,
        top: 15,
        width: 50,
        height: 80,
        pitch: 56,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 410,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
      PlateTextGroup([4, 5], key: 'letters'),
      PlateTextGroup([6, 7], key: 'region'),
    ],
  );

  /// The two-row variant of [car] (340×190), e.g. `9999` over `MK 02`.
  ///
  /// The same eight characters in the same three groups, broken across two rows:
  /// the flag block and the serial share the head row, the letters and region
  /// have the lower one. Its own spec and not [car] on a deeper canvas, because
  /// the boxes are what differ.
  static final PlateSpec carTwoRow = PlateSpec(
    id: 'tj.carTwoRow',
    country: TajikistanCountry.civilian,
    canvasWidth: 340,
    canvasHeight: 190,
    panel: const PlatePanel(
      box: PlateBox(16, 16, 74, 80),
      padding: EdgeInsets.zero,
      captionScale: 1.6,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 100,
        top: 12,
        width: 52,
        height: 84,
        pitch: 58,
      ),
      ...plateRegister(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 40,
        top: 100,
        width: 60,
        height: 82,
        pitch: 68,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 190,
        top: 100,
        width: 56,
        height: 82,
        pitch: 64,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
      PlateTextGroup([4, 5], key: 'letters'),
      PlateTextGroup([6, 7], key: 'region'),
    ],
  );

  /// The motorcycle plate (220×165), e.g. `304` over `A 03`: a three-digit
  /// serial in the head row, one letter and the region in the lower one.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'tj.motorcycle',
    country: TajikistanCountry.civilian,
    canvasWidth: 220,
    canvasHeight: 165,
    panel: const PlatePanel(
      box: PlateBox(12, 10, 58, 66),
      padding: EdgeInsets.zero,
      captionScale: 1.4,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 80,
        top: 8,
        width: 42,
        height: 70,
        pitch: 46,
      ),
      const PlateSlot(
        alphabet: TajikistanAlphabets.letters,
        box: PlateBox(20, 88, 46, 68),
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 96,
        top: 88,
        width: 42,
        height: 68,
        pitch: 48,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'serial'),
      PlateTextGroup([3], key: 'letters'),
      PlateTextGroup([4, 5], key: 'region'),
    ],
  );

  /// The trailer plate (340×190), e.g. `07 AA` over `0776`: the region and two
  /// letters in the head row, a four-digit serial in the lower one.
  ///
  /// The one two-row plate that leads with its region: the head row is
  /// `NN LL` and the serial has the whole lower row to itself.
  static final PlateSpec trailer = PlateSpec(
    id: 'tj.trailer',
    country: TajikistanCountry.civilian,
    canvasWidth: 340,
    canvasHeight: 190,
    panel: const PlatePanel(
      box: PlateBox(16, 16, 74, 80),
      padding: EdgeInsets.zero,
      captionScale: 1.6,
    ),
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 12,
        width: 46,
        height: 84,
        pitch: 52,
      ),
      ...plateRegister(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 216,
        top: 12,
        width: 50,
        height: 84,
        pitch: 58,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 60,
        top: 100,
        width: 52,
        height: 82,
        pitch: 58,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1], key: 'region'),
      PlateTextGroup([2, 3], key: 'letters'),
      PlateTextGroup([4, 5, 6, 7], key: 'serial'),
    ],
  );

  /// The public-transport plate (520×110), e.g. `9006 TT 05` — black on amber
  /// under `TajikistanThemes.transport`.
  ///
  /// A four-digit serial, the fixed `TT` marker, and the region. `TT` is a
  /// [PlateLabel], not a slot: every public-transport plate carries it and it is
  /// not a value anyone enters.
  static final PlateSpec publicTransport = PlateSpec(
    id: 'tj.publicTransport',
    country: TajikistanCountry.transport,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 72,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 410,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
    ],
    labels: const [
      PlateLabel(text: 'TT', box: PlateBox(288, 18, 96, 74), glyphHeight: 74),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
      PlateTextGroup([4, 5], key: 'region'),
    ],
  );

  /// The police plate (520×110), e.g. `0245 M 01` — white on blue under
  /// `TajikistanThemes.police`.
  ///
  /// A four-digit serial, one letter, and the region, with the flag block on the
  /// blue field. Its own [PlateCountry] — `TajikistanCountry.police` — because
  /// the `TJ` under the flag is reversed out white here, not printed black.
  static final PlateSpec police = PlateSpec(
    id: 'tj.police',
    country: TajikistanCountry.police,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 72,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
      const PlateSlot(
        alphabet: TajikistanAlphabets.letters,
        box: PlateBox(300, 15, 50, 80),
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 410,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2, 3], key: 'serial'),
      PlateTextGroup([4], key: 'letters'),
      PlateTextGroup([5, 6], key: 'region'),
    ],
  );

  /// The foreign-vehicle plate (520×110), e.g. `200 P 005` — black on yellow
  /// under `TajikistanThemes.foreign`.
  ///
  /// A three-digit prefix, one letter, a three-digit serial, and no flag block:
  /// a foreign vehicle carries no region code, so there is nothing at the hoist
  /// end and the spec declares [PlateSpec.noPanel].
  static final PlateSpec foreign = PlateSpec(
    id: 'tj.foreign',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 60,
        top: 15,
        width: 52,
        height: 80,
        pitch: 60,
      ),
      const PlateSlot(
        alphabet: TajikistanAlphabets.letters,
        box: PlateBox(250, 15, 56, 80),
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 330,
        top: 15,
        width: 52,
        height: 80,
        pitch: 60,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'prefix'),
      PlateTextGroup([3], key: 'letters'),
      PlateTextGroup([4, 5, 6], key: 'serial'),
    ],
  );

  /// The diplomatic plate (520×110), e.g. `091 CMD 1` — white on red under
  /// `TajikistanThemes.diplomatic`.
  ///
  /// A three-digit serial, a class code — `CD`, `CMD`, `D`, `T` or `S` — and a
  /// single trailing digit. No flag block: the plate declares [PlateSpec.noPanel]
  /// and prints nothing at the hoist end.
  ///
  /// The class slot is set wide because [TajikistanAlphabets.diplomaticClass]
  /// holds three-character codes: `CMD` is one choice a slot renders as three
  /// glyphs, not three letters typed in a row.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'tj.diplomatic',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 40,
        top: 15,
        width: 54,
        height: 80,
        pitch: 62,
      ),
      const PlateSlot(
        alphabet: TajikistanAlphabets.diplomaticClass,
        box: PlateBox(240, 15, 150, 80),
      ),
      const PlateSlot(
        alphabet: PlateAlphabet.latinDigits,
        box: PlateBox(420, 15, 54, 80),
      ),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'serial'),
      PlateTextGroup([3], key: 'class'),
      PlateTextGroup([4], key: 'tail'),
    ],
  );

  /// The governmental plate (520×110), e.g. `001 CO 04` with `RT` beneath the
  /// region — white on black under `TajikistanThemes.governmental`.
  ///
  /// The old Russian-derived design still issued to state vehicles: a three-digit
  /// serial and two letters, then the region boxed off at the right by a divider,
  /// with `RT` — *Respublika Tojikiston* — printed small beneath it. The divider
  /// is a [PlateRule] painted in the theme's ink, and `RT` is a [PlateLabel]
  /// because it is on every plate of this design and no one enters it.
  static final PlateSpec governmental = PlateSpec(
    id: 'tj.governmental',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    rules: const <PlateRule>[PlateRule(box: PlateBox(360, 10, 5, 90))],
    slots: [
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 40,
        top: 15,
        width: 50,
        height: 80,
        pitch: 56,
      ),
      ...plateRegister(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 220,
        top: 15,
        width: 54,
        height: 80,
        pitch: 60,
      ),
      ...plateRegister(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 385,
        top: 12,
        width: 48,
        height: 58,
        pitch: 54,
      ),
    ],
    labels: const [
      PlateLabel(text: 'RT', box: PlateBox(395, 74, 84, 22), glyphHeight: 20),
    ],
    textGroups: const [
      PlateTextGroup([0, 1, 2], key: 'serial'),
      PlateTextGroup([3, 4], key: 'letters'),
      PlateTextGroup([5, 6], key: 'region'),
    ],
  );

  /// Every Tajik design, in the order they are introduced above. A picker
  /// iterates this rather than naming nine constants.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    car,
    carTwoRow,
    motorcycle,
    trailer,
    publicTransport,
    police,
    foreign,
    diplomatic,
    governmental,
  ]);

  /// The validator that judges [spec].
  ///
  /// Most designs are a serial, some letters and a region in some order, and
  /// take a [TajikistanPlateValidator] configured for their lengths. The three
  /// that break that shape — the foreign plate with no region, the diplomatic
  /// plate with a class code — get their own.
  static PlateValidator validatorFor(PlateSpec spec) => switch (spec.id) {
    'tj.motorcycle' => const TajikistanPlateValidator(
      serialLength: 3,
      letterCount: 1,
    ),
    'tj.trailer' => const TajikistanPlateValidator(
      serialLength: 4,
      letterCount: 2,
      gate: 'serial',
    ),
    'tj.publicTransport' => const TajikistanPlateValidator(
      serialLength: 4,
      letterCount: 0,
    ),
    'tj.police' => const TajikistanPlateValidator(
      serialLength: 4,
      letterCount: 1,
    ),
    'tj.governmental' => const TajikistanPlateValidator(
      serialLength: 3,
      letterCount: 2,
    ),
    'tj.foreign' => const TajikistanForeignPlateValidator(),
    'tj.diplomatic' => const TajikistanDiplomaticPlateValidator(),
    _ => const TajikistanPlateValidator(),
  };
}
