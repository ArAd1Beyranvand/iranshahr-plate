import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'armenia_alphabets.dart';
import 'armenia_country.dart';
import 'armenia_validators.dart';

/// Structurally European plates: a country block at the hoist end, then Latin
/// groups read left to right with no divider between them.
///
/// `NN LL NNN` is a private vehicle; `NNN LL NN` is a state one, where the
/// trailing pair is half of an institution's reserved combination. [car] and
/// [public] are two specs because their registers differ (2/2/3 against 3/2/2).
///
/// The silver identifier band of the 2014 design is a [PlateRule], which is why
/// `ArmeniaThemes.civilian` is not a [PlateTheme.monochrome]; the older [trailer]
/// and [bus] declare no rule. The diplomatic, UN and military plates print their
/// own wording in place of the flag block and declare [PlateSpec.noPanel].
///
/// Colour is never here, and [carTwoRow] is the same number as [car] on a deeper
/// canvas, not a different class.
///
/// `final`, not `const`: the digit runs are built by [plateRegister]. Every
/// coordinate is sampled by eye from photographs and is a calibration target.
abstract final class ArmeniaPlates {
  /// The flag over `AM`. Zero padding and a [PlatePanel.flagScale] of 1 make the
  /// flag fill the box's width. [PlatePanel.captionScale] is set past what fits on
  /// purpose: the caption is in a `BoxFit.scaleDown`, so too big means "as large as
  /// the block allows" while too small would leave the block half empty.
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 14, 48, 82),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// The 2014 design's silver strip between the flag block and the first digit.
  /// A [PlateRule] and not a [PlateBand]: nothing is printed on it, and it takes
  /// the theme's divider colour.
  static const PlateRule _identifierBand = PlateRule(
    box: PlateBox(66, 12, 10, 86),
  );

  /// Private plate, e.g. `01 AD 234`; judged by [ArmeniaPlateValidator].
  static final PlateSpec car = PlateSpec(
    id: 'am.car',
    country: ArmeniaCountry.armenia,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    rules: const <PlateRule>[_identifierBand],
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 90,
        top: 17,
        width: 48,
        height: 76,
        pitch: 54,
      ),
      // Wider cells on a wider pitch: FE-Schrift prints a letter broader than a
      // digit, so the pair is its own register rather than a continuation of
      // the one before.
      plateField(
        alphabet: ArmeniaAlphabets.letters,
        count: 2,
        left: 204,
        top: 17,
        width: 52,
        height: 76,
        pitch: 60,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 338,
        top: 17,
        width: 48,
        height: 76,
        pitch: 54,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// Two-row [car], e.g. `01 AD` over `234`; the flag block sits beside the serial.
  static final PlateSpec carTwoRow = PlateSpec(
    id: 'am.carTwoRow',
    country: ArmeniaCountry.armenia,
    canvasWidth: 300,
    canvasHeight: 150,
    // Lower and shallower than the full-size block: on a two-row plate the
    // block sits against the bottom row, not against the middle of the plate.
    panel: const PlatePanel(
      box: PlateBox(12, 34, 42, 72),
      padding: EdgeInsets.zero,
      captionScale: 1.6,
    ),
    rules: const <PlateRule>[PlateRule(box: PlateBox(60, 32, 9, 76))],
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 74,
        top: 16,
        width: 40,
        height: 62,
        pitch: 44,
      ),
      plateField(
        alphabet: ArmeniaAlphabets.letters,
        count: 2,
        left: 170,
        top: 16,
        width: 44,
        height: 62,
        pitch: 48,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 108,
        top: 84,
        width: 44,
        height: 62,
        pitch: 50,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// Motorcycle plate, e.g. `01AD` over `234`. The closed gap between region and
  /// letters is the design, so this is not [carTwoRow] on a narrower canvas.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'am.motorcycle',
    country: ArmeniaCountry.armenia,
    canvasWidth: 200,
    canvasHeight: 150,
    panel: const PlatePanel(
      box: PlateBox(8, 84, 34, 54),
      padding: EdgeInsets.zero,
      captionScale: 1.5,
    ),
    slots: [
      // Head row: region and letters, hard against one another.
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 52,
        top: 14,
        width: 30,
        height: 44,
        pitch: 34,
      ),
      plateField(
        alphabet: ArmeniaAlphabets.letters,
        count: 2,
        left: 120,
        top: 14,
        width: 32,
        height: 44,
        pitch: 36,
      ),
      // Lower row: the serial, at the size the head row gave up.
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 50,
        top: 74,
        width: 34,
        height: 58,
        pitch: 40,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// State plate, e.g. `001 NN 01`. The trailing pair is a reserved combination
  /// (`ArmeniaSpecialPlates`), judged by [ArmeniaPublicPlateValidator] as a
  /// membership test rather than a shape.
  static final PlateSpec public = PlateSpec(
    id: 'am.public',
    country: ArmeniaCountry.armenia,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    rules: const <PlateRule>[_identifierBand],
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 90,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
      plateField(
        alphabet: ArmeniaAlphabets.letters,
        count: 2,
        left: 258,
        top: 17,
        width: 50,
        height: 76,
        pitch: 58,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 380,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'tail'),
    ],
  );

  /// Trailer plate, e.g. `290 L` over `01`; pre-2014, so no identifier band. The
  /// letter is a slot because the article says the count was cut to one, not the
  /// choice.
  static final PlateSpec trailer = PlateSpec(
    id: 'am.trailer',
    country: ArmeniaCountry.armenia,
    canvasWidth: 210,
    canvasHeight: 150,
    panel: const PlatePanel(
      box: PlateBox(10, 86, 34, 52),
      padding: EdgeInsets.zero,
      captionScale: 1.5,
    ),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 40,
        top: 14,
        width: 36,
        height: 58,
        pitch: 42,
      ),
      // Set smaller than the digits beside it and dropped to their centre line,
      // the way the photographed plates print it.
      const PlateSlot(
        alphabet: ArmeniaAlphabets.letters,
        box: PlateBox(166, 22, 30, 46),
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 96,
        top: 82,
        width: 36,
        height: 58,
        pitch: 42,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'tail'),
    ],
  );

  /// Bus plate, e.g. `1234 S`; pre-2014 and still issued, so no identifier band.
  /// The class letter is `S` (city bus) or `L` (coach).
  static final PlateSpec bus = PlateSpec(
    id: 'am.bus',
    country: ArmeniaCountry.armenia,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 100,
        top: 17,
        width: 60,
        height: 76,
        pitch: 70,
      ),
      const PlateSlot(
        alphabet: ArmeniaAlphabets.busClass,
        box: PlateBox(400, 17, 64, 76),
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'class'),
    ],
  );

  /// Diplomatic plate, e.g. `04 D 057 AM`: mission code, class letter, serial and
  /// Armenia's code as fixed wording. [diplomatic] and [diplomaticArm] differ only
  /// in that wording and the room it takes.
  static final PlateSpec diplomatic = _diplomatic(
    id: 'am.diplomatic',
    countryCode: 'AM',
  );

  /// Prints `ARM` in place of [diplomatic]'s `AM`.
  static final PlateSpec diplomaticArm = _diplomatic(
    id: 'am.diplomaticArm',
    countryCode: 'ARM',
  );

  /// A label is laid out from the top of its box while a slot centres its glyph,
  /// so the label top is 20 + 70/2 - 0.72*56/2 = 34.8 to sit on the digits' centre
  /// line.
  static PlateSpec _diplomatic({
    required String id,
    required String countryCode,
  }) => PlateSpec(
    id: id,
    country: ArmeniaCountry.armenia,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 40,
        top: 20,
        width: 48,
        height: 70,
        pitch: 56,
      ),
      // Taller than the digits either side of it, as the photographed plates
      // print it: the class letter is the one character on a diplomatic plate
      // that has to be read at a checkpoint.
      const PlateSlot(
        alphabet: ArmeniaAlphabets.diplomaticClass,
        box: PlateBox(160, 17, 56, 76),
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 228,
        top: 20,
        width: 48,
        height: 70,
        pitch: 56,
      ),
    ],
    labels: [
      PlateLabel(
        text: countryCode,
        box: PlateBox(400, 34.8, 104, 56),
        glyphHeight: 56,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'mission'),
      PlateTextGroup([1], key: 'class'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// UN plate, e.g. `UN 080 AM`. Both words are labels because neither is a
  /// choice. The label tops are on the slots' centre line: 17 + 76/2 - 0.72*76/2
  /// for the head word, 17 + 38 - 0.72*56/2 for the smaller tail.
  static final PlateSpec un = PlateSpec(
    id: 'am.un',
    country: ArmeniaCountry.armenia,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 190,
        top: 17,
        width: 50,
        height: 76,
        pitch: 58,
      ),
    ],
    labels: const [
      PlateLabel(text: 'UN', box: PlateBox(44, 27.6, 130, 76), glyphHeight: 76),
      PlateLabel(
        text: 'AM',
        box: PlateBox(380, 34.8, 104, 56),
        glyphHeight: 56,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Ministry of Defence plate, e.g. `ՊՆ 1007 Մ`. The tail is a class letter in
  /// [ArmeniaAlphabets.militaryClass] (genuine Armenian letters, not the
  /// shape-sharing stand-ins of [ArmeniaAlphabets.letters]); `ՊՆ` is a label.
  static final PlateSpec military = PlateSpec(
    id: 'am.military',
    country: ArmeniaCountry.armenia,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: 170,
        top: 17,
        width: 50,
        height: 76,
        pitch: 58,
      ),
      const PlateSlot(
        alphabet: ArmeniaAlphabets.militaryClass,
        box: PlateBox(410, 17, 54, 76),
      ),
    ],
    labels: const [
      PlateLabel(text: 'ՊՆ', box: PlateBox(40, 27.6, 112, 76), glyphHeight: 76),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'class'),
    ],
  );

  /// Every design, in the order introduced above.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    car,
    carTwoRow,
    motorcycle,
    public,
    trailer,
    bus,
    diplomatic,
    diplomaticArm,
    un,
    military,
  ]);

  /// The validator that judges [spec]. [ArmeniaPlateValidator] describes only
  /// private registrations; handing it a public number would paint a correct
  /// state plate red, so the choice is made from the spec. The UN plate has only
  /// its three-digit serial left to check.
  static PlateValidator validatorFor(PlateSpec spec) => switch (spec.id) {
    'am.public' => const ArmeniaPublicPlateValidator(),
    'am.trailer' => const ArmeniaTrailerPlateValidator(),
    'am.bus' => const ArmeniaBusPlateValidator(),
    'am.diplomatic' ||
    'am.diplomaticArm' => const ArmeniaDiplomaticPlateValidator(),
    'am.un' => const ArmeniaSerialPlateValidator(length: 3),
    'am.military' => const ArmeniaMilitaryPlateValidator(),
    _ => const ArmeniaPlateValidator(),
  };
}
