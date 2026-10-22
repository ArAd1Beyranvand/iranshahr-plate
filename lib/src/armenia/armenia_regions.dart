/// The ten provinces and the capital, and the two-digit codes a plate
/// registered in each opens with.
///
/// Not a [PlateCountry]: the region is the first two digits of the number, an
/// ordinary pair of slots. This file is a lookup for validators and hosts.
///
/// Allocation is the Wikipedia table after the 2025 reallocation. `22` and `90`
/// were Artsakh codes until 2024 and appear under their current holders only,
/// so a `90 SO 123` plate issued then reads as an individual number today.
library;

/// A province (*marz*) of Armenia, or the capital, together with the codes its
/// plates open with.
enum ArmeniaProvince {
  /// The capital, which registers vehicles as a province does.
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

  aragatsotn('Aragatsotn', 'Արագածոտն', <String>['15', '21', '22', '23', '24']),
  gegharkunik('Gegharkunik', 'Գեղարքունիք', <String>['16', '31', '32', '33', '34', '35']),
  kotayk('Kotayk', 'Կոտայք', <String>['17', '42', '43']),
  vayotsDzor('Vayots Dzor', 'Վայոց ձոր', <String>['18', '56']),
  ararat('Ararat', 'Արարատ', <String>['25', '26']),
  lori('Lori', 'Լոռի', <String>['36', '37', '38', '39', '41']),
  syunik('Syunik', 'Սյունիք', <String>['51', '52', '53', '54']),
  tavush('Tavush', 'Տավուշ', <String>['57', '58', '59']);

  const ArmeniaProvince(this.englishName, this.localName, this.codes);

  /// Neither name is printed: a plate names its region in digits only.
  final String englishName;
  final String localName;

  /// Two-digit codes as printed, with the leading zero.
  final List<String> codes;
}

/// Which province a region code belongs to, and which belong to none.
abstract final class ArmeniaRegions {
  /// Individual plates, which do not show a province.
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

  /// Null for an individual code or a non-code; [isIssued] tells them apart.
  static ArmeniaProvince? provinceFor(String code) =>
      ArmeniaProvince.values.where((p) => p.codes.contains(code)).firstOrNull;

  /// Every `01`–`99` is allocated, so this is a membership test rather than a
  /// range check, to keep a future deallocation a change to the tables.
  static bool isIssued(String code) => individualCodes.contains(code) || provinceFor(code) != null;
}
