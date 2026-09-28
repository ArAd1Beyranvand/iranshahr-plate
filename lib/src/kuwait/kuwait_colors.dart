import 'package:flutter/widgets.dart';

/// Every colour a Kuwaiti plate is printed in, in one place.
///
/// All of these are sampled by eye from plate photographs and official
/// specifications rather than from a printing standard, so each is a calibration
/// target: move the value here and every spec and theme that uses it moves with
/// it.
abstract final class KuwaitColors {
  /// The digits and frame on civilian plates. // CALIBRATE
  static const Color darkInk = Color(0xFF000000);

  /// The white field for civilian plates.
  static const Color civField = Color(0xFFFFFFFF);

  /// The yellow field for public transport plates.
  static const Color transField = Color(0xFFFFD700);

  /// The red field for police plates.
  static const Color policeField = Color(0xFFCC0000);

  /// The blue field for government and diplomatic plates.
  static const Color govField = Color(0xFF0033CC);

  /// White text for police and diplomatic plates. // CALIBRATE
  static const Color whiteText = Color(0xFFFFFFFF);

  /// Green field for national guard plates.
  static const Color guardField = Color(0xFF008000);

  /// Orange field for construction plates.
  static const Color constructField = Color(0xFFFF6600);

  /// Pink field for commercial plates.
  static const Color commField = Color(0xFFFF1493);

  /// Red field for firefighting plates.
  static const Color fireField = Color(0xFFFF0000);

  /// Purple field for temporary customs plates.
  static const Color customsField = Color(0xFF9400D3);

  /// Green field for export plates.
  static const Color exportField = Color(0xFF228B22);

  /// Beige/tan field for army plates.
  static const Color armyField = Color(0xFFD2B48C);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor].
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x66FFFFFF);
}
