import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

import 'kazakhstan_missions.dart';

/// Judges `573 ABX | 15` by its groups `number`, `letters` and `region`.
///
/// Three digits, then [letters] letters (three on private plates, two on
/// non-private), then a two-digit region code 01–20. Gated on the region, so
/// nothing is reported until the plate is complete. Reports, never bars a
/// keystroke.
class KazakhstanValidator extends GatedPlateValidator {
  const KazakhstanValidator({this.letters = 3});

  final int letters;

  @override
  String get gateGroup => 'region';

  static const String reasonNumber = 'The number is three digits.';
  static const String reasonLetters =
      'The serial has the wrong number of letters.';
  static const String reasonRegion = 'The region code is 01 to 20.';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    if (!RegExp('^[A-Z]{$letters}\$').hasMatch(entry.group('letters'))) {
      return const PlateValidation.invalid(reasonLetters);
    }
    if (!KazakhstanAlphabets.regionCodes.contains(entry.group('region'))) {
      return const PlateValidation.invalid(reasonRegion);
    }
    return const PlateValidation.valid();
  }
}

/// Judges the diplomatic plate `D 001 618`: a class letter, a three-digit
/// mission code ([KazakhstanMissions]) and three digits. Refuses `007` on its
/// own account as well as through the spec's restriction, always with
/// [KazakhstanMissions.notFound].
class KazakhstanDiplomaticValidator extends GatedPlateValidator {
  const KazakhstanDiplomaticValidator();

  @override
  String get gateGroup => 'number';

  static const String reasonClass = 'The class is one letter.';
  static const String reasonNumber = 'The number is three digits.';

  @override
  PlateValidation validate(PlateEntry entry) {
    if (KazakhstanMissions.isRefused(entry.group('mission'))) {
      return const PlateValidation.invalid(KazakhstanMissions.notFound);
    }
    return super.validate(entry);
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!RegExp(r'^[A-Z]$').hasMatch(entry.group('class'))) {
      return const PlateValidation.invalid(reasonClass);
    }
    if (KazakhstanMissions.name(entry.group('mission')) == null) {
      return const PlateValidation.invalid(KazakhstanMissions.notFound);
    }
    if (!isDigitsOfLength(entry.group('number'), 3)) {
      return const PlateValidation.invalid(reasonNumber);
    }
    return const PlateValidation.valid();
  }
}
