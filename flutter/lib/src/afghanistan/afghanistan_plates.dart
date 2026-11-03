import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';

import '../plate_field.dart';
import 'afghanistan_alphabets.dart';
import 'afghanistan_colors.dart';
import 'afghanistan_provinces.dart';
import 'afghanistan_themes.dart';

/// Afghan plates: a class register (Persian letter over its Latin twin), a
/// serial of 3–6 figures (Iranian numerals above, Latin below) and a province
/// block (name over the emblem over its code). Class and province are slots,
/// so a Herat taxi and a Kabul lorry are one spec with different values; the
/// class letter picks the livery (see [AfghanistanThemes.byClass]). Geometry
/// is calibrated by eye: 420×175 mm full-size, 265×105 mm two-wheeler.
///
/// The province is the last slot of every spec except [kabul6].
abstract final class AfghanistanPlates {
  static const double _width = 420, _height = 175;

  /// The upper band holds the Iranian-numeral serial and Persian class letter,
  /// the lower their Latin twins. Core sets a glyph at 0.72 of the height it is
  /// handed, so these are as deep as two bands can be and clear the frame.
  static const double _upperTop = 2, _lowerTop = 82, _bandHeight = 78;

  /// The serial's edges; a shorter run sits centred in the box.
  static const double _serialLeft = 106, _serialRight = 310;

  /// The block is 84×156: name slot, emblem, code mirror. The panel draws only
  /// the emblem, so its box is the block's middle band.
  static const PlateBox _panelBox = PlateBox(16, 8, 84, 156);
  static final PlatePanel _panel = PlatePanel(
    box: _emblemBox(_panelBox),
    padding: EdgeInsets.zero,
    flagScale: 0.82,
  );

  static const PlateBox _classBox = PlateBox(337, _upperTop, 60, _bandHeight);

  static const PlateSlot _classSlot = PlateSlot(
    alphabet: AfghanistanAlphabets.vehicleClass,
    box: _classBox,
  );

  static PlateMirror _classMirror(int source) => PlateMirror(
    source: source,
    box: const PlateBox(322, _lowerTop, 90, _bandHeight),
    glyphHeight: 62,
    alphabet: AfghanistanAlphabets.classLatin,
  );

  static PlateBox _emblemBox(PlateBox block) => PlateBox(
    block.left,
    block.top + block.height * 0.3,
    block.width,
    block.height * 0.42,
  );

  /// Name over code, top and bottom of [box].
  static PlateSlot _province(PlateBox box) => PlateSlot(
    alphabet: AfghanistanProvince.names,
    box: PlateBox(box.left, box.top, box.width, box.height * 0.3),
  );

  static PlateMirror _provinceCode(int source, PlateBox box) => PlateMirror(
    source: source,
    box: PlateBox(
      box.left,
      box.top + box.height * 0.72,
      box.width,
      box.height * 0.28,
    ),
    glyphHeight: box.height * 0.25,
    alphabet: AfghanistanProvince.codes,
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
        // An editable mirror wraps rather than shrinks, so a narrower run
        // (Kabul's) takes a shorter glyph.
        glyphHeight: math.min(_bandHeight, (_serialRight - left) * 0.4),
        alphabet: AfghanistanAlphabets.iranshahrDigits,
        editable: true,
      );

