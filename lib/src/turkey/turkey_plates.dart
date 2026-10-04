import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import 'turkey_alphabets.dart';
import 'turkey_colors.dart';
import 'turkey_country.dart';

/// Where the ink sits, in plate millimetres. Measured off the SVG artwork on
/// Wikimedia Commons linked from Wikipedia's "Vehicle registration plates of
/// Turkey", normalising each file's plate rectangle to the article's 520x110.
/// The artwork is drawn at 4.48:1 against the documented 4.73:1, so x is
/// stretched proportionally.
///
/// Every current design prints one row of ink, y 23.8..85.8 (62 tall), centred
/// on the field the strip leaves: x 284.4 on a strip plate (ink extents of all
/// nine strip references centre within 1 mm of it), x 260 on a stripless one.
///
/// Core paints a bold Roboto cap at about 0.51 of the box height, so the 62
/// would need a 121 box on a 110 plate. [rowHeight] is the tallest box that
/// stays on the canvas about the measured centre, and the ink comes out about
/// 90% of reference.
abstract final class _Layout {
  static const double width = 520;
  static const double height = 110;

  static const double rowCentre = 54.8;
  static const double rowHeight = 2 * rowCentre;

  /// The artwork's figures sit at a 44 pitch ("1234": right edges 394.5,
  /// 436.7, 483.0), its letters at 52 (`A`/`B`, `S`/`A`/`B` centres), and
  /// groups are a space of 14 apart: that reproduces the ink extent of the
  /// private plate (396 measured, 397 here), the foreign-resident plate
  /// (364 / 357) and the gendarmerie plate (439 / 446).
  static const double digitPitch = 44;
  static const double letterPitch = 52;

  /// A letter box's width over its pitch: Roboto Bold's M is ~0.87 em, 69 at
  /// this row's font size, against a 52 pitch. At full width it crowds its
  /// neighbours, so it is let scale ~10% down rather than ~25%.
  static const double letterBoxRatio = 1.2;
  static const double groupGap = 14;

  /// The TR strip, x 0..51.6, under the frame to the plate's edge.
  static const double stripEnd = 51.6;
  static const double stripCentre = 284.4;
  static const double plainCentre = width / 2;

  /// "TR": ink x 9.3..43.1, y 71.2..95.4 (24.2 tall). Roboto's TR is wider
  /// than the plate face's, so it is set a little smaller and further right
  /// to sit inside the strip rather than run into the field.
  static const PlateBox trBox = PlateBox(12, 71.2, 33.8, 24.2);
  static const double trGlyph = 21.5 / ink;

  /// The taxi plate's black rule at the strip edge, x 49.6..53.2.
  static const double taxiDivider = 3.5;

  /// The temporary plate's white stripe falls 0.21 per mm left to right
  /// (centres y 62.9 at x 300, 91 at x 450), 18.8 tall measured vertically,
  /// crossing the field's centreline at y 52.
  static const double stripeAngle = -0.207;
  static const double stripeTop = 52 - 9.4;
  static const double stripeBottom = 52 + 9.4;

  /// The sample plate: a blue band x 172.2..374.4 between the province code
  /// (ink x 77.9..159.9) and the serial (ink x 383.4..489); "NUMUNE" ink
  /// x 213..333, y 22.7..47.3, "PLAKA" x 226..319, y 62.4..87.
  static const double sampleBandStart = 172.2;
  static const double sampleBandEnd = 374.4;
  static const double sampleProvinceCentre = 118.9;
  static const double sampleSerialCentre = 436.2;

  /// Roboto's figures are wider than the plate face's, so at [digitPitch] the
  /// serial's first figure touches the band; a 38 pitch scales them down to
  /// clear it, as the reference does.
  static const double sampleSerialPitch = 38;
  static const double sampleCaptionGlyph = 24.6 / ink;

  /// Parliament's labelled plate: "TBMM" ink x 54..194.6, y 47.7..84.6; its
  /// serial ink x 339.6..461.5.
  static const double tbmmGlyph = 36.9 / ink;
  static const double tbmmSerialCentre = 400.5;

  /// Bold Roboto's cap height at core's 0.72 glyph scale.
  static const double ink = 0.512;
}

/// The motorcycle plate, 240x150 — the article's 150x240 — measured off the
/// one photograph the article carries (no artwork exists), so to perhaps 2 mm.
///
/// Two rows: province and letters over the serial, and the TR strip in the
/// bottom-left corner only, x 0..36.3 below y 89. The photograph's rows are
/// 66 and 63 tall; boxes that fit the canvas give about 60% of that.
abstract final class _Moto {
  static const double width = 240;
  static const double height = 150;

