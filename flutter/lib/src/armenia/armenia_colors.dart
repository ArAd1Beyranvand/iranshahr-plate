import 'package:flutter/widgets.dart';

/// Sampled by eye from plate photographs, so each value is a calibration
/// target.
///
/// The civilian plate has three colours, not two: [identifierBand], the silver
/// strip beside the flag, is neither field nor ink, so it cannot come from a
/// [PlateTheme.monochrome].
abstract final class ArmeniaColors {
  /// Also the white block the flag and `AM` sit in on the coloured classes.
  static const Color field = Color(0xFFFFFFFF); // CALIBRATE
  static const Color ink = Color(0xFF101010); // CALIBRATE

  /// A security feature, so it reaches the plate as a
  /// [PlateTheme.dividerColor]. // CALIBRATE
  static const Color identifierBand = Color(0xFFC9CCD1);

  static const Color busYellow = Color(0xFFF5C500); // CALIBRATE
  static const Color onBusYellow = ink;

  static const Color diplomaticRed = Color(0xFFCC1E3C); // CALIBRATE
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  static const Color unBlue = Color(0xFF2A5CAA); // CALIBRATE
  static const Color onUnBlue = Color(0xFFFFFFFF);

  /// The one plate whose field is darker than its ink. // CALIBRATE
  static const Color militaryBlack = Color(0xFF1A1A1A);
  static const Color onMilitaryBlack = Color(0xFFF2F2F2);

  /// Input chrome only, never printed. Two greys because one that reads on
  /// white vanishes on black or red.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
