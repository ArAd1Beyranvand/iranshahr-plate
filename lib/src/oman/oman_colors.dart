import 'package:flutter/widgets.dart';

/// Every colour sampled from the pixels of the article's artwork
/// (`Оман1.gif`, `Оман2.gif`): the modal colour of each field and ink.
abstract final class OmanColors {
  /// Private field and the taxi ink, `Оман1.gif`.
  static const Color yellow = Color(0xFFFED800);

  /// Private ink and frame.
  static const Color black = Color(0xFF000000);

  /// Taxi field, `Оман2.gif`. Pure red, not the orange-red the article's
  /// "red" might suggest.
  static const Color red = Color(0xFFFF0000);

  /// Taxi ink and frame.
  static const Color white = Color(0xFFFFFFFF);

  /// Shown on a red field, where the default alert colour would vanish.
  static const Color alertOnRed = Color(0xFF1A1A1A);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0x80FFFFFF);
}
