import 'dart:math' as math;

import 'package:plate_core/core_plate.dart';
import 'package:flutter/widgets.dart';

import 'uae_alphabets.dart';
import 'uae_colors.dart';
import 'uae_country.dart';

/// The private-vehicle plates of the seven emirates, in both sizes.
///
/// Every number below is a measured *ink* extent in plate millimetres, taken
/// off the reference artwork on Wikimedia Commons linked from Wikipedia's
/// "Vehicle registration plates of the United Arab Emirates", with each file's
/// plate rectangle normalised to the article's 520x110 or 335x155. The short
/// artwork is drawn at 1.84:1 against the documented 2.16:1, so its content is
/// stretched proportionally across the documented canvas.
///
/// [_ink] and [_cells] turn an ink extent into the box that reproduces it:
/// core paints ink at about 0.55 of a Latin glyph height and 0.65 of an Arabic
/// one (dots and descenders included). A cell whose box would leave the canvas
/// is shrunk about its centre, so the tallest serials come out short of
/// reference — the long serials at about 90%, Abu Dhabi's short at 80%.
///
/// Not implemented: the logo variants of Abu Dhabi, Ajman and Umm Al Quwain,
/// Dubai's coloured plate, and the new Fujairah, Ras Al Khaimah and Umm Al
/// Quwain calligraphy plates — each needs emblem artwork. Dubai's "DUBAI"
/// logotype is set as bold text, and its doubled codes (AA to EE) are not laid
/// out; the code is one letter.
abstract final class UaePlates {
  static const double _longW = 520;
  static const double _longH = 110;
  static const double _shortW = 335;
  static const double _shortH = 155;

  static const double _latinInk = 0.55;
  static const double _arabicInk = 0.65;

  /// Sharjah's frame: 7 mm on the long plate, 8 on the short.
  static const double _sharjahLongBorder = 7 / _longH;
  static const double _sharjahShortBorder = 8 / _shortH;

  /// A label reproducing ink spanning [x0]..[x1] by [y0]..[y1].
  static PlateLabel _ink(
    String text,
    double x0,
    double x1,
    double y0,
    double y1, {
    bool arabic = false,
    Color? color,
  }) => PlateLabel(
    text: text,
    box: PlateBox(x0, y0, x1 - x0, y1 - y0),
    glyphHeight: (y1 - y0) / (arabic ? _arabicInk : _latinInk),
    color: color,
  );

  /// [count] cells centred from [firstCx] at [pitch], reproducing ink spanning
  /// [y0]..[y1] on a canvas [canvasH] tall.
  static List<PlateSlot> _cells({
    required PlateAlphabet alphabet,
    required int count,
    required double firstCx,
    required double pitch,
    required double y0,
    required double y1,
    required double canvasH,
    double? width,
    Color? color,
  }) {
    final cy = (y0 + y1) / 2;
    final double height = math.min(
      (y1 - y0) / _latinInk,
      2 * math.min(cy, canvasH - cy),
    );
    final w = width ?? pitch * 0.96;
    return plateRegister(
      alphabet: alphabet,
      count: count,
      left: firstCx - w / 2,
      top: cy - height / 2,
      width: w,
      height: height,
      pitch: pitch,
      color: color,
    );
  }

  static List<PlateSlot> _letter(
    double cx,
    double y0,
    double y1,
    double canvasH, {
    double width = 48,
  }) => _cells(
    alphabet: UaeAlphabets.letters,
    count: 1,
    firstCx: cx,
    pitch: width,
    y0: y0,
    y1: y1,
    canvasH: canvasH,
  );

  static List<PlateSlot> _serial(
    double firstCx,
    double pitch,
    double y0,
    double y1,
    double canvasH,
  ) => _cells(
    alphabet: UaeAlphabets.digits,
    count: 5,
    firstCx: firstCx,
    pitch: pitch,
    y0: y0,
    y1: y1,
    canvasH: canvasH,
  );

  static const PlatePanel _noPanel = PlatePanel(
    box: PlateBox(0, 0, 0, 0),
    padding: EdgeInsets.zero,
  );

