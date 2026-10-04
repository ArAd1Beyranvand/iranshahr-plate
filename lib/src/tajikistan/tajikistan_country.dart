import 'package:plate_core/plate_core.dart';

import 'tajikistan_colors.dart';

/// The block that goes in a Tajik plate's [PlateSpec.panel]: the flag over `TJ`.
///
/// Every Tajik plate that carries a block carries this one — the national flag
/// with `TJ` set beneath it — and the block differs between classes only in the
/// colour behind it. On a civilian plate the block sits on a white field and
/// cannot be seen as a block at all, so the flag and the caption appear to be
/// printed straight on the plate; that is the same trick
/// `AzerbaijanCountry.azerbaijan` and `ArmeniaCountry.armenia` play.
///
/// Three constants rather than one with a colour argument, because the caption's
/// ink changes with the field: black `TJ` reads on the white and amber plates
/// and would vanish on the blue one, where it is reversed out white. A host
/// hands [PlateCanvas] the constant that matches the theme it is printing.
///
/// The flagless designs — foreign, diplomatic and governmental — name this
/// country too (a spec always has one) but declare [PlateSpec.noPanel] and never
/// paint a block; they carry no flag at all.
abstract final class TajikistanCountry {
  /// Official ratio of the flag of Tajikistan is 1:2 — width over height, which
  /// is what [PlateCountry.flagAspectRatio] wants, is 2.
  static const double _flagAspectRatio = 2;

  /// The flag over a black `TJ`, on white: private cars, trailers and
  /// motorcycles.
  static const PlateCountry civilian = PlateCountry(
    code: 'tj',
    captionLines: <String>['TJ'],
    panelColor: TajikistanColors.field,
    panelTextColor: TajikistanColors.ink,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset(
      'assets/flags/Flag_of_Tajikistan.svg',
      package: 'iranshahr_plate',
    ),
  );

  /// The flag over a black `TJ`, on the amber public-transport field.
  static const PlateCountry transport = PlateCountry(
    code: 'tj',
    captionLines: <String>['TJ'],
    panelColor: TajikistanColors.transportAmber,
    panelTextColor: TajikistanColors.onTransportAmber,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset(
      'assets/flags/Flag_of_Tajikistan.svg',
      package: 'iranshahr_plate',
    ),
  );

  /// The flag over a white `TJ`, on the blue police field.
  static const PlateCountry police = PlateCountry(
    code: 'tj',
    captionLines: <String>['TJ'],
    panelColor: TajikistanColors.policeBlue,
    panelTextColor: TajikistanColors.onPoliceBlue,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset(
      'assets/flags/Flag_of_Tajikistan.svg',
      package: 'iranshahr_plate',
    ),
  );
}
