import 'package:core_plate/core_plate.dart';

import 'bahrain_colors.dart';

/// The `PlateTheme`s a Bahraini plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: BahrainPlates.diplomatic,
///   country: BahrainCountry.diplomatic,
///   theme: BahrainThemes.diplomatic,
///   ...
/// )
/// ```
///
/// None of these is a [PlateTheme.monochrome]. That constructor makes the
/// divider colour the ink, and on a Bahraini plate it is not: the vertical
/// security band down the right is grey on every class of plate, including the
/// two whose numbers are printed near black and the three printed in blue. The
/// band is the one thing all five designs share, so it is the one colour none
/// of these themes is free to derive from its ink.
abstract final class BahrainThemes {
  /// Frame thickness as a fraction of plate height. Bahraini frames are thin
  /// next to an Iranian one. // CALIBRATE
  static const double _borderWidthRatio = 0.03;

  /// Noticeably rounded — the reference photographs show a soft, generous
  /// corner, closer to a credit card than a squared-off plate. // CALIBRATE
  static const double _plateRadiusRatio = 0.14;

  /// Civilian plates in every size: blue on white, grey band.
  static const PlateTheme civilian = PlateTheme(
    plateBackground: BahrainColors.field,
    plateBorder: BahrainColors.blue,
    ink: BahrainColors.blue,
    dividerColor: BahrainColors.band,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: BahrainColors.blue,
    inactiveColor: BahrainColors.inactiveOnLight,
  );

  /// Diplomatic corps: a near-black serial on white under the green band, in a
  /// frame the same green.
  static const PlateTheme diplomatic = PlateTheme(
    plateBackground: BahrainColors.field,
    plateBorder: BahrainColors.diplomaticGreen,
    ink: BahrainColors.darkInk,
    dividerColor: BahrainColors.band,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: BahrainColors.darkInk,
    inactiveColor: BahrainColors.inactiveOnLight,
  );

  /// Police: the same near-black serial, framed in the dark blue the band's
  /// wording is printed in.
  static const PlateTheme police = PlateTheme(
    plateBackground: BahrainColors.field,
    plateBorder: BahrainColors.onPoliceBlue,
    ink: BahrainColors.darkInk,
    dividerColor: BahrainColors.band,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: BahrainColors.darkInk,
    inactiveColor: BahrainColors.inactiveOnLight,
  );
}
