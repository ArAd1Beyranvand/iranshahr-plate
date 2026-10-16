import 'package:plate_core/plate_core.dart';
import 'package:flutter/widgets.dart';

import '../plate_field.dart';
import 'kuwait_colors.dart';
import 'kuwait_country.dart';

/// Where the ink sits, in plate coordinates. Almost every category prints on one
/// template, measured off the Commons reference artwork by normalising each
/// plate rectangle to the article's 335x155 mm and projecting the ink onto each
/// axis; the files agree to within half a unit.
abstract final class _Layout {
  static const double width = 335;
  static const double height = 155;

  /// Vertical rule between the "KUWAIT" band and the face.
  static const double ruleLeft = 39;
  static const double ruleWidth = 3;

  /// "KUWAIT" set as six stacked upright letters, not rotated text. Sized so
  /// the widest letter clears [ruleLeft]: the band is only 13 units of ink
  /// wide on the reference, narrower than a bold "W" at the height the six
  /// letters need to fill the plate.
  static const PlateBox kuwaitBand = PlateBox(10, 10, 27, 135);
  static const double kuwaitGlyph = 19;
  static const double kuwaitLineHeight = 1.6;

  /// The face: everything right of the rule, inside the frame.
  static const double faceLeft = 48;
  static const double faceRight = 319;

  /// Arabic caption row. Each category passes its own glyph height: 42 gives
  /// the reference's 31 units of ink, and the longer captions step down from
  /// there to stay inside the face.
  static const double captionTop = 11;
  static const double captionHeight = 37;

  /// Serial row. The reference ink is 71 units tall, which would need a
  /// 130-unit box — taller than the plate. 112 is the tallest box that keeps
  /// the ink centred where the reference puts it (y 98) and still fits, so
  /// the digits come out at about 86% of reference size.
  static const double serialTop = 42;
  static const double serialHeight = 112;

  /// The two-digit class code public-transport plates set left of the caption,
  /// and the shortened caption that leaves room for it.
  static const double classLeft = 52;
  static const double classWidth = 31;
  static const double classPitch = 33;
  static const double classTop = 0;
  static const double classHeight = 57;
  static const PlateBox captionBesideClass = PlateBox(
    122,
    captionTop,
    faceRight - 122,
    captionHeight,
  );

  /// Square motorcycle plates, 155x155. Same band, tighter face.
  static const double squareSide = 155;
  static const double squareRuleLeft = 37;
  static const PlateBox squareKuwaitBand = PlateBox(6, 8, 28, 139);
  static const double squareKuwaitGlyph = 25;
  static const double squareKuwaitLineHeight = 1.4;
  static const double squareFaceLeft = 44;
  static const double squareFaceRight = 148;
}

