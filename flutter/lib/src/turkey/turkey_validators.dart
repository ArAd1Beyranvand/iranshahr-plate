import 'package:plate_core/plate_core.dart';

import 'turkey_alphabets.dart';

// TODO(py): [D4-code] hand-port; reason strings are the contract, keep them byte-identical.
// TODO(ts): [D4-code] hand-port; reason strings are the contract, keep them byte-identical.
// TODO(kt): [D4-code] hand-port; reason strings are the contract, keep them byte-identical.
/// What a Turkish registration may contain, as description rather than
/// restriction: it reports on a value, it does not bar it from being typed.
/// Transcribed from Wikipedia's "Vehicle registration plates of Turkey".
///
/// - `province`: 01 to 81, the province of the holder's residence.
/// - `letters`: one to three of [TurkeyAlphabets.letters]; a class's letters
///   (`CD`, `CC`, `GMR`, `J`, ...) set its livery, see `TurkeyThemes.byLetters`.
/// - `serial`: figures. On a general-issue plate letters and figures together
///   number at most six ([maxLettersAndDigits]); the police, gendarmerie and
///   coast-guard formats exceed that, so they pass `limitSix: false`.
///
/// Diplomatic plates have been numbered at random since 2004, so no code here
/// identifies a mission.
class TurkeyPlateValidator extends PlateValidator {
  const TurkeyPlateValidator({this.limitSix = true});

  /// Whether letters and figures may number at most [maxLettersAndDigits].
  final bool limitSix;

  static const int maxLettersAndDigits = 6;

  static const TurkeyPlateValidator general = TurkeyPlateValidator();
  static const TurkeyPlateValidator police = TurkeyPlateValidator(
    limitSix: false,
  );

  /// Whether [code] is one of the 81 province codes, `01` to `81`.
  static bool isProvince(String code) {
    if (!isDigitsOfLength(code, 2)) return false;
    final n = int.parse(code);
    return n >= 1 && n <= 81;
  }

  /// Whether every character of [letters] is a plate letter.
  static bool isLetters(String letters) =>
      letters.isNotEmpty &&
      letters.split('').every(TurkeyAlphabets.letters.characters.contains);

  @override
  PlateValidation validate(PlateEntry entry) {
    final province = entry.group('province');
    final letters = entry.group('letters');
    final serial = entry.group('serial');
    if (province.isNotEmpty && !isProvince(province)) {
      return const PlateValidation.invalid('Province code must be 01 to 81');
    }
    final hasLetters = entry.spec.indicesOfGroup('letters').isNotEmpty;
    if (hasLetters && letters.isNotEmpty && !isLetters(letters)) {
      return const PlateValidation.invalid('Letters exclude Ç Ş İ Ö Ü Ğ Q W X');
    }
    if (serial.isNotEmpty && !isDigits(serial)) {
      return const PlateValidation.invalid('Serial must be figures');
    }
    if (limitSix &&
        hasLetters &&
        letters.length + serial.length > maxLettersAndDigits) {
      return const PlateValidation.invalid(
        'Letters and figures number at most six',
      );
    }
    return const PlateValidation.valid();
  }
}
