import 'package:flutter/widgets.dart';
import 'package:plate_core/plate_core.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

void main() => runApp(
  PlateExampleApp(
    spec: AfghanistanPlates.car,
    theme: AfghanistanThemes.civilian,
  ),
);
