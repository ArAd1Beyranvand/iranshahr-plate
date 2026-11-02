import 'package:flutter/widgets.dart';

/// Sampled from the flats of `.plateref/tm` (modal colour of each field and
/// ink), not read from the article's adjectives.
abstract final class TurkmenistanColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The flag's green as the plates print it (the Commons SVG's 00843D is
  /// darker), also the field of the green government plates.
  static const Color green = Color(0xFF28AE66);

  /// Foreign and export plates: black on an amber.
  static const Color yellow = Color(0xFFFFC913);

  static const Color diplomaticBlue = Color(0xFF003399);

  /// The 1994 plate is photographed, so its field is a cool off-white and its
  /// ink a dark slate rather than black.
  static const Color classicField = Color(0xFFF2F2F5);
  static const Color classicInk = Color(0xFF343C44);

  static const Color inactive = Color(0xFFB0B0B0);
}
