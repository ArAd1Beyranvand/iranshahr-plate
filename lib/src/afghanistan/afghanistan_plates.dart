import 'package:flutter/widgets.dart';
import 'package:core_plate/core_plate.dart';

import 'afghanistan_alphabets.dart';
import 'afghanistan_colors.dart';
import 'afghanistan_provinces.dart';

/// The Afghan plate designs, as introduced in 2004 and amended since.
///
/// **One plate, three columns, read right to left.** Every design here is the
/// same three-column row:
///
/// 1. the **class**, at the head of the plate: a Persian letter over its Latin
///    code — `ش` over `PRV`, `ت` over `T`;
/// 2. the **serial**, in the middle: the same three to six figures printed
///    twice, iranian Arabic numerals above and Latin digits below;
/// 3. the **province**, at the tail: its name in Persian or Pashto over the
///    Darul Aman emblem over its three-letter Latin code.
///
/// Only the third of those is in this file by its absence. The province column
/// is a [PlateCountry] and lives in [AfghanistanProvince], because it is the
/// axis a plate varies along at runtime and geometry is the same in Herat as in
/// Kabul. A renderer is handed one:
///
/// ```dart
/// PlateCanvas(
///   spec: AfghanistanPlates.car5,
///   theme: AfghanistanThemes.civilian,
///   country: AfghanistanProvince.herat.country(),
/// )
/// ```
///
/// ## Why there are eleven specs and not eleven classes
///
/// The article tabulates eleven vehicle types. Eight of them are **not** specs
/// here, because what tells a lorry from a taxi is one character in one
/// register and the colour of the field — a class and a livery, never a
/// geometry. They are [car3]/[car4]/[car5] (or [cycle3]/[cycle4] on a
/// two-wheeler's smaller plate) with a different value in the class register
/// and a different `AfghanistanThemes` constant.
///
/// A spec appears here only when the *shape* of the plate changes, and it
/// changes for exactly five reasons:
///
/// * **how many figures the serial has** — [car3], [car4], [car5], and the
///   smaller [cycle3] and [cycle4]. A register's cells are evenly pitched
///   across a span, so a three-figure plate and a five-figure one are two
///   registers and therefore two specs.
/// * **Kabul ran out of numbers.** [kabul6] adds a sixth figure printed only
///   in Persian, set apart from the serial between two hyphens.
/// * **three classes carry no class register at all.** [diplomatic] prints
///   `CD` with no Persian counterpart (and hyphenates its number, which
///   nothing else does), [governmental] prints a dash in both registers, and
///   [un] prints nothing.
/// * **the temporary plate prints in two inks.** [temporary] puts `موقت` where
///   the province code goes and `TEMP` where the Latin class code goes, both
///   in red on an otherwise black-on-white plate.
/// * **the cross-border plate drops the Persian half entirely.** [international]
///   is one row of Latin figures and a spelled-out category.
///
/// ## Calibration
///
/// Every coordinate below is sampled by eye from the plate photographs on the
/// Wikipedia article and is a calibration target. The full-size canvas is
/// 420×175, which is the plate's real size in millimetres; the two-wheeler
/// canvas is 265×105, scaled off the motorcycle and rickshaw photographs, which
/// are a noticeably longer rectangle than the car plate rather than a shrunk
/// copy of it.
///
/// `final`, not `const`: the serial registers are built by [plateRegisterAcross]
/// and [plateEcho], and a `const` constructor cannot run a loop. Initialised
/// lazily, once per isolate; [PlateSpec] equality is over `id` alone, so nothing
/// here depended on const canonicalisation.
abstract final class AfghanistanPlates {
  // ---------------------------------------------------------------------------
  // The full-size plate: 420×175 mm, and every design but the two-wheelers'.
  // ---------------------------------------------------------------------------

  static const double _width = 420;
  static const double _height = 175;

