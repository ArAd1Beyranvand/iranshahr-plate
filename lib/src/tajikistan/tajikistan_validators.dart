import 'package:plate_core/plate_core.dart';

import 'tajikistan_alphabets.dart';
import 'tajikistan_regions.dart';

/// Validates a standard Tajik registration: a serial, a letter group, and a
/// two-digit region code, in whatever order the spec lays them out.
///
/// The three checks are keyed by group name, not by position, so the one class
/// judges every plate whose number is built from those three groups however they
/// are arranged: the car reads `NNNN LL NN`, the trailer `NN LL NNNN`, and both
/// are this validator with the same three keys. What varies between them is data
/// — how long the serial runs, how many letters there are, whether the region is
/// checked at all — and so it is a constructor argument. See
/// `plate_core/CLAUDE.md`: variation is data.
///
/// Advisory, like every validator in this workspace. It never prevents input: it
/// is asked whether a number is well formed and answers, and what the host does
/// with the answer is the host's business.
class TajikistanPlateValidator extends GatedPlateValidator {
  const TajikistanPlateValidator({
    this.serialLength = 4,
    this.letterCount = 2,
    this.checkRegion = true,
    this.gate = 'region',
  });

  /// How many digits the serial group runs to.
  final int serialLength;

  /// How many letters the letter group carries, or zero on a plate that has no
  /// letter group of its own — the public-transport plate, whose `TT` is printed
  /// rather than entered.
  final int letterCount;

  /// Whether the region group is a Tajik region code. False on the plates whose
  /// trailing digits are not a region at all.
  final bool checkRegion;

  /// The group that fills last, and so the one whose completion means there is a
  /// whole plate to judge.
  final String gate;

  @override
  String get gateGroup => gate;

  @override
  PlateValidation judge(PlateEntry entry) {
    if (checkRegion) {
      final region = validateRegion(entry.group('region'));
      if (!region.isValid) return region;
    }
    if (letterCount > 0) {
      final letters = validateLetters(
        entry.group('letters'),
        count: letterCount,
      );
      if (!letters.isValid) return letters;
    }
    return validateSerial(entry.group('serial'), length: serialLength);
  }

  /// The two-digit region code.
  ///
  /// Quiet about a code that is not yet two digits: `0` is on its way to `01`,
  /// and flagging it would make the plate flash red at the first keystroke of a
  /// number that is going to be fine.
  static PlateValidation validateRegion(String region) {
    if (region.length < 2) return const PlateValidation.valid();
    if (!isDigitsOfLength(region, 2)) {
      return const PlateValidation.invalid('A region code is two digits.');
    }
    if (!TajikistanRegions.isIssued(region)) {
      return PlateValidation.invalid(
        '"$region" is not a region code Tajikistan issues.',
      );
    }
    return const PlateValidation.valid();
  }

  /// A group of [count] plate letters, each from [TajikistanAlphabets.letters].
  ///
  /// Static and taking a count, because the motorcycle and police plates run the
  /// same rule over one letter instead of two.
  static PlateValidation validateLetters(String letters, {required int count}) {
    final value = letters.toUpperCase();
    for (final letter in value.split('')) {
      if (!TajikistanAlphabets.letters.characters.contains(letter)) {
        return PlateValidation.invalid('"$letter" is not a plate letter.');
      }
    }
    // Checked last: an in-progress group is short before it is wrong, and
    // reporting the length first would flag every plate halfway through its
    // letters.
    if (value.length > count) {
      return PlateValidation.invalid('The letter group is $count letter(s).');
    }
    return const PlateValidation.valid();
  }

  /// A run of digits of a known length.
  ///
  /// Quiet while the run is still short, for the reason [validateRegion] is: half
  /// a serial is not a wrong serial. Leading zeros are legal — `0776` is a Tajik
  /// serial, not a number written badly.
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

/// Validates a Tajik foreign-vehicle number: `NNN L NNN`.
///
/// A three-digit prefix, a single letter, and a three-digit serial, on a yellow
/// field. There is no region code on this design — a foreign vehicle is not
/// registered to a Tajik region — so [TajikistanRegions] has nothing to say
/// about it, and all three groups are judged on their own shape.
class TajikistanForeignPlateValidator extends GatedPlateValidator {
  const TajikistanForeignPlateValidator();

  @override
  String get gateGroup => 'serial';

  @override
  PlateValidation judge(PlateEntry entry) {
    final prefix = TajikistanPlateValidator.validateSerial(
      entry.group('prefix'),
      length: 3,
    );
    if (!prefix.isValid) return prefix;
    final letter = TajikistanPlateValidator.validateLetters(
      entry.group('letters'),
      count: 1,
    );
    if (!letter.isValid) return letter;
    return TajikistanPlateValidator.validateSerial(
      entry.group('serial'),
      length: 3,
    );
  }
}

/// Validates a Tajik diplomatic number: `NNN [class] N`.
///
/// A three-digit serial, a class code — `CD` for the corps, `CMD` for a head of
/// mission, or one of the graded letters `D`, `T`, `S` — and a single trailing
/// digit. The spec's own alphabet already holds the code to those five, so what
/// is left is the shape of the digits and that the code is one of them.
class TajikistanDiplomaticPlateValidator extends GatedPlateValidator {
  const TajikistanDiplomaticPlateValidator();

  @override
  String get gateGroup => 'tail';

  @override
  PlateValidation judge(PlateEntry entry) {
    final serial = TajikistanPlateValidator.validateSerial(
      entry.group('serial'),
      length: 3,
    );
    if (!serial.isValid) return serial;
    final code = entry.group('class').toUpperCase();
    if (code.isNotEmpty &&
        !TajikistanAlphabets.diplomaticClass.characters.contains(code)) {
      return const PlateValidation.invalid(
        'A diplomatic class is CD, CMD, D, T or S.',
      );
    }
    final tail = entry.group('tail');
    if (tail.isNotEmpty && !isDigits(tail)) {
      return const PlateValidation.invalid(
        'The trailing group must be digits.',
      );
    }
    if (tail.length > 1) {
      return const PlateValidation.invalid('The trailing group is one digit.');
    }
    return const PlateValidation.valid();
  }
}
