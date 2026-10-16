import 'package:plate_core/plate_core.dart';

import 'armenia_alphabets.dart';
import 'armenia_regions.dart';
import 'armenia_special_plates.dart';

/// Validates a private registration, `NN LL NNN`: a region code `ArmeniaRegions`
/// issues, letters that are neither `G` nor `I` (reserved to the state since 2015,
/// see [ArmeniaAlphabets.stateVehiclesOnly]), and a three-digit serial.
///
/// Given [issuedYear], it also checks that the letters existed then
/// ([ArmeniaAlphabets.introduced]); left null the check does not run, since
/// today every letter is legal. Advisory: it never prevents input.
class ArmeniaPlateValidator extends GatedPlateValidator {
  const ArmeniaPlateValidator({this.issuedYear, this.issuedMonth = 12});

  final int? issuedYear;

  /// The month within [issuedYear]; December by default.
  final int issuedMonth;

  @override
  String get gateGroup => 'serial';

  @override
  PlateValidation judge(PlateEntry entry) {
    final region = validateRegion(entry.group('region'));
    if (!region.isValid) return region;

    final letters = validateLetters(
      entry.group('letters'),
      count: 2,
      issuedYear: issuedYear,
      issuedMonth: issuedMonth,
    );
    if (!letters.isValid) return letters;

    return validateSerial(entry.group('serial'), length: 3);
  }

  /// Quiet about a code not yet two digits, so the plate does not flash red at the
  /// first keystroke.
  static PlateValidation validateRegion(String region) {
    if (region.length < 2) return const PlateValidation.valid();
    if (!isDigitsOfLength(region, 2)) {
      return const PlateValidation.invalid('A region code is two digits.');
    }
    if (!ArmeniaRegions.isIssued(region)) {
      return PlateValidation.invalid(
        '"$region" is not a region code Armenia issues.',
      );
    }
    return const PlateValidation.valid();
  }

  /// [count] letters, none reserved to the state, none added after [issuedYear]. Static and taking a count because the trailer runs the same rules over one letter.
  static PlateValidation validateLetters(
    String letters, {
    required int count,
    int? issuedYear,
    int issuedMonth = 12,
  }) {
    final value = letters.toUpperCase();
    for (final letter in value.split('')) {
      if (!ArmeniaAlphabets.letters.characters.contains(letter)) {
        return PlateValidation.invalid('"$letter" is not a plate letter.');
      }
      if (ArmeniaAlphabets.stateVehiclesOnly.contains(letter)) {
        return PlateValidation.invalid(
          '"$letter" is issued to the Police and the Prosecutor\'s office only.',
        );
      }
      if (issuedYear != null &&
          !ArmeniaAlphabets.inUseOn(letter, issuedYear, month: issuedMonth)) {
        return PlateValidation.invalid(
          '"$letter" was not being issued in $issuedYear.',
        );
      }
    }
    // Checked last: an in-progress block is short before it is wrong, and
    // reporting the length first would flag every plate halfway through its
    // letters.
    if (value.length > count) {
      return PlateValidation.invalid('The letter block is $count letter(s).');
    }
    return const PlateValidation.valid();
  }

  /// A run of digits of a known length; quiet while short. Leading zeros are legal.
  static PlateValidation validateSerial(String serial, {required int length}) {
    if (serial.isNotEmpty && !isDigits(serial)) {
      return const PlateValidation.invalid('The serial must be digits.');
    }
    if (serial.length > length) {
      return PlateValidation.invalid('The serial is $length digits.');
    }
    return const PlateValidation.valid();
  }
}

/// Validates a state number, `NNN LL NN`. The `LL NN` tail is a reserved
/// combination naming an institution, judged against `ArmeniaSpecialPlates`; the
/// pair must be on the list. So `G` and `I`, rejected by [ArmeniaPlateValidator],
/// are required here, doubled and only over the tails the table gives them.
class ArmeniaPublicPlateValidator extends GatedPlateValidator {
  const ArmeniaPublicPlateValidator();

  @override
  String get gateGroup => 'tail';

  @override
  PlateValidation judge(PlateEntry entry) {
    final serial = ArmeniaPlateValidator.validateSerial(
      entry.group('serial'),
      length: 3,
    );
    if (!serial.isValid) return serial;

    final letters = entry.group('letters').toUpperCase();
    final tail = entry.group('tail');
    // Quiet until both halves are there: a combination is a pair of letters and
    // a pair of digits, and three quarters of one matches nothing.
    if (letters.length < 2 || tail.length < 2) {
      return const PlateValidation.valid();
    }
    if (!isDigitsOfLength(tail, 2)) {
      return const PlateValidation.invalid('The last group is two digits.');
    }
    if (ArmeniaSpecialPlates.lookup(letters, tail) == null) {
      return PlateValidation.invalid(
        '"$letters $tail" is not a combination issued to any institution.',
      );
    }
    return const PlateValidation.valid();
  }
}

