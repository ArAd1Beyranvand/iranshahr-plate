import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'turkey_colors.dart';

/// The liveries a Turkish plate is printed in. Every one is one ink on one
/// field inside a frame, so they differ only in those three colours and in
/// two frame shapes, measured off the 520x110 reference artwork:
///
/// - the TR-strip plates: a 3.5 mm black frame, 9 mm corners;
/// - the stripless official plates: a 3.2 mm frame in a colour of their own
///   (white on the police, consulate and official plates, gold on the state
///   plates), 9 mm corners — square on the provincial-government plate.
///
/// The ratios are of the plate's height, so the motorcycle plate, which reuses
/// [civilian], gets a proportionally heavier frame.
abstract final class TurkeyThemes {
  static const double _stripFrame = 3.5 / 110;
  static const double _plainFrame = 3.2 / 110;
  static const double _radius = 9 / 110;

  static PlateTheme _theme({
    required Color field,
    required Color ink,
    Color frame = TurkeyColors.black,
    double borderWidthRatio = _stripFrame,
    double plateRadiusRatio = _radius,
    bool dark = false,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: frame,
    ink: ink,
    // The one divider any design prints, the taxi plate's rule at the strip,
    // is the frame's black.
    dividerColor: frame,
    borderWidthRatio: borderWidthRatio,
    plateRadiusRatio: plateRadiusRatio,
    activeColor: ink,
    inactiveColor: dark
        ? TurkeyColors.inactiveOnDark
        : TurkeyColors.inactiveOnLight,
  );

  static PlateTheme _plain({
    required Color field,
    required Color ink,
    required Color frame,
  }) => _theme(
    field: field,
    ink: ink,
    frame: frame,
    borderWidthRatio: _plainFrame,
    dark: true,
  );

  /// Black on white: private and commercial vehicles, foreign and Syrian
  /// residents, taxis, the sample plate and motorcycles.
  static final PlateTheme civilian = _theme(
    field: TurkeyColors.white,
    ink: TurkeyColors.black,
  );

  /// Blue on white: members of international organisations.
  static final PlateTheme internationalOrganization = _theme(
    field: TurkeyColors.white,
    ink: TurkeyColors.blue,
  );

  /// Green on white: the diplomatic corps, `CD`.
  static final PlateTheme diplomatic = _theme(
    field: TurkeyColors.white,
    ink: TurkeyColors.diplomaticGreen,
  );

  /// Black on yellow, under a white diagonal stripe the spec paints.
  static final PlateTheme temporary = _theme(
    field: TurkeyColors.temporaryYellow,
    ink: TurkeyColors.black,
  );

  /// Red on green: temporary customs, `GMR`.
  static final PlateTheme temporaryCustoms = _theme(
    field: TurkeyColors.customsGreen,
    ink: TurkeyColors.customsRed,
  );

  /// Red on white in a square red frame: provincial governments and
  /// university rectors.
  static final PlateTheme provincialGovernment = _theme(
    field: TurkeyColors.white,
    ink: TurkeyColors.provincialRed,
    frame: TurkeyColors.provincialRed,
    borderWidthRatio: _plainFrame,
    plateRadiusRatio: 0,
  );

  /// White on blue: police, gendarmerie and coast guard.
  static final PlateTheme police = _plain(
    field: TurkeyColors.blue,
    ink: TurkeyColors.white,
    frame: TurkeyColors.white,
  );

  /// White on green: consulates, `CC`.
  static final PlateTheme consulate = _plain(
    field: TurkeyColors.green,
    ink: TurkeyColors.white,
    frame: TurkeyColors.white,
  );

  /// White on black: government and public administrations.
  static final PlateTheme official = _plain(
    field: TurkeyColors.black,
    ink: TurkeyColors.white,
    frame: TurkeyColors.white,
  );

  /// Gold on red in a gold frame: parliament and province governors.
  static final PlateTheme state = _plain(
    field: TurkeyColors.stateRed,
    ink: TurkeyColors.gold,
    frame: TurkeyColors.gold,
  );
}
