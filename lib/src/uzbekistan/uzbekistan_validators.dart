import 'package:plate_core/plate_core.dart';

import 'uzbekistan_missions.dart';

/// Regional plates: once the region is started, every keyed group must be
/// full. Advisory, except for the spec's restrictions, which
/// [GatedPlateValidator] reports first.
class UzbekistanValidator extends GatedPlateValidator {
  const UzbekistanValidator();

  @override
  String get gateGroup => 'region';

  @override
  PlateValidation judge(PlateEntry entry) {
    for (final g in entry.spec.textGroups) {
      final key = g.key;
      if (key == null) continue;
      if (entry.group(key).length != g.indices.length) {
        return PlateValidation.invalid('The $key is incomplete.');
      }
    }
    return const PlateValidation.valid();
  }
}

/// Diplomatic plates carry no region: a mission code and a serial, the
/// mission register refusing `011` on its own account as well as through the
/// spec's restriction.
class UzbekistanDiplomaticValidator extends GatedPlateValidator {
  const UzbekistanDiplomaticValidator();

  @override
  String get gateGroup => 'mission';

  @override
  PlateValidation validate(PlateEntry entry) {
    if (UzbekistanMissions.isRefused(entry.group('mission'))) {
      return const PlateValidation.invalid(UzbekistanMissions.notFound);
    }
    return super.validate(entry);
  }

  @override
  PlateValidation judge(PlateEntry entry) {
    final mission = entry.group('mission');
    if (mission.length != 3) {
      return const PlateValidation.invalid('The mission code is incomplete.');
    }
    if (UzbekistanMissions.name(mission) == null) {
      return const PlateValidation.invalid(UzbekistanMissions.notFound);
    }
    if (entry.group('serial').length != 3) {
      return const PlateValidation.invalid('The serial is incomplete.');
    }
    return const PlateValidation.valid();
  }
}

/// UN plates, `UN 0123`: four digits, no region.
class UzbekistanUnitedNationsValidator extends GatedPlateValidator {
  const UzbekistanUnitedNationsValidator();

  @override
  String get gateGroup => 'serial';

  @override
  PlateValidation judge(PlateEntry entry) =>
      isDigitsOfLength(entry.group('serial'), 4)
      ? const PlateValidation.valid()
      : const PlateValidation.invalid('The serial is incomplete.');
}