/// Sizes: 520x110 (EU) for private long-format, 335x155 for everything but
/// motorcycles, 155x155 for motorcycle and police motorcycle. Only public
/// transport carries a class code beside the serial.
abstract final class KuwaitPlates {
  /// The template every 335x155 plate but the diplomatic one is built from:
  /// "KUWAIT" band, rule, Arabic caption, five-digit serial.
  ///
  /// [classCode] adds the two-digit prefix public-transport plates carry and
  /// shifts the caption right to clear it. [band] is false for the national
  /// guard, the one category whose artwork drops the band and rule entirely
  /// and runs the face to the frame.
  static PlateSpec _standard({
    required String id,
    required PlateCountry country,
    required String caption,
    required double captionGlyph,
    Color? captionColor,
    bool classCode = false,
    bool band = true,
  }) {
    final faceLeft = band ? _Layout.faceLeft : 34.0;
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: _noPanel,
      slots: <PlateSlot>[
        plateField(
          alphabet: PlateAlphabet.latinDigits,
          count: 5,
          left: faceLeft,
          width: (_Layout.faceRight - faceLeft) / 5,
          top: _Layout.serialTop,
          height: _Layout.serialHeight,
        ),
      ],
      background: band ? _bandBackground : PlateSection.plain,
      labels: <PlateLabel>[
        if (band) _kuwaitLabel(captionColor),
        PlateLabel(
          text: caption,
          box: classCode
              ? _Layout.captionBesideClass
              : PlateBox(
                  faceLeft,
                  _Layout.captionTop,
                  _Layout.faceRight - faceLeft,
                  _Layout.captionHeight,
                ),
          glyphHeight: captionGlyph,
          color: captionColor,
        ),
      ],
      textGroups: const <PlateTextGroup>[
        PlateTextGroup([0], key: 'serial'),
      ],
    );
  }

  /// [_standard] plus the two-digit class code, which is typed, so it has to
  /// be slots rather than a label.
  static PlateSpec _withClassCode({
    required String id,
    required PlateCountry country,
    required String caption,
    required double captionGlyph,
  }) {
    final base = _standard(
      id: id,
      country: country,
      caption: caption,
      captionGlyph: captionGlyph,
      classCode: true,
    );
    return PlateSpec(
      id: id,
      country: country,
      canvasWidth: _Layout.width,
      canvasHeight: _Layout.height,
      noPanel: true,
      panel: _noPanel,
      slots: <PlateSlot>[
        plateField(
          alphabet: PlateAlphabet.latinDigits,
          count: 2,
          left: _Layout.classLeft,
          top: _Layout.classTop,
          width: _Layout.classWidth,
          height: _Layout.classHeight,
          pitch: _Layout.classPitch,
        ),
        ...base.slots,
      ],
      background: base.background,
      labels: base.labels,
      textGroups: const <PlateTextGroup>[
        PlateTextGroup([0], key: 'class'),
        PlateTextGroup([1], key: 'serial'),
      ],
    );
  }

  static const PlatePanel _noPanel = PlatePanel(
    box: PlateBox(0, 0, 0, 0),
    padding: EdgeInsets.zero,
  );

  static const PlateSection _bandBackground = PlateSection.columns(<PlatePart>[
    PlatePart(
      PlateSection.plain,
      end: _Layout.ruleLeft + _Layout.ruleWidth / 2,
      divider: _Layout.ruleWidth,
    ),
    PlatePart(PlateSection.plain),
  ]);

  static PlateLabel _kuwaitLabel(Color? color) => PlateLabel(
    text: 'K\nU\nW\nA\nI\nT',
    box: _Layout.kuwaitBand,
    glyphHeight: _Layout.kuwaitGlyph,
    color: color,
    lineHeight: _Layout.kuwaitLineHeight,
  );

  /// EU-size private vehicle (520x110): black on white, "10-23456".
  ///
  /// The only plate that reads left to right across a single row: the Arabic
  /// caption and "KUWAIT" stack at the left end instead of taking the band.
  static final PlateSpec civilian = PlateSpec(
    id: 'kw.civilian',
    country: KuwaitCountry.civilian,
    canvasWidth: 520,
    canvasHeight: 110,
    noPanel: true,
    panel: _noPanel,
    slots: <PlateSlot>[
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 2,
        left: 158,
        top: 14,
        width: 54,
        height: 82,
        pitch: 58,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: 288,
        top: 14,
        width: 42,
        height: 82,
        pitch: 45,
      ),
    ],
    labels: const <PlateLabel>[
      PlateLabel(
        text: 'دولة الكويت',
        box: PlateBox(14, 12, 138, 38),
        glyphHeight: 30,
      ),
      PlateLabel(
        text: 'KUWAIT',
        box: PlateBox(14, 56, 138, 42),
        glyphHeight: 38,
      ),
      PlateLabel(text: '-', box: PlateBox(266, 14, 20, 82), glyphHeight: 70),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup([0], key: 'class'),
      PlateTextGroup([1], key: 'serial'),
    ],
  );

  /// Public transport (codes 90-99): black on yellow, class code and serial.
  static final PlateSpec transport = _withClassCode(
    id: 'kw.transport',
    country: KuwaitCountry.transport,
    caption: 'دولة الكويت',
    captionGlyph: 42,
  );

  /// Police: white on black, "POLICE" left and "شرطة" right of the caption
  /// row, six-digit serial.
  static final PlateSpec police = PlateSpec(
    id: 'kw.police',
    country: KuwaitCountry.police,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: _noPanel,
    slots: <PlateSlot>[
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 5,
        left: _Layout.faceLeft,
        width: (_Layout.faceRight - _Layout.faceLeft) / 5,
        top: _Layout.serialTop,
        height: _Layout.serialHeight,
      ),
    ],
    background: _bandBackground,
    labels: <PlateLabel>[
      _kuwaitLabel(null),
      const PlateLabel(
        text: 'POLICE',
        box: PlateBox(48, 10, 132, 40),
        glyphHeight: 40,
      ),
      const PlateLabel(
        text: 'شرطة',
        box: PlateBox(218, 8, 96, 44),
        glyphHeight: 44,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  /// Corps Diplomatique: blue on white, red band along the bottom carrying a
  /// white capsule with "C.D" in it, "123-456".
  ///
  /// The capsule is a stadium — its corner radius is exactly half the band's
  /// height, so it is drawn by the band rather than approximated — and it is
  /// centred on the band, not on the plate.
  static final PlateSpec diplomatic = PlateSpec(
    id: 'kw.diplomatic',
    country: KuwaitCountry.diplomatic,
    canvasWidth: _Layout.width,
    canvasHeight: _Layout.height,
    noPanel: true,
    panel: _noPanel,
    background: _diplomaticBackground,
    bands: const <PlateBand>[
      PlateBand(
        box: _diplomaticCapsuleBox,
        color: KuwaitColors.civField,
        topCornerRadius: _diplomaticBandHeight / 2,
        bottomCornerRadius: _diplomaticBandHeight / 2,
      ),
    ],
    slots: <PlateSlot>[
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 55,
        top: _diplomaticSerialTop,
        width: 34,
        height: _diplomaticSerialHeight,
        pitch: _diplomaticPitch,
      ),
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 3,
        left: 55 + 4 * _diplomaticPitch,
        top: _diplomaticSerialTop,
        width: 34,
        height: _diplomaticSerialHeight,
        pitch: _diplomaticPitch,
      ),
    ],
    labels: <PlateLabel>[
      _kuwaitLabel(null),
      const PlateLabel(
        text: 'هيئة دبلوماسية',
        box: PlateBox(50, 8, 274, 38),
        glyphHeight: 36,
      ),
      const PlateLabel(
        text: '-',
        box: PlateBox(
          55 + 3 * _diplomaticPitch,
          _diplomaticSerialTop,
          34,
          _diplomaticSerialHeight,
        ),
        glyphHeight: _diplomaticSerialHeight,
      ),
      // The capsule is only 30 units tall but the reference fills it edge to
      // edge, so the glyph is sized past its own box and centred in it.
      const PlateLabel(
        text: 'C.D',
        box: _diplomaticCapsuleBox,
        glyphHeight: 36,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup([0], key: 'class'),
      PlateTextGroup([1], key: 'serial'),
    ],
  );

  /// Six digits and a dash on a seven-position pitch, sized so the ink lands
  /// on the reference's 52..318 span at its measured 48-unit cap height.
  static const double _diplomaticPitch = 38;
  static const double _diplomaticSerialTop = 32;
  static const double _diplomaticSerialHeight = 90;

  static const double _diplomaticBandTop = 113;
  static const double _diplomaticBandHeight = 30;

  /// The rule, 4 units wide at x 42, and right of it the red band: a row of
  /// the face from the rule out under the frame, so it meets both with no
  /// field between.
  static const PlateSection _diplomaticBackground = PlateSection.columns(
    <PlatePart>[
      PlatePart(PlateSection.plain, end: 44, divider: 4),
      PlatePart(
        PlateSection.rows(<PlatePart>[
          PlatePart(PlateSection.plain, end: _diplomaticBandTop),
          PlatePart(
            PlateSection.fill(PlateFill.color(KuwaitColors.diplomaticBand)),
            end: _diplomaticBandTop + _diplomaticBandHeight,
          ),
          PlatePart(PlateSection.plain),
        ]),
      ),
    ],
  );

  static const PlateBox _diplomaticCapsuleBox = PlateBox(
    150,
    _diplomaticBandTop,
    77,
    _diplomaticBandHeight,
  );

  static final PlateSpec government = _standard(
    id: 'kw.government',
    country: KuwaitCountry.government,
    caption: 'دولة الكويت - حكومة',
    captionGlyph: 38,
  );

  /// National guard: yellow on teal. The one category whose artwork has no
  /// "KUWAIT" band, so the serial runs the full width of the plate.
  static final PlateSpec nationalGuard = _standard(
    id: 'kw.nationalguard',
    country: KuwaitCountry.nationalGuard,
    caption: 'الحرس الوطني',
    captionGlyph: 42,
    band: false,
  );

  static final PlateSpec army = _standard(
    id: 'kw.army',
    country: KuwaitCountry.army,
    caption: 'الجيش الكويتي',
    captionGlyph: 42,
  );

  static final PlateSpec commercial = _standard(
    id: 'kw.commercial',
    country: KuwaitCountry.commercial,
    caption: 'دولة الكويت-تجاري',
    captionGlyph: 40,
  );

  static final PlateSpec construction = _standard(
    id: 'kw.construction',
    country: KuwaitCountry.construction,
    caption: 'دولة الكويت-إنشاءات',
    captionGlyph: 37,
  );

  static final PlateSpec firefighting = _standard(
    id: 'kw.firefighting',
    country: KuwaitCountry.firefighting,
    caption: 'FIRE-الإطفاء العام',
    captionGlyph: 37,
  );

  static final PlateSpec exportPlate = _standard(
    id: 'kw.export',
    country: KuwaitCountry.export,
    caption: 'دولة الكويت - تصدير',
    captionGlyph: 37,
  );

  static final PlateSpec customs = _standard(
    id: 'kw.customs',
    country: KuwaitCountry.customs,
    caption: 'دولة الكويت - جمرك مؤقت',
    captionGlyph: 32,
  );

  static final PlateSpec emiri = _standard(
    id: 'kw.emiri',
    country: KuwaitCountry.emiri,
    caption: 'دولة الكويت - الديوان الأميري',
    captionGlyph: 23,
  );

  static final PlateSpec emiriGuard = _standard(
    id: 'kw.emiriguard',
    country: KuwaitCountry.emiriGuard,
    caption: 'الحرس الأميري',
    captionGlyph: 42,
  );

  /// Motorcycle (155x155): "دولة الكويت" above the serial, the class digit and
  /// "دراجة" below it.
  static final PlateSpec motorcycle = PlateSpec(
    id: 'kw.motorcycle',
    country: KuwaitCountry.civilian,
    canvasWidth: _Layout.squareSide,
    canvasHeight: _Layout.squareSide,
    noPanel: true,
    panel: _noPanel,
    slots: <PlateSlot>[
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: _Layout.squareFaceLeft,
        width: (_Layout.squareFaceRight - _Layout.squareFaceLeft) / 4,
        top: 52,
        height: 42,
      ),
      const PlateSlot(
        alphabet: PlateAlphabet.latinDigits,
        box: PlateBox(58, 106, 26, 34),
      ),
    ],
    background: _squareBackground,
    labels: <PlateLabel>[
      _squareKuwaitLabel,
      const PlateLabel(
        text: 'دولة الكويت',
        box: PlateBox(44, 10, 104, 32),
        glyphHeight: 24,
      ),
      const PlateLabel(
        text: 'دراجة',
        box: PlateBox(96, 106, 52, 34),
        glyphHeight: 24,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup([0], key: 'serial'),
      PlateTextGroup([1], key: 'class'),
    ],
  );

  /// Police motorcycle (155x155): "شرطة" above the serial, "POLICE" below.
  static final PlateSpec policeMotorcycle = PlateSpec(
    id: 'kw.policemotorcycle',
    country: KuwaitCountry.policeMotorcycle,
    canvasWidth: _Layout.squareSide,
    canvasHeight: _Layout.squareSide,
    noPanel: true,
    panel: _noPanel,
    slots: <PlateSlot>[
      plateField(
        alphabet: PlateAlphabet.latinDigits,
        count: 4,
        left: _Layout.squareFaceLeft,
        width: (_Layout.squareFaceRight - _Layout.squareFaceLeft) / 4,
        top: 52,
        height: 38,
      ),
    ],
    background: _squareBackground,
    labels: <PlateLabel>[
      _squareKuwaitLabel,
      const PlateLabel(
        text: 'شرطة',
        box: PlateBox(52, 10, 96, 26),
        glyphHeight: 26,
      ),
      const PlateLabel(
        text: 'POLICE',
        box: PlateBox(44, 114, 104, 26),
        glyphHeight: 24,
      ),
    ],
    textGroups: const <PlateTextGroup>[
      PlateTextGroup([0], key: 'serial'),
    ],
  );

  static const PlateSection _squareBackground =
      PlateSection.columns(<PlatePart>[
        PlatePart(
          PlateSection.plain,
          end: _Layout.squareRuleLeft + 1,
          divider: 2,
        ),
        PlatePart(PlateSection.plain),
      ]);

  static const PlateLabel _squareKuwaitLabel = PlateLabel(
    text: 'K\nU\nW\nA\nI\nT',
    box: _Layout.squareKuwaitBand,
    glyphHeight: _Layout.squareKuwaitGlyph,
    lineHeight: _Layout.squareKuwaitLineHeight,
  );

  static final List<PlateSpec> all = List<PlateSpec>.unmodifiable(<PlateSpec>[
    civilian,
    transport,
    police,
    policeMotorcycle,
    government,
    diplomatic,
    nationalGuard,
    army,
    commercial,
    construction,
    firefighting,
    exportPlate,
    customs,
    emiri,
    emiriGuard,
    motorcycle,
  ]);
}