  /// Top row: "34" at a 40 pitch, "UF" at 54, ink x 11.9..236.5.
  static const double topCentre = 124;
  static const double topTop = 0;
  static const double topHeight = 79;
  static const double topDigitPitch = 40;
  static const double topLetterPitch = 54;
  static const double topGap = 40;

  /// Bottom row: "2409" at a 42.3 pitch, ink x 49.2..213.6.
  static const double bottomCentre = 131.4;
  static const double bottomTop = 79;
  static const double bottomHeight = 71;
  static const double bottomPitch = 42.3;

  static const double stripTop = 89;
  static const double stripEnd = 36.3;

  /// "TR": ink x 8..30, y 130.9..145.5.
  static const PlateBox trBox = PlateBox(10, 130.9, 22, 14.6);
  static const double trGlyph = 13.6 / _Layout.ink;
}

/// One register of a row: its key, alphabet, length and pitch.
typedef _Run = (String key, PlateAlphabet alphabet, int count, double pitch);

/// The current Turkish plates (1996 onwards): `99 X 9999` to `99 XXX 999`, a
/// province code, one to three letters and two to five figures.
///
/// Every design is one of three shapes, and each shape is one builder:
///
/// - [strip] — the TR strip at the hoist, one row centred on the field right
///   of it. Private and commercial, international organisations, diplomatic,
///   temporary customs, foreign and Syrian residents, Istanbul taxis.
/// - [plain] — no strip, one row centred on the plate. Police, gendarmerie,
///   coast guard, consulates, provincial governments, official vehicles and,
///   with no letters, province governors.
/// - [motorcycle] — two rows, the strip in one corner.
///
/// Letter and figure counts are parameters, never forks; colour lives on the
/// [TurkeyThemes] a host passes. On top of the three: [taxi] adds a rule at
/// the strip, the two temporary plates a diagonal stripe, [sample] a caption
/// band, and the parliament plates print no province.
///
/// Not implemented: the presidential plate and parliament's emblem plate, both
/// of which print a seal (a crest — artwork, not geometry); the
/// stencilled military number, which is painted on the bumper rather than a
/// plate; the 210x320 and 150x300 sizes, for which the article has no
/// artwork; and the pre-1996 and pre-1962 series.
abstract final class TurkeyPlates {
  static const PlatePanel _noPanel = PlatePanel(
    box: PlateBox(0, 0, 0, 0),
    padding: EdgeInsets.zero,
  );

  static const PlateSection _stripColumn = PlateSection.fill(
    PlateFill.color(TurkeyColors.stripBlue),
  );

  static const PlateLabel _tr = PlateLabel(
    text: 'TR',
    box: _Layout.trBox,
    glyphHeight: _Layout.trGlyph,
    color: TurkeyColors.white,
  );

  static List<_Run> _standardRuns(int letters, int digits) => <_Run>[
    ('province', TurkeyAlphabets.digits, 2, _Layout.digitPitch),
    if (letters > 0)
      ('letters', TurkeyAlphabets.letters, letters, _Layout.letterPitch),
    ('serial', TurkeyAlphabets.digits, digits, _Layout.digitPitch),
  ];

  /// [runs] laid end to end, [gap] apart, centred on [centre].
  static (List<PlateSlot>, List<PlateTextGroup>) _row(
    List<_Run> runs, {
    required double centre,
    double top = 0,
    double height = _Layout.rowHeight,
    double gap = _Layout.groupGap,
    double letterBoxRatio = _Layout.letterBoxRatio,
    int firstIndex = 0,
  }) {
    var span = gap * (runs.length - 1);
    for (final r in runs) {
      span += r.$3 * r.$4;
    }
    var left = centre - span / 2;
    var index = firstIndex;
    final slots = <PlateSlot>[];
    final groups = <PlateTextGroup>[];
    for (final (key, alphabet, count, pitch) in runs) {
      // A letter box is wider than its pitch so a scaled-down slot does not
      // shrink Roboto's M, the one letter wider than the pitch.
      final width = identical(alphabet, TurkeyAlphabets.letters)
          ? pitch * letterBoxRatio
          : pitch;
      slots.addAll(
        plateRegister(
          alphabet: alphabet,
          count: count,
          left: left - (width - pitch) / 2,
          top: top,
          width: width,
          pitch: pitch,
          height: height,
        ),
      );
      groups.add(
        PlateTextGroup(<int>[
          for (var i = 0; i < count; i++) index + i,
        ], key: key),
      );
      index += count;
      left += count * pitch + gap;
    }
    return (slots, groups);
  }

  static PlateSpec _spec({
    required String id,
    required (List<PlateSlot>, List<PlateTextGroup>) row,
    PlateSection background = PlateSection.plain,
    List<PlateLabel> labels = const <PlateLabel>[],
    double width = _Layout.width,
    double height = _Layout.height,
  }) => PlateSpec(
    id: id,
    country: TurkeyCountry.turkey,
    canvasWidth: width,
    canvasHeight: height,
    noPanel: true,
    panel: _noPanel,
    background: background,
    slots: row.$1,
    textGroups: row.$2,
    labels: labels,
  );

