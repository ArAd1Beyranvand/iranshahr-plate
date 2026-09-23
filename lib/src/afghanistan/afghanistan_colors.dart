import 'package:flutter/widgets.dart';

/// Every colour an Afghan plate is printed in, in one place.
///
/// Sampled by eye from the plate photographs on Wikipedia rather than from a
/// printing standard, so each is a calibration target: move the value here and
/// every theme that uses it moves with it.
///
/// Like Azerbaijan's, these come in field-and-ink pairs, because an Afghan
/// plate is one ink on one field. There is one exception and it is the reason
/// [temporaryRed] exists on its own: the temporary plate prints `موقت` and
/// `TEMP` in red on a plate that is otherwise black on white, so red is a
/// second ink on one design rather than the ink of a design.
abstract final class AfghanistanColors {
  /// The white field of a private, lorry, motorcycle, rickshaw, duplicate or
  /// temporary plate. // CALIBRATE
  static const Color field = Color(0xFFFFFFFF);

  /// The near-black the serial, the class letters, the province code and the
  /// frame are printed in on a white or yellow field. // CALIBRATE
  static const Color ink = Color(0xFF0D0D0D);

  /// Buses and taxis: black on yellow. The two classes share a field and are
  /// told apart by their class letter — `ب`/`B` against `ت`/`T`. // CALIBRATE
  static const Color transportYellow = Color(0xFFF5C518);
  static const Color onTransportYellow = ink;

  /// The diplomatic corps: white on red, and the one Afghan design whose
  /// number is hyphenated. // CALIBRATE
  static const Color diplomaticRed = Color(0xFFE01B1B);
  static const Color onDiplomaticRed = Color(0xFFFFFFFF);

  /// Government vehicles: white on black. // CALIBRATE
  static const Color governmentalBlack = Color(0xFF0A0A0A);
  static const Color onGovernmentalBlack = Color(0xFFFFFFFF);

  /// United Nations vehicles: black on the UN's own blue. // CALIBRATE
  static const Color unBlue = Color(0xFF5B9BD5);
  static const Color onUnBlue = ink;

  /// The red `موقت` / `TEMP` on the temporary plate — a second ink on a plate
  /// printed in [ink], not a plate printed in red. It is passed to the
  /// individual [PlateLabel]s that need it and never to a theme, which carries
  /// one ink and would recolour the serial along with the wording.
  /// // CALIBRATE
  static const Color temporaryRed = Color(0xFFE01B1B);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor]. Two of them, because a grey that
  /// reads on a white plate vanishes on a red or a black one.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x99FFFFFF);
}
