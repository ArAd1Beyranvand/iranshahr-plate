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

  /// The upper band holds the iranian-numeral serial and Persian class letter, the
  /// lower its Latin twins. A band is taller than the figure in it: core sets a
  /// glyph at 0.72 of the height it is handed, so a cell is about twice the ink it
  /// carries. These are as deep as two bands can be and still clear the frame.
  static const double _upperTop = 2;
  static const double _lowerTop = 82;
  static const double _bandHeight = 78;

  /// The serial's edges; a shorter run sits centred in the box.
  static const double _serialLeft = 106;
  static const double _serialRight = 310;

  /// The province block, printed straight onto the field. Zero padding and a
  /// [PlatePanel.flagScale] of 0.82 make the emblem 69 wide and 44 deep, leaving
  /// 112 of the block's 156 split between the name and the code.
  /// [PlatePanel.captionScale] is set past what fits on purpose: both lines are in a
  /// `BoxFit.scaleDown`, so too big means "as large as allowed" and too small would
  /// leave the block half empty.
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

  static List<PlateSlot> get _classSlot => const <PlateSlot>[
    PlateSlot(alphabet: AfghanistanAlphabets.vehicleClass, box: _classBox),
  ];

  static PlateMirror _classMirror(int source) => PlateMirror(
    source: source,
    box: _classLatinBox,
    glyphHeight: _classLatinGlyph,
    alphabet: AfghanistanAlphabets.classLatin,
  );

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

  /// The province a spec names when a renderer is handed none; hosts pass the
  /// registered province via `PlateCanvas.country`.
  static final PlateCountry _defaultProvince = AfghanistanProvince.kabul
      .country();

  /// Kabul's six-figure plate: a five-figure serial and a sixth figure set apart
  /// ahead of it between two hyphens. The sixth is printed once, in Persian only,
  /// spanning both bands, so it is a slot over [AfghanistanAlphabets.iranianDigits]
  /// with no mirror. It leads the serial group; the five that follow sit at a
  /// tighter left edge than [car]'s.
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

  /// Three figures for a motorcycle (`م`/`M`), four for a rickshaw (`ر`/`TRC`).
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

  /// White on red, `١٢-٣٤` over `12-34`, with `CD` at the head and no Persian class
  /// letter. A spec rather than a livery because the number is grouped by a hyphen,
  /// a gap one evenly pitched register cannot express, and `CD` is a [PlateLabel]
  /// printed once between the bands.
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

  /// White on black with a dash in each band where a class code would be. The dash
  /// is fixed wording, so this is a spec and not [car] in another livery.
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

  /// Black on UN blue: the province block and a four-figure serial, no class.
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

  /// Issued from September 2023, valid three years. Printed in two inks: `موقت` and
  /// `TEMP` are red [PlateLabel]s with their own [PlateLabel.color] because a
  /// [PlateTheme] carries one ink. The class is fixed (`ش`, private only), so it is
  /// a label, not a slot.
  ///
  /// Hand this a bare province block, `AfghanistanProvince.herat.country(showCode:
  /// false)`, or the code will print under the emblem beneath the `موقت` label.
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

  /// Kabul with the bottom line suppressed, as [temporary] requires.
  static final PlateCountry _bareDefaultProvince = AfghanistanProvince.kabul
      .country(showCode: false);

  /// Cross-border plate issued in Herat from January 2026 to taxis, buses and
  /// cargo lorries running to Iran. Reconstructed from the article's text, not a
  /// photograph: only the absence of the iranian-numeral band and Persian class
  /// letter is stated. The rest is a reading of "like the others, minus the
  /// Persian half". // CALIBRATE
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

  /// Every geometry, in the order introduced above. A bus, taxi, lorry or private
  /// car is [car] with another class and theme, e.g.
  /// `(car, AfghanistanThemes.transport, 'T')`.
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
