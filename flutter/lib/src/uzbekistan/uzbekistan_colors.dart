import 'package:flutter/widgets.dart';

/// Every colour sampled from the article's artwork (modal pixel of the field).
abstract final class UzbekistanColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// Foreign companies, diplomatic and consular fields.
  static const Color green = Color(0xFF22B14C);

  /// Foreign citizens.
  static const Color yellow = Color(0xFFFFC913);

  /// United Nations.
  static const Color blue = Color(0xFF3F48CC);

  /// The `UZ` caption, printed in the flag's sky-blue.
  static const Color caption = Color(0xFF0099B5);

  static const Color inactiveOnLight = Color(0xFFB0B0B0);
  static const Color inactiveOnDark = Color(0x80FFFFFF);
}
