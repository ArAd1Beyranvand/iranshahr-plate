/// The regions of Tajikistan and the two-digit codes a plate registered in each
/// carries.
///
/// **This is not a [PlateCountry] and never becomes one.** Afghanistan prints
/// its province at the hoist end of the plate; Tajikistan does not. The region
/// is the two-digit group of the number itself — an ordinary pair of slots on
/// `PlateAlphabet.latinDigits`, in the same place on every civilian plate. So
/// this file is a *lookup*, used by `TajikistanPlateValidator` to judge a code
/// and by a host to label one, and no spec here mentions it.
///
/// The allocation is the one the Wikipedia article gives: the capital and four
/// regions, several of them holding two codes because the first block filled.
library;

/// A region of Tajikistan, or the capital, together with the codes its plates
/// carry.
enum TajikistanRegion {
  /// The capital. Not a region proper, but registers vehicles as one, and holds
  /// two codes.
  dushanbe('Dushanbe', 'Душанбе', <String>['01', '05']),

  /// Sughd, in the north, capital Khujand.
  sughd('Sughd', 'Суғд', <String>['02', '06']),

  /// Khatlon, in the south-west, capital Bokhtar (Kurgan-Tube).
  khatlon('Khatlon', 'Хатлон', <String>['03']),

  /// Gorno-Badakhshan Autonomous Region, in the east, capital Khorog.
  gornoBadakhshan('Gorno-Badakhshan', 'Кӯҳистони Бадахшон', <String>['04']),

  /// The Districts of Republican Subordination, governed directly from the
  /// centre rather than through a region, and holding two codes.
  districtsOfRepublicanSubordination(
    'Districts of Republican Subordination',
    'Ноҳияҳои тобеи ҷумҳурӣ',
    <String>['07', '08'],
  );

  const TajikistanRegion(this.englishName, this.localName, this.codes);

  /// The region's name in English. Never printed on a plate — this is for a
  /// picker's label and for a log.
  final String englishName;

  /// The name in Tajik. Never printed on a plate either: a Tajik plate names its
  /// region in digits and in nothing else.
  final String localName;

  /// Every two-digit code registered to this region, as printed — with the
  /// leading zero, because `01` is what the plate carries and `1` is not a region
  /// code.
  final List<String> codes;
}

/// The region code as a lookup: which region a code belongs to, and whether a
/// code is one Tajikistan issues at all.
abstract final class TajikistanRegions {
  /// The region [code] is registered to, or null when it is not a code
  /// Tajikistan issues.
  ///
  /// Null rather than a throw: this is what a host reaches for after reading two
  /// digits off a plate, and an unknown code is not a programming error to crash
  /// on. [isIssued] is the same question asked as a bool.
  static TajikistanRegion? regionFor(String code) {
    for (final region in TajikistanRegion.values) {
      if (region.codes.contains(code)) return region;
    }
    return null;
  }

  /// Whether [code] is a region code Tajikistan issues.
  ///
  /// A closed membership test rather than a range check, so that a future
  /// allocation is a change to [TajikistanRegion] and not to a validator: today
  /// only `01`–`08` are issued, and `05`, `06`, `07`, `08` are the second blocks
  /// the capital, Sughd and the republican districts grew into.
  static bool isIssued(String code) => regionFor(code) != null;
}
