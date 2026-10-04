import 'package:plate_core/plate_core.dart';

/// Every slot filled. The article gives no rule beyond the format, and the
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
      if (entry.group(key).length != g.indices.length) {
        return PlateValidation.invalid('The $key is incomplete.');
      }
    }
    return const PlateValidation.valid();
  }
}
