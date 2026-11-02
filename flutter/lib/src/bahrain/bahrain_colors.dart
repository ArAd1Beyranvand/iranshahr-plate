import 'package:flutter/widgets.dart';

/// Sampled by eye from plate photographs, so each value is a calibration
/// target.
abstract final class BahrainColors {
  /// Digits, caption and frame on a civilian plate. // CALIBRATE
  static const Color blue = Color(0xFF1B2A8F);

  static const Color field = Color(0xFFFFFFFF);

  /// The security band down the right of every plate. Rules paint in
  /// [PlateTheme.dividerColor], which each theme sets to this, not the ink.
  /// // CALIBRATE
  static const Color band = Color(0xFF8E8E8E);

  /// The diplomatic block and the ink reversed out of it. // CALIBRATE
  static const Color diplomaticGreen = Color(0xFF2F7A4F);
  static const Color onDiplomaticGreen = Color(0xFFFFFFFF);

  /// The police block is pale, so its caption is dark. // CALIBRATE
  static const Color policeBlue = Color(0xFF4FB8E8);
  static const Color onPoliceBlue = Color(0xFF10307A);

  /// The serial ink on the diplomatic and police plates.
  static const Color darkInk = Color(0xFF101010);

  /// Input chrome only, never printed.
  static const Color inactiveOnLight = Color(0x66666666);
}