  static PlateSection _withStrip(PlateSection field, {double divider = 0}) =>
      PlateSection.columns(<PlatePart>[
        PlatePart(_stripColumn, end: _Layout.stripEnd, divider: divider),
        PlatePart(field),
      ]);

  static final Map<String, PlateSpec> _cache = <String, PlateSpec>{};

  /// A TR-strip plate printing `99`, [letters] letters and [digits] figures.
  static PlateSpec strip(int letters, int digits) =>
      _cache.putIfAbsent('tr.strip.$letters.$digits', () {
        return _spec(
          id: 'tr.strip.$letters.$digits',
          row: _row(
            _standardRuns(letters, digits),
            centre: _Layout.stripCentre,
          ),
          background: _withStrip(PlateSection.plain),
          labels: const <PlateLabel>[_tr],
        );
      });

  /// A stripless plate printing `99`, [letters] letters (none on a
  /// governor's plate) and [digits] figures.
  static PlateSpec plain(int letters, int digits) =>
      _cache.putIfAbsent('tr.plain.$letters.$digits', () {
        return _spec(
          id: 'tr.plain.$letters.$digits',
          row: _row(
            _standardRuns(letters, digits),
            centre: _Layout.plainCentre,
          ),
        );
      });

  /// A motorcycle plate: `99` and [letters] letters over [digits] figures.
  static PlateSpec motorcycle(int letters, int digits) =>
      _cache.putIfAbsent('tr.motorcycle.$letters.$digits', () {
        final top = _row(
          <_Run>[
            ('province', TurkeyAlphabets.digits, 2, _Moto.topDigitPitch),
            ('letters', TurkeyAlphabets.letters, letters, _Moto.topLetterPitch),
          ],
          centre: _Moto.topCentre,
          top: _Moto.topTop,
          height: _Moto.topHeight,
          gap: _Moto.topGap,
          // At this row's size an M fits its pitch, and the letters reach the
          // right edge, so a wider box would leave the canvas.
          letterBoxRatio: 1,
        );
        final bottom = _row(
          <_Run>[('serial', TurkeyAlphabets.digits, digits, _Moto.bottomPitch)],
          centre: _Moto.bottomCentre,
          top: _Moto.bottomTop,
          height: _Moto.bottomHeight,
          firstIndex: 2 + letters,
        );
        return _spec(
          id: 'tr.motorcycle.$letters.$digits',
          width: _Moto.width,
          height: _Moto.height,
          row: (<PlateSlot>[...top.$1, ...bottom.$1], [...top.$2, ...bottom.$2]),
          background: const PlateSection.rows(<PlatePart>[
            PlatePart(PlateSection.plain, end: _Moto.stripTop),
            PlatePart(
              PlateSection.columns(<PlatePart>[
                PlatePart(_stripColumn, end: _Moto.stripEnd),
                PlatePart(PlateSection.plain),
              ]),
            ),
          ]),
          labels: const <PlateLabel>[
            PlateLabel(
              text: 'TR',
              box: _Moto.trBox,
              glyphHeight: _Moto.trGlyph,
              color: TurkeyColors.white,
            ),
          ],
        );
      });

  // -------------------------------------------------------------------------
  // The named plates: one per category in the article's "Types" table, each a
  // format of the builders above. Pair each with its TurkeyThemes livery.
  // -------------------------------------------------------------------------

  /// Private and commercial vehicles, `99 XX 9999` — the article's example.
  /// Any of the six formats is [strip] with its counts.
  static final PlateSpec private = strip(2, 4);

  /// Members of international organisations, `99 B 9999`, blue on white.
  static final PlateSpec internationalOrganization = strip(1, 4);

  /// Diplomatic corps, `99 CD 999`, green on white.
  static final PlateSpec diplomatic = strip(2, 3);

  /// Temporary customs, `99 GMR 999`, red on green.
  static final PlateSpec temporaryCustoms = strip(3, 3);

  /// Foreigners with a residence permit, `99 MA 999` to `99 MZ 999`.
  static final PlateSpec foreignResident = strip(2, 3);

  /// Syrians with a residence permit, `99 SAA 999` to `99 SZZ 999`.
  static final PlateSpec syrianResident = strip(3, 3);

  /// Istanbul taxis, `34 TAA 99` to `34 TKZ 99`.
  static final PlateSpec istanbulTaxi = strip(3, 2);

