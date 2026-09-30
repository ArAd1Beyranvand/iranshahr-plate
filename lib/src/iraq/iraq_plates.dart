import 'package:core_plate/core_plate.dart';
import 'package:flutter/widgets.dart';

import 'iraq_alphabets.dart';
import 'iraq_colors.dart';
import 'iraq_country.dart';

/// Iraqi registration plates (2022+).
///
/// Canvas: 520mm × 110mm (standard European size)
/// Format: [Colored panel on left with "IRQ"] [Governorate code] [Letter] [4-digit number]
/// Panel colour indicates vehicle type (red=for-hire, blue=gov, white=private, etc)
///
/// Geometry (in plate coordinates, where 1 unit = 1mm):
/// - Canvas: 520 × 110
/// - Left panel: x 0..60, y 0..110 (coloured band)
/// - Main field: x 60..520, y 0..110 (white background with black text)
/// - Text row: centered, containing governorate code, vehicle letter, and registration number
abstract final class IraqPlates {
  static const double canvasWidth = 520;
  static const double canvasHeight = 110;

  // Panel (left side, ~60mm wide) — colour coded by vehicle type
  static const double panelWidth = 60;

  /// Build a standard registration plate for a given governorate and panel colour.
  /// [govCode]: 2-digit governorate code (e.g., "14" for Basra)
  /// [panelColour]: The colour of the left panel (red, blue, white, yellow, green)
  ///
  /// Format: [Coloured left panel with "IRQ"] [GG·X####]
  /// Where GG = governorate code (2 digits), X = vehicle type letter, #### = registration number
  static PlateSpec _buildStandardPlate({
    required String id,
    required String govCode,
    required Color panelColour,
  }) {
    // Main registration field spans from after panel (x=60) to right edge (x=520)
    const double mainLeft = 70;
    const double mainRight = 510;
    const double mainTop = 15;
    const double mainHeight = 80;

    // Governorate code: 2 digits at x 70..105
    final govCodeSlots = plateRegisterAcross(
      alphabet: IraqAlphabets.digits,
      count: 2,
      left: mainLeft,
      right: mainLeft + 35,
      top: mainTop,
      height: mainHeight,
    );

    // Labels: "IRQ" on left panel (vertical) and separator dot
    final labels = <PlateLabel>[
      // "IRQ" displayed vertically on the left panel
      PlateLabel(
        text: 'IRQ',
        box: PlateBox(5, 20, 50, 70),
        glyphHeight: 20,
        rotated: true,
        color: IraqColors.whiteField, // White text on colored panel
      ),
      // Separator dot "·" — a small label at x 108..120
      PlateLabel(
        text: '·',
        box: PlateBox(108, mainTop, 10, mainHeight),
        glyphHeight: 65,
      ),
    ];

    // Vehicle type letter at x 125..155
    final vehicleLetterSlot = <PlateSlot>[
      PlateSlot(
        alphabet: IraqAlphabets.latinLetters,
        box: PlateBox(125, mainTop, 28, mainHeight),
      ),
    ];

    // Registration number: 4 digits at x 160..510
    final registrationSlots = plateRegisterAcross(
      alphabet: IraqAlphabets.digits,
      count: 4,
      left: 160,
      right: mainRight,
      top: mainTop,
      height: mainHeight,
    );

    // Combine all slots: 2 (gov code) + 1 (vehicle type) + 4 (registration) = 7 total
    final allSlots = <PlateSlot>[
      ...govCodeSlots,
      ...vehicleLetterSlot,
      ...registrationSlots,
    ];

    // Text groups for rendering and validation
    const List<PlateTextGroup> textGroups = <PlateTextGroup>[
      PlateTextGroup([0, 1], key: 'governorate'),
      PlateTextGroup([2], key: 'vehicle_type'),
      PlateTextGroup([3, 4, 5, 6], key: 'registration'),
    ];

    // Create the spec with the coloured left panel
    return PlateSpec(
      id: id,
      country: iraqCountry,
      canvasWidth: canvasWidth,
      canvasHeight: canvasHeight,
      panel: PlatePanel(
        box: PlateBox(0, 0, panelWidth, canvasHeight),
        flagScale: 0,
        captionScale: 0,
      ),
      noPanel: true, // Don't draw a traditional country block
      slots: allSlots,
      labels: labels,
      rules: const <PlateRule>[],
      textGroups: textGroups,
      // Coloured band on the left (vehicle type indicator)
      leftBand: PlateBand(
        box: PlateBox(0, 0, panelWidth, canvasHeight),
        color: panelColour,
        topCornerRadius: 6,
        bottomCornerRadius: 6,
      ),
    );
  }

  // ===== Specific plate instances =====

  // Private vehicles (white panel)
  static final PlateSpec private_11 = _buildStandardPlate(
    id: 'iq.private.11',
    govCode: '11',
    panelColour: IraqColors.whitePanel,
  );

  static final PlateSpec private_14 = _buildStandardPlate(
    id: 'iq.private.14',
    govCode: '14',
    panelColour: IraqColors.whitePanel,
  );

  // Governmental vehicles (blue panel)
  static final PlateSpec governmental_11 = _buildStandardPlate(
    id: 'iq.governmental.11',
    govCode: '11',
    panelColour: IraqColors.bluePanel,
  );

  static final PlateSpec governmental_14 = _buildStandardPlate(
    id: 'iq.governmental.14',
    govCode: '14',
    panelColour: IraqColors.bluePanel,
  );

  // For-hire vehicles (red panel)
  static final PlateSpec forHire_11 = _buildStandardPlate(
    id: 'iq.forHire.11',
    govCode: '11',
    panelColour: IraqColors.redPanel,
  );

  static final PlateSpec forHire_14 = _buildStandardPlate(
    id: 'iq.forHire.14',
    govCode: '14',
    panelColour: IraqColors.redPanel,
  );

  // Commercial/trade vehicles (yellow panel)
  static final PlateSpec commercial_11 = _buildStandardPlate(
    id: 'iq.commercial.11',
    govCode: '11',
    panelColour: IraqColors.yellowPanel,
  );

  // Agricultural vehicles (green panel)
  static final PlateSpec agricultural_11 = _buildStandardPlate(
    id: 'iq.agricultural.11',
    govCode: '11',
    panelColour: IraqColors.greenPanel,
  );
}
