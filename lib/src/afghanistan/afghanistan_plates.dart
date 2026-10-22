import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'afghanistan_alphabets.dart';
import 'afghanistan_colors.dart';
import 'afghanistan_provinces.dart';

/// Afghan plates: a class register (Persian letter over its Latin twin), a
/// serial of 3–6 figures (Iranian numerals above, Latin below) and a province
/// block. The province varies at runtime, so it is a [PlateCountry] and not
/// part of the spec; specs differ only where the shape does. Geometry is
/// calibrated by eye: 420×175 mm full-size, 265×105 mm two-wheeler.
abstract final class AfghanistanPlates {
  static const double _width = 420;
  static const double _height = 175;

  /// The upper band holds the Iranian-numeral serial and Persian class letter,
  /// the lower their Latin twins. Core sets a glyph at 0.72 of the height it is
  /// handed, so these are as deep as two bands can be and clear the frame.
  static const double _upperTop = 2;
  static const double _lowerTop = 82;
  static const double _bandHeight = 78;

  /// The serial's edges; a shorter run sits centred in the box.
  static const double _serialLeft = 106;
  static const double _serialRight = 310;

  /// The flag scale makes the emblem 69 wide and 44 deep, leaving 112 of the
  /// block's 156 for the name and code. The caption scale exceeds what fits on
  /// purpose: both lines scale down, so "too big" means "as large as allowed".
  static const PlatePanel _panel = PlatePanel(
    box: PlateBox(16, 8, 84, 156),
    padding: EdgeInsets.zero,
    flagScale: 0.82,
    captionScale: 1.8,
  );

  static const PlateBox _classBox = PlateBox(337, _upperTop, 60, _bandHeight);
  static const PlateBox _classLatinBox = PlateBox(322, _lowerTop, 90, _bandHeight);
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

  static PlateSlot _serial(int count, {double left = _serialLeft, int? minLength}) => plateField(
    alphabet: AfghanistanAlphabets.digits,
    count: count,
    left: left,
    width: (_serialRight - left) / count,
    top: _lowerTop,
    height: _bandHeight,
    minLength: minLength,
  );

  static PlateMirror _serialEcho(int source, {double left = _serialLeft}) => PlateMirror(
    source: source,
    box: PlateBox(left, _upperTop, _serialRight - left, _bandHeight),
    glyphHeight: _bandHeight,
    alphabet: AfghanistanAlphabets.iranshahrDigits,
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

  /// Used when a renderer is handed no province.
  static final PlateCountry _defaultProvince = AfghanistanProvince.kabul.country();
  static final PlateCountry _bareDefaultProvince = AfghanistanProvince.kabul.country(
    showCode: false,
  );

  /// Kabul's six-figure plate: a sixth figure between two hyphens, printed once
  /// in Persian across both bands (a slot with no mirror) and leading the serial
  /// group.
  static final PlateSpec kabul6 = PlateSpec(
    id: 'af.kabul6',
    country: _defaultProvince,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[
      const PlateSlot(
        alphabet: AfghanistanAlphabets.iranshahrDigits,
        box: PlateBox(106, 46, 44, 74),
      ),
      _serial(5, left: 154),
      ..._classSlot,
    ],
    mirrors: <PlateMirror>[_serialEcho(1, left: 154), _classMirror(2)],
    // Labels, not rules: a rule takes the divider colour, a hyphen the ink.
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: PlateBox(106, 4, 44, 38), glyphHeight: 38),
      PlateLabel(text: '-', box: PlateBox(106, 124, 44, 38), glyphHeight: 38),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[2], key: 'class'),
      PlateTextGroup(<int>[0, 1], key: 'serial'),
    ],
  );

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
        box: PlateBox(70, _cycleUpperTop, _cycleSerialRight - 70, _cycleBandHeight),
        glyphHeight: _cycleBandHeight,
        alphabet: AfghanistanAlphabets.iranshahrDigits,
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

  /// `١٢-٣٤` over `12-34` with `CD` between the bands and no class letter. The
  /// hyphen is a gap one evenly pitched register cannot express.
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
        alphabet: AfghanistanAlphabets.iranshahrDigits,
        editable: true,
      ),
      PlateMirror(
        source: 1,
        box: PlateBox(232, _upperTop, 84, _bandHeight),
        glyphHeight: _bandHeight,
        alphabet: AfghanistanAlphabets.iranshahrDigits,
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
    // Two groups: one of four unevenly pitched cells fails `debugValidateSpec`.
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'mission'),
      PlateTextGroup(<int>[1], key: 'serial'),
    ],
  );

  /// A fixed dash in each band where a class code would be.
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
      PlateLabel(text: '—', box: PlateBox(330, _upperTop, 74, _bandHeight), glyphHeight: 56),
      PlateLabel(text: '—', box: PlateBox(330, _lowerTop, 74, _bandHeight), glyphHeight: 56),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
  );

  /// A four-figure serial and no class.
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

  /// `موقت` and `TEMP` are red labels because a theme carries one ink. The
  /// class is fixed (`ش`, private only), so it is a label, not a slot.
  ///
  /// Pass a block built with `country(showCode: false)`, or the province code
  /// prints under the emblem beneath the `موقت` label.
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

  /// Cross-border plate for vehicles running to Iran. Reconstructed from the
  /// article's text, not a photograph: only the missing Iranian-numeral band and
  /// Persian class letter are stated. // CALIBRATE
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
      // A category (the service run), not a class. Its glyph is short because
      // five characters at serial height would span half the plate.
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
