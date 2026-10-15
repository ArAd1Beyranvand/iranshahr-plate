import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'afghanistan_alphabets.dart';
import 'afghanistan_colors.dart';
import 'afghanistan_provinces.dart';

/// Afghan plates: class (Persian letter over Latin code), serial (3–6 figures,
/// above/below), province (name, emblem, code). Province is a [PlateCountry]
/// (varies at runtime). Specs only where *shape* changes: Kabul6 extra digit, diplomatic/governmental/UN no-class forms, temporary's
/// two inks, international's Latin-only row. Geometry calibrated by eye from
/// Wikipedia; 420×175 mm full-size, 265×105 mm two-wheeler. `final` not `const`.
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

  /// The serial's edges on a full-size plate. One field box spans them for the
  /// longest run; a shorter run sits centred in it.
  static const double _serialLeft = 106;
  static const double _serialRight = 310;

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

  static const PlateBox _classBox = PlateBox(337, _upperTop, 60, _bandHeight);
  static const PlateBox _classLatinBox = PlateBox(
    322,
    _lowerTop,
    90,
    _bandHeight,
  );
  static const double _classLatinGlyph = 62;

  /// Class as slot, code as mirror (one value, printed twice).
  static List<PlateSlot> get _classSlot => const <PlateSlot>[
    PlateSlot(alphabet: AfghanistanAlphabets.vehicleClass, box: _classBox),
  ];

  static PlateMirror _classMirror(int source) => PlateMirror(
    source: source,
    box: _classLatinBox,
    glyphHeight: _classLatinGlyph,
    alphabet: AfghanistanAlphabets.classLatin,
  );

  /// Serial: [count] Latin figures lower, one field; the Iranian echo is above.
  static PlateSlot _serial(
    int count, {
    double left = _serialLeft,
    int? minLength,
  }) => plateField(
    alphabet: AfghanistanAlphabets.digits,
    count: count,
    left: left,
    width: (_serialRight - left) / count,
    top: _lowerTop,
    height: _bandHeight,
    minLength: minLength,
  );

  static PlateMirror _serialEcho(int source, {double left = _serialLeft}) =>
      PlateMirror(
        source: source,
        box: PlateBox(left, _upperTop, _serialRight - left, _bandHeight),
        glyphHeight: _bandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      );

  /// Ordinary plate: three to five figures, class register, province block.
  static final PlateSpec car = PlateSpec(
    id: 'af.car',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[_serial(5, minLength: 3), ..._classSlot],
    mirrors: <PlateMirror>[_serialEcho(0), _classMirror(1)],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[1], key: 'class'),
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );

  /// The province a spec names when a renderer is handed none.
  ///
  /// Kabul, because a default has to be *some* province and the capital is the
  /// least surprising one. It is a default and nothing more: `PlateCanvas.country`
  /// overrides it, and a host that draws Afghan plates is expected to pass the
  /// province the vehicle is registered in.
  static final PlateCountry _defaultProvince = AfghanistanProvince.kabul
      .country();

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
  /// than [car]'s, to make room for it.
  static final PlateSpec kabul6 = PlateSpec(
    id: 'af.kabul6',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: AfghanistanAlphabets.iranianDigits,
        box: PlateBox(106, 46, 44, 74),
      ),
      _serial(5, left: 154),
      ..._classSlot,
    ],
    mirrors: <PlateMirror>[_serialEcho(1, left: 154), _classMirror(2)],
    // The two hyphens that bracket the extra figure. Labels and not rules: a
    // hyphen is a character, printed in the serial's own ink at the serial's
    // own size, where a PlateRule takes the theme's divider colour and would
    // read as a dash drawn on the plate rather than as part of the number.
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: PlateBox(106, 4, 44, 38), glyphHeight: 38),
      PlateLabel(text: '-', box: PlateBox(106, 124, 44, 38), glyphHeight: 38),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[2], key: 'class'),
      PlateTextGroup(<int>[0, 1], key: 'serial'),
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

  /// The two-wheeler plate: three figures for a motorcycle (`م`/`M`), four for
  /// a rickshaw (`ر`/`TRC`). Which vehicle it is is a value in the class field.
  static final PlateSpec cycle = PlateSpec(
    id: 'af.cycle',
    country: _defaultProvince,
    canvasWidth: _cycleWidth,
    canvasHeight: _cycleHeight,
    textDirection: TextDirection.rtl,
    panel: _cyclePanel,
    slots: <PlateSlot>[
      plateField(
        alphabet: AfghanistanAlphabets.digits,
        count: 4,
        left: 70,
        width: (_cycleSerialRight - 70) / 4,
        top: _cycleLowerTop,
        height: _cycleBandHeight,
        minLength: 3,
      ),
      const PlateSlot(
        alphabet: AfghanistanAlphabets.vehicleClass,
        box: PlateBox(212, _cycleUpperTop, 38, _cycleBandHeight),
      ),
    ],
    mirrors: const <PlateMirror>[
      PlateMirror(
        source: 0,
        box: PlateBox(
          70,
          _cycleUpperTop,
          _cycleSerialRight - 70,
          _cycleBandHeight,
        ),
        glyphHeight: _cycleBandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      ),
      PlateMirror(
        source: 1,
        box: PlateBox(202, _cycleLowerTop, 58, _cycleBandHeight),
        glyphHeight: 40,
        alphabet: AfghanistanAlphabets.classLatin,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[1], key: 'class'),
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );

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
      plateField(
        alphabet: AfghanistanAlphabets.digits,
        count: 2,
        left: 106,
        top: _lowerTop,
        width: 42,
        height: _bandHeight,
      ),
      plateField(
        alphabet: AfghanistanAlphabets.digits,
        count: 2,
        left: 232,
        top: _lowerTop,
        width: 42,
        height: _bandHeight,
      ),
    ],
    mirrors: const <PlateMirror>[
      PlateMirror(
        source: 0,
        box: PlateBox(106, _upperTop, 84, _bandHeight),
        glyphHeight: _bandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      ),
      PlateMirror(
        source: 1,
        box: PlateBox(232, _upperTop, 84, _bandHeight),
        glyphHeight: _bandHeight,
        alphabet: AfghanistanAlphabets.iranianDigits,
        editable: true,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '-',
        box: PlateBox(190, _upperTop, 42, _bandHeight),
        glyphHeight: _bandHeight,
      ),
      PlateLabel(
        text: '-',
        box: PlateBox(190, _lowerTop, 42, _bandHeight),
        glyphHeight: _bandHeight,
      ),
      PlateLabel(text: 'CD', box: PlateBox(322, 56, 90, 60), glyphHeight: 54),
    ],
    // Two groups of two and not one of four: the hyphen is a real gap, and a
    // keyed register of four unevenly pitched cells is the exact thing
    // `debugValidateSpec` fails a spec for.
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'mission'),
      PlateTextGroup(<int>[1], key: 'serial'),
    ],
  );

  /// The governmental plate: white on black, a four-figure serial, and a dash
  /// in each band where a class code would be.
  ///
  /// The dash is the class — a government vehicle's type is not printed — so it
  /// is fixed wording in both bands rather than a slot with a mirror, and this
  /// is a spec and not [car] in another livery.
  static final PlateSpec governmental = PlateSpec(
    id: 'af.governmental',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[_serial(4, left: 118)],
    mirrors: <PlateMirror>[_serialEcho(0, left: 118)],
    labels: const <PlateLabel>[
      PlateLabel(
        text: '—',
        box: PlateBox(330, _upperTop, 74, _bandHeight),
        glyphHeight: 56,
      ),
      PlateLabel(
        text: '—',
        box: PlateBox(330, _lowerTop, 74, _bandHeight),
        glyphHeight: 56,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
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
    slots: <PlateSlot>[_serial(4, left: 118)],
    mirrors: <PlateMirror>[_serialEcho(0, left: 118)],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
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
    slots: <PlateSlot>[_serial(5)],
    mirrors: <PlateMirror>[_serialEcho(0)],
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
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );

  /// Kabul again, with the block's bottom line suppressed — [temporary]'s
  /// default, for the reason that spec's doc gives.
  static final PlateCountry _bareDefaultProvince = AfghanistanProvince.kabul
      .country(showCode: false);

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
      plateField(
        alphabet: AfghanistanAlphabets.digits,
        count: 5,
        left: 112,
        width: (306 - 112) / 5,
        top: 40,
        height: 96,
      ),
      // The category, not a class: `CARGO` names the service the vehicle runs,
      // where `L` names what it is registered as. Shorter in the glyph than
      // anything else on the plate because five characters at a serial figure's
      // height would be half the plate wide.
      const PlateSlot(
        alphabet: AfghanistanAlphabets.internationalCategory,
        box: PlateBox(316, 68, 98, 40),
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
      PlateTextGroup(<int>[1], key: 'category'),
    ],
  );

  /// Every Afghan geometry, in the order they are introduced above. A picker
  /// iterates this rather than naming each constant.
  ///
  /// Rather more plates on the road than specs: a bus, a taxi, a lorry, a
  /// private car and a duplicate are all [car] with a different class and a
  /// different theme. A picker that wants to offer a taxi
  /// offers `(car, AfghanistanThemes.transport, 'T')`.
  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    car,
    kabul6,
    cycle,
    diplomatic,
    governmental,
    un,
    temporary,
    international,
  ]);
}
