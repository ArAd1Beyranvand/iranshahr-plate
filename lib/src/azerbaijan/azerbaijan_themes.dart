import 'package:core_plate/core_plate.dart';

import 'azerbaijan_colors.dart';

/// The `PlateTheme`s an Azerbaijani plate is printed in.
///
/// Colour never lives on a [PlateSpec] — a spec is geometry — so the host
/// passes one:
///
/// ```dart
/// PlateCanvas(
///   spec: AzerbaijanPlates.car,          // the same geometry ...
///   theme: AzerbaijanThemes.transport,   // ... printed as a taxi's plate
///   ...
/// )
/// ```
///
/// **Every one of these is a [PlateTheme.monochrome], and that is the point.**
/// Azerbaijan's classes are told apart by the colour of the field and nothing
/// else: one ink prints the serial, the hyphens and the frame, and there is no
/// divider, no security band and no second ink anywhere on any of the four
/// designs. That is the exact shape `monochrome` exists for — and the exact
/// opposite of `BahrainThemes`, whose grey security band is why no Bahraini
/// theme can be one.
///
/// The `AZ` block is not themed here. It is white with black wording on all
/// four, because it is a white block printed on the field rather than a part of
/// it — see [AzerbaijanCountry].
abstract final class AzerbaijanThemes {
  /// Frame thickness as a fraction of plate height. // CALIBRATE
  static const double _borderWidthRatio = 0.035;

  /// // CALIBRATE
  static const double _plateRadiusRatio = 0.10;

  /// Private cars, motorcycles and trailers: black on white.
  static const PlateTheme civilian = PlateTheme.monochrome(
    field: AzerbaijanColors.field,
    ink: AzerbaijanColors.ink,
    inactive: AzerbaijanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// Privately owned public transport — a bus or a taxi: white on blue, on
  /// [AzerbaijanPlates.car]'s geometry.
  static const PlateTheme transport = PlateTheme.monochrome(
    field: AzerbaijanColors.transportBlue,
    ink: AzerbaijanColors.onTransportBlue,
    inactive: AzerbaijanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// The diplomatic corps: white on red, on [AzerbaijanPlates.diplomatic].
  static const PlateTheme diplomatic = PlateTheme.monochrome(
    field: AzerbaijanColors.diplomaticRed,
    ink: AzerbaijanColors.onDiplomaticRed,
    inactive: AzerbaijanColors.inactiveOnDark,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );

  /// A foreign-owned company: black on yellow, on [AzerbaijanPlates.foreign].
  /// The only coloured field here that keeps the civilian ink.
  static const PlateTheme foreign = PlateTheme.monochrome(
    field: AzerbaijanColors.foreignYellow,
    ink: AzerbaijanColors.onForeignYellow,
    inactive: AzerbaijanColors.inactiveOnLight,
    borderWidthRatio: _borderWidthRatio,
    plateRadiusRatio: _plateRadiusRatio,
  );
}
