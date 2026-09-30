/// Validators for Iraqi registration plates.
///
/// Current format (2022+): `GG X ####`
/// - GG: Governorate code (11–29)
/// - X: Vehicle classification letter (A–Z)
/// - ####: Registration number (0000–9999)
abstract final class IraqValidators {
  /// Valid governorate codes for Iraq (11–29).
  static const Set<String> validGovernorates = {
    '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
    '21', '22', '23', '24', '25', '26', '27', '28', '29',
  };

  /// Check if a governorate code is valid.
  static bool isValidGovernorate(String code) =>
      validGovernorates.contains(code);

  /// Check if a character is a valid vehicle type letter (A–Z).
  static bool isValidVehicleType(String letter) =>
      letter.length == 1 && RegExp(r'^[A-Z]$').hasMatch(letter);

  /// Check if a string is a valid registration number (4 digits).
  static bool isValidRegistrationNumber(String number) =>
      number.length == 4 && RegExp(r'^\d+$').hasMatch(number);
}
