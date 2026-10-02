import 'package:core_plate/core_plate.dart';

import 'uae_colors.dart';

/// The block a UAE plate would put in its panel. No UAE design has one — every
/// emirate prints its name as text on the face, which the specs carry as
/// labels — so every spec is `noPanel` and this exists only because
/// `PlateCanvas` takes a country.
abstract final class UaeCountry {
  static const PlateCountry uae = PlateCountry(
    code: 'ae',
    captionLines: <String>[],
    panelColor: UaeColors.field,
    panelTextColor: UaeColors.ink,
  );
}
