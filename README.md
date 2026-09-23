# iranshahr_plate

License plates for **Bahrain**, **Azerbaijan**, **Afghanistan**, and **Armenia** — four countries with the [`core_plate`](https://pub.dev/packages/core_plate) library.

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

## Afghanistan

Eleven plate specs in five colour themes, and the one bilingual design here.
The serial is printed twice — iranian Arabic numerals over Latin figures — and
so is the vehicle class, as a Persian letter over its Latin code; each pair is
one stored value echoed by a `PlateMirror`, so they cannot drift apart.

- **`car3` / `car4` / `car5`** — the private plate, at each serial length
- **`kabul6`** — Kabul only: a sixth figure, printed once in Persian between hyphens
- **`cycle3` / `cycle4`** — motorcycles and rickshaws, on their own shallower canvas
- **`diplomatic`** — red field, hyphenated mission-and-serial number, `CD`
- **`governmental`** — black field; the class is a dash in both registers
- **`un`** — blue field, nothing at the head
- **`temporary`** — issued from 2023; the one plate printed in two inks
- **`international`** — Herat's 2026 cross-border plate, Latin only

The eleven types (bus, taxi, lorry, private, duplicate, …) are mostly *not*
separate specs: the class is a single character on `AfghanistanAlphabets.vehicleClass`,
so a taxi is `car5` with a `'T'` and `AfghanistanThemes.transport`.

The block at the hoist end is the province, and it is the plate's `PlateCountry`
rather than part of its spec — name over the Darul Aman emblem over a
three-letter Latin code:

```dart
PlateCanvas(
  spec: AfghanistanPlates.car5,
  theme: AfghanistanThemes.civilian,
  country: AfghanistanProvince.herat.country(),
)
PlateCanvas(
  spec: AfghanistanPlates.diplomatic,
  theme: AfghanistanThemes.diplomatic,
  country: AfghanistanProvince.kabul.country(ink: AfghanistanPanelInk.light),
)
```

## Armenia

Ten plate specs in five colour themes, on a German-style face: the flag over
`AM`, a silver identifier band, and `NN LL NNN` told apart by gaps alone — no
hyphen and no divider.

- **`car` / `carTwoRow` / `motorcycle`** — the private number, in its three sizes
- **`public`** — the state number, `NNN LL NN`, with the groups the other way round
- **`trailer`** — a pre-2014 two-row design, one letter instead of two
- **`bus`** — black on yellow, `NNNN L`: `S` for a city bus, `L` for a coach
- **`diplomatic` / `diplomaticArm`** — white on red; newer plates print `ARM` for `AM`
- **`un`** — white on blue, three digits between two printed words
- **`military`** — white on black, and the one Armenian plate with no Latin on it

Two things about Armenia are rules rather than shapes, and both are data here.

**The letters.** The four the system opened with in 1996 were Armenian letters
chosen for their shapes — `Ս` reads *s* and looks like `U`, `Տ` reads *t* and
looks like `S`, `Օ` reads *ô* and looks like `O` — so an Armenian read them as
Armenian and everyone else read them as Latin. The other twenty-two are plain
Latin, added in batches until 2019, and `ArmeniaAlphabets.introduced` has the
date of each. `G` and `I` are still issued to the Police and the Prosecutor's
office alone, so a private plate carries neither:

```dart
const ArmeniaPlateValidator().validate(entry);              // 01 GG 234 → invalid
const ArmeniaPlateValidator(issuedYear: 2015).validate(e);  // 01 JW 234 → invalid: J is 2018
```

**The state plates.** A public number's trailing `LL NN` is not a serial but an
institution — `NN 01` the Security Council, `GG 01` the General Prosecutor's
office, `SS 01`, `SS 02` and `SS 03` three different bodies sharing a letter
pair. That is a membership test, not a shape, so the table is
`ArmeniaSpecialPlates` and the validator just asks it.

The region is the first two digits of the number itself, never a panel, so
`ArmeniaRegions` is a lookup rather than a country block:

```dart
ArmeniaRegions.provinceFor('01');  // ArmeniaProvince.yerevan
ArmeniaRegions.provinceFor('90');  // null — an individual plate, showing no province
```

```dart
PlateCanvas(spec: ArmeniaPlates.car, theme: ArmeniaThemes.civilian, ...)
PlateCanvas(spec: ArmeniaPlates.military, theme: ArmeniaThemes.military, ...)
```

## Usage

Add `iranshahr_plate` to your `pubspec.yaml`:

```yaml
dependencies:
  iranshahr_plate: ^0.1.0
```

Import and use:

```dart
import 'package:iranshahr_plate/iranshahr.dart';
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
- `src/afghanistan/` — Afghan plate specs, themes, colors, alphabets, and the province enum
- `src/armenia/` — Armenian plate specs, themes, colors, alphabets, the region lookup, the reserved-combination table, and the validators
- `assets/flags/` — SVG flag assets
- `assets/emblems/` — the Darul Aman line art, in a dark and a light ink

The four countries' code is completely independent — no cross-imports, no shared constants.