  /// Every design is a code (one or two cells) then a five-digit serial.
  static PlateSpec _spec({
    required String id,
    required bool long,
    required List<PlateSlot> code,
    required List<PlateSlot> serial,
    required List<PlateLabel> labels,
    PlateSection background = PlateSection.plain,
    double? borderWidthRatioOverride,
  }) {
    final n = code.length;
    return PlateSpec(
      id: id,
      country: UaeCountry.uae,
      canvasWidth: long ? _longW : _shortW,
      canvasHeight: long ? _longH : _shortH,
      noPanel: true,
      panel: _noPanel,
      slots: <PlateSlot>[...code, ...serial],
      labels: labels,
      background: background,
      borderWidthRatioOverride: borderWidthRatioOverride,
      textGroups: <PlateTextGroup>[
        PlateTextGroup(<int>[for (var i = 0; i < n; i++) i], key: 'code'),
        PlateTextGroup(<int>[for (var i = n; i < n + 5; i++) i], key: 'serial'),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Abu Dhabi
  // -------------------------------------------------------------------------

  /// Long: a red strip x 0..107.2 under the frame, its two-digit code in white
  /// (ink centres 33.2 and 72.7, y 26.7..82.8). Then "الامارات" over "أبوظبي"
  /// (x 124..230, y 14.7..61.8), "U.A.E A.D" (y 70.7..89), and the serial,
  /// centres 276.2 + 50.1k, y 21..88.5.
  static final PlateSpec abuDhabiLong = _spec(
    id: 'ae.abudhabi.long',
    long: true,
    background: const PlateSection.columns(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(UaeColors.abuDhabiRed)),
        end: 107.2,
      ),
      PlatePart(PlateSection.plain),
    ]),
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 2,
      firstCx: 33.2,
      pitch: 39.5,
      y0: 26.7,
      y1: 82.8,
      canvasH: _longH,
      color: UaeColors.field,
    ),
    serial: _serial(276.2, 50.1, 21, 88.5, _longH),
    labels: <PlateLabel>[
      _ink('الامارات', 124, 230, 14.7, 36, arabic: true),
      _ink('أبوظبي', 124, 230, 38.2, 61.8, arabic: true),
      _ink('U.A.E  A.D', 125, 234.5, 70.7, 89),
    ],
  );

  /// Short: a red band y 0..60.1 closed by a 2.8 black rule, carrying the
  /// white code (centres 146.75 and 185, y 9.5..56.2) between "أبوظبي / A.D"
  /// on the left and "الامارات / U.A.E" on the right. The serial below,
  /// centres 53.4 + 55.5k, y 73.6..139.8.
  static final PlateSpec abuDhabiShort = _spec(
    id: 'ae.abudhabi.short',
    long: false,
    background: const PlateSection.rows(<PlatePart>[
      PlatePart(
        PlateSection.fill(PlateFill.color(UaeColors.abuDhabiRed)),
        end: 61.5,
        divider: 2.8,
      ),
      PlatePart(PlateSection.plain),
    ]),
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 2,
      firstCx: 146.75,
      pitch: 38.3,
      y0: 9.5,
      y1: 56.2,
      canvasH: _shortH,
      color: UaeColors.field,
    ),
    serial: _serial(53.4, 55.5, 73.6, 139.8, _shortH),
    labels: <PlateLabel>[
      _ink('أبوظبي', 12, 113, 8.4, 34.8, arabic: true, color: UaeColors.field),
      _ink('A.D', 39, 76.5, 37, 53, color: UaeColors.field),
      _ink('الامارات', 209, 322, 9, 33, arabic: true, color: UaeColors.field),
      _ink('U.A.E', 251, 309, 35, 51, color: UaeColors.field),
    ],
  );

  // -------------------------------------------------------------------------
  // Ajman
  // -------------------------------------------------------------------------

  /// Long: letter (cx 48.8, y 15.7..90.6), "الامارات / UAE.AJMAN / عجمان"
  /// stacked at x 100..194, then the serial spread across x 222..500, y
  /// 20..95. The reference's figures are proportional (its "1" is narrow), so
  /// the pitch is the mean, 55.6.
  static final PlateSpec ajmanLong = _spec(
    id: 'ae.ajman.long',
    long: true,
    code: _letter(48.8, 15.7, 90.6, _longH),
    serial: _serial(249.8, 55.6, 20, 95, _longH),
    labels: <PlateLabel>[
      _ink('الامارات', 100, 194, 18, 46, arabic: true),
      _ink('UAE.AJMAN', 100.8, 192, 50.8, 62.9),
      _ink('عجمان', 100, 194, 67, 95, arabic: true),
    ],
  );

  /// Short: serial on top (x 8..327, y 10..86.5); below it "عجمان / AJMAN",
  /// the letter (cx 164, y 99.4..147) and "الامارات / UAE".
  static final PlateSpec ajmanShort = _spec(
    id: 'ae.ajman.short',
    long: false,
    code: _letter(164, 99.4, 147, _shortH),
    serial: _serial(8 + 31.9, 63.8, 10, 86.5, _shortH),
    labels: <PlateLabel>[
      _ink('عجمان', 50, 118.7, 102, 125, arabic: true),
      _ink('AJMAN', 39, 107.5, 132.5, 145.5),
      _ink('الامارات', 214, 302, 102, 124, arabic: true),
      _ink('UAE', 237, 275.6, 132, 145),
    ],
  );

  // -------------------------------------------------------------------------
  // Dubai
  // -------------------------------------------------------------------------

  /// Long: "DUBAI" (x 40.9..127.3, y 12.6..45.6) over the letter (cx 74.8,
  /// y 58..93), serial centres 201.6 + 52k, y 22.5..88.5.
  static final PlateSpec dubaiLong = _spec(
    id: 'ae.dubai.long',
    long: true,
    code: _letter(74.8, 58, 93, _longH, width: 40),
    serial: _serial(201.6, 52, 22.5, 88.5, _longH),
    labels: <PlateLabel>[_ink('DUBAI', 40.9, 127.3, 12.6, 45.6)],
  );

  /// Short: "DUBAI" top left (x 34..120, y 12.9..41), the letter top right
  /// (cx 287, y 9..38.8), serial along the bottom at pitch 59.3, y 75.8..141.
  static final PlateSpec dubaiShort = _spec(
    id: 'ae.dubai.short',
    long: false,
    code: _letter(287, 9, 38.8, _shortH, width: 30),
    serial: _serial(33, 59.3, 75.8, 141, _shortH),
    labels: <PlateLabel>[_ink('DUBAI', 34, 120, 12.9, 41)],
  );

  // -------------------------------------------------------------------------
  // Fujairah and Umm Al Quwain share the long layout: letter, "U.A.E" over
  // the emirate's Arabic name, serial.
  // -------------------------------------------------------------------------

  /// Letter cx 48.3, y 15.7..85; "U.A.E" x 101..214, y 18.3..48.2; serial
  /// centres 257 + 47.6k, y 16..87. [name] is the Arabic line under "U.A.E".
  static PlateSpec _letterUaeNameLong(String id, PlateLabel name) => _spec(
    id: id,
    long: true,
    code: _letter(48.3, 15.7, 85, _longH),
    serial: _serial(257, 47.6, 16, 87, _longH),
    labels: <PlateLabel>[_ink('U.A.E', 101, 214, 18.3, 48.2), name],
  );

  static final PlateSpec fujairahLong = _letterUaeNameLong(
    'ae.fujairah.long',
    _ink('الفجيرة', 105.6, 216.5, 56, 96, arabic: true),
  );

  /// Short: serial on top (centres 31.9 + 59.1k, y 10.7..87); "U.A.E", the
  /// letter (cx 155, y 97..145) and "الفجيرة" below.
  static final PlateSpec fujairahShort = _spec(
    id: 'ae.fujairah.short',
    long: false,
    code: _letter(155, 97, 145, _shortH, width: 40),
    serial: _serial(31.9, 59.1, 10.7, 87, _shortH),
    labels: <PlateLabel>[
      _ink('U.A.E', 22, 116, 106, 136),
      _ink('الفجيرة', 195, 307, 105, 140, arabic: true),
    ],
  );

  static final PlateSpec ummAlQuwainLong = _letterUaeNameLong(
    'ae.ummalquwain.long',
    _ink('ام القوين', 102, 217.6, 57.6, 91, arabic: true),
  );

  /// Short: the letter (cx 34.6, y 16..85.4) and serial (centres 97.7 + 47k,
  /// y 15.7..86) on top; "UAE" and "ام القوين" below.
  static final PlateSpec ummAlQuwainShort = _spec(
    id: 'ae.ummalquwain.short',
    long: false,
    code: _letter(34.6, 16, 85.4, _shortH, width: 44),
    serial: _serial(97.7, 47, 15.7, 86, _shortH),
    labels: <PlateLabel>[
      _ink('UAE', 39.6, 113.4, 118.5, 139.3),
      _ink('ام القوين', 166, 310, 109, 145, arabic: true),
    ],
  );

  // -------------------------------------------------------------------------
  // Ras Al Khaimah
  // -------------------------------------------------------------------------

  /// Long: Ajman's letter, "الامارات / رأس الخيمة / UAE.RAK" at x 107..213,
  /// and Abu Dhabi's serial positions.
  static final PlateSpec rasAlKhaimahLong = _spec(
    id: 'ae.rasalkhaimah.long',
    long: true,
    code: _letter(48.8, 15.7, 90.6, _longH),
    serial: _serial(276.2, 50.1, 21, 88.5, _longH),
    labels: <PlateLabel>[
      _ink('الامارات', 108, 207.5, 17, 37, arabic: true),
      _ink('رأس الخيمة', 107, 213, 41.4, 63.9, arabic: true),
      _ink('UAE.RAK', 108, 207.5, 71.8, 90),
    ],
  );

  /// Short: serial on top (centres 70.9 + 49.4k, y 12.4..68); "رأس الخيمة /
  /// RAK", the letter (cx 176, y 86.5..142) and "الامارات / UAE" below.
  static final PlateSpec rasAlKhaimahShort = _spec(
    id: 'ae.rasalkhaimah.short',
    long: false,
    code: _letter(176, 86.5, 142, _shortH),
    serial: _serial(70.9, 49.4, 12.4, 68, _shortH),
    labels: <PlateLabel>[
      _ink('رأس الخيمة', 10.6, 132.5, 83.7, 108, arabic: true),
      _ink('RAK', 37.6, 97.6, 114.6, 133.7),
      _ink('الامارات', 213, 322.5, 90, 112, arabic: true),
      _ink('UAE', 237, 296, 118.5, 138),
    ],
  );

  // -------------------------------------------------------------------------
  // Sharjah: a heavier frame, and a one-digit code (1 to 4) a plate may omit.
  // -------------------------------------------------------------------------

  /// Long: code (cx 48.4, y 23.7..76.7); "الشارقة" over "U.A.E  إ.ع.م" over
  /// "SHARJAH" at x 85..235; serial centres 262.8 + 51.3k, y 23.7..90.8.
  static final PlateSpec sharjahLong = _spec(
    id: 'ae.sharjah.long',
    long: true,
    borderWidthRatioOverride: _sharjahLongBorder,
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 1,
      firstCx: 48.4,
      pitch: 40,
      y0: 23.7,
      y1: 76.7,
      canvasH: _longH,
    ),
    serial: _serial(262.8, 51.3, 23.7, 90.8, _longH),
    labels: <PlateLabel>[
      _ink('الشارقة', 85, 235, 16, 50, arabic: true),
      _ink('U.A.E', 103.5, 148.7, 55, 69),
      _ink('إ.ع.م', 168, 206, 55.5, 71, arabic: true),
      _ink('SHARJAH', 111, 201, 79, 93),
    ],
  );

  /// Short: "SHARJAH", the code (cx 155, y 12.9..43.6) and "الشارقة" across
  /// the top; serial centres 55.1 + 51.5k, y 52.2..118.9; "U.A.E" and "إ.ع.م"
  /// at the bottom corners.
  static final PlateSpec sharjahShort = _spec(
    id: 'ae.sharjah.short',
    long: false,
    borderWidthRatioOverride: _sharjahShortBorder,
    code: _cells(
      alphabet: UaeAlphabets.digits,
      count: 1,
      firstCx: 155,
      pitch: 28,
      y0: 12.9,
      y1: 43.6,
      canvasH: _shortH,
    ),
    serial: _serial(55.1, 51.5, 52.2, 118.9, _shortH),
    labels: <PlateLabel>[
      _ink('SHARJAH', 19, 130, 14, 29),
      _ink('الشارقة', 186.8, 314, 12.9, 38, arabic: true),
      _ink('U.A.E', 27, 83, 127, 142),
      _ink('إ.ع.م', 259, 307, 128.6, 145.3, arabic: true),
    ],
  );
}
