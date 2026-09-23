import 'package:core_plate/core_plate.dart';

import 'bahrain_colors.dart';

/// The blocks that go in a Bahraini plate's [PlateSpec.panel].
///
/// **Every constant here has `code: 'bh'`, so they all compare equal.** That is
/// the same contract the other country packages in this workspace keep: the
/// code identifies the country, and the rest of the value is how that country's
/// block is printed on one class of plate. A host that wants to know which
/// block it is holding asks the spec, not the code.
///
/// Bahrain uses its country block in two quite different ways, which is why
/// there are two shapes of value here rather than one with a colour argument:
///
/// - **Civilian plates** ([civilian]) print no coloured block at all. The flag
///   sits directly on the white field, so the panel is the flag's rectangle and
///   [PlateCountry.panelColor] is the field colour — a block that is there,
///   holds the flag, and cannot be seen. The words `البحرين` / `BAHRAIN` are
///   set at their own spot on the face as [PlateLabel]s, not as a caption, so
///   the two scripts can sit apart from each other instead of stacking against
///   the flag.
/// - **Special plates** ([diplomatic], [police]) print a coloured band across
///   the head of the plate and no flag. There the panel is that band: a colour
///   and nothing else, with the wording again placed as labels so each script
///   lands where the real plate puts it.
///
/// So neither shape uses [PlateCountry.captionLines]. A caption is one
/// left-aligned column stacked under the flag, and no Bahraini plate sets its
/// wording that way.
abstract final class BahrainCountry {
  /// Official ratio of the flag of Bahrain is 3:5 — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 5/3.
  static const double _flagAspectRatio = 5 / 3;

  /// The flag on the white field: civilian plates in every size.
  static const PlateCountry civilian = PlateCountry(
    code: 'bh',
    captionLines: <String>[],
    // The field colour, so the panel is invisible and the flag appears to sit
    // straight on the plate. See the class comment.
    panelColor: BahrainColors.field,
    panelTextColor: BahrainColors.blue,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset('assets/flags/Flag_of_Bahrain.svg', package: 'iranshahr_plate'),
    // The photographed plates print a fine black line around the flag's own
    // rectangle, distinct from the frame around the whole plate. // CALIBRATE
    flagBorderColor: BahrainColors.darkInk,
  );

  /// The diplomatic corps band: green, flagless, captions reversed out white by
  /// the labels that sit on it.
  static const PlateCountry diplomatic = PlateCountry(
    code: 'bh',
    captionLines: <String>[],
    panelColor: BahrainColors.diplomaticGreen,
    panelTextColor: BahrainColors.onDiplomaticGreen,
    flagAspectRatio: _flagAspectRatio,
  );

  /// The police band: pale blue, flagless, captions printed dark on it.
  static const PlateCountry police = PlateCountry(
    code: 'bh',
    captionLines: <String>[],
    panelColor: BahrainColors.policeBlue,
    panelTextColor: BahrainColors.onPoliceBlue,
    flagAspectRatio: _flagAspectRatio,
  );
}
