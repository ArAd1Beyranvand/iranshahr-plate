import 'package:plate_core/core_plate.dart';

import 'qatar_colors.dart';

/// The blocks that go in a Qatari plate's [PlateSpec.panel].
///
/// **Every constant here has `code: 'qa'`, so they all compare equal.** That is
/// the contract the other countries in this package keep: the code identifies
/// the country, and the rest of the value is how that country's block is
/// printed on one class of plate.
///
/// Qatar's block is the odd one in this package, and in two ways.
///
/// - **It carries no flag asset.** The block *is* the flag — its hoist end,
///   maroon, serrated down the inboard edge — so painting a flag rectangle
///   inside it would be painting the flag twice. [PlateCountry.flag] is null
///   and the shape comes from [QatarFlagEdgeClipper] on the spec's panel
///   instead. The `Flag_of_Qatar.svg` this package ships is what the clipper's
///   geometry is derived from, not something the panel draws.
/// - **Its wording is a [PlateLabel], not a caption.** `QATAR` runs *down* the
///   block, one letter per line, which a caption — a left-aligned column set at
///   caption scale — cannot express. The stacked letters are a rotated label on
///   the spec; see `QatarPlates.civilian`.
///
/// So neither constant sets [PlateCountry.captionLines].
abstract final class QatarCountry {
  /// Official ratio of the flag of Qatar is 11:28 — width over height, which is
  /// what [PlateCountry.flagAspectRatio] wants, is 28/11. Nothing reads it
  /// while the block carries no flag, but it is the country's number and the
  /// value belongs here rather than at whatever default a flagless block gets.
  static const double _flagAspectRatio = 28 / 11;

  /// The maroon hoist block: civilian plates in every size.
  static const PlateCountry civilian = PlateCountry(
    code: 'qa',
    captionLines: <String>[],
    panelColor: QatarColors.maroon,
    panelTextColor: QatarColors.onMaroon,
    flagAspectRatio: _flagAspectRatio,
  );

  /// The police plate's blue field. Flagless and blockless in the same sense —
  /// the whole plate is blue and the wording sits on it as labels.
  static const PlateCountry police = PlateCountry(
    code: 'qa',
    captionLines: <String>[],
    panelColor: QatarColors.policeBlue,
    panelTextColor: QatarColors.onPoliceBlue,
    flagAspectRatio: _flagAspectRatio,
  );
}
