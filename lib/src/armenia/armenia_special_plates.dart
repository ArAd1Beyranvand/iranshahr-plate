import 'package:flutter/foundation.dart';

/// A reserved letter pair and tail that names an institution on a public
/// number (`### LL ##`). Membership in the table, not shape, makes the number
/// valid: `001 NN 01` is a Security Council car, `001 NN 02` is not a plate.
@immutable
class ArmeniaSpecialCombination {
  const ArmeniaSpecialCombination({
    required this.institution,
    required this.armenianLetters,
    required this.letters,
    required this.tails,
  });

  /// The body the number belongs to, in English.
  final String institution;

  /// The pair as Armenian reads it, e.g. `ՕՏ`. Recorded even where it equals
  /// [letters], so the field is never missing.
  final String armenianLetters;

  /// The pair as the letter register stores it, or null when it cannot be
  /// written there: the Police's `ՈՍ`, whose `Ո` has no Latin key. A null row is
  /// listed because it is on the road, but [lookup] never returns it.
  final String? letters;

  /// The two-digit tails issued, or null when any digits are legal.
  final Set<String>? tails;

  /// Case-insensitive on the letters; a null [letters] matches nothing.
  bool matches(String letters, String tail) {
    final mine = this.letters;
    if (mine == null || mine != letters.toUpperCase()) return false;
    return tails == null || tails!.contains(tail);
  }
}

/// The table of reserved combinations. `final`, not `const`: the ranged rows
/// are built by [_tails], which a `const` initialiser cannot run.
abstract final class ArmeniaSpecialPlates {
  /// [from] to [to] inclusive, zero-padded to two digits.
  static Set<String> _tails(int from, int to) => <String>{
    for (var n = from; n <= to; n++) n.toString().padLeft(2, '0'),
  };

  /// One row per combination, not per institution: `SS` is shared by three
  /// bodies told apart by their tails.
  static final List<ArmeniaSpecialCombination> all = List<ArmeniaSpecialCombination>.unmodifiable(
    <ArmeniaSpecialCombination>[
      const ArmeniaSpecialCombination(
        institution: 'Constitutional Court',
        armenianLetters: 'ՕՏ',
        letters: 'OS',
        tails: <String>{'01'},
      ),
      const ArmeniaSpecialCombination(
        institution: 'Presidential Administration',
        armenianLetters: 'ՍՍ',
        letters: 'UU',
        tails: <String>{'01'},
      ),
      ArmeniaSpecialCombination(
        institution: 'National Assembly',
        armenianLetters: 'ՕՕ',
        letters: 'OO',
        tails: _tails(1, 11),
      ),
      const ArmeniaSpecialCombination(
        institution: 'Government',
        armenianLetters: 'FF',
        letters: 'FF',
        tails: <String>{'01'},
      ),
      const ArmeniaSpecialCombination(
        institution: 'Government',
        armenianLetters: 'LL',
        letters: 'LL',
        tails: <String>{'03', '50', '55', '60', '70'},
      ),
      const ArmeniaSpecialCombination(
        institution: 'Government',
        armenianLetters: 'ՏՏ',
        letters: 'SS',
        tails: <String>{'03', '60'},
      ),
      const ArmeniaSpecialCombination(
        institution: 'Government',
        armenianLetters: 'VV',
        letters: 'VV',
        tails: <String>{'01'},
      ),
      const ArmeniaSpecialCombination(
        institution: 'Security Council',
        armenianLetters: 'NN',
        letters: 'NN',
        tails: <String>{'01'},
      ),
      const ArmeniaSpecialCombination(
        institution: "General Prosecutor's office",
        armenianLetters: 'GG',
        letters: 'GG',
        tails: <String>{'01'},
      ),
      ArmeniaSpecialCombination(
        institution: 'Police',
        armenianLetters: 'ՈՍ',
        letters: null,
        tails: _tails(1, 14),
      ),
      const ArmeniaSpecialCombination(
        institution: 'Police',
        armenianLetters: 'II',
        letters: 'II',
        tails: null,
      ),
      ArmeniaSpecialCombination(
        institution: 'Banks',
        armenianLetters: 'ՏL',
        letters: 'SL',
        tails: _tails(1, 33),
      ),
      const ArmeniaSpecialCombination(
        institution: 'Court of Cassation',
        armenianLetters: 'ՏՏ',
        letters: 'SS',
        tails: <String>{'01'},
      ),
      const ArmeniaSpecialCombination(
        institution: 'National Security Service',
        armenianLetters: 'ՏՏ',
        letters: 'SS',
        tails: <String>{'02'},
      ),
    ],
  );

  /// No two rows overlap, so the first match is the only one.
  static ArmeniaSpecialCombination? lookup(String letters, String tail) =>
      all.where((c) => c.matches(letters, tail)).firstOrNull;
}
