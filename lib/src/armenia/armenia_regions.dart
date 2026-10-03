/// The ten provinces and the capital, and the two-digit codes a plate
/// registered in each opens with.
///
/// **This is not a [PlateCountry] and never becomes one.** Afghanistan prints
/// its province at the hoist end of the plate, so there the province is the
/// country block; Armenia prints nothing of the kind. The region is the first
/// two digits of the number itself — an ordinary pair of slots on
/// `PlateAlphabet.latinDigits`, the same pair on every plate in the country.
/// So this file is a *lookup*, used by `ArmeniaPlateValidator` to judge a code
/// and by a host to label one, and no spec here mentions it.
///
/// The allocation is the one the Wikipedia table gives, as it stands after the
/// 2025 reallocation. Two codes have a history worth stating rather than
/// silently dropping: `22` and `90` were issued in Artsakh (Nagorno-Karabakh)
/// until 2024 and were reallocated in 2025 — `22` to [ArmeniaProvince.aragatsotn]
/// and `90` to [ArmeniaRegions.individualCodes]. They appear below under their
/// current holders only. A plate reading `90 SO 123` is a real plate and this
/// table will call it an individual number, which is what it is today; it was
/// an Artsakh number when it was issued.
library;

/// A province (*marz*) of Armenia, or the capital, together with the codes its
/// plates open with.
enum ArmeniaProvince {
  /// The capital, which is not a province but registers vehicles as one. It
  /// holds twenty-one of the ninety-nine codes — more than any three provinces
  /// together, and the reason the ranges are as scattered as they are: Yerevan
  /// kept outgrowing its allocation and was given another block each time.
  yerevan('Yerevan', 'Երևան', <String>[
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '13',
    '19',
    '61',
    '62',
    '63',
    '64',
    '65',
    '66',
    '67',
    '68',
  ]),
  armavir('Armavir', 'Արմավիր', <String>['12', '27', '28', '29']),
  shirak('Shirak', 'Շիրակ', <String>['14', '45', '46', '47', '48', '49']),

  /// `22` is here since 2025; until 2024 it was an Artsakh code. See the
  /// library doc.
  aragatsotn('Aragatsotn', 'Արագածոտն', <String>['15', '21', '22', '23', '24']),
  gegharkunik('Gegharkunik', 'Գեղարքունիք', <String>[
    '16',
    '31',
    '32',
    '33',
    '34',
    '35',
  ]),
  kotayk('Kotayk', 'Կոտայք', <String>['17', '42', '43']),
  vayotsDzor('Vayots Dzor', 'Վայոց ձոր', <String>['18', '56']),
  ararat('Ararat', 'Արարատ', <String>['25', '26']),
  lori('Lori', 'Լոռի', <String>['36', '37', '38', '39', '41']),
  syunik('Syunik', 'Սյունիք', <String>['51', '52', '53', '54']),
  tavush('Tavush', 'Տավուշ', <String>['57', '58', '59']);

  const ArmeniaProvince(this.englishName, this.localName, this.codes);

  /// The province's name in English. Never printed on a plate — this is for a
  /// picker's label and for a log.
  final String englishName;

  /// The name in Armenian. Never printed on a plate either: an Armenian plate
  /// names its region in digits and in nothing else.
  final String localName;

  /// Every two-digit code registered to this province, as printed — with the
  /// leading zero, because `01` is what the plate carries and `1` is not a
  /// region code.
  final List<String> codes;
}

/// The region code as a lookup: which province a code belongs to, and which
/// codes belong to no province at all.
abstract final class ArmeniaRegions {
  /// The codes issued without a province behind them.
  ///
  /// The last row of the article's table — "individual plates not showing
  /// province". These are ordinary numbers in every other respect; they simply
  /// say nothing about where the vehicle is registered, which is the point of
  /// paying for one.
  static const Set<String> individualCodes = <String>{
    '20',
    '30',
    '40',
    '44',
    '50',
    '55',
    '60',
    '69',
    '70',
    '71',
    '72',
    '73',
    '74',
    '75',
    '76',
    '77',
    '78',
    '79',
    '80',
    '81',
    '82',
    '83',
    '84',
    '85',
    '86',
    '87',
    '88',
    '89',
    '90',
    '91',
    '92',
    '93',
    '94',
    '95',
    '96',
    '97',
    '98',
    '99',
  };

  /// The province [code] is registered to, or null when it is an individual
  /// code ([individualCodes]) or not a code at all.
  ///
  /// Null rather than a throw for both cases: this is what a host reaches for
  /// after reading two digits off a plate, and neither "this is an individual
  /// number" nor "this is not a number" is a programming error to crash on.
  /// [isIssued] is the question that tells the two apart.
  static ArmeniaProvince? provinceFor(String code) {
    for (final province in ArmeniaProvince.values) {
      if (province.codes.contains(code)) return province;
    }
    return null;
  }

  /// Whether [code] is a region code Armenia issues: any of `01` to `99`.
  ///
  /// Every one of the ninety-nine is allocated — to a province or to
  /// [individualCodes] — so this is really the test that [code] is two digits
  /// and not `00`. It is written as a membership test all the same, so that a
  /// future deallocation is a change to the tables above and not to a range
  /// check hidden in a validator.
  static bool isIssued(String code) =>
      individualCodes.contains(code) || provinceFor(code) != null;
}
