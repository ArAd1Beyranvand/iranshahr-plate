/// Bahrain's, Azerbaijan's, Afghanistan's, Armenia's, Tajikistan's, Kuwait's,
/// Qatar's, Iraq's, the UAE's, Turkey's and Oman's licence plates for the `core_plate` library.
///
/// Data, not code: [PlateCountry]s, [PlateAlphabet]s and [PlateSpec]s that the
/// core widget layer paints. Nothing here knows about any other country
/// package.
///
/// ```dart
/// PlateCanvas(spec: BahrainPlates.eu, theme: BahrainThemes.civilian, ...)
/// PlateCanvas(spec: AzerbaijanPlates.car, theme: AzerbaijanThemes.civilian, ...)
/// PlateCanvas(spec: KuwaitPlates.civilian, theme: KuwaitThemes.civilian, ...)
/// PlateCanvas(spec: QatarPlates.civilian, theme: QatarThemes.civilian, ...)
/// ```
///
/// The countries live side by side here and share nothing: `src/bahrain/`
/// for Bahrain, `src/azerbaijan/` for Azerbaijan, `src/kuwait/` for Kuwait,
/// no import across any line, and no constant in common. Each country's designs
/// are its own — Bahrain's grey security band and its wording set as labels
/// rather than as a panel caption, Azerbaijan's single white country block on
/// four differently coloured fields, Kuwait's simple design with coloured fields
/// for each vehicle class — and are described in `BahrainPlates`,
/// `AzerbaijanPlates`, `KuwaitPlates`, and so on.
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

// ---------------------------------------------------------------------------
// Kuwait. A sixth country on the same terms as the first five: its own folder
// (`src/kuwait/`), no import across any line, and no constant shared with any
// of them.
//
// Kuwait adopted its current plate format in 2008. The standard format is
// "12-45678" (2 digits, hyphen, 5 digits), with the country block at the hoist
// end displaying the flag and "دولة الكويت" (State of Kuwait). The field colour
// varies by vehicle class: white for civilians, yellow for public transport,
// red for police, blue for government, and various colours for other special
// classes.
// ---------------------------------------------------------------------------

/// The field-and-ink pairs every Kuwaiti plate is printed in.
export 'src/kuwait/kuwait_colors.dart';

/// The country blocks that go in a Kuwaiti plate's panel: the flag and caption,
/// on various coloured fields for different vehicle classes.
export 'src/kuwait/kuwait_country.dart';

/// The liveries — civilian white, transport yellow, police red, government
/// blue, and eight other colours for special vehicle classes — that print the
/// specs below.
export 'src/kuwait/kuwait_themes.dart';

/// The thirteen Kuwaiti plate specs: civilian private vehicles, public transport,
/// police, government, diplomatic, national guard, military, commercial,
/// construction, firefighting, export, customs, and Emiri Bureau.
export 'src/kuwait/kuwait_plates.dart';

// ---------------------------------------------------------------------------
// Qatar. A seventh country on the same terms as the first six: its own folder
// (`src/qatar/`), no import across any line, and no constant shared with any of
// them.
//
// It is the one country here whose country block is not a rectangle. A Qatari
// plate opens with the hoist end of the flag itself — a maroon column cut down
// its inboard edge by the flag's nine-point serration, with `QATAR` reversed
// out of it one letter per line — so the block carries no flag image and needs
// a shape no `PlateBox` can describe. That shape is `QatarFlagEdgeClipper`,
// handed to `PlatePanel.shape`, and its geometry is taken from the official
// flag construction rather than eyeballed: nine triangles whose tips reach 6
// units inboard of a spine at 22/28 of the block's width.
// ---------------------------------------------------------------------------

/// The field-and-ink pairs every Qatari plate is printed in, including the
/// official `#8a1538` maroon of the hoist block.
export 'src/qatar/qatar_colors.dart';

/// The serrated edge of the hoist block: the flag's own nine-point geometry,
/// as a clipper for [PlatePanel.shape].
export 'src/qatar/qatar_clippers.dart';

/// The two Qatari country blocks — the maroon civilian hoist and the police
/// plate's blue field — neither of which carries a flag asset or a caption.
export 'src/qatar/qatar_country.dart';

/// The two liveries: civilian black on white, and police white on blue.
export 'src/qatar/qatar_themes.dart';

