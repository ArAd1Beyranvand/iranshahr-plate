import 'package:flutter/widgets.dart';

/// Every colour a UAE plate is printed in, sampled from the reference artwork
/// on Wikimedia Commons linked from Wikipedia's "Vehicle registration plates
/// of the United Arab Emirates". The private plates of all seven emirates are
/// pure black on pure white; Abu Dhabi alone adds its red.
abstract final class UaeColors {
  static const Color field = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF000000);

  /// Abu Dhabi's code panel: the left strip of the long plate, the top band of
  /// the short one. The code and captions on it are printed in [field].
  static const Color abuDhabiRed = Color(0xFFD10101);

  /// Input chrome only: the outline core paints under an empty field.
  static const Color inactiveOnLight = Color(0x66666666);
}
