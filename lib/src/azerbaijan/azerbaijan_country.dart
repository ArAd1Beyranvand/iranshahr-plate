import 'package:plate_core/plate_core.dart';

import 'azerbaijan_colors.dart';

/// The block that goes in an Azerbaijani plate's [PlateSpec.panel].
///
/// **One value, for every class of plate** — and that is the whole design, not
/// a shortcut. An Azerbaijani plate identifies its country the same way whether
/// the field under it is white, blue, red or yellow: a white block carrying the
/// flag with `AZ` set beneath it. Nothing about the block changes with the
/// class; only the field around it does, and a field is a [PlateTheme].
///
/// So there is no `AzerbaijanCountry.diplomatic` to go with the red plate. The
/// block is [azerbaijan] on all five designs, which is why it prints its
/// caption in [AzerbaijanColors.ink] unconditionally: the caption sits on
/// [AzerbaijanColors.field], never on the coloured field, so the plate's own
/// ink — white on the blue and red plates — would be invisible on it.
///
/// On the civilian plates the block is white on white and cannot be seen at
/// all; the flag and the caption appear to sit straight on the plate. That is
/// the same trick `BahrainCountry.civilian` plays, and for the same reason.
///
/// This is a caption, not a [PlateLabel]: `AZ` is one short line stacked
/// directly under the flag, left-aligned — which is exactly what
/// [PlateCountry.captionLines] lays out, and exactly what the Bahraini wording
/// was not.
abstract final class AzerbaijanCountry {
  /// Official ratio of the flag of Azerbaijan is 1:2 — width over height, which
  /// is what [PlateCountry.flagAspectRatio] wants, is 2.
  static const double _flagAspectRatio = 2;

  /// The flag over `AZ`, on a white block: every Azerbaijani plate in this
  /// package.
  static const PlateCountry azerbaijan = PlateCountry(
    code: 'az',
    captionLines: <String>['AZ'],
    panelColor: AzerbaijanColors.field,
    panelTextColor: AzerbaijanColors.ink,
    flagAspectRatio: _flagAspectRatio,
    flag: SvgPlateAsset(
      'assets/flags/Flag_of_Azerbaijan.svg',
      package: 'iranshahr_plate',
    ),
  );
}
