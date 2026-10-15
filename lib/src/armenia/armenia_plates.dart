import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'armenia_alphabets.dart';
import 'armenia_country.dart';
import 'armenia_validators.dart';

/// The Armenian plate designs.
///
/// Structurally these are European plates — a country block at the hoist end,
/// then Latin groups read left to right — and the country number is
/// `NN LL NNN`: a two-digit region code, two letters, a three-digit serial,
/// with no hyphen and no divider between them. The groups are told apart by
/// the gaps alone.
///
/// Three things make the set what it is:
///
/// 1. **The silver identifier band.** From 6 August 2014 every plate carries a
///    holographic strip immediately right of the flag block. It is a
///    [PlateRule] — the same tool Bahrain's security band uses — and it is the
///    reason `ArmeniaThemes.civilian` is not a [PlateTheme.monochrome]. The
///    pre-2014 designs still on the road ([trailer], [bus]) carry no band, and
///    say so by declaring no rule.
///
/// 2. **Which way round the number runs.** `NN LL NNN` is a private vehicle;
///    `NNN LL NN` — the same seven characters, regrouped — is a state one, and
///    there the trailing pair is not a serial at all but half of an
///    institution's reserved combination. [car] and [public] are two specs for
///    exactly that reason: the registers are 2/2/3 on one and 3/2/2 on the
///    other, and a spec is its registers.
///
/// 3. **What replaces the flag block.** The diplomatic, UN and military plates
///    print their own wording where the block would be and declare
///    [PlateSpec.noPanel]. They are the three designs a host cannot hand a
///    different `country` to; there is nowhere to put it.
///
/// Colour is never here. A bus plate is [bus] printed in `ArmeniaThemes.bus`,
/// and the two-row [carTwoRow] is the same number as [car] on a deeper canvas,
/// not a different class.
///
/// `final`, not `const`: the digit runs are built by [plateRegister], and a
/// `const` constructor cannot run a loop. Initialised lazily, once per isolate;
/// [PlateSpec] equality is over `id` alone, so nothing here depended on const
/// canonicalisation.
///
/// Every coordinate below is sampled by eye from plate photographs and is a
/// calibration target.
abstract final class ArmeniaPlates {
  /// The country block on the full-size plates: the flag at the top, `AM`
  /// beneath it, in a white block inset from the frame.
  ///
  /// Zero padding and a [PlatePanel.flagScale] of 1 make the flag fill the
  /// box's width exactly, so 48 wide at 1:2 is 24 deep and the remaining 58
  /// belongs to the caption. [PlatePanel.captionScale] is set past what will
  /// fit on purpose: `CountryPanel` puts the caption in a `BoxFit.scaleDown`,
  /// so a value too big means "as large as the block allows" and a value too
  /// small would silently leave the block half empty.
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 14, 48, 82),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// The silver identifier band on a full-size plate of the 2014 design: a
  /// narrow strip between the flag block and the first digit, stopping short of
  /// the frame at both ends.
  ///
  /// A [PlateRule] and not a [PlateBand]: a band is a field that ink is printed
  /// *on* and lives only at the right-hand end, and nothing is printed on this
  /// one. It is chrome, it takes the theme's divider colour, and it is the only
  /// reason that colour is not the ink.
  static const PlateRule _identifierBand = PlateRule(
    box: PlateBox(66, 12, 10, 86),
  );

  /// The standard private plate (520×110), e.g. `01 AD 234`: a two-digit region
  /// code, two letters, a three-digit serial.
  ///
  /// The commonest plate in the country and the one the article's lead
  /// photograph shows. Judged by [ArmeniaPlateValidator], which is where the
  /// rule that a private number carries no `G` or `I` lives.
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

  /// The two-row variant of [car] (300×150), e.g. `01 AD` over `234`.
  ///
  /// The same seven characters in the same three groups, broken across two rows
  /// for a vehicle with no room for a 520 mm plate: region and letters share the
  /// head row, the serial has the lower one to itself, and the flag block drops
  /// to sit beside the serial rather than beside the whole number.
  ///
  /// Its own spec and not [car] on a deeper canvas, because the boxes are what
  /// differ and the boxes are the spec.
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

  /// The motorcycle plate (200×150), e.g. `01AD` over `234`.
  ///
  /// The compact form, and the reason it exists is in the article: the first
  /// motorcycle plates were ordinary two-row plates, found too cumbersome to
  /// carry, and shrunk by closing the gap between the region code and the
  /// letters. That closed gap is the design — region and letters run together
  /// as one block on the head row — and it is why this cannot be [carTwoRow] on
  /// a narrower canvas.
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

  /// The public (state-owned) plate (520×110), e.g. `001 NN 01`: a three-digit
  /// serial, then a reserved combination of two letters and two digits.
  ///
  /// [car]'s seven characters regrouped, and a different plate for it. The
  /// trailing pair is not a serial: `NN 01` is the Security Council and
  /// `GG 01` is the General Prosecutor's office, and the table of which is
  /// which is `ArmeniaSpecialPlates`. [ArmeniaPublicPlateValidator] judges the
  /// pair against it — the one rule in this package that is a membership test
  /// rather than a shape.
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

  /// The trailer plate (210×150), e.g. `290 L` over `01`.
  ///
  /// A two-row plate with one letter instead of two — most often `L` — on a
  /// canvas more compact than [carTwoRow]'s. A pre-2014 design: no identifier
  /// band, and the block is the bare `AM` with the flag above it.
  ///
  /// The letter is a slot rather than a printed `L`, because "most often L" is
  /// not "always L": the article says the count was cut to one, not that the
  /// choice was.
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

  /// The bus plate (520×110), e.g. `1234 S` — black on yellow under
  /// `ArmeniaThemes.bus`.
  ///
  /// Four digits and a class letter: `S` for a city bus, `L` for a long-range
  /// coach, which is the whole of [ArmeniaAlphabets.busClass]. The format and
  /// the yellow are both inherited from the Soviet public-transport plate,
  /// which Russia has since discontinued and Armenia has not — so this is a
  /// pre-2014 design still being issued, and it carries no identifier band.
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

  /// The diplomatic plate (520×110), e.g. `04 D 057 AM` — white on red under
  /// `ArmeniaThemes.diplomatic`.
  ///
  /// The mission's country code, the class letter (`D` for a diplomat, `T` for
  /// a technician), the serial, and then Armenia's own code printed as fixed
  /// wording. [PlateSpec.noPanel]: there is no flag block on this design, and
  /// the `AM` at the tail is doing that job at the other end of the plate.
  ///
  /// Two specs rather than one, because newer plates print `ARM` where these
  /// print `AM` and the two are different widths of the same design. Built by
  /// [_diplomatic], so the pair differ in the one datum they actually differ
  /// in: see `plate_core/CLAUDE.md` — variation is data.
  static final PlateSpec diplomatic = _diplomatic(
    id: 'am.diplomatic',
    countryCode: 'AM',
  );

  /// The current diplomatic plate, printing `ARM` in place of [diplomatic]'s
  /// `AM`.
  static final PlateSpec diplomaticArm = _diplomatic(
    id: 'am.diplomaticArm',
    countryCode: 'ARM',
  );

  /// [diplomatic] and [diplomaticArm], which differ only in the wording at the
  /// tail and in how much room it takes.
  ///
  /// The label is laid out from the top of its box while a slot centres its
  /// glyph, so its top is not the slots' 20: 20 + 70/2 - 0.72*56/2 = 34.8,
  /// which puts the wording on the digits' own centre line.
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

  /// The United Nations plate (520×110), e.g. `UN 080 AM` — white on blue under
  /// `ArmeniaThemes.un`.
  ///
  /// Three digits between two fixed words, and nothing else: no region, no
  /// letters, no class. Both words are [PlateLabel]s because neither is a
  /// choice — every plate of this design reads `UN` at the head and `AM` at the
  /// tail — and a slot that accepts exactly one character is a label with extra
  /// steps.
  ///
  /// The label tops are on the slots' centre line: 17 + 76/2 - 0.72*76/2 = 27.6
  /// for the head word at the serial's own size, and 17 + 38 - 0.72*56/2 = 34.8
  /// for the smaller `AM` at the tail.
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

  /// The Ministry of Defence plate (520×110), e.g. `ՊՆ 1007 Մ` — white on black
  /// under `ArmeniaThemes.military`.
  ///
  /// **The one Armenian plate with no Latin on it.** `ՊՆ` is
  /// *Պաշտպանության Նախարարություն*, the Ministry of Defence, and the letter at
  /// the tail is the vehicle's class: `Մ` for a passenger vehicle, `Տ` for a
  /// transport one. Those are Armenian letters being Armenian, not the
  /// shape-sharing stand-ins a civilian plate's letters are — which is why the
  /// tail is [ArmeniaAlphabets.militaryClass] and not
  /// [ArmeniaAlphabets.letters].
  ///
  /// `ՊՆ` is a label: it is on every plate of this design and is not a value
  /// anyone enters.
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

  /// Every Armenian design, in the order they are introduced above. A picker
  /// iterates this rather than naming nine constants.
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

  /// The validator that judges [spec].
  ///
  /// Not every Armenian plate is a private registration, and
  /// [ArmeniaPlateValidator]'s rules describe only the ones that are: a region
  /// code, a letter pair that may not be `G` or `I`, a three-digit serial. A
  /// public number breaks all three — its letters *are* `GG` when it belongs to
  /// the Prosecutor's office — and handing it that validator would paint a
  /// perfectly correct state plate red. So the choice is made here, from the
  /// spec, rather than left to a caller with no way of knowing which rules
  /// apply.
  ///
  /// The UN plate is the one design with nothing to judge: three digits on a
  /// digit alphabet, with every other character printed. There is no rule to
  /// state about it that the spec does not already enforce, so it gets
  /// [ArmeniaSerialPlateValidator], which checks the one thing left — that the
  /// serial is three digits.
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
