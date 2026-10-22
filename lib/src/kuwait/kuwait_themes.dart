import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'kuwait_colors.dart';

/// The `PlateTheme`s a Kuwaiti plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: KuwaitPlates.civilian,
///   country: KuwaitCountry.civilian,
///   theme: KuwaitThemes.civilian,
///   ...
/// )
/// ```
abstract final class KuwaitThemes {
  /// 3 units of frame on a 155-unit plate, measured off the reference
  /// artwork. The article's table does not give a frame width.
  static const double _borderWidthRatio = 0.02;

  /// 14 units of corner radius on a 155-unit plate, same source.
  static const double _plateRadiusRatio = 0.09;

  /// Every Kuwaiti plate is one ink on one field with a frame in one of the
  /// two; only those three colours ever change.
  static PlateTheme _theme({
    required Color field,
    required Color ink,
    required Color frame,
    required bool darkField,
  }) => PlateTheme(
    plateBackground: field,
    plateBorder: frame,
    ink: ink,
    dividerColor: ink,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
    activeColor: ink,
    inactiveColor: darkField ? KuwaitColors.inactiveOnDark : KuwaitColors.inactiveOnLight,
  );

  /// Private vehicles: black on white, dark frame.
  static final PlateTheme civilian = _theme(
    field: KuwaitColors.civField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Public transport: black on yellow, dark frame.
  static final PlateTheme transport = _theme(
    field: KuwaitColors.transField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Police and police motorcycle: white on black. The frame is the field, so
  /// the plate reads as one solid black rounded rectangle.
  static final PlateTheme police = _theme(
    field: KuwaitColors.policeField,
    ink: KuwaitColors.whiteText,
    frame: KuwaitColors.policeField,
    darkField: true,
  );

  /// Government: black on blue, dark frame.
  static final PlateTheme government = _theme(
    field: KuwaitColors.govField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Corps Diplomatique: blue on white, blue frame. The red band and its
  /// white capsule are geometry, so they come from the spec, not from here.
  static final PlateTheme diplomatic = _theme(
    field: KuwaitColors.civField,
    ink: KuwaitColors.govField,
    frame: KuwaitColors.govField,
    darkField: false,
  );

  /// National guard: yellow on teal, yellow frame — the only category whose
  /// frame takes the ink colour rather than the dark ink.
  static final PlateTheme nationalGuard = _theme(
    field: KuwaitColors.guardField,
    ink: KuwaitColors.transField,
    frame: KuwaitColors.transField,
    darkField: true,
  );

  /// Army: black on beige, dark frame.
  static final PlateTheme army = _theme(
    field: KuwaitColors.armyField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Commercial: black on pink, dark frame.
  static final PlateTheme commercial = _theme(
    field: KuwaitColors.commField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Construction: black on red-orange, dark frame.
  static final PlateTheme construction = _theme(
    field: KuwaitColors.constructField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// General firefighting: black on orange-red, dark frame.
  static final PlateTheme firefighting = _theme(
    field: KuwaitColors.fireField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Export: black on green, dark frame.
  static final PlateTheme export = _theme(
    field: KuwaitColors.exportField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Temporary customs: black on lilac, dark frame.
  static final PlateTheme customs = _theme(
    field: KuwaitColors.customsField,
    ink: KuwaitColors.darkInk,
    frame: KuwaitColors.darkInk,
    darkField: false,
  );

  /// Emiri Bureau: white on azure, dark frame.
  static final PlateTheme emiri = _theme(
    field: KuwaitColors.emiriField,
    ink: KuwaitColors.whiteText,
    frame: KuwaitColors.darkInk,
    darkField: true,
  );

  /// Emiri Guard: white on navy, dark frame. A distinct blue from [emiri] —
  /// the two are different plates, not one plate rendered twice.
  static final PlateTheme emiriGuard = _theme(
    field: KuwaitColors.emiriGuardField,
    ink: KuwaitColors.whiteText,
    frame: KuwaitColors.darkInk,
    darkField: true,
  );
}