  /// The upper band, where the iranian-numeral serial and the Persian class
  /// letter are printed, and the lower band, where their Latin twins are.
  ///
  /// A band is taller than the figure in it: core sets a glyph at 0.72 of the
  /// height it is handed and centres it, so a cell is about twice the ink it
  /// carries. These two are as deep as two bands can be on a 175-deep plate and
  /// still clear the frame.
  static const double _upperTop = 2;
  static const double _lowerTop = 82;
  static const double _bandHeight = 78;

  /// The right-hand edge of the serial, shared by every full-size design. The
  /// serial's *left* edge moves with how many figures it has — fewer figures
  /// are set wider apart at the same size, which is what the photographs show —
  /// so [_serialLeft] computes it and this stays put.
  static const double _serialRight = 310;

  /// Where a serial of [count] figures starts.
  ///
  /// Three values and not a formula, because the block does not scale with the
  /// serial and no arithmetic over `count` says so honestly: 60 units per
  /// figure at three, 48 at four, 41 at five. Figures are set at one size and
  /// spread to fill, so a three-figure plate reads wider-spaced rather than
  /// bigger — which is what the Takhar, Zabul and Herat photographs show. The
  /// left edge also has [_panel]'s 100 to clear, and a formula that looked
  /// tidy ran under it at five.
  static double _serialLeft(int count) => switch (count) {
    3 => 130,
    4 => 118,
    _ => 106,
  };

  /// The province block: the name, the emblem and the code, printed straight
  /// onto the field.
  ///
  /// Zero padding and a [PlatePanel.flagScale] of 0.82 make the emblem 69 wide,
  /// and 69 at 200:128 is 44 deep — which leaves 112 of the block's 156 to be
  /// split evenly between the name above and the code below.
  /// [PlatePanel.captionScale] is set past what will fit on purpose:
  /// `CountryPanel` puts both lines in a `BoxFit.scaleDown`, so a value too big
  /// means "as large as the block allows" and a value too small would silently
  /// leave half of it empty.
  static const PlatePanel _panel = PlatePanel(
    box: PlateBox(16, 8, 84, 156),
    padding: EdgeInsets.zero,
    flagScale: 0.82,
    captionScale: 1.8,
  );

  /// The Persian class letter, at the head of the upper band.
  static const PlateBox _classBox = PlateBox(337, _upperTop, 60, _bandHeight);

  /// Its Latin twin, under it. Wider than the letter above because the code it
  /// prints can be three characters (`PRV`, `TRC`) where the letter is always
  /// one, and shorter in the glyph because three characters at the band's full
  /// height would run off the end of the plate.
  static const PlateBox _classLatinBox = PlateBox(322, _lowerTop, 90, _bandHeight);
  static const double _classLatinGlyph = 62;

  /// The class register: the letter as a slot, its Latin code as a mirror of
  /// that same slot.
  ///
  /// The mirror is what makes this one value rather than two. A plate does not
  /// carry a Persian class *and* a Latin class that have to be kept in step —
  /// it carries a class, printed twice — so the letter is the slot, the code
  /// echoes it, and no caller can put `ش` over `T`.
  static List<PlateSlot> get _classSlot => const <PlateSlot>[
    PlateSlot(alphabet: AfghanistanAlphabets.vehicleClass, box: _classBox),
  ];

  static PlateMirror _classMirror(int source) => PlateMirror(
    source: source,
    box: _classLatinBox,
    glyphHeight: _classLatinGlyph,
    alphabet: AfghanistanAlphabets.classLatin,
  );

