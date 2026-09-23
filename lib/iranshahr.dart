/// Bahrain's, Azerbaijan's and Afghanistan's licence plates for the
/// `core_plate` library.
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

// ---------------------------------------------------------------------------
// Afghanistan. A third country on the same terms as the first two: its own
// folder (`src/afghanistan/`), no import across any line, and no constant
// shared with either.
//
// It is the one country here whose plate is bilingual throughout. An Afghan
// plate prints its serial twice — eastern Arabic numerals over Latin figures —
// and its vehicle class twice — a Persian letter over a Latin code — so both
// are one value with two presentations, held together by `PlateMirror` rather
// than by two registers a caller has to keep in step. It is also the one whose
// hoist block is a runtime value: the province column varies over all
// thirty-four, so it is an `AfghanistanProvince` handed to `PlateCanvas.country`
// and not a constant baked into a spec.
// ---------------------------------------------------------------------------

/// The field-and-ink pairs every Afghan plate is printed in, and the red of the
/// temporary plate's two words.
export 'src/afghanistan/afghanistan_colors.dart';

/// The two pairs of alphabets behind an Afghan plate: the serial's figures and
/// their eastern-numeral twins, the vehicle class and its Latin code.
export 'src/afghanistan/afghanistan_alphabets.dart';

/// The thirty-four provinces, and the name-over-emblem-over-code block each one
/// prints at the hoist end of a plate registered in it.
export 'src/afghanistan/afghanistan_provinces.dart';

/// The five liveries — civilian white, transport yellow, diplomatic red,
/// governmental black and UN blue — that print the specs below.
export 'src/afghanistan/afghanistan_themes.dart';

/// The eleven Afghan geometries: the three- to five-figure plates, Kabul's
/// six-figure one, the two two-wheeler sizes, and the five designs that print
/// something other than a class code at the head.
export 'src/afghanistan/afghanistan_plates.dart';
