import 'package:flutter/widgets.dart';

/// Every colour a Turkish plate is printed in, sampled as the modal pixel of
/// each region of the reference artwork on Wikimedia Commons linked from
/// Wikipedia's "Vehicle registration plates of Turkey". The article's
/// adjectives are not used: its three "green"s sample to three values.
abstract final class TurkeyColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  /// The TR strip and the sample plate's centre band.
  static const Color stripBlue = Color(0xFF003698);

  /// The police field, and the international-organisation plate's ink.
  static const Color blue = Color(0xFF00309A);

  /// The consulate field.
  static const Color green = Color(0xFF1CB24B);

  /// The diplomatic plate's ink.
  static const Color diplomaticGreen = Color(0xFF16B34B);

  /// The temporary customs plate's field and ink.
  static const Color customsGreen = Color(0xFF15B34A);
  static const Color customsRed = Color(0xFFEF0D19);

  /// The provincial-government plate's ink and frame.
  static const Color provincialRed = Color(0xFFEE151F);

  /// The state plates — parliament, governors — gold on red.
  static const Color stateRed = Color(0xFFE30613);
  static const Color gold = Color(0xFFD2AB66);

  /// The temporary plate's field; its diagonal stripe is [white].
  static const Color temporaryYellow = Color(0xFFFFCB03);

  /// Input chrome only: the outline core paints under an empty field.
  static const Color inactiveOnLight = Color(0x66666666);
  static const Color inactiveOnDark = Color(0x66FFFFFF);
}
