import 'package:flutter/widgets.dart';

/// Every colour a Kuwaiti plate is printed in, in one place.
///
/// Values are sampled from the reference plate artwork on Wikimedia Commons
/// linked from Wikipedia's "Vehicle registration plates of Kuwait", not from
/// the prose colour names in that article's table — "orange", "green" and
/// "red" name three shades the artwork does not agree on.
abstract final class KuwaitColors {
  /// The near-black the 2024 artwork prints in. Not pure black: the reference
  /// files use this single ink for glyphs, rules and frames alike.
  static const Color darkInk = Color(0xFF1D1D1B);

  static const Color whiteText = Color(0xFFFFFFFF);

  /// Private, motorcycle and diplomatic plates.
  static const Color civField = Color(0xFFFFFFFF);

  /// Public transport (codes 90-99). Also the national guard's ink.
  static const Color transField = Color(0xFFFFEC00);

  /// Police and police motorcycle. Shares [darkInk] so the frame vanishes into
  /// the field, exactly as the reference shows.
  static const Color policeField = Color(0xFF1D1D1B);

  /// Government. Also the diplomatic plate's ink and frame.
  static const Color govField = Color(0xFF0079C1);

  /// National guard — a teal, distinctly bluer than [exportField].
  static const Color guardField = Color(0xFF008C7B);

  /// Construction. A red-orange, not the pure orange the article's table names.
  static const Color constructField = Color(0xFFE84433);

  static const Color commField = Color(0xFFF473B1);

  /// General firefighting, sampled from the photographed plate.
  static const Color fireField = Color(0xFFFF4401);

  /// The diplomatic plate's bottom band. A pure signal red, unlike
  /// [fireField].
  static const Color diplomaticBand = Color(0xFFED1C24);

  static const Color customsField = Color(0xFFCA98EA);

  static const Color exportField = Color(0xFF41AD59);

  static const Color armyField = Color(0xFFB3A58E);

  /// Emiri Bureau — a brighter azure than [govField].
  static const Color emiriField = Color(0xFF0778E8);

  /// Emiri Guard, sampled from the photographed plate: a deep navy, and the
  /// one Kuwaiti blue that is neither [govField] nor [emiriField].
  static const Color emiriGuardField = Color(0xFF234691);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor].
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x66FFFFFF);
}