/// The five Qatari plate specs: the civilian plate at each of its three serial
/// lengths, the motorcycle plate, and the police plate.
export 'src/qatar/qatar_plates.dart';

// ---------------------------------------------------------------------------
// Iraq. An eighth country on the same terms as the first seven: its own folder
// (`src/iraq/`), no import across any line, and no constant shared with any of
// them.
// ---------------------------------------------------------------------------

/// The six band colours, the one field and the two inks every Iraqi plate is
/// printed in.
export 'src/iraq/iraq_colors.dart';

/// The digits and class letters that compose an Iraqi registration.
export 'src/iraq/iraq_alphabets.dart';

/// The governorate codes, and the left band in each of its six class colours.
export 'src/iraq/iraq_country.dart';

/// One theme per canvas — 520x110, 335x155, and the red-on-white temporary —
/// since the frame is a ratio of the plate's height.
export 'src/iraq/iraq_themes.dart';

/// The five Iraqi plate specs: both sizes in both regional designs, plus the
/// temporary plate.
export 'src/iraq/iraq_plates.dart';

/// The advisory validator, including the Kurdistan Region's transition rules.
export 'src/iraq/iraq_validators.dart';

// ---------------------------------------------------------------------------
// United Arab Emirates. A ninth country on the same terms as the first eight:
// its own folder (`src/uae/`), no import across any line, and no constant
// shared with any of them.
//
// Each of the seven emirates prints its own design, in a long 520x110 and a
// short 335x155 size, all black on white save Abu Dhabi's red code panel.
// ---------------------------------------------------------------------------

/// Black, white, and Abu Dhabi's red.
export 'src/uae/uae_colors.dart';

/// The digits and code letters that compose a UAE registration.
export 'src/uae/uae_alphabets.dart';

/// The panel-less country value every UAE spec carries.
export 'src/uae/uae_country.dart';

/// One theme per canvas, long and short.
export 'src/uae/uae_themes.dart';

/// The fourteen UAE plate specs: seven emirates, two sizes each.
export 'src/uae/uae_plates.dart';

/// The advisory validators: each emirate's codes and the serial.
export 'src/uae/uae_validators.dart';

// ---------------------------------------------------------------------------
// Turkey. A tenth country on the same terms as the first nine: its own folder
// (`src/turkey/`), no import across any line, and no constant shared with any
// of them.
//
// Every current design is one row of ink — a province code, one to three
// letters, two to five figures — on one of three shapes: with the blue TR
// strip, without it, or the two-row motorcycle plate. The counts are
// parameters of one builder per shape, and the class lives in the livery.
// ---------------------------------------------------------------------------

/// The field, ink and frame colours every Turkish plate is printed in.
export 'src/turkey/turkey_colors.dart';

/// The province figures and the 23 serial letters.
export 'src/turkey/turkey_alphabets.dart';

/// The panel-less country value every Turkish spec carries.
export 'src/turkey/turkey_country.dart';

/// The ten liveries, from civilian black on white to the state's gold on red.
export 'src/turkey/turkey_themes.dart';

/// The strip, stripless and motorcycle builders and the named category plates.
export 'src/turkey/turkey_plates.dart';

/// The advisory validator: province codes, letters, class prefixes, and the
/// six-character limit.
export 'src/turkey/turkey_validators.dart';

// ---------------------------------------------------------------------------
// Oman. An eleventh country on the same terms as the others: its own folder
// (`src/oman/`), no import across any line, and no constant shared with any
// of them.
//
// One three-panel design — number, letters, `عمان` — in two liveries, black on
// yellow for private cars and white on red for taxis. The digit count (four or
// five) and the letter count (one or two) are parameters of one builder.
// ---------------------------------------------------------------------------

/// The yellow, red, black and white every Omani plate is printed in.
export 'src/oman/oman_colors.dart';

/// The digits and the Latin and Arabic letter rows.
export 'src/oman/oman_alphabets.dart';

/// The panel-less country value every Omani spec carries.
export 'src/oman/oman_country.dart';

/// The private and taxi liveries.
export 'src/oman/oman_themes.dart';

/// The standard builder and its four named forms.
export 'src/oman/oman_plates.dart';

/// The advisory validator: every group complete.
export 'src/oman/oman_validators.dart';
