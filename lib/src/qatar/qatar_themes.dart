import 'package:plate_core/plate_core.dart';

import 'qatar_colors.dart';

/// The `PlateTheme`s a Qatari plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: QatarPlates.civilian,
///   country: QatarCountry.civilian,
///   theme: QatarThemes.civilian,
///   ...
/// )
/// ```
abstract final class QatarThemes {
  /// Frame thickness as a fraction of plate height. The reference photograph
  /// shows a heavy black frame, closer to an Iranian plate's than a Bahraini
  /// one's. // CALIBRATE
  static const double _borderWidthRatio = 0.05;

  /// Generously rounded, matching the reference photograph. // CALIBRATE
  static const double _plateRadiusRatio = 0.12;

  /// Civilian plates in every size: black on white, maroon hoist block.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: QatarColors.field,
    ink: QatarColors.darkInk,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    inactive: QatarColors.inactiveOnLight,
  );

  /// Police: white reversed out of blue, on a blue field.
  static const PlateTheme police = PlateTheme.monochrome(
    field: QatarColors.policeBlue,
    ink: QatarColors.onPoliceBlue,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    inactive: QatarColors.inactiveOnLight,
  );
}
