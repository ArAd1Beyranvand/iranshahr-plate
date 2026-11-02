import 'package:plate_core/plate_core.dart';

/// The three-digit mission codes after a diplomatic plate's status letter,
/// from the article's "Diplomatic Codes" table.
///
/// Code `011` is deliberately absent and refused: [name] throws for it,
/// [isRefused] is true for it, and [restriction] carries it into every
/// diplomatic spec so `plate_core` refuses it in every layer.
abstract final class UzbekistanMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  static const List<String> refused = <String>['011'];

  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// The mission for [code], or null for a code the list does not have.
  /// Throws [PlateRestrictionException] for a refused code.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '001': 'Turkey',
    '002': 'China',
    '003': 'Pakistan',
    '004': 'Germany',
    '005': 'India',
    '006': 'France',
    '007': 'Russia',
    '008': 'Iran',
    '009': 'Italy',
    '010': 'United States',
    '020': 'United States',
    '012': 'Jordan',
    '013': 'Korea',
    '014': 'Afghanistan',
    '015': 'Japan',
    '016': 'United Kingdom',
    '017': 'Vietnam',
    '018': 'Switzerland',
    '021': 'Malaysia',
    '022': 'Algeria',
    '023': 'Indonesia',
    '025': 'Saudi Arabia',
    '026': 'Egypt',
    '029': 'Ukraine',
    '030': 'Kazakhstan',
    '031': 'Poland',
    '032': 'Kyrgyzstan',
    '033': 'Latvia',
    '035': 'South Korea',
    '036': 'Palestine',
    '037': 'Moldova',
    '038': 'Slovakia',
    '039': 'Czech Republic',
    '040': 'Azerbaijan',
    '041': 'South Africa',
    '043': 'Bangladesh',
    '044': 'Belarus',
    '046': 'Georgia',
    '052': 'North Macedonia',
  };
}
