import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// The Omani alphabets, defined in `plate_alphabet`. Digits are Western.
abstract final class OmanAlphabets {
  static const PlateAlphabet digits = PlateAlphabetDigits.english;
  static const PlateAlphabet letters = PlateAlphabetOman.letters;
  static const PlateAlphabet lettersArabic = PlateAlphabetOman.arabic;
}