  /// The serial: [count] Latin figures across the lower band, and their iranian
  /// twins above.
  ///
  /// The Latin row is the slot row and the iranian row the mirror, rather than
  /// the other way round: the Latin figures are what a host stores, so they are
  /// the position in the grammar. Both rows are editable, though — the iranian
  /// mirrors are `editable` (see [_serialEcho]) — so the same one value can be
  /// typed in either script, the upper (iranian) row being the primary one the
  /// user reads and reaches for. A keystroke in either row writes the shared
  /// value and the other row re-renders it; storage stays ASCII because core
  /// folds a typed iranian numeral back to its character.
  static List<PlateSlot> _serialSlots(int count) => plateRegisterAcross(
    alphabet: AfghanistanAlphabets.digits,
    count: count,
    left: _serialLeft(count),
    right: _serialRight,
    top: _lowerTop,
    height: _bandHeight,
  );

  static List<PlateMirror> _serialEcho(int count, {int from = 0}) {
    final left = _serialLeft(count);
    final cell = (_serialRight - left) / count;
    return plateEcho(
      sources: <int>[for (var i = 0; i < count; i++) from + i],
      left: left,
      top: _upperTop,
      width: cell,
      height: _bandHeight,
      alphabet: AfghanistanAlphabets.iranianDigits,
      editable: true,
    );
  }

  /// One ordinary plate: [count] figures, a class register, a province block.
  ///
  /// [car3], [car4] and [car5] are three calls to this and differ in one
  /// integer, which is the whole of what separates a Takhar three-figure plate
  /// from a Herat five-figure one. Every class printed on this geometry — a
  /// private car, a lorry, a duplicate, a bus, a taxi — is a value in the class
  /// register and a `PlateTheme`, not another call.
  static PlateSpec _car(int count) => PlateSpec(
    id: 'af.car$count',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[..._serialSlots(count), ..._classSlot],
    mirrors: <PlateMirror>[..._serialEcho(count), _classMirror(count)],
    textGroups: <PlateTextGroup>[
      PlateTextGroup(<int>[count], key: 'class'),
      PlateTextGroup(<int>[for (var i = 0; i < count; i++) i], key: 'serial'),
    ],
  );

  /// The province a spec names when a renderer is handed none.
  ///
  /// Kabul, because a default has to be *some* province and the capital is the
  /// least surprising one. It is a default and nothing more: `PlateCanvas.country`
  /// overrides it, and a host that draws Afghan plates is expected to pass the
  /// province the vehicle is registered in.
  static final PlateCountry _defaultProvince = AfghanistanProvince.kabul.country();

  /// A three-figure plate, e.g. Takhar `١٢٣` / `123`.
  static final PlateSpec car3 = _car(3);

  /// A four-figure plate, e.g. Zabul `١٢٣٤` / `1234`.
  static final PlateSpec car4 = _car(4);

  /// A five-figure plate, e.g. Herat `١٢٣٤٦` / `12346` — the longest an
  /// ordinary province issues.
  static final PlateSpec car5 = _car(5);

