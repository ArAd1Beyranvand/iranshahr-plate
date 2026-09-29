import 'package:flutter/widgets.dart';

/// Every colour a Kuwaiti plate is printed in, in one place.
///
/// Sourced from the "Vehicle types" table on Wikipedia's
/// "Vehicle registration plates of Kuwait", which gives each category as
/// `text colour on field colour`. Move the value here and every spec and
/// theme that uses it moves with it.
abstract final class KuwaitColors {
  /// Black text/frame, used on every field except the black-background ones.
  static const Color darkInk = Color(0xFF000000);

  /// White text, used on the black-background fields.
  static const Color whiteText = Color(0xFFFFFFFF);

  /// The white field: private, motorcycle, and diplomatic (blue text) plates.
  static const Color civField = Color(0xFFFFFFFF);

  /// The yellow field: public transport plates. Also the text colour on the
  /// national guard's green field.
  static const Color transField = Color(0xFFFFD700);

  /// The black field: police and police motorcycle plates (white text).
  static const Color policeField = Color(0xFF000000);

  /// The blue field: government (black text), Emiri Bureau, and Emiri Guard
  /// (white text) plates. Also the text colour on diplomatic's white field.
  static const Color govField = Color(0xFF0033CC);

  /// The green field: national guard plates (yellow text).
  static const Color guardField = Color(0xFF008000);

  /// The orange field: construction plates (black text).
  static const Color constructField = Color(0xFFFF6600);

  /// The pink field: commercial plates (black text).
  static const Color commField = Color(0xFFFF1493);

  /// The red field: firefighting plates (black text). Also the diplomatic
  /// plate's bottom band.
  static const Color fireField = Color(0xFFFF0000);

  /// The purple field: temporary customs plates (black text).
  static const Color customsField = Color(0xFF9400D3);

  /// The green field: export plates (black text). A distinct shade from the
  /// national guard's green.
  static const Color exportField = Color(0xFF228B22);

  /// The beige field: army plates (black text).
  static const Color armyField = Color(0xFFD2B48C);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor].
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x66FFFFFF);
}
