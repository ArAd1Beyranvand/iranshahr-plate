import 'package:flutter/widgets.dart';

/// Every colour an Iraqi plate is printed in, in one place.
///
/// Sampled as the modal pixel of the left band and of the ink on the reference
/// artwork for the 2022/2024 series on Wikimedia Commons — the ten
/// `Iraq_-_License_Plate_-_*` and `Iraq_-_Kurdistan_-_License_Plate_-_*` files
/// linked from the colour table in Wikipedia's "Vehicle registration plates of
/// Iraq" — not from the colour names in that table.
///
/// Two things the table's wording hides, and the pixels do not:
///
/// - The colour names the **left band**, not the field. Every class in the
///   current series is black on a white field; only the band changes. A "blue
///   plate" is a white plate with a blue band.
/// - The band letters are black on all six bands, including the red and the
///   blue, where white would be the obvious guess.
abstract final class IraqColors {
  /// The field of every plate in the series, and the band of the private and
  /// temporary classes.
  static const Color field = Color(0xFFFFFFFF);

  /// Glyphs, frame and divider on all five permanent classes.
  static const Color ink = Color(0xFF000000);

  /// Vehicle for hire, bus, taxi.
  static const Color hireBand = Color(0xFFED1C24);

  /// Governmental. A mid azure, not the navy "blue" suggests.
  static const Color governmentBand = Color(0xFF0079C1);

  /// Trade: trucks, tractors, cranes.
  static const Color tradeBand = Color(0xFFFFC913);

  /// Agricultural. A jade green.
  static const Color agriculturalBand = Color(0xFF01A06A);

  /// Temporary plates print in this red throughout — glyphs, frame and
  /// divider — on a white field with a white band. A softer red than
  /// [hireBand]; the two are different inks, not one red used twice.
  static const Color temporaryInk = Color(0xFFD8272D);

  /// Input chrome only: the outline core paints under an empty field. Never
  /// printed — see [PlateTheme.inactiveColor].
  static const Color inactiveOnLight = Color(0x66666666);
}
