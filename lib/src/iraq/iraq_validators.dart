import 'iraq_country.dart';

/// What an Iraqi registration may contain, as description rather than
/// restriction: these report on a value, they do not bar it from being typed.
///
/// The current series is `GG X #####` — a governorate code from
/// [IraqGovernorates.byCode], one class letter, and a five-digit serial. The
/// article gives the format as four digits, but every reference plate in it,
/// in both regional designs and both sizes, prints five; the five-digit
/// transition rules below assume five as well.
abstract final class IraqValidators {
  static const int serialLength = 5;

  /// The 17 letters the 2008-2024 Arabic series used, with the Arabic letter
  /// each transliterates. Recorded because the article tabulates it, and
  /// because plates issued under it keep their letter through the transition —
  /// not as a constraint on new registrations, which the current series does
  /// not publish a set for and which the reference artwork ("G") falls
  /// outside.
  static const Map<String, String> arabicSeriesLetters = <String, String>{
    'A': 'ا',
    'B': 'ب',
    'J': 'ج',
    'D': 'د',
    'R': 'ر',
    'S': 'س',
    'T': 'ط',
    'F': 'ف',
    'K': 'ك',
    'M': 'م',
    'N': 'ن',
    'H': 'هـ',
    'E': 'ى',
    'Q': 'ق',
    'L': 'ل',
    'W': 'و',
    'Z': 'ز',
  };

  /// Whether [code] is one of the nineteen governorate codes, 11 to 29.
  static bool isGovernorate(String code) =>
      IraqGovernorates.byCode.containsKey(code);

  /// Whether [letter] is a single Latin capital.
  static bool isClassLetter(String letter) =>
      letter.length == 1 && _isUpperLatin(letter.codeUnitAt(0));

  /// Whether [serial] is exactly [serialLength] western Arabic numerals.
  static bool isSerial(String serial) =>
      serial.length == serialLength && serial.codeUnits.every(_isDigit);

  /// Whether [year] is the two-digit expiry a temporary plate carries.
  static bool isExpiryYear(String year) =>
      year.length == 2 && year.codeUnits.every(_isDigit);

  /// The letter the Kurdistan Region's transition rules assign to an existing
  /// registration [number], or null if [number] is not one they cover.
  ///
  /// Kurdistan registrations changed letter-digit shape in the move to the
  /// current series, and the article fixes how an old number maps onto a new
  /// one:
  ///
  /// - five digits or fewer: letter `A`, left-padded with zeros to five
  /// - exactly `100000`, `200000` … `900000`: letter `M`, one zero dropped
  /// - any other six-digit number: the first digit selects the letter, `0`
  ///   giving `B`, `1` giving `C`, and so on up to `9` giving `L`
  ///
  /// Returns the `(letter, serial)` the new plate prints. The rest of Iraq has
  /// no equivalent rule: its registrations already carried a Latin letter and
  /// digits, and only the governorate name changed to a code.
  static (String letter, String serial)? kurdistanTransition(String number) {
    if (number.isEmpty || !number.codeUnits.every(_isDigit)) return null;
    if (number.length <= serialLength) {
      return ('A', number.padLeft(serialLength, '0'));
    }
    if (number.length != 6) return null;
    if (number.endsWith('00000') && number[0] != '0') {
      return ('M', number.substring(0, serialLength));
    }
    final letter = String.fromCharCode(
      'B'.codeUnitAt(0) + (number.codeUnitAt(0) - _zero),
    );
    return (letter, number.substring(1));
  }

  static const int _zero = 0x30;

  static bool _isDigit(int c) => c >= _zero && c <= 0x39;

  static bool _isUpperLatin(int c) => c >= 0x41 && c <= 0x5A;
}
