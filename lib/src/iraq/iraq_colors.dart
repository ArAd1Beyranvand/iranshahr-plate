import 'package:flutter/widgets.dart';

/// Every colour an Iraqi plate is printed in. Sampled from Wikipedia graphics
/// (https://en.wikipedia.org/wiki/Vehicle_registration_plates_of_Iraq).
abstract final class IraqColors {
  // Panel colours by vehicle type — sampled from modal colour of left band
  static const Color redPanel = Color(0xFFED1C24); // Vehicle for hire, buses, taxis
  static const Color bluePanel = Color(0xFF0079C1); // Governmental vehicles
  static const Color whitePanel = Color(0xFF7A7A7A); // Private vehicles (gray/neutral)
  static const Color yellowPanel = Color(0xFFFFC913); // Trade/commercial (trucks)
  static const Color greenPanel = Color(0xFF01A06A); // Agricultural

  // Main field
  static const Color whiteField = Color(0xFFFFFFFF);
  static const Color blackText = Color(0xFF1A1A1A);
  static const Color blackBorder = Color(0xFF000000);

  // Red-on-white temporary plates
  static const Color temporaryRed = Color(0xFFC0261F);
}
