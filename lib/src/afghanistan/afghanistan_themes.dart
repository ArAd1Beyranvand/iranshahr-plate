import 'package:plate_core/plate_core.dart';

import 'afghanistan_colors.dart';

/// Five liveries over eleven classes: colour is coarser than class, so a bus
/// and a taxi share [transport] and a car, lorry, motorcycle, rickshaw,
/// duplicate and temporary plate share [civilian], each told apart by its class
/// register. All are monochrome; the temporary plate's red wording is carried
/// by its labels (see `AfghanistanColors.temporaryRed`).
///
/// The emblem's ink is not themed here: the spec picks it with
/// `AfghanistanPanelInk`.
abstract final class AfghanistanThemes {
  static const double _borderWidthRatio = 0.035; // CALIBRATE

  static const double _plateRadiusRatio = 0.09; // CALIBRATE

  /// Black on white.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: AfghanistanColors.field,
    ink: AfghanistanColors.ink,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Black on yellow.
  static const PlateTheme transport = PlateTheme.monochrome(
    field: AfghanistanColors.transportYellow,
    ink: AfghanistanColors.onTransportYellow,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// White on red.
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: AfghanistanColors.diplomaticRed,
    ink: AfghanistanColors.onDiplomaticRed,
    inactive: AfghanistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// White on black.
  static const PlateTheme governmental = PlateTheme.monochrome(
    field: AfghanistanColors.governmentalBlack,
    ink: AfghanistanColors.onGovernmentalBlack,
    inactive: AfghanistanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Black on blue.
  static const PlateTheme un = PlateTheme.monochrome(
    field: AfghanistanColors.unBlue,
    ink: AfghanistanColors.onUnBlue,
    inactive: AfghanistanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  // TODO(py): [D4-code] resolver with logic: hand-port against the same vectors (D9).
  // TODO(ts): [D4-code] resolver with logic: hand-port against the same vectors (D9).
  // TODO(kt): [D4-code] resolver with logic: hand-port against the same vectors (D9).
  /// [PlateSpec.resolveTheme] for plates with a class register: taxi and bus
  /// (`ت`, `ب`) print on [transport], every other class on [civilian], keeping
  /// [base]'s rim and corner.
  static PlateTheme byClass(
    PlateTheme base,
    String Function(String key) group,
  ) {
    final t = switch (group('class')) {
      'T' || 'B' => transport,
      _ => civilian,
    };
    return base.copyWith(
      plateBackground: t.plateBackground,
      plateBorder: t.plateBorder,
      ink: t.ink,
      dividerColor: t.dividerColor,
      activeColor: t.activeColor,
      inactiveColor: t.inactiveColor,
    );
  }
}