  /// Taxis outside Istanbul, `99 T 9999`: the strip closed by a black rule.
  static final PlateSpec taxi = _spec(
    id: 'tr.taxi',
    row: _row(_standardRuns(1, 4), centre: _Layout.stripCentre),
    background: _withStrip(PlateSection.plain, divider: _Layout.taxiDivider),
    labels: const <PlateLabel>[_tr],
  );

  static const PlateSection _temporaryField = PlateSection.fill(
    PlateFill.stripes(
      <PlateFill>[
        PlateFill.field,
        PlateFill.color(TurkeyColors.white),
        PlateFill.field,
      ],
      stops: <double>[_Layout.stripeTop, _Layout.stripeBottom],
      angle: _Layout.stripeAngle,
    ),
  );

  /// Temporary transport, `99 G 9999`, black on yellow under a white diagonal
  /// stripe, without the strip.
  static final PlateSpec temporary = _spec(
    id: 'tr.temporary',
    row: _row(_standardRuns(1, 4), centre: _Layout.plainCentre),
    background: _temporaryField,
  );

  /// The same with the TR strip, as issued since 1996; the stripe runs over
  /// the field right of it.
  static final PlateSpec temporaryWithStrip = _spec(
    id: 'tr.temporary.strip',
    row: _row(_standardRuns(1, 4), centre: _Layout.stripCentre),
    background: _withStrip(_temporaryField),
    labels: const <PlateLabel>[_tr],
  );

  /// Police, `99 A 99999` (also `99 AA 999` and `99 AAA 999`), white on blue.
  static final PlateSpec police = plain(1, 5);

  /// Gendarmerie, `99 JAA 9999`; the article's format says three figures, its
  /// artwork prints four.
  static final PlateSpec gendarmerie = plain(3, 4);

  /// Coast guard, `99 SGH 9999`, likewise.
  static final PlateSpec coastGuard = plain(3, 4);

  /// Consulates, `99 CC 9999`, white on green. The artwork prints `34 CC 001`.
  static final PlateSpec consulate = plain(2, 4);

  /// Provincial governments and university rectors, `99 AA 999`, red.
  static final PlateSpec provincialGovernment = plain(2, 3);

  /// Government and public administrations, `99 AA 999`, white on black.
  static final PlateSpec official = plain(2, 3);

  /// Province governors, `99 9999`, gold on red.
  static final PlateSpec governor = plain(0, 4);

  /// The sample plate, `99 NUMUNE PLAKA 999`: the province code and a serial
  /// either side of a blue band captioned in white. The frame is broken where
  /// the band meets it on the artwork; core draws an unbroken frame.
  static final PlateSpec sample = _spec(
    id: 'tr.sample',
    row: () {
      final province = _row(<_Run>[
        ('province', TurkeyAlphabets.digits, 2, _Layout.digitPitch),
      ], centre: _Layout.sampleProvinceCentre);
      final serial = _row(
        <_Run>[
          ('serial', TurkeyAlphabets.digits, 3, _Layout.sampleSerialPitch),
        ],
        centre: _Layout.sampleSerialCentre,
        firstIndex: 2,
      );
      return (
        <PlateSlot>[...province.$1, ...serial.$1],
        <PlateTextGroup>[...province.$2, ...serial.$2],
      );
    }(),
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(_stripColumn, end: _Layout.stripEnd),
      PlatePart(PlateSection.plain, end: _Layout.sampleBandStart),
      PlatePart(_stripColumn, end: _Layout.sampleBandEnd),
      PlatePart(PlateSection.plain),
    ]),
    labels: const <PlateLabel>[
      _tr,
      PlateLabel(
        text: 'NUMUNE',
        box: PlateBox(213, 22.7, 120, 24.6),
        glyphHeight: _Layout.sampleCaptionGlyph,
        color: TurkeyColors.white,
      ),
      PlateLabel(
        text: 'PLAKA',
        box: PlateBox(226, 62.4, 93, 24.6),
        glyphHeight: _Layout.sampleCaptionGlyph,
        color: TurkeyColors.white,
      ),
    ],
  );

  /// Parliament's officers, a four-figure number alone, gold on red.
  static final PlateSpec parliament = _spec(
    id: 'tr.parliament',
    row: _row(<_Run>[
      ('serial', TurkeyAlphabets.digits, 4, _Layout.digitPitch),
    ], centre: _Layout.plainCentre),
  );

  /// Parliament's deputy speaker and commission chairs: "TBMM" and three
  /// figures.
  static final PlateSpec parliamentLabelled = _spec(
    id: 'tr.parliament.labelled',
    row: _row(<_Run>[
      ('serial', TurkeyAlphabets.digits, 3, _Layout.digitPitch),
    ], centre: _Layout.tbmmSerialCentre),
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'TBMM',
        box: PlateBox(54, 47.7, 140.6, 36.9),
        glyphHeight: _Layout.tbmmGlyph,
      ),
    ],
  );
}
