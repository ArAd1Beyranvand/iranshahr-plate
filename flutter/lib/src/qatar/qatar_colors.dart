import 'package:flutter/widgets.dart';

/// Every colour a Qatari plate is printed in, in one place.
abstract final class QatarColors {
  /// Qatar maroon. The one colour here that is not a calibration target: it is
  /// the `#8a1538` of the official flag construction, the colour the hoist block is cut from.
  static const Color maroon = Color(0xFF8A1538);

  /// The white field, and the `QATAR` reversed out of the maroon block.
  static const Color field = Color(0xFFFFFFFF);
  static const Color onMaroon = Color(0xFFFFFFFF);

  /// The serial, `قطر`, and the frame on a civilian plate. // CALIBRATE
  static const Color darkInk = Color(0xFF101010);

  /// The police plate: white wording reversed out of a mid blue. // CALIBRATE
  static const Color policeBlue = Color(0xFF1E8AC8);
  static const Color onPoliceBlue = Color(0xFFFFFFFF);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor].
  static const Color inactiveOnLight = Color(0x66666666);
}