  /// Kabul's six-figure plate: a five-figure serial, and a sixth figure set
  /// apart ahead of it between two hyphens.
  ///
  /// Kabul exhausted the five-figure range, and the extra figure was added
  /// where there was room for it rather than by widening the serial — so it is
  /// printed **once, in Persian only**, spanning both bands, with a hyphen
  /// above and below it. That is why it is a slot of its own over
  /// [AfghanistanAlphabets.iranianDigits] and carries no mirror: there is no
  /// Latin twin to echo, and on a plate where everything else is said twice
  /// that is the one thing worth saying about this design.
  ///
  /// It is the plate's most significant figure, so it leads [textGroups]' serial
  /// group. The five that follow have their own register at a tighter left edge
  /// than [car5]'s, to make room for it.
  static final PlateSpec kabul6 = PlateSpec(
    id: 'af.kabul6',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[
      const PlateSlot(alphabet: AfghanistanAlphabets.iranianDigits, box: PlateBox(106, 46, 44, 74)),
      ...plateRegisterAcross(
        alphabet: AfghanistanAlphabets.digits,
        count: 5,
        left: 154,
        right: _serialRight,
        top: _lowerTop,
        height: _bandHeight,
      ),
      ..._classSlot,
    ],
    mirrors: <PlateMirror>[
      ...plateEcho(
        sources: const <int>[1, 2, 3, 4, 5],
        left: 154,
        top: _upperTop,
        width: (_serialRight - 154) / 5,
        height: _bandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      ),
      _classMirror(6),
    ],
    // The two hyphens that bracket the extra figure. Labels and not rules: a
    // hyphen is a character, printed in the serial's own ink at the serial's
    // own size, where a PlateRule takes the theme's divider colour and would
    // read as a dash drawn on the plate rather than as part of the number.
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: PlateBox(106, 4, 44, 38), glyphHeight: 38),
      PlateLabel(text: '-', box: PlateBox(106, 124, 44, 38), glyphHeight: 38),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[6], key: 'class'),
      PlateTextGroup(<int>[0, 1, 2, 3, 4, 5], key: 'serial'),
    ],
  );

  // ---------------------------------------------------------------------------
  // The two-wheeler plate: a shorter, deeper rectangle for a motorcycle or a
  // rickshaw, at 265×105.
  // ---------------------------------------------------------------------------

  static const double _cycleWidth = 265;
  static const double _cycleHeight = 105;
  static const double _cycleUpperTop = 2;
  static const double _cycleLowerTop = 53;
  static const double _cycleBandHeight = 48;
  static const double _cycleSerialRight = 196;

  static const PlatePanel _cyclePanel = PlatePanel(
    box: PlateBox(10, 5, 54, 95),
    padding: EdgeInsets.zero,
    flagScale: 0.82,
    captionScale: 1.8,
  );

  /// A two-wheeler plate with [count] figures: a motorcycle (`م`/`M`) at three,
  /// a rickshaw (`ر`/`TRC`) at four.
  ///
  /// The same three columns as [_car] on a plate two-thirds the width, and the
  /// same rule about what is and is not a spec: which of the two vehicles this
  /// is is a value in the class register, so both share whichever of
  /// [cycle3]/[cycle4] matches their serial length.
  static PlateSpec _cycle(int count) {
    // 82 at three figures, 70 at four — the same "spread, don't grow" rule as
    // [_serialLeft], against [_cyclePanel]'s right edge of 64.
    final left = count == 3 ? 82.0 : 70.0;
    final cell = (_cycleSerialRight - left) / count;
    return PlateSpec(
      id: 'af.cycle$count',
      country: _defaultProvince,
      canvasWidth: _cycleWidth,
      canvasHeight: _cycleHeight,
      textDirection: TextDirection.rtl,
      panel: _cyclePanel,
      slots: <PlateSlot>[
        ...plateRegisterAcross(
          alphabet: AfghanistanAlphabets.digits,
          count: count,
          left: left,
          right: _cycleSerialRight,
          top: _cycleLowerTop,
          height: _cycleBandHeight,
        ),
        const PlateSlot(alphabet: AfghanistanAlphabets.vehicleClass, box: PlateBox(212, _cycleUpperTop, 38, _cycleBandHeight)),
      ],
      mirrors: <PlateMirror>[
        ...plateEcho(
          sources: <int>[for (var i = 0; i < count; i++) i],
          left: left,
          top: _cycleUpperTop,
          width: cell,
          height: _cycleBandHeight,
          alphabet: AfghanistanAlphabets.iranianDigits,
          editable: true,
        ),
        PlateMirror(
          source: count,
          box: const PlateBox(202, _cycleLowerTop, 58, _cycleBandHeight),
          glyphHeight: 40,
          alphabet: AfghanistanAlphabets.classLatin,
        ),
      ],
      textGroups: <PlateTextGroup>[
        PlateTextGroup(<int>[count], key: 'class'),
        PlateTextGroup(<int>[for (var i = 0; i < count; i++) i], key: 'serial'),
      ],
    );
  }

  /// The motorcycle plate, e.g. Nimruz `١٢٣` / `123` with `م` over `M`.
  static final PlateSpec cycle3 = _cycle(3);

  /// The rickshaw plate, e.g. Nangarhar `١٢٣٤` / `1234` with `ر` over `TRC`.
  static final PlateSpec cycle4 = _cycle(4);

  // ---------------------------------------------------------------------------
  // The three classes that carry no class register, and the two that print
  // something else where one would go.
  // ---------------------------------------------------------------------------

  /// The diplomatic plate: white on red, `١٢-٣٤` over `12-34`, with `CD` at the
  /// head and no Persian class letter at all.
  ///
  /// Two things make it a spec rather than a livery. The number is **grouped**,
  /// two and two with a hyphen between, where every other Afghan serial is one
  /// run — and a hyphen is a gap a single evenly-pitched register cannot
  /// express. And `CD` is printed **once**, not twice: there is no Persian code
  /// for the diplomatic corps, so it is a [PlateLabel] on the face rather than
  /// a class slot with a mirror. It sits between the two bands for that reason,
  /// belonging to neither.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'af.diplomatic',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[
      ...plateRegister(alphabet: AfghanistanAlphabets.digits, count: 2, left: 106, top: _lowerTop, width: 42, height: _bandHeight),
      ...plateRegister(alphabet: AfghanistanAlphabets.digits, count: 2, left: 232, top: _lowerTop, width: 42, height: _bandHeight),
    ],
    mirrors: <PlateMirror>[
      ...plateEcho(
        sources: const <int>[0, 1],
        left: 106,
        top: _upperTop,
        width: 42,
        height: _bandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      ),
      ...plateEcho(
        sources: const <int>[2, 3],
        left: 232,
        top: _upperTop,
        width: 42,
        height: _bandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: PlateBox(190, _upperTop, 42, _bandHeight), glyphHeight: _bandHeight),
      PlateLabel(text: '-', box: PlateBox(190, _lowerTop, 42, _bandHeight), glyphHeight: _bandHeight),
      PlateLabel(text: 'CD', box: PlateBox(322, 56, 90, 60), glyphHeight: 54),
    ],
    // Two groups of two and not one of four: the hyphen is a real gap, and a
    // keyed register of four unevenly pitched cells is the exact thing
    // `debugValidateSpec` fails a spec for.
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1], key: 'mission'),
      PlateTextGroup(<int>[2, 3], key: 'serial'),
    ],
  );

  /// The governmental plate: white on black, a four-figure serial, and a dash
  /// in each band where a class code would be.
  ///
  /// The dash is the class — a government vehicle's type is not printed — so it
  /// is fixed wording in both bands rather than a slot with a mirror, and this
  /// is a spec and not [car4] in another livery.
  static final PlateSpec governmental = PlateSpec(
    id: 'af.governmental',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: _serialSlots(4),
    mirrors: _serialEcho(4),
    labels: const <PlateLabel>[
      PlateLabel(text: '—', box: PlateBox(330, _upperTop, 74, _bandHeight), glyphHeight: 56),
      PlateLabel(text: '—', box: PlateBox(330, _lowerTop, 74, _bandHeight), glyphHeight: 56),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2, 3], key: 'serial'),
    ],
  );

  /// The United Nations plate: black on UN blue, a four-figure serial, and
  /// nothing at all where a class would go.
  ///
  /// The plainest Afghan design: the province block and the number, twice.
  static final PlateSpec un = PlateSpec(
    id: 'af.un',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: _serialSlots(4),
    mirrors: _serialEcho(4),
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2, 3], key: 'serial'),
    ],
  );

  /// The temporary plate, issued from September 2023 and valid three years: a
  /// private five-figure plate printed in **two inks**.
  ///
  /// `موقت` ("temporary") takes the place of the province's Latin code at the
  /// foot of the block, and `TEMP` the place of the class code — both in red on
  /// a plate that is otherwise black on white. That second ink is why this is a
  /// spec: [PlateTheme] carries one ink and giving it red would print the
  /// serial red too, so the two red words are [PlateLabel]s with their own
  /// [PlateLabel.color] and the theme stays `AfghanistanThemes.civilian`.
  ///
  /// The class is fixed: only private vehicles are issued these, so `ش` is a
  /// label rather than a class slot, and there is no register for a value that
  /// can only take one.
  ///
  /// **Hand this one a bare province block** —
  /// `AfghanistanProvince.herat.country(showCode: false)` — or the block will
  /// print `HRT` under the emblem and the `موقت` label will land on top of it.
  static final PlateSpec temporary = PlateSpec(
    id: 'af.temporary',
    country: _bareDefaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: _serialSlots(5),
    mirrors: _serialEcho(5),
    labels: const <PlateLabel>[
      PlateLabel(text: 'ش', box: _classBox, glyphHeight: _bandHeight),
      PlateLabel(
        text: 'TEMP',
        box: PlateBox(318, _lowerTop, 98, _bandHeight),
        glyphHeight: 48,
        color: AfghanistanColors.temporaryRed,
      ),
      PlateLabel(
        text: 'موقت',
        box: PlateBox(14, 112, 88, 52),
        glyphHeight: 50,
        color: AfghanistanColors.temporaryRed,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2, 3, 4], key: 'serial'),
    ],
  );

  /// Kabul again, with the block's bottom line suppressed — [temporary]'s
  /// default, for the reason that spec's doc gives.
  static final PlateCountry _bareDefaultProvince = AfghanistanProvince.kabul.country(showCode: false);

  /// The cross-border international plate, issued in Herat from January 2026 to
  /// taxis, buses and cargo lorries running between Afghanistan and Iran.
  ///
  /// **Reconstructed from the article's text, not from a photograph.** No image
  /// of one has been published, and the article says only that the plate bears
  /// Western Arabic numerals and a spelled-out category. So the one thing this
  /// spec asserts confidently is the thing the source states: there is no
  /// iranian-numeral band and no Persian class letter, which makes it the only
  /// Afghan design in this file that says anything once. Everything else here —
  /// a five-figure serial on one centred row, the category at the head, the
  /// province block unchanged — is a reasonable reading of "like the others,
  /// minus the Persian half" and should be recalibrated the day a photograph
  /// appears. // CALIBRATE
  static final PlateSpec international = PlateSpec(
    id: 'af.international',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.ltr,
    panel: _panel,
    slots: <PlateSlot>[
      ...plateRegisterAcross(
        alphabet: AfghanistanAlphabets.digits,
        count: 5,
        left: 112,
        right: 306,
        top: 40,
        height: 96,
      ),
      // The category, not a class: `CARGO` names the service the vehicle runs,
      // where `L` names what it is registered as. Shorter in the glyph than
      // anything else on the plate because five characters at a serial figure's
      // height would be half the plate wide.
      const PlateSlot(alphabet: AfghanistanAlphabets.internationalCategory, box: PlateBox(316, 68, 98, 40)),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0, 1, 2, 3, 4], key: 'serial'),
      PlateTextGroup(<int>[5], key: 'category'),
    ],
  );

  /// Every Afghan geometry, in the order they are introduced above. A picker
  /// iterates this rather than naming eleven constants.
  ///
  /// Eleven specs, and rather more than eleven plates on the road: a bus, a
  /// taxi, a lorry, a private car and a duplicate are all [car5] with a
  /// different class and a different theme, and any of the five can be a
  /// three- or four-figure plate instead. A picker that wants to offer a taxi
  /// offers `(car5, AfghanistanThemes.transport, 'T')`.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    car3,
    car4,
    car5,
    kabul6,
    cycle3,
    cycle4,
    diplomatic,
    governmental,
    un,
    temporary,
    international,
  ]);
}
