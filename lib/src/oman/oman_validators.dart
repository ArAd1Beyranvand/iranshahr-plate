import 'package:plate_core/plate_core.dart';

/// Every field at least at its minimum length. The article gives no rule beyond the format, and the
/// letter list is incomplete, so nothing else is judged.
class OmanPlateValidator extends PlateValidator {
  const OmanPlateValidator();

  @override
  PlateValidation validate(PlateEntry entry) {
    final refused = restrictionVerdict(entry);
    if (refused != null) return refused;
    for (final g in entry.spec.textGroups) {
      final key = g.key;
      if (key == null) continue;
      for (final i in g.indices) {
        if (!entry.spec.slots[i].isComplete(entry.values[i])) {
          return PlateValidation.invalid('The $key is incomplete.');
        }
      }
    }
    return const PlateValidation.valid();
  }
}
