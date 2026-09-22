# iranshahr

Bahrain's and Azerbaijan's licence plates for the [`core_plate`](https://pub.dev/packages/core_plate) library.

Data, not code: [`PlateCountry`](https://pub.dev/documentation/core_plate/latest/core_plate/PlateCountry-class.html)s, [`PlateAlphabet`](https://pub.dev/documentation/core_plate/latest/core_plate/PlateAlphabet-class.html)s and [`PlateSpec`](https://pub.dev/documentation/core_plate/latest/core_plate/PlateSpec-class.html)s that the core widget layer paints.

## Bahrain

Five plate designs, each in one colour theme:

- **Civilian EU** — white flag on white field
- **Civilian US tall** — white flag on white field
- **Civilian US wide** — white flag on white field
- **Diplomatic corps** — flag-free, green band
- **Police** — flag-free, pale blue band

```dart
PlateCanvas(spec: BahrainPlates.eu, theme: BahrainThemes.civilian, ...)
PlateCanvas(spec: BahrainPlates.diplomatic, theme: BahrainThemes.diplomatic, ...)
PlateCanvas(spec: BahrainPlates.police, theme: BahrainThemes.police, ...)
```

## Azerbaijan

Four plate designs, each in four colour themes:

- **Civilian** — white block
- **Motorcycle** — white block, smaller
- **Diplomatic** — white block, red field
- **Foreign company** — white block, yellow field

```dart
PlateCanvas(spec: AzerbaijanPlates.car, theme: AzerbaijanThemes.civilian, ...)
PlateCanvas(spec: AzerbaijanPlates.motorcycle, theme: AzerbaijanThemes.transport, ...)
PlateCanvas(spec: AzerbaijanPlates.diplomatic, theme: AzerbaijanThemes.diplomatic, ...)
PlateCanvas(spec: AzerbaijanPlates.foreignCompany, theme: AzerbaijanThemes.foreignCompany, ...)
```

## Usage

Add `iranshahr` to your `pubspec.yaml`:

```yaml
dependencies:
  iranshahr: ^0.1.0
```

Import and use:

```dart
import 'package:iranshahr/iranshahr.dart';
import 'package:core_plate/core_plate.dart';

PlateCanvas(
  spec: BahrainPlates.eu,
  theme: BahrainThemes.civilian,
  height: 80,
)
```

## Structure

- `src/bahrain/` — Bahraini plate specs, themes, colors, and country block
- `src/azerbaijan/` — Azerbaijani plate specs, themes, colors, and country block
- `assets/flags/` — SVG flag assets for both countries

The two countries' code is completely independent — no cross-imports, no shared constants.
