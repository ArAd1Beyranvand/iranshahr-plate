import 'package:core_plate/core_plate.dart';

import 'armenia_alphabets.dart';
import 'armenia_regions.dart';
import 'armenia_special_plates.dart';

/// Validates an Armenian private registration: `NN LL NNN`.
///
/// Three rules, and the middle one is the interesting one:
///
/// 1. **The region code is one Armenia issues** — `01` to `99`, every one of
///    which is allocated to a province or to the individual-plate pool. The
///    table is `ArmeniaRegions`; this only asks it.
/// 2. **The letters are not `G` or `I`.** Both entered use in 2015 for the
///    Police and the Prosecutor's office alone, and only ever doubled as `GG`
///    or `II` on a state number. A private plate carries neither, in a pair or
///    singly — see [ArmeniaAlphabets.stateVehiclesOnly].
/// 3. **The serial is three digits.**
///
/// Optionally it also checks that the letters existed when the plate was
/// issued. Armenia added its letters in batches between 1996 and 2019, and
/// [ArmeniaAlphabets.introduced] has the dates, so a caller who knows the year
/// can have `77 JW 555` called out as impossible in 2015. A caller who does not
/// leaves [issuedYear] null and the check does not run — which is the right
/// default: most of the time all that is known is that the plate is on the road
/// today, and today every letter is legal.
///
/// Advisory, like every validator in this workspace. It never prevents input:
/// it is asked whether a number is well formed and answers, and what the host
/// does with the answer is the host's business.
class ArmeniaPlateValidator extends GatedPlateValidator {
  const ArmeniaPlateValidator({this.issuedYear, this.issuedMonth = 12});

  /// The year the plate was issued, or null to skip the letter-timeline check.
  final int? issuedYear;

  /// The month within [issuedYear]. Defaults to December, so a caller who knows
  /// only the year gets the letters that year ended with.
  final int issuedMonth;

  /// The serial: the last register the user reaches, so by the time it has a
  /// character there is a whole plate to judge.
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

  /// The two digits at the head of a private number.
  ///
  /// Quiet about a code that is not yet two digits: `0` is on its way to `01`,
  /// and flagging it would make the plate flash red at the first keystroke of a
  /// number that is going to be fine.
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

  /// The letter block of a private number: [count] letters, none of them
  /// reserved to the state, and — when [issuedYear] is given — none of them
  /// added after the plate was issued.
  ///
  /// Static and taking a count, because the trailer plate runs the same rules
  /// over one letter instead of two. See `core_plate/CLAUDE.md`: variation is
  /// data.
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

  /// A run of digits of a known length.
  ///
  /// Quiet while the run is still short, for the reason [validateRegion] is:
  /// half a serial is not a wrong serial. Leading zeros are legal — `001` is an
  /// Armenian serial, not a number written badly.
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

/// Validates an Armenian public (state-owned) number: `NNN LL NN`.
///
/// The three digits at the head are an ordinary serial, assigned in increasing
/// order. Everything after them is not: `LL NN` is a reserved combination that
/// names the institution — `NN 01` the Security Council, `GG 01` the General
/// Prosecutor's office, `SS 01`, `SS 02` and `SS 03` three different bodies
/// sharing a letter pair — and the only way to judge it is to look it up. The
/// table is `ArmeniaSpecialPlates`.
///
/// So this validator states one rule that no shape check could: the pair must
/// be on the list. That also means `G` and `I`, which
/// [ArmeniaPlateValidator] rejects outright, are *required* here — doubled, and
/// only over the tails the table gives them.
class ArmeniaPublicPlateValidator extends GatedPlateValidator {
  const ArmeniaPublicPlateValidator();

  /// The tail, which fills last and is half the combination being judged.
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
    if (letters.length < 2 || tail.length < 2)
      return const PlateValidation.valid();
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

/// Validates an Armenian trailer number: `NNN L` over `NN`.
///
/// [ArmeniaPlateValidator]'s letter rules over one letter instead of two — most
/// trailers carry `L`, but the article says the count was cut to one, not that
/// the choice was — plus the two shapes either side of it.
class ArmeniaTrailerPlateValidator extends GatedPlateValidator {
  const ArmeniaTrailerPlateValidator();

  /// The bottom row, which is the last thing on the plate to be filled in.
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

/// Validates an Armenian bus number: `NNNN L`.
///
/// Four digits and a class letter. The letter is the whole classification the
/// format carries — `S` for a city bus, `L` for a long-range coach — and the
/// spec's own alphabet already holds it to those two, so what is left to check
/// is the shape of the digits and that the letter is there at all.
class ArmeniaBusPlateValidator extends GatedPlateValidator {
  const ArmeniaBusPlateValidator();

  /// The class letter, which sits at the tail and fills last.
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

/// Validates an Armenian diplomatic number: `NN L NNN`.
///
/// The leading pair is the mission's country code, not a region code, so
/// [ArmeniaRegions] has nothing to say about it — any two digits are a country
/// somewhere on the list the Ministry of Foreign Affairs keeps, and this
/// package does not ship that list. The class letter is `D` for a diplomat or
/// `T` for a technician.
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

/// Validates an Armenian Ministry of Defence number: `ՊՆ NNNN Մ`.
///
/// Four digits and the vehicle class — `Մ` for a passenger vehicle, `Տ` for a
/// transport one, stored as `M` and `T`. The `ՊՆ` at the head is printed, not
/// entered, so there is nothing here to check about it.
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

/// Validates a number that is nothing but a serial: the UN plate, whose every
/// other character is printed.
///
/// A whole class for one length check, because the alternative is
/// [ArmeniaPlates.validatorFor] returning null for one spec and every caller
/// then handling a nullable validator for the sake of it.
class ArmeniaSerialPlateValidator extends GatedPlateValidator {
  const ArmeniaSerialPlateValidator({required this.length});

  /// How many digits the serial runs to.
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
