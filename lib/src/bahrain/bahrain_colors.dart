import 'package:flutter/widgets.dart';

/// Every colour a Bahraini plate is printed in, in one place.
///
/// All of these are sampled by eye from plate photographs rather than from a
/// printing standard, so each is a calibration target: move the value here and
/// every spec and theme that uses it moves with it.
abstract final class BahrainColors {
  /// The digits, the caption and the frame on a civilian plate. // CALIBRATE
  static const Color blue = Color(0xFF1B2A8F);

  /// The white field the digits sit on.
  static const Color field = Color(0xFFFFFFFF);

  /// The vertical security band down the right of every Bahraini plate. Core
  /// paints every [PlateRule] in [PlateTheme.dividerColor], so this is what
  /// each Bahraini theme sets that to — it is deliberately NOT the ink.
  /// // CALIBRATE
  static const Color band = Color(0xFF8E8E8E);

  /// The diplomatic corps block, and the ink reversed out of it. // CALIBRATE
  static const Color diplomaticGreen = Color(0xFF2F7A4F);
  static const Color onDiplomaticGreen = Color(0xFFFFFFFF);

  /// The police block, and the ink printed on it. The block is pale, so the
  /// caption is printed dark rather than reversed out. // CALIBRATE
  static const Color policeBlue = Color(0xFF4FB8E8);
  static const Color onPoliceBlue = Color(0xFF10307A);

  /// The serial ink on the two special plates, whose numbers are printed near
  /// black rather than in the civilian blue.
  static const Color darkInk = Color(0xFF101010);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor].
  static const Color inactiveOnLight = Color(0x66666666);
}
