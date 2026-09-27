/// Bahrain's, Azerbaijan's, Afghanistan's and Armenia's licence plates for the
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
/// The countries live side by side here and share nothing: `src/bahrain/`
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
// plate prints its serial twice — iranian Arabic numerals over Latin figures —
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
/// their iranian-numeral twins, the vehicle class and its Latin code.
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

// ---------------------------------------------------------------------------
// Armenia. A fourth country on the same terms as the first three: its own
// folder (`src/armenia/`), no import across any line, and no constant shared
// with any of them.
//
// It is the one country here whose *letters* are the design. Armenia opened in
// 1996 with four letters picked for their shapes — `Լ`, `Ս`, `Տ`, `Օ`, which an
// Armenian reads as Armenian and a foreigner reads as `L`, `U`, `S`, `O` — and
// added the other twenty-two in batches until 2019, two of them (`G`, `I`) to
// the Police and the Prosecutor's office alone. It is also the one whose state
// plates are a lookup rather than a shape: `NN 01` is the Security Council and
// `GG 01` the Prosecutor's office, and no shape check can say so.
// ---------------------------------------------------------------------------

/// The field-and-ink pairs every Armenian plate is printed in, and the silver
/// of the 2014 design's identifier band.
export 'src/armenia/armenia_colors.dart';

/// The one country block every Armenian plate with a block carries: the flag
/// over `AM`, on white.
export 'src/armenia/armenia_country.dart';

/// The letter register and the three class alphabets — diplomatic, bus and the
/// Armenian-script military one — plus the timeline of when each of the
/// twenty-six letters entered use.
export 'src/armenia/armenia_alphabets.dart';

/// The ten provinces and the capital, and which two-digit codes open a plate
/// registered in each. A lookup, not a panel: Armenia prints its region in the
/// number itself.
export 'src/armenia/armenia_regions.dart';

/// The reserved letter-and-tail combinations that name an institution on a
/// public plate.
export 'src/armenia/armenia_special_plates.dart';

/// The five liveries — civilian white, bus yellow, diplomatic red, UN blue and
/// military black — that print the specs below.
export 'src/armenia/armenia_themes.dart';

/// The ten Armenian geometries: the private number in its three sizes, the
/// state number, the trailer and bus plates, the two diplomatic wordings, the
/// UN plate and the military one.
export 'src/armenia/armenia_plates.dart';

/// The advisory validators: [ArmeniaPlateValidator] for private registrations —
/// the region code, the letters reserved to the state, and optionally the
/// letter timeline — [ArmeniaPublicPlateValidator] for the reserved
/// combinations, and one each for the trailer, bus, diplomatic, UN and military
/// formats, none of which follows the private plate's rules.
/// [ArmeniaPlates.validatorFor] picks between them.
export 'src/armenia/armenia_validators.dart';

// ---------------------------------------------------------------------------
// Tajikistan. A fifth country on the same terms as the first four: its own
// folder (`src/tajikistan/`), no import across any line, and no constant shared
// with any of them.
//
// It is the one country here whose letter register is a Cyrillic one wearing
// Latin shapes: the fifteen letters a Tajik plate carries are the eleven whose
// Cyrillic and Latin forms coincide — `А В Е К М Н О Р С Т Х` — plus the four
// plain-Latin additions of the 2014 redesign, `D J Z Y`. Its flag block sits on
// three differently coloured fields — white, amber and blue — so the block is
// three `PlateCountry` values, one per ink, and its flagless coloured classes —
// foreign yellow, diplomatic red and the old boxed-region governmental black —
// declare `noPanel` and carry their own arrangement instead.
// ---------------------------------------------------------------------------

/// The field-and-ink pairs every Tajik plate is printed in.
export 'src/tajikistan/tajikistan_colors.dart';

/// The letter register — the fifteen shape-sharing and Latin letters — and the
/// diplomatic class codes.
export 'src/tajikistan/tajikistan_alphabets.dart';

/// The capital and four regions, and which two-digit codes a plate registered in
/// each carries. A lookup, not a panel: Tajikistan prints its region in the
/// number itself.
export 'src/tajikistan/tajikistan_regions.dart';

/// The flag-over-`TJ` block in its three fields — white civilian, amber
/// transport and blue police.
export 'src/tajikistan/tajikistan_country.dart';

/// The six liveries — civilian white, transport amber, foreign yellow,
/// diplomatic red, police blue and governmental black — that print the specs
/// below.
export 'src/tajikistan/tajikistan_themes.dart';

/// The nine Tajik geometries: the private number in three sizes, the trailer,
/// the public-transport and police plates, and the three flagless coloured
/// classes — foreign, diplomatic and governmental.
export 'src/tajikistan/tajikistan_plates.dart';

/// The advisory validators: [TajikistanPlateValidator] for the serial /
/// letters / region designs, and one each for the foreign and diplomatic
/// formats. [TajikistanPlates.validatorFor] picks between them.
export 'src/tajikistan/tajikistan_validators.dart';
