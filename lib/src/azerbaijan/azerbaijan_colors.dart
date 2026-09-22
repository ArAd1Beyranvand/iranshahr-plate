import 'package:flutter/widgets.dart';

/// Every colour an Azerbaijani plate is printed in, in one place.
///
/// All of these are sampled by eye from plate photographs rather than from a
/// printing standard, so each is a calibration target: move the value here and
/// every theme that uses it moves with it.
///
/// They come in pairs — a field and the ink printed on it — because every
/// Azerbaijani design is one ink on one field. There is no third colour on any
/// of them: no divider, no security band, no second ink for a caption. See
/// `AzerbaijanThemes`, every one of which is a [PlateTheme.monochrome].
abstract final class AzerbaijanColors {
  /// The white field of a civilian plate, and the white block the flag and
  /// `AZ` sit in on every other class. // CALIBRATE
  static const Color field = Color(0xFFFFFFFF);

  /// The near-black the civilian serial, its hyphens and its frame are printed
  /// in — and the `AZ` under the flag on every class, because the block under
  /// it is [field] whatever the plate is. // CALIBRATE
  static const Color ink = Color(0xFF101010);

  /// Privately owned public transport — a bus or a taxi: white on blue.
  /// // CALIBRATE
  static const Color transportBlue = Color(0xFF2C6EB5);
  static const Color onTransportBlue = Color(0xFFFFFFFF);

  /// The diplomatic corps: white on red. // CALIBRATE
  static const Color diplomaticRed = Color(0xFFC8102E);
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  /// A foreign-owned company: black on yellow. The one coloured design printed
  /// in the same ink as a civilian plate. // CALIBRATE
  static const Color foreignYellow = Color(0xFFF2C200);
  static const Color onForeignYellow = ink;

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor]. Two of them, because a grey that
  /// reads on a white plate vanishes on a blue or a red one.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
