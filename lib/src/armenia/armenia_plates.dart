import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'armenia_alphabets.dart';
import 'armenia_country.dart';
import 'armenia_validators.dart';

/// Structurally European plates: a country block at the hoist end, then Latin
/// groups with no divider.
///
/// `NN LL NNN` is a private vehicle, `NNN LL NN` a state one whose trailing
/// pair is half an institution's reserved combination; their registers differ,
/// hence two specs. The diplomatic, UN and military plates print their own
/// wording in place of the flag block and declare [PlateSpec.noPanel].
///
/// `final`, not `const`: the digit runs are built by [plateField]. Every
/// coordinate is sampled by eye and is a calibration target.
abstract final class ArmeniaPlates {
  /// The flag fills the box's width. The caption scale exceeds what fits on
  /// purpose: the caption scales down, so "too big" means "as large as allowed".
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 14, 48, 82),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// The 2014 design's silver strip: a rule, so it takes the divider colour.
  static const PlateRule _identifierBand = PlateRule(box: PlateBox(66, 12, 10, 86));

  /// `01 AD 234`.
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
      // Letters print broader than digits, so wider cells on a wider pitch.
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

  /// `01 AD` over `234`; the flag block sits beside the serial.
  static final PlateSpec carTwoRow = PlateSpec(
    id: 'am.carTwoRow',
    country: ArmeniaCountry.armenia,
    canvasWidth: 300,
    canvasHeight: 150,
    // Against the bottom row, not the middle of the plate.
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

  /// `01AD` over `234`. Region and letters abut, so this is not [carTwoRow]
  /// on a narrower canvas.
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

  /// `001 NN 01`; the trailing pair is an `ArmeniaSpecialPlates` combination.
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

  /// `290 L` over `01`; pre-2014, so no identifier band.
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
      // Smaller than the digits, on their centre line.
      const PlateSlot(alphabet: ArmeniaAlphabets.letters, box: PlateBox(166, 22, 30, 46)),
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

  /// `1234 S` (city) or `L` (coach); pre-2014, so no identifier band.
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
      const PlateSlot(alphabet: ArmeniaAlphabets.busClass, box: PlateBox(400, 17, 64, 76)),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'class'),
    ],
  );

  /// `04 D 057 AM`: mission code, class letter, serial and the country code as
  /// fixed wording.
  static final PlateSpec diplomatic = _diplomatic(id: 'am.diplomatic', countryCode: 'AM');

  /// Prints `ARM` in place of [diplomatic]'s `AM`.
  static final PlateSpec diplomaticArm = _diplomatic(id: 'am.diplomaticArm', countryCode: 'ARM');

  /// A label lays out from the top of its box and a slot centres its glyph, so
  /// the label top is 20 + 70/2 - 0.72*56/2 = 34.8 to sit on the digits' centre
  /// line.
  static PlateSpec _diplomatic({required String id, required String countryCode}) => PlateSpec(
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
      // Taller than the digits, as photographed.
      const PlateSlot(alphabet: ArmeniaAlphabets.diplomaticClass, box: PlateBox(160, 17, 56, 76)),
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
    labels: [PlateLabel(text: countryCode, box: PlateBox(400, 34.8, 104, 56), glyphHeight: 56)],
    textGroups: const [
      PlateTextGroup([0], key: 'mission'),
      PlateTextGroup([1], key: 'class'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// `UN 080 AM`; both words are labels. Their tops sit on the slots' centre
  /// line: 17 + 76/2 - 0.72*76/2 for `UN`, 17 + 38 - 0.72*56/2 for `AM`.
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
      PlateLabel(text: 'AM', box: PlateBox(380, 34.8, 104, 56), glyphHeight: 56),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// `ՊՆ 1007 Մ`. The class uses genuine Armenian letters
  /// ([ArmeniaAlphabets.militaryClass]), not the lookalikes of
  /// [ArmeniaAlphabets.letters]; `ՊՆ` is a label.
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
      const PlateSlot(alphabet: ArmeniaAlphabets.militaryClass, box: PlateBox(410, 17, 54, 76)),
    ],
    labels: const [PlateLabel(text: 'ՊՆ', box: PlateBox(40, 27.6, 112, 76), glyphHeight: 76)],
    textGroups: const [
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'class'),
    ],
  );

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

  /// The validator for [spec]. [ArmeniaPlateValidator] describes only private
  /// registrations and would flag a correct state plate.
  static PlateValidator validatorFor(PlateSpec spec) => switch (spec.id) {
    'am.public' => const ArmeniaPublicPlateValidator(),
    'am.trailer' => const ArmeniaTrailerPlateValidator(),
    'am.bus' => const ArmeniaBusPlateValidator(),
    'am.diplomatic' || 'am.diplomaticArm' => const ArmeniaDiplomaticPlateValidator(),
    'am.un' => const ArmeniaSerialPlateValidator(length: 3),
    'am.military' => const ArmeniaMilitaryPlateValidator(),
    _ => const ArmeniaPlateValidator(),
  };
}
