/// Bahrain's and Azerbaijan's licence plates for the `core_plate` library.
///
/// Data, not code: [PlateCountry]s, [PlateAlphabet]s and [PlateSpec]s that the
/// core widget layer paints. Nothing here knows about any other country
/// package.
///
/// ```dart
/// PlateCanvas(spec: BahrainPlates.eu, theme: BahrainThemes.civilian, ...)
/// PlateCanvas(spec: AzerbaijanPlates.car, theme: AzerbaijanThemes.civilian, ...)
/// ```
///
/// The two countries live side by side here and share nothing: `src/bahrain/`
/// for Bahrain, `src/azerbaijan/` for Azerbaijan, no import across any line,
/// and no constant in common. Each country's designs are its own — Bahrain's
/// grey security band and its wording set as labels rather than as a panel
/// caption, Azerbaijan's single white country block on four differently
/// coloured fields — and are described in `BahrainPlates` and
/// `AzerbaijanPlates`.
library;

// ---------------------------------------------------------------------------
// Bahrain. A separate country, a separate design language, and a separate
// folder (`src/bahrain/`) — no Bahraini file imports an Azerbaijani one or the
// reverse, and the two sets of plates have no constant in common.
// ---------------------------------------------------------------------------

/// The colours every Bahraini plate is printed in.
export 'src/bahrain/bahrain_colors.dart';

/// The blocks that go in a Bahraini plate's panel: the flag on the field, and
/// the diplomatic and police bands.
export 'src/bahrain/bahrain_country.dart';

/// The themes the five Bahraini designs are printed in.
export 'src/bahrain/bahrain_themes.dart';

/// The five Bahraini plate specs: the two civilian sizes, the bicycle plate,
/// the diplomatic corps plate and the police plate.
export 'src/bahrain/bahrain_plates.dart';

// ---------------------------------------------------------------------------
// Azerbaijan. A separate country on the same terms as Bahrain: its own folder
// (`src/azerbaijan/`), no import across any line, and no constant shared with
// Bahrain.
// ---------------------------------------------------------------------------

/// The field-and-ink pairs every Azerbaijani plate is printed in.
export 'src/azerbaijan/azerbaijan_colors.dart';

/// The one country block every Azerbaijani plate carries: the flag over `AZ`,
/// on white, whatever colour the field around it is.
export 'src/azerbaijan/azerbaijan_country.dart';

/// The four themes — civilian white, transport blue, diplomatic red and
/// foreign-company yellow — that print the specs below.
export 'src/azerbaijan/azerbaijan_themes.dart';

/// The four Azerbaijani plate specs: the civilian car plate (which is also the
/// blue transport plate, under another theme), the motorcycle plate, the
/// diplomatic plate and the foreign-company plate.
export 'src/azerbaijan/azerbaijan_plates.dart';
