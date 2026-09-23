import 'package:flutter/foundation.dart';

/// The reserved letter-and-tail combinations that make a public number what it
/// is.
///
/// A public vehicle's plate reads `### LL ##`: three digits assigned in
/// increasing order, and then a pair of letters and a pair of digits that are
/// *not* a serial at all. They name the institution the vehicle belongs to, and
/// the list of which pairs name which is the whole content of the article's
/// "Special combinations" section.
///
/// So the number `001 NN 01` is a Security Council car and `001 NN 02` is not a
/// plate. That is a rule no shape check can express — it is a membership test
/// against a table — which is why the table is data here and
/// `ArmeniaPublicPlateValidator` is four lines long.
@immutable
class ArmeniaSpecialCombination {
  const ArmeniaSpecialCombination({
    required this.institution,
    required this.armenianLetters,
    required this.letters,
    required this.tails,
  });

  /// The body the number belongs to, in English, e.g. `Security Council`. For
  /// a picker's label, a log, and the text of an invalid verdict.
  final String institution;

  /// The pair as Armenian reads it, e.g. `ՕՏ` for the Constitutional Court.
  ///
  /// Always present, including for the pairs that are plain Latin: `FF` is
  /// `FF` in both scripts, and recording it twice keeps this field from being
  /// the one that is sometimes missing.
  final String armenianLetters;

  /// The pair as the plate's letter register stores it, or null when the
  /// combination cannot be written in that register at all.
  ///
  /// Null on exactly one row: the Police's `ՈՍ`. `Ո` reads `o` and was used on
  /// plates because it looks like a lowercase Latin `n` — a resemblance the
  /// authorities decided in 2010 was too weak, and the letter fell out of use
  /// without ever getting a Latin key. It has none here either, so a `ՈՍ`
  /// number cannot be typed on `ArmeniaAlphabets.letters` and [lookup] will
  /// never return this row. It is listed because it is on the road, not because
  /// it can be entered.
  final String? letters;

  /// Every two-digit tail this combination is issued with, or null when any
  /// pair of digits is legal.
  ///
  /// Null on the Police's `II ##`, which the article gives with the digits left
  /// open. Everywhere else the set is small and closed — often a single `01`.
  final Set<String>? tails;

  /// Whether this combination covers the number `<something> [letters] [tail]`.
  ///
  /// Case-insensitive on the letters; a null [letters] matches nothing, since
  /// the register cannot hold it.
  bool matches(String letters, String tail) {
    final mine = this.letters;
    if (mine == null || mine != letters.toUpperCase()) return false;
    return tails == null || tails!.contains(tail);
  }
}

/// The table of reserved combinations, and the lookup over it.
///
/// `final`, not `const`: the ranged rows — the National Assembly's `01` to
/// `11`, the banks' `01` to `33`, the Police's `01` to `14` — are built by
/// [_tails], and a `const` initialiser cannot run a loop. Initialised lazily,
/// once per isolate.
abstract final class ArmeniaSpecialPlates {
  /// `{'01', '02', ... }` from [from] to [to] inclusive, zero-padded to the two
  /// digits a tail is printed in.
  static Set<String> _tails(int from, int to) => <String>{
    for (var n = from; n <= to; n++) n.toString().padLeft(2, '0'),
  };

  /// Every combination the article lists, in its order.
  ///
  /// One entry per *combination*, not per institution: the Government holds
  /// nine of them and gets nine rows. Folding them into one row with a list of
  /// pairs would make every other row carry a list of one, and would lose the
  /// fact that `SS 03` and `SS 60` are the Government's while `SS 01` is the
  /// Court of Cassation's and `SS 02` the National Security Service's — three
  /// bodies sharing one pair of letters, told apart by two digits.
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
      // The two Police rows. The first cannot be typed — see
      // [ArmeniaSpecialCombination.letters] — and the second leaves its digits
      // open, which is what a null tail set means.
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

  /// The combination that covers `<serial> [letters] [tail]`, or null when no
  /// institution is issued that pair.
  ///
  /// The first match wins, and no two rows overlap — `SS` is shared by three
  /// bodies but never over the same tail, which is what makes the table a
  /// lookup rather than a list of candidates.
  static ArmeniaSpecialCombination? lookup(String letters, String tail) {
    for (final combination in all) {
      if (combination.matches(letters, tail)) return combination;
    }
    return null;
  }
}
