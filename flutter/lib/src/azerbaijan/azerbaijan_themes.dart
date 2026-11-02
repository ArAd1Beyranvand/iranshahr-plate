import 'package:plate_core/plate_core.dart';

import 'azerbaijan_colors.dart';

/// Classes differ by field colour alone: one ink prints the serial, hyphens and
/// frame, with no divider or second ink, so every theme is monochrome.
///
/// The `AZ` block is not themed; see [AzerbaijanCountry].
abstract final class AzerbaijanThemes {
  static const double _borderWidthRatio = 0.035; // CALIBRATE
  static const double _plateRadiusRatio = 0.10; // CALIBRATE

  /// Black on white.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: AzerbaijanColors.field,
    ink: AzerbaijanColors.ink,
    inactive: AzerbaijanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// White on blue.
  static const PlateTheme transport = PlateTheme.monochrome(
    field: AzerbaijanColors.transportBlue,
    ink: AzerbaijanColors.onTransportBlue,
    inactive: AzerbaijanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// White on red.
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: AzerbaijanColors.diplomaticRed,
    ink: AzerbaijanColors.onDiplomaticRed,
    inactive: AzerbaijanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Black on yellow.
  static const PlateTheme foreign = PlateTheme.monochrome(
    field: AzerbaijanColors.foreignYellow,
    ink: AzerbaijanColors.onForeignYellow,
    inactive: AzerbaijanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
