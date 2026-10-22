/// What a UAE registration may contain, per emirate, as description rather
/// than restriction: these report on a value, they do not bar it from being
/// typed. Transcribed from Wikipedia's "Vehicle registration plates of the
/// United Arab Emirates".
///
/// Every emirate prints a serial of up to five digits after its code. Abu
/// Dhabi's and Sharjah's codes are numbers; the other five use a letter.
abstract final class UaeValidators {
  static const int maxSerialLength = 5;

  /// Abu Dhabi's numeric codes: 1, 4 to 22, and 50.
  static bool isAbuDhabiCode(String code) {
    final n = int.tryParse(code);
    if (n == null || code != '$n') return false;
    return n == 1 || (n >= 4 && n <= 22) || n == 50;
  }

  /// Sharjah's code, 1 to 4, which a plate may also omit.
  static bool isSharjahCode(String code) =>
      code.isEmpty || const <String>{'1', '2', '3', '4'}.contains(code);

  static const Set<String> ajmanLetters = <String>{'A', 'B', 'C', 'D', 'E', 'H'};
  static const Set<String> fujairahLetters = <String>{
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'K',
    'M',
    'P',
    'R',
    'S',
    'T',
  };
  static const Set<String> rasAlKhaimahLetters = <String>{
    'A',
    'C',
    'D',
    'I',
    'K',
    'M',
    'N',
    'S',
    'V',
    'Y',
  };
  static const Set<String> ummAlQuwainLetters = <String>{
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'X',
  };

  /// Dubai: any single letter, or one of the five doubled ones the article
  /// lists. The specs print a single letter only.
  static bool isDubaiCode(String code) =>
      (code.length == 1 && _isUpperLatin(code.codeUnitAt(0))) ||
      const <String>{'AA', 'BB', 'CC', 'DD', 'EE'}.contains(code);

  /// Whether [serial] is one to [maxSerialLength] western Arabic numerals.
  static bool isSerial(String serial) =>
      serial.isNotEmpty &&
      serial.length <= maxSerialLength &&
      serial.codeUnits.every((c) => c >= 0x30 && c <= 0x39);

  static bool _isUpperLatin(int c) => c >= 0x41 && c <= 0x5A;
}
