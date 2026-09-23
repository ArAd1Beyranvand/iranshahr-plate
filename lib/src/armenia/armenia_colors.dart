import 'package:flutter/widgets.dart';

/// Every colour an Armenian plate is printed in, in one place.
///
/// All of these are sampled by eye from plate photographs rather than from a
/// printing standard, so each is a calibration target: move the value here and
/// every theme that uses it moves with it.
///
/// Armenia is the one country in this package whose civilian plate is printed
/// in **three** colours rather than two. Black on white is the field and the
/// ink; the third is [identifierBand] — the silver strip added beside the flag
/// in the 2014 redesign, which is neither the field nor the ink and so cannot
/// come out of a [PlateTheme.monochrome]. See `ArmeniaThemes`, where exactly
/// one theme is not one.
abstract final class ArmeniaColors {
  /// The white field of a civilian plate, and the white block the flag and `AM`
  /// sit in on the coloured classes. // CALIBRATE
  static const Color field = Color(0xFFFFFFFF);

  /// The near-black the serial, the frame and the `AM` under the flag are
  /// printed in. // CALIBRATE
  static const Color ink = Color(0xFF101010);

  /// The silver identifier band: the holographic strip printed immediately to
  /// the right of the flag block on every plate of the 2014 design.
  ///
  /// It carries the frame's own colour on no plate and the serial's on none
  /// either — it is a security feature, printed in a metallic grey that reads
  /// as neither. That is why it reaches the plate as a [PlateTheme.dividerColor]
  /// and the civilian theme is written out in full. // CALIBRATE
  static const Color identifierBand = Color(0xFFC9CCD1);

  /// Buses: black on yellow, the format Armenia kept from the Soviet
  /// public-transport plate. // CALIBRATE
  static const Color busYellow = Color(0xFFF5C500);
  static const Color onBusYellow = ink;

  /// The diplomatic corps: white on red. // CALIBRATE
  static const Color diplomaticRed = Color(0xFFCC1E3C);
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  /// A United Nations office in Yerevan: white on blue. // CALIBRATE
  static const Color unBlue = Color(0xFF2A5CAA);
  static const Color onUnBlue = Color(0xFFFFFFFF);

  /// The Ministry of Defence: white on black. The one Armenian plate whose
  /// field is darker than its ink. // CALIBRATE
  static const Color militaryBlack = Color(0xFF1A1A1A);
  static const Color onMilitaryBlack = Color(0xFFF2F2F2);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor]. Two of them, because a grey that
  /// reads on a white plate vanishes on a black or a red one.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
