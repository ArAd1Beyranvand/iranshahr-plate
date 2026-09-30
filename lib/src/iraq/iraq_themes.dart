import 'package:core_plate/core_plate.dart';
import 'package:flutter/widgets.dart';

import 'iraq_colors.dart';

/// PlateThemes for Iraqi registration plates. All plates have white field with
/// black text; variation is the left panel colour only. Themes are passed at
/// render time via the host's [PlateView] or [PlateCanvas].
abstract final class IraqThemes {
  static const double _borderWidthRatio = 0.04;
  static const double _plateRadiusRatio = 0.08;
  static const Color _inactiveLight = Color(0x66666666);

  /// Private vehicle plate: white field, black text.
  static const PlateTheme privateVehicle = PlateTheme.monochrome(
    field: IraqColors.whiteField,
    ink: IraqColors.blackText,
    inactive: _inactiveLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Bus, taxi, vehicle for hire: white field, black text.
  static const PlateTheme forHire = PlateTheme.monochrome(
    field: IraqColors.whiteField,
    ink: IraqColors.blackText,
    inactive: _inactiveLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Governmental vehicle: white field, black text.
  static const PlateTheme governmental = PlateTheme.monochrome(
    field: IraqColors.whiteField,
    ink: IraqColors.blackText,
    inactive: _inactiveLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Trade/commercial (trucks, tractors, cranes): white field, black text.
  static const PlateTheme commercial = PlateTheme.monochrome(
    field: IraqColors.whiteField,
    ink: IraqColors.blackText,
    inactive: _inactiveLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Agricultural vehicle: white field, black text.
  static const PlateTheme agricultural = PlateTheme.monochrome(
    field: IraqColors.whiteField,
    ink: IraqColors.blackText,
    inactive: _inactiveLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Temporary plate: white field, red text.
  static const PlateTheme temporary = PlateTheme.monochrome(
    field: IraqColors.whiteField,
    ink: IraqColors.temporaryRed,
    inactive: _inactiveLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
