import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'azerbaijan_country.dart';

/// The Azerbaijani plate designs: four specs, five plates on the road.
///
/// The grouping of the serial is the spec; the field colour is the theme. A
/// bus or taxi plate is [car] in `AzerbaijanThemes.transport`, not a separate
/// spec, because a [PlateSpec] never carries colour.
///
/// The country block is [AzerbaijanCountry.azerbaijan] on every plate. Its
/// [PlatePanel.box] stays clear of the frame: the panel is white, and a white
/// block run out under a black frame would rub the frame out.
///
/// `final`, not `const`: the digit runs are built by [plateRegister].
///
/// Every coordinate is sampled by eye from plate photographs and is a
/// calibration target.
abstract final class AzerbaijanPlates {
  /// The country block shared by the three full-size designs.
  ///
  /// [PlatePanel.captionScale] is set past what will fit on purpose:
  /// `CountryPanel` scales the caption down, so too big means "as large as the
  /// block allows" while too small would leave the block half empty.
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 26, 44, 60),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// The standard civilian plate (520×110), e.g. `88-BE-114`: a two-digit
  /// regional code, two Latin letters, a three-digit serial, hyphenated.
  ///
  /// In `AzerbaijanThemes.transport` this is the blue bus-and-taxi plate.
  static final PlateSpec car = PlateSpec(
    id: 'az.car',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 78,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
      plateField(
        alphabet: PlateAlphabet.latinUppercase,
        count: 2,
        left: 204,
        top: 17,
        width: 50,
        height: 76,
        pitch: 58,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 340,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
    ],
    // Hyphens are characters in the serial's ink, so labels, not PlateRules. A
    // label is laid out from its box top while a slot centres its glyph:
    // 17 + 76/2 - 0.72*76/2 = 27.6 puts the hyphen on the digits' centre line.
    labels: const [
      PlateLabel(text: '-', box: PlateBox(181, 27.6, 22, 76), glyphHeight: 76),
      PlateLabel(text: '-', box: PlateBox(314, 27.6, 22, 76), glyphHeight: 76),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// The motorcycle plate (200×150), e.g. `07` over `T-096`.
  ///
  /// The characters of [car] across two rows, with one letter instead of two.
  static final PlateSpec bicycle = PlateSpec(
    id: 'az.bicycle',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 200,
    canvasHeight: 150,
    // Shallower than _euPanel: it shares the head row with the regional pair.
    panel: const PlatePanel(
      box: PlateBox(14, 16, 40, 52),
      padding: EdgeInsets.zero,
      captionScale: 1.5,
    ),
    slots: [
      // Head row: the regional pair.
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 20,
        width: 34,
        height: 46,
        pitch: 42,
      ),
      const PlateSlot(
        alphabet: PlateAlphabet.latinUppercase,
        box: PlateBox(14, 82, 36, 54),
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 72,
        top: 82,
        width: 34,
        height: 54,
        pitch: 40,
      ),
    ],
    // 82 + 54/2 - 0.72*54/2 = 89.6. See car.
    labels: const [
      PlateLabel(text: '-', box: PlateBox(52, 89.6, 18, 54), glyphHeight: 54),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// The diplomatic plate (520×110), e.g. `013 D 004`: the mission's country
  /// code, the class letter, and the serial — printed white on red by
  /// `AzerbaijanThemes.diplomatic`.
  ///
  /// No hyphens; the groups are told apart by gaps wider than [car]'s. The
  /// class letter is a slot because `D` is not the only one issued.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'az.diplomatic',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 94,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
      const PlateSlot(
        alphabet: PlateAlphabet.latinUppercase,
        box: PlateBox(262, 17, 50, 76),
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 326,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'mission'),
      PlateTextGroup([1], key: 'class'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// The foreign-owned company plate (520×110), e.g. `H 023 149`: the class
  /// letter first, then six digits in two threes — printed black on yellow by
  /// `AzerbaijanThemes.foreign`.
  ///
  /// The six digits are two registers, not one: a register's cells are evenly
  /// pitched (`debugValidateSpec` checks), so it cannot express the gap.
  static final PlateSpec foreign = PlateSpec(
    id: 'az.foreign',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      const PlateSlot(
        alphabet: PlateAlphabet.latinUppercase,
        box: PlateBox(94, 17, 50, 76),
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 158,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 326,
        top: 17,
        width: 46,
        height: 76,
        pitch: 54,
      ),
    ],
    textGroups: const [
      PlateTextGroup([0], key: 'class'),
      PlateTextGroup([1], key: 'series'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// Every Azerbaijani design. The blue transport plate is [car] under another
  /// theme, so a picker offers it as `(car, AzerbaijanThemes.transport)`.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    car,
    bicycle,
    diplomatic,
    foreign,
  ]);
}
