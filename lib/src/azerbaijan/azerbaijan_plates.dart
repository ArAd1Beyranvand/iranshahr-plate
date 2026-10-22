import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'azerbaijan_country.dart';

/// Four specs, five plates on the road: the serial grouping is the spec, the
/// field colour is the theme, so a bus or taxi plate is [car] in
/// `AzerbaijanThemes.transport`.
///
/// The white country block stays clear of the frame, or it would rub out the
/// frame's edge. `final`, not `const`: the digit runs are built by
/// [plateField]. Every coordinate is sampled by eye and is a calibration
/// target.
abstract final class AzerbaijanPlates {
  /// Shared by the three full-size designs. The caption scale exceeds what fits
  /// on purpose: the caption scales down, so "too big" means "as large as
  /// allowed".
  static const PlatePanel _euPanel = PlatePanel(
    box: PlateBox(10, 26, 44, 60),
    padding: EdgeInsets.zero,
    captionScale: 1.6,
  );

  /// `88-BE-114`: regional code, two letters, serial.
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
    // Labels, not rules, so the hyphens take the ink. A label lays out from its
    // box top and a slot centres its glyph: 17 + 76/2 - 0.72*76/2 = 27.6 puts
    // the hyphen on the digits' centre line.
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

  /// `07` over `T-096`: [car] across two rows with one letter.
  static final PlateSpec bicycle = PlateSpec(
    id: 'az.bicycle',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 200,
    canvasHeight: 150,
    // Shallower than _euPanel: it shares the head row with the region.
    panel: const PlatePanel(
      box: PlateBox(14, 16, 40, 52),
      padding: EdgeInsets.zero,
      captionScale: 1.5,
    ),
    slots: [
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 100,
        top: 20,
        width: 34,
        height: 46,
        pitch: 42,
      ),
      const PlateSlot(alphabet: PlateAlphabet.latinUppercase, box: PlateBox(14, 82, 36, 54)),
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
    labels: const [PlateLabel(text: '-', box: PlateBox(52, 89.6, 18, 54), glyphHeight: 54)],
    textGroups: const [
      PlateTextGroup([0], key: 'region'),
      PlateTextGroup([1], key: 'letters'),
      PlateTextGroup([2], key: 'serial'),
    ],
  );

  /// `013 D 004`: mission country code, class letter, serial. No hyphens; the
  /// groups are told apart by gaps. The class is a slot because `D` is not the
  /// only letter issued.
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
      const PlateSlot(alphabet: PlateAlphabet.latinUppercase, box: PlateBox(262, 17, 50, 76)),
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

  /// `H 023 149`: class letter, then two groups of three digits. Two fields,
  /// because one evenly pitched field cannot express the gap.
  static final PlateSpec foreign = PlateSpec(
    id: 'az.foreign',
    country: AzerbaijanCountry.azerbaijan,
    canvasWidth: 520,
    canvasHeight: 110,
    panel: _euPanel,
    slots: [
      const PlateSlot(alphabet: PlateAlphabet.latinUppercase, box: PlateBox(94, 17, 50, 76)),
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

  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    car,
    bicycle,
    diplomatic,
    foreign,
  ]);
}