/// Validates a trailer number, `NNN L` over `NN`: [ArmeniaPlateValidator]'s letter rules over one letter.
class ArmeniaTrailerPlateValidator extends GatedPlateValidator {
  const ArmeniaTrailerPlateValidator();

  @override
  String get gateGroup => 'tail';

  @override
  PlateValidation judge(PlateEntry entry) {
    final serial = ArmeniaPlateValidator.validateSerial(
      entry.group('serial'),
      length: 3,
    );
    if (!serial.isValid) return serial;

    final letters = ArmeniaPlateValidator.validateLetters(
      entry.group('letters'),
      count: 1,
    );
    if (!letters.isValid) return letters;

    final tail = entry.group('tail');
    if (tail.isNotEmpty && !isDigits(tail)) {
      return const PlateValidation.invalid('The bottom row must be digits.');
    }
    if (tail.length > 2) {
      return const PlateValidation.invalid('The bottom row is two digits.');
    }
    return const PlateValidation.valid();
  }
}

/// Validates a bus number, `NNNN L`; the spec's alphabet already restricts the class letter.
class ArmeniaBusPlateValidator extends GatedPlateValidator {
  const ArmeniaBusPlateValidator();

  @override
  String get gateGroup => 'class';

  @override
  PlateValidation judge(PlateEntry entry) {
    final serial = entry.group('serial');
    if (!isDigitsOfLength(serial, 4)) {
      return const PlateValidation.invalid('A bus number is four digits.');
    }
    if (!ArmeniaAlphabets.busClass.characters.contains(
      entry.group('class').toUpperCase(),
    )) {
      return const PlateValidation.invalid(
        'A bus is "S" (city) or "L" (long-range).',
      );
    }
    return const PlateValidation.valid();
  }
}

/// Validates a diplomatic number, `NN L NNN`. The leading pair is the mission's
/// country code, not a region, and no country list is shipped; the class letter
/// is `D` or `T`.
class ArmeniaDiplomaticPlateValidator extends GatedPlateValidator {
  const ArmeniaDiplomaticPlateValidator();

  @override
  String get gateGroup => 'serial';

  @override
  PlateValidation judge(PlateEntry entry) {
    final mission = entry.group('mission');
    if (mission.length == 2 && !isDigitsOfLength(mission, 2)) {
      return const PlateValidation.invalid('A mission code is two digits.');
    }
    if (!ArmeniaAlphabets.diplomaticClass.characters.contains(
      entry.group('class').toUpperCase(),
    )) {
      return const PlateValidation.invalid(
        'A diplomatic plate is "D" (diplomat) or "T" (technician).',
      );
    }
    return ArmeniaPlateValidator.validateSerial(
      entry.group('serial'),
      length: 3,
    );
  }
}

/// Validates a Ministry of Defence number, `ՊՆ NNNN Մ`; the class is `Մ` or `Տ`, stored as `M` and `T`.
class ArmeniaMilitaryPlateValidator extends GatedPlateValidator {
  const ArmeniaMilitaryPlateValidator();

  @override
  String get gateGroup => 'class';

  @override
  PlateValidation judge(PlateEntry entry) {
    if (!isDigitsOfLength(entry.group('serial'), 4)) {
      return const PlateValidation.invalid('A military number is four digits.');
    }
    if (!ArmeniaAlphabets.militaryClass.characters.contains(
      entry.group('class').toUpperCase(),
    )) {
      return const PlateValidation.invalid(
        'A military plate is "Մ" (passenger) or "Տ" (transport).',
      );
    }
    return const PlateValidation.valid();
  }
}

/// Validates the UN plate, whose every character but the serial is printed. A
/// class rather than a null from [ArmeniaPlates.validatorFor].
class ArmeniaSerialPlateValidator extends GatedPlateValidator {
  const ArmeniaSerialPlateValidator({required this.length});

  final int length;

  @override
  String get gateGroup => 'serial';

  @override
  PlateValidation judge(PlateEntry entry) =>
      ArmeniaPlateValidator.validateSerial(
        entry.group('serial'),
        length: length,
      );
}
