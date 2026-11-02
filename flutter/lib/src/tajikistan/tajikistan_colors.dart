import 'package:flutter/widgets.dart';

/// Every colour a Tajik plate is printed in, in one place.
///
/// All of these are sampled by eye from the Wikipedia plate drawings rather than
/// from a printing standard, so each is a calibration target: move the value
/// here and every theme that uses it moves with it.
///
/// Tajikistan runs one field-and-ink pair for private traffic — black on white —
/// and then a small run of coloured classes that keep the black ink but swap the
/// field: the amber public-transport plate, the yellow foreign plate, the red
/// diplomatic plate, and the two that reverse the ink out white, the blue police
/// plate and the black governmental one.
abstract final class TajikistanColors {
  /// The white field of a civilian plate, and the white the flag block sits on
  /// when a plate carries one. // CALIBRATE
  static const Color field = Color(0xFFFFFFFF);

  /// The near-black the serial, the frame and the `TJ` under the flag are printed
  /// in. // CALIBRATE
  static const Color ink = Color(0xFF101010);

  /// Public transport: black on amber, the golden field of a bus or taxi plate
  /// carrying the fixed `TT` marker. // CALIBRATE
  static const Color transportAmber = Color(0xFFF2B600);
  static const Color onTransportAmber = ink;

  /// Vehicles of foreign citizens and companies: black on a lighter, purer
  /// yellow than the transport amber. // CALIBRATE
  static const Color foreignYellow = Color(0xFFF6C915);
  static const Color onForeignYellow = ink;

  /// The diplomatic corps: white on red. // CALIBRATE
  static const Color diplomaticRed = Color(0xFFD81E28);
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  /// The police: white on blue. // CALIBRATE
  static const Color policeBlue = Color(0xFF203C8C);
  static const Color onPoliceBlue = Color(0xFFFFFFFF);

  /// Governmental vehicles: white on black, the old Russian-derived design with
  /// the region boxed off at the right. The one Tajik plate whose field is
  /// darker than its ink. // CALIBRATE
  static const Color governmentBlack = Color(0xFF161616);
  static const Color onGovernmentBlack = Color(0xFFF2F2F2);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor]. Two of them, because a grey that
  /// reads on a white plate vanishes on a blue, red or black one.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
