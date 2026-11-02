import 'package:plate_core/plate_core.dart';

/// The diplomatic mission codes: the three digits after the class letter.
///
/// Taken from the article's list (001–040). Code `007` (Israel) is
/// deliberately absent and refused: [name] throws for it, [isRefused] is true
/// for it, and [restriction] carries it into the diplomatic spec so
/// `plate_core` refuses it in the controller, the input machine, the canvas,
/// the validators and the bloc. Nothing in this package will ever store it.
abstract final class KazakhstanMissions {
  /// The error every layer shows for a refused code.
  static const String notFound = 'COUNTRY NOT FOUND';

  /// Codes no layer may store.
  static const List<String> refused = <String>['007'];

  /// The restriction on the diplomatic spec's `mission` register.
  static const PlateRestriction restriction = PlateRestriction(
    group: 'mission',
    values: refused,
    reason: notFound,
  );

  static bool isRefused(String code) => refused.contains(code);

  /// The mission for [code], or null for a code the list does not have.
  ///
  /// Throws [PlateRestrictionException] for a refused code: unlike an unknown
  /// one, a refused code is never a lookup miss a caller may shrug off.
  static String? name(String code) {
    if (isRefused(code)) throw const PlateRestrictionException(restriction);
    return _missions[code];
  }

  /// Every listed code and its mission, refused codes excluded.
  static Map<String, String> get all => Map.unmodifiable(_missions);

  static const Map<String, String> _missions = <String, String>{
    '001': 'United States',
    '002': 'Iran',
    '003': 'China',
    '004': 'Turkey',
    '005': 'Germany',
    '006': 'Pakistan',
    '008': 'India',
    '009': 'Canada',
    '010': 'North Korea',
    '011': 'France',
    '012': 'Mongolia',
    '013': 'Italy',
    '014': 'Cuba',
    '015': 'Hungary',
    '016': 'Libya',
    '017': 'Romania',
    '018': 'United Kingdom',
    '019': 'Russia',
    '020': 'Armenia',
    '021': 'Japan',
    '022': 'Switzerland',
    '023': 'Uzbekistan',
    '024': 'Palestine',
    '025': 'South Korea',
    '026': 'Egypt',
    '027': 'Czech Republic',
    '028': 'Lithuania',
    '029': 'Georgia',
    '031': 'Tajikistan',
    '032': 'Poland',
    '033': 'Bulgaria',
    '034': 'Ukraine',
    '035': 'Afghanistan',
    '036': 'Central Asia Regional Economic Cooperation Program',
    '037': 'UNICEF',
    '038': 'Lebanon',
    '039': 'Kyrgyzstan',
    '040': 'European Union',
  };
}
