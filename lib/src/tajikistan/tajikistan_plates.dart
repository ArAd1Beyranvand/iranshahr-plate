import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'tajikistan_alphabets.dart';
import 'tajikistan_country.dart';
import 'tajikistan_validators.dart';

/// European plates: a country block at the hoist end, then Latin groups with no
/// divider; the private number is `NNNN LL NN` (serial, letters, region).
///
/// The private, transport and police plates carry the flag over `TJ`; the field
/// behind it changes, so each takes the matching [PlateCountry] (`TajikistanCountry`).
/// The foreign, diplomatic and governmental plates print no flag and declare
/// [PlateSpec.noPanel]. The trailer and motorcycle break the number across two
/// rows, and are their own specs because the boxes are the spec.
///
/// Colour is never here: [publicTransport] in `TajikistanThemes.transport` is not
/// a different class. `final`, not `const`: the digit runs are built by
/// [plateRegister]. Every coordinate is sampled by eye from the Wikipedia
/// drawings and is a calibration target.
abstract final class TajikistanPlates {
  /// The flag over `TJ`. Zero padding and a [PlatePanel.flagScale] of 1 fill the
  /// box's width; [PlatePanel.captionScale] is set past what fits so the
  /// `BoxFit.scaleDown` caption is as large as the block allows.
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 14, 48, 82),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// Private plate, e.g. `9999 MK 02`. Letters come from [TajikistanAlphabets.letters];
  /// the article's `WT` drawing is illustrative, `W` not being issued.
  static final PlateSpec car = PlateSpec(
    id: 'tj.car',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 72,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
      plateField(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 286,
        top: 15,
        width: 50,
        height: 80,
        pitch: 56,
      ),
      plateField(
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
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'region'),
    ],
  );

  /// Two-row [car] (340×190): the flag block and serial share the head row.
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
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 100,
        top: 12,
        width: 52,
        height: 84,
        pitch: 58,
      ),
      plateField(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 40,
        top: 100,
        width: 60,
        height: 82,
        pitch: 68,
      ),
      plateField(
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
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'region'),
    ],
  );

  /// Motorcycle plate (220×165), e.g. `304` over `A 03`.
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
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 80,
        top: 8,
        width: 42,
        height: 70,
        pitch: 46,
      ),
      const PlateSlot(alphabet: TajikistanAlphabets.letters, box: PlateBox(20, 88, 46, 68)),
      plateField(
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
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'region'),
    ],
  );

  /// Trailer plate (340×190), e.g. `07 AA` over `0776`; the one two-row plate that leads with its region.
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
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 12,
        width: 46,
        height: 84,
        pitch: 52,
      ),
      plateField(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 216,
        top: 12,
        width: 50,
        height: 84,
        pitch: 58,
      ),
      plateField(
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
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// Black on amber, e.g. `9006 TT 05`. `TT` is a [PlateLabel], not a slot.
  static final PlateSpec publicTransport = PlateSpec(
    id: 'tj.publicTransport',
    country: TajikistanCountry.transport,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 72,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 410,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
    ],
    labels: const [PlateLabel(text: 'TT', box: PlateBox(288, 18, 96, 74), glyphHeight: 74)],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'region'),
    ],
  );

  /// White on blue, e.g. `0245 M 01`. Takes `TajikistanCountry.police` because the
  /// `TJ` is reversed out white here.
  static final PlateSpec police = PlateSpec(
    id: 'tj.police',
    country: TajikistanCountry.police,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 72,
        top: 15,
        width: 46,
        height: 80,
        pitch: 50,
      ),
      const PlateSlot(alphabet: TajikistanAlphabets.letters, box: PlateBox(300, 15, 50, 80)),
      plateField(
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
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'region'),
    ],
  );

  /// Black on yellow, e.g. `200 P 005`. No region code, so no flag block.
  static final PlateSpec foreign = PlateSpec(
    id: 'tj.foreign',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 60,
        top: 15,
        width: 52,
        height: 80,
        pitch: 60,
      ),
      const PlateSlot(alphabet: TajikistanAlphabets.letters, box: PlateBox(250, 15, 56, 80)),
      plateField(
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
      PlateTextGroup([0], key: 'prefix'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// White on red, e.g. `091 CMD 1`; no flag block. The class slot is wide because
  /// [TajikistanAlphabets.diplomaticClass] holds three-character codes, each one
  /// choice rendered as three glyphs.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'tj.diplomatic',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      plateField(
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
      const PlateSlot(alphabet: PlateAlphabet.latinDigits, box: PlateBox(420, 15, 54, 80)),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'class'),
      PlateTextGroup([2], key: 'tail'),
    ],
  );

  /// White on black, e.g. `001 CO 04` with `RT` beneath the region. The old
  /// Russian-derived design: the region is boxed off by a [PlateRule] divider, and
  /// `RT` is a [PlateLabel].
  static final PlateSpec governmental = PlateSpec(
    id: 'tj.governmental',
    country: TajikistanCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    rules: const <PlateRule>[PlateRule(box: PlateBox(360, 10, 5, 90))],
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 40,
        top: 15,
        width: 50,
        height: 80,
        pitch: 56,
      ),
      plateField(
        alphabet: TajikistanAlphabets.letters,
        count: 2,
        left: 220,
        top: 15,
        width: 54,
        height: 80,
        pitch: 60,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 385,
        top: 12,
        width: 48,
        height: 58,
        pitch: 54,
      ),
    ],
    labels: const [PlateLabel(text: 'RT', box: PlateBox(395, 74, 84, 22), glyphHeight: 20)],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'region'),
    ],
  );

  /// Every design, in the order introduced above.
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

  /// The validator that judges [spec]. Most designs take a
  /// [TajikistanPlateValidator] configured for their lengths; the foreign and
  /// diplomatic plates, which break that shape, get their own.
  static PlateValidator validatorFor(PlateSpec spec) => switch (spec.id) {
    'tj.motorcycle' => const TajikistanPlateValidator(serialLength: 3, letterCount: 1),
    'tj.trailer' => const TajikistanPlateValidator(serialLength: 4, letterCount: 2, gate: 'serial'),
    'tj.publicTransport' => const TajikistanPlateValidator(serialLength: 4, letterCount: 0),
    'tj.police' => const TajikistanPlateValidator(serialLength: 4, letterCount: 1),
    'tj.governmental' => const TajikistanPlateValidator(serialLength: 3, letterCount: 2),
    'tj.foreign' => const TajikistanForeignPlateValidator(),
    'tj.diplomatic' => const TajikistanDiplomaticPlateValidator(),
    _ => const TajikistanPlateValidator(),
  };
}
