import 'package:plate_alphabet/plate_alphabet.dart';
import 'package:plate_core/plate_core.dart';

/// One register of a Turkmen serial: [length] digits or Latin capitals, and
/// when [allowed] is set, one of those values.
final class TurkmenistanPart {
  const TurkmenistanPart(this.group, this.length, {this.digits = false, this.allowed});

  final String group;
  final int length;
  final bool digits;
  final List<String>? allowed;

  bool accepts(String value) {
    final String kind = digits ? '[0-9]' : '[A-Z]';
    if (!RegExp('^$kind{$length}\$').hasMatch(value)) return false;
    return allowed == null || allowed!.contains(value);
  }

  String get reason {
    if (allowed != null) {
      return 'The $group is one of ${allowed!.join(', ')}.';
    }
    return 'The $group is $length ${digits ? 'digits' : 'letters'}.';
  }
}

/// Judges a Turkmen serial register by register. Reports, never bars a
/// keystroke; gated on the last register, so nothing is said until the serial
/// is started.
///
/// The default is the private plate `AT 0123 AG`: two series letters, four
/// digits and a province code. The article states the province codes (AG, AH,
/// AK, BN, DZ, LB, MR) only for that plate, the 1994 series and the trailer's
/// closing pair; every other letter position is unrestricted there.
class TurkmenistanValidator extends GatedPlateValidator {
  const TurkmenistanValidator({this.parts = _private});

  final List<TurkmenistanPart> parts;

  static const TurkmenistanPart _province = TurkmenistanPart(
    'region',
    2,
    allowed: TurkmenistanAlphabets.provinceCodes,
  );

  static const List<TurkmenistanPart> _private = <TurkmenistanPart>[
    TurkmenistanPart('series', 2),
    TurkmenistanPart('number', 4, digits: true),
    _province,
  ];

  /// `N 29 38 LB`, the 1994 plate.
  static const TurkmenistanValidator classic = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('series', 1),
      TurkmenistanPart('first', 2, digits: true),
      TurkmenistanPart('second', 2, digits: true),
      _province,
    ],
  );

  /// `AG 0123 TR`.
  static const TurkmenistanValidator trailer = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('series', 2),
      TurkmenistanPart('number', 4, digits: true),
      TurkmenistanPart('letters', 2),
    ],
  );

  /// `1 H 01234`: a digit, `H`, five digits.
  static const TurkmenistanValidator foreign = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('class', 1, digits: true),
      TurkmenistanPart('letter', 1, allowed: <String>['H']),
      TurkmenistanPart('number', 5, digits: true),
    ],
  );

  /// `1 HT 2345`: a digit, `HT`, four digits.
  static const TurkmenistanValidator foreignTrailer = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('class', 1, digits: true),
      TurkmenistanPart('letters', 2, allowed: <String>['HT']),
      TurkmenistanPart('number', 4, digits: true),
    ],
  );

  /// `TDG 0123`.
  static const TurkmenistanValidator export = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('letters', 3),
      TurkmenistanPart('number', 4, digits: true),
    ],
  );

  /// `01 CD 234`: embassy code, `CD`, serial.
  static const TurkmenistanValidator diplomatic = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('embassy', 2, digits: true),
      TurkmenistanPart('letters', 2, allowed: <String>['CD']),
      TurkmenistanPart('number', 3, digits: true),
    ],
  );

  /// `0123 AGA`.
  static const TurkmenistanValidator government = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('number', 4, digits: true),
      TurkmenistanPart('letters', 3),
    ],
  );

  /// `01 23 GM`.
  static const TurkmenistanValidator military = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('number', 4, digits: true),
      TurkmenistanPart('letters', 2),
    ],
  );

  /// `DABARA 1`: the article gives no format; the picture shows six letters
  /// and a digit.
  static const TurkmenistanValidator ceremony = TurkmenistanValidator(
    parts: <TurkmenistanPart>[
      TurkmenistanPart('letters', 6),
      TurkmenistanPart('number', 1, digits: true),
    ],
  );

  @override
  String get gateGroup => parts.last.group;

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final TurkmenistanPart part in parts) {
      if (!part.accepts(entry.group(part.group))) {
        return PlateValidation.invalid(part.reason);
      }
    }
    return const PlateValidation.valid();
  }
}
