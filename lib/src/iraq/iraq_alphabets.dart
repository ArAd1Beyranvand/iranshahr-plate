import 'package:core_plate/core_plate.dart';
import 'package:plate_alphabet/plate_alphabet.dart';

/// Character sets used on Iraqi registration plates.
abstract final class IraqAlphabets {
  /// Western Arabic numerals (0–9).
  static const PlateAlphabet digits = PlateAlphabetDigits.english;

  /// Latin uppercase letters used for vehicle classification.
  static const PlateAlphabet latinLetters = PlateAlphabet(
    id: 'iq.latin.uppercase',
    characters: <String>[
      'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
      'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
      'U', 'V', 'W', 'X', 'Y', 'Z',
    ],
    input: AlphabetInput.typed,
    isNumeric: false,
  );
}
