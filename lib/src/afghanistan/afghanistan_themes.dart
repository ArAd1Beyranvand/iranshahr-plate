import 'package:plate_core/plate_core.dart';

import 'afghanistan_colors.dart';

/// The `PlateTheme`s an Afghan plate is printed in.
///
/// Five liveries over eleven classes, because in Afghanistan colour is a
/// coarser signal than class: a bus and a taxi share [transport] and are told
/// apart by their class register (`ب`/`B` against `ت`/`T`), and a private car,
/// a lorry, a motorcycle, a rickshaw, a duplicate and a temporary plate all
/// share [civilian] and are told apart the same way. Only the diplomatic,
/// governmental and United Nations plates get a field of their own, and each of
/// those three also gets a spec of its own, because none of them carries a
/// class register at all.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: AfghanistanPlates.car,          // the same geometry ...
///   theme: AfghanistanThemes.transport,    // ... printed as a taxi's plate
///   country: AfghanistanProvince.kabul.country(),
/// )
/// ```
///
/// All five are [PlateTheme.monochrome]: one ink prints the serial, the class,
/// the province block and the frame, and there is no divider and no security
/// band on any Afghan design. The one place a second ink appears is the
/// temporary plate's red `موقت`/`TEMP`, and that is carried by the two
/// [PlateLabel]s that print it — see [AfghanistanColors.temporaryRed] — rather
/// than by a sixth theme, which would recolour the serial along with the
/// wording.
///
/// **The block's ink is not themed here.** A [PlateCountry] carries its own
/// wording colour and its own emblem asset, so the caller that picks a dark
/// field picks the light block to go with it:
/// `AfghanistanProvince.kabul.country(ink: AfghanistanPanelInk.light)`.
abstract final class AfghanistanThemes {
  /// Frame thickness as a fraction of plate height. // CALIBRATE
  static const double _borderWidthRatio = 0.035;

  /// // CALIBRATE
  static const double _plateRadiusRatio = 0.09;

  /// Private cars, lorries, motorcycles, rickshaws, duplicates and temporary
  /// plates: black on white.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: AfghanistanColors.field,
    ink: AfghanistanColors.ink,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Buses and taxis: black on yellow, on the ordinary civilian geometry.
  static const PlateTheme transport = PlateTheme.monochrome(
    field: AfghanistanColors.transportYellow,
    ink: AfghanistanColors.onTransportYellow,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// The diplomatic corps: white on red, on [AfghanistanPlates.diplomatic].
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: AfghanistanColors.diplomaticRed,
    ink: AfghanistanColors.onDiplomaticRed,
    inactive: AfghanistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Government vehicles: white on black, on [AfghanistanPlates.governmental].
  static const PlateTheme governmental = PlateTheme.monochrome(
    field: AfghanistanColors.governmentalBlack,
    ink: AfghanistanColors.onGovernmentalBlack,
    inactive: AfghanistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// United Nations vehicles: black on blue, on [AfghanistanPlates.un]. The
  /// second coloured field that keeps the civilian ink.
  static const PlateTheme un = PlateTheme.monochrome(
    field: AfghanistanColors.unBlue,
    ink: AfghanistanColors.onUnBlue,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
