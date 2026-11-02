import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import 'oman_colors.dart';

/// One ink on one field, the frame in the ink.
abstract final class OmanThemes {
  /// Frame 3.9 of 110 (`Оман1.gif` outer edge to field; 4.4 on the photograph);
  /// corner ~14.6 — the artwork's panel corner measured at ~10.7 plus the
  /// frame.
  static const double _border = 0.037;
  static const double _radius = 0.13;

  static PlateTheme _mono(
    Color field,
    Color ink,
    Color inactive, {
    Color alert = const Color(0xFFF87171),
  }) => PlateTheme.monochrome(
    field: field,
    ink: ink,
    inactive: inactive,
    borderWidthRatio: _border,
    plateRadiusRatio: _radius,
    alertColor: alert,
  );

  /// Black on yellow: private vehicles.
  static final PlateTheme private = _mono(
    OmanColors.yellow,
    OmanColors.black,
    OmanColors.inactiveOnLight,
  );

  /// White on red: taxis.
  static final PlateTheme taxi = _mono(
    OmanColors.red,
    OmanColors.white,
    OmanColors.inactiveOnDark,
    alert: OmanColors.alertOnRed,
  );
}
