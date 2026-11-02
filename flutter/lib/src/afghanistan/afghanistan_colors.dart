import 'package:flutter/widgets.dart';

/// Sampled by eye from the plate photographs, so each value is a calibration
/// target.
abstract final class AfghanistanColors {
  static const Color field = Color(0xFFFFFFFF); // CALIBRATE
  static const Color ink = Color(0xFF0D0D0D); // CALIBRATE

  /// Buses and taxis share the field; the class letter tells them apart.
  static const Color transportYellow = Color(0xFFF5C518); // CALIBRATE
  static const Color onTransportYellow = ink;

  static const Color diplomaticRed = Color(0xFFE01B1B); // CALIBRATE
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  static const Color governmentalBlack = Color(0xFF0A0A0A); // CALIBRATE
  static const Color onGovernmentalBlack = Color(0xFFFFFFFF);

  static const Color unBlue = Color(0xFF5B9BD5); // CALIBRATE
  static const Color onUnBlue = ink;

  /// A second ink on the temporary plate, passed to its labels and never to a
  /// theme, which would recolour the serial too. // CALIBRATE
  static const Color temporaryRed = Color(0xFFE01B1B);

  /// Input chrome only, never printed. Two greys because one that reads on
  /// white vanishes on red or black.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
