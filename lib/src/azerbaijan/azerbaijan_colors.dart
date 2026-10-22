import 'package:flutter/widgets.dart';

/// Sampled by eye from plate photographs, so each value is a calibration
/// target. Every design is one ink on one field.
abstract final class AzerbaijanColors {
  /// Also the white block the flag and `AZ` sit in on every other class.
  /// // CALIBRATE
  static const Color field = Color(0xFFFFFFFF);

  /// Also the colour of `AZ` on every class, since its block is [field]
  /// whatever the plate is. // CALIBRATE
  static const Color ink = Color(0xFF101010);

  /// Buses and taxis. // CALIBRATE
  static const Color transportBlue = Color(0xFF2C6EB5);
  static const Color onTransportBlue = Color(0xFFFFFFFF);

  // CALIBRATE
  static const Color diplomaticRed = Color(0xFFC8102E);
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  /// Foreign-owned companies; keeps the civilian ink. // CALIBRATE
  static const Color foreignYellow = Color(0xFFF2C200);
  static const Color onForeignYellow = ink;

  /// Input chrome only, never printed. Two greys because one that reads on
  /// white vanishes on blue or red.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