  /// A full-size spec: [slots] then the province, with [mirrors] then its code.
  static PlateSpec _plate(
    String id, {
    required List<PlateSlot> slots,
    List<PlateMirror> mirrors = const <PlateMirror>[],
    List<PlateLabel> labels = const <PlateLabel>[],
    List<PlateTextGroup> groups = const <PlateTextGroup>[
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
    AfghanistanPanelInk ink = AfghanistanPanelInk.dark,
    TextDirection textDirection = TextDirection.rtl,
    PlateThemeResolver? resolveTheme,
  }) {
    final p = slots.length;
    return PlateSpec(
      id: id,
      country: ink.country,
      canvasWidth: _width,
      canvasHeight: _height,
      textDirection: textDirection,
      panel: _panel,
      slots: <PlateSlot>[...slots, _province(_panelBox)],
      mirrors: <PlateMirror>[...mirrors, _provinceCode(p, _panelBox)],
      labels: labels,
      textGroups: <PlateTextGroup>[
        ...groups,
        PlateTextGroup(<int>[p], key: 'province'),
      ],
      resolveTheme: resolveTheme,
    );
  }

  /// Private, duplicate, taxi, bus and lorry, with 3–5 figures: values are
  /// `[serial, class, province]`. Taxi and bus turn the field yellow.
  static final PlateSpec car = _plate(
    'af.car',
    slots: <PlateSlot>[_serial(5, minLength: 3), _classSlot],
    mirrors: <PlateMirror>[_serialEcho(0), _classMirror(1)],
    groups: const <PlateTextGroup>[
      PlateTextGroup(<int>[1], key: 'class'),
      PlateTextGroup(<int>[0], key: 'serial'),
    ],
    resolveTheme: AfghanistanThemes.byClass,
  );

  /// Kabul's six-figure plate: a sixth figure between two hyphens, printed once
  /// in Persian across both bands (a slot with no mirror) and leading the serial
  /// group. Kabul-only, so its block is printed, not a slot.
  static final PlateSpec kabul6 = PlateSpec(
    id: 'af.kabul6',
    country: AfghanistanPanelInk.dark.country,
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
      _classSlot,
    ],
    mirrors: <PlateMirror>[_serialEcho(1, left: 154), _classMirror(2)],
    // Labels, not rules: a rule takes the divider colour, a hyphen the ink.
    labels: const <PlateLabel>[
      PlateLabel(text: '-', box: PlateBox(106, 4, 44, 38), glyphHeight: 38),
      PlateLabel(text: '-', box: PlateBox(106, 124, 44, 38), glyphHeight: 38),
      PlateLabel(text: 'کابل', box: PlateBox(16, 8, 84, 47), glyphHeight: 34),
      PlateLabel(text: 'KBL', box: PlateBox(16, 120, 84, 44), glyphHeight: 39),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[2], key: 'class'),
      PlateTextGroup(<int>[0, 1], key: 'serial'),
    ],
    resolveTheme: AfghanistanThemes.byClass,
  );

  static const double _cycleSerialRight = 196, _cycleBandHeight = 48;
  static const PlateBox _cyclePanelBox = PlateBox(10, 5, 54, 95);

  /// Three figures for a motorcycle (`م`/`M`), four for a rickshaw (`ر`/`TRC`):
  /// values are `[serial, class, province]`.
  static final PlateSpec cycle = PlateSpec(
    id: 'af.cycle',
    country: AfghanistanPanelInk.dark.country,
    canvasWidth: 265,
    canvasHeight: 105,
    textDirection: TextDirection.rtl,
    panel: PlatePanel(
      box: _emblemBox(_cyclePanelBox),
      padding: EdgeInsets.zero,
      flagScale: 0.82,
    ),
    slots: <PlateSlot>[
      plateField(
        alphabet: AfghanistanAlphabets.digits,
        count: 4,
        left: 70,
        width: (_cycleSerialRight - 70) / 4,
        top: 53,
        height: _cycleBandHeight,
        minLength: 3,
      ),
      const PlateSlot(
        alphabet: AfghanistanAlphabets.vehicleClass,
        box: PlateBox(212, 2, 38, _cycleBandHeight),
      ),
      _province(_cyclePanelBox),
    ],
    mirrors: <PlateMirror>[
      const PlateMirror(
        source: 0,
        box: PlateBox(70, 2, _cycleSerialRight - 70, _cycleBandHeight),
        glyphHeight: _cycleBandHeight,
        alphabet: AfghanistanAlphabets.iranshahrDigits,
        editable: true,
      ),
      const PlateMirror(
        source: 1,
        box: PlateBox(202, 53, 58, _cycleBandHeight),
        glyphHeight: 40,
        alphabet: AfghanistanAlphabets.classLatin,
      ),
      _provinceCode(2, _cyclePanelBox),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup(<int>[1], key: 'class'),
      PlateTextGroup(<int>[0], key: 'serial'),
      PlateTextGroup(<int>[2], key: 'province'),
    ],
  );

  static PlateSlot _pair(double left) => plateField(
    alphabet: AfghanistanAlphabets.digits,
    count: 2,
    left: left,
    top: _lowerTop,
    width: 42,
    height: _bandHeight,
  );

  static PlateMirror _pairEcho(int source, double left) => PlateMirror(
    source: source,
    box: PlateBox(left, _upperTop, 84, _bandHeight),
    glyphHeight: _bandHeight,
    alphabet: AfghanistanAlphabets.iranshahrDigits,
    editable: true,
  );

  /// `١٢-٣٤` over `12-34` with `CD` between the bands and no class letter. The
  /// hyphen is a gap one evenly pitched register cannot express, hence two
  /// groups: one of four unevenly pitched cells fails `debugValidateSpec`.
  static final PlateSpec diplomatic = _plate(
    'af.diplomatic',
    ink: AfghanistanPanelInk.light,
    slots: <PlateSlot>[_pair(106), _pair(232)],
    mirrors: <PlateMirror>[_pairEcho(0, 106), _pairEcho(1, 232)],
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
    groups: PlateTextGroup.perSlot(<String>['mission', 'serial']),
  );

  /// A fixed dash in each band where a class code would be.
  static final PlateSpec governmental = _plate(
    'af.governmental',
    ink: AfghanistanPanelInk.light,
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
  );

  /// A four-figure serial and no class.
  static final PlateSpec un = _plate(
    'af.un',
    slots: <PlateSlot>[_serial(4, left: 118)],
    mirrors: <PlateMirror>[_serialEcho(0, left: 118)],
  );

  /// `موقت` and `TEMP` are red labels because a theme carries one ink; `موقت`
  /// takes the province code's place. The class is fixed (`ش`, private only).
  static final PlateSpec temporary = PlateSpec(
    id: 'af.temporary',
    country: AfghanistanPanelInk.dark.country,
    canvasWidth: _width,
    canvasHeight: _height,
    textDirection: TextDirection.rtl,
    panel: _panel,
    slots: <PlateSlot>[_serial(5), _province(_panelBox)],
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
    textGroups: PlateTextGroup.perSlot(<String>['serial', 'province']),
  );

  /// Cross-border plate for vehicles running to Iran. Reconstructed from the
  /// article's text, not a photograph: only the missing Iranian-numeral band and
  /// Persian class letter are stated. // CALIBRATE
  static final PlateSpec international = _plate(
    'af.international',
    textDirection: TextDirection.ltr,
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
    groups: PlateTextGroup.perSlot(<String>['serial', 'category']),
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
