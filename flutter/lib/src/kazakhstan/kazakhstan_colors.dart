import 'package:flutter/widgets.dart';

/// Sampled from `.plateref/kz/flat__2012-01.png` (modal colour of each
/// region), not read from the article's adjectives.
abstract final class KazakhstanColors {
  static const Color white = Color(0xFFFEFEFE);
  static const Color black = Color(0xFF000000);
  static const Color flagBlue = Color(0xFF00AFCA);

  /// Diplomatic field, sampled from `.plateref/kz/diplomatic.png` (a photo,
  /// so glare skews it): mean of three unlit patches (254, 95, 13), an
  /// orange-red.
  static const Color diplomaticOrange = Color(0xFFFE5F0D);

  static const Color inactive = Color(0xFFB0B0B0);
}
