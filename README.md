FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the kindred peoples of Iranshahr to view examples:

https://platexample.ir/#/discover/iranshahr

# iranshahr_plate

License plates for **Bahrain**, **Azerbaijan**, **Afghanistan**, **Armenia**, and **Tajikistan** — five countries with [`plate_core`](https://pub.dev/packages/plate_core). Data, not code: [`PlateCountry`](https://pub.dev/documentation/plate_core/latest/plate_core/PlateCountry-class.html)s, [`PlateAlphabet`](https://pub.dev/documentation/plate_core/latest/plate_core/PlateAlphabet-class.html)s and [`PlateSpec`](https://pub.dev/documentation/plate_core/latest/plate_core/PlateSpec-class.html)s that the widget layer paints.

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

## Tajikistan

Nine plate specs in six colour themes, on a German-style face: the flag over
`TJ`, and `NNNN LL NN` told apart by gaps alone — no hyphen and no divider.

- **`car` / `carTwoRow` / `motorcycle`** — the private number, in its three sizes
- **`trailer`** — a two-row design that leads with its region, `NN LL` over `NNNN`
- **`publicTransport`** — black on amber, the fixed `TT` printed between serial and region
- **`police`** — white on blue, `NNNN L NN`
- **`foreign`** — black on yellow, `NNN L NNN`, and no flag block
- **`diplomatic`** — white on red; the class is `CD`, `CMD`, `D`, `T` or `S`
- **`governmental`** — white on black, the old Russian-derived layout with the region boxed off and `RT` beneath it

**The letters.** A Tajik plate's register is a Cyrillic one wearing Latin
shapes: the eleven letters whose Cyrillic and Latin forms coincide — `А В Е К
М Н О Р С Т Х` — plus the four plain-Latin additions of 2014, `D J Z Y`. They
are stored and rendered in Latin, so there is nothing to transliterate.

The flag block sits on three differently coloured fields, so it is three
`PlateCountry` values — one per ink — and the region is the two-digit group of
the number itself, never a panel, so `TajikistanRegions` is a lookup:

```dart
TajikistanRegions.regionFor('01');  // TajikistanRegion.dushanbe
TajikistanRegions.isIssued('09');   // false — only 01–08 are issued
```

```dart
PlateCanvas(spec: TajikistanPlates.car, theme: TajikistanThemes.civilian, ...)
PlateCanvas(spec: TajikistanPlates.police, theme: TajikistanThemes.police, ...)
```

## Usage

Add `iranshahr_plate` to your `pubspec.yaml`:

```yaml
dependencies:
  iranshahr_plate: ^0.1.0
```

Import and use:

```dart
import 'package:iranshahr_plate/iranshahr_plate.dart';
import 'package:plate_core/plate_core.dart';

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

## Also available

- [`plate_core`](https://pub.dev/packages/plate-core) - Paint license plates.
- [`plate_alphabet`](https://pub.dev/packages/plate-alphabet) - A library of alphabets for license plates.
- [`plate_keypad`](https://pub.dev/packages/plate-keypad) - A character picker for license plates.
- [`plate_number_holder`](https://pub.dev/packages/plate-number-holder) - A frame to hold license plate numbers.
- [`algeria_plate`](https://pub.dev/packages/algeria-plate) - Algeria's licence plates.
- [`bolivia_plate`](https://pub.dev/packages/bolivia-plate) - Bolivia's licence plates.
- [`colombia_plate`](https://pub.dev/packages/colombia-plate) - Colombia's licence plates.
- [`cuba_plate`](https://pub.dev/packages/cuba-plate) - Cuba's licence plates.
- [`germany_plate`](https://pub.dev/packages/germany-plate) - Germany's licence plates.
- [`india_plate`](https://pub.dev/packages/india-plate) - India's licence plates.
- [`indonesia_plate`](https://pub.dev/packages/indonesia-plate) - Indonesia's licence plates.
- [`iran_plate`](https://pub.dev/packages/iran-plate) - Iran's licence plates.
- [`lebanon_plate`](https://pub.dev/packages/lebanon-plate) - Lebanon's licence plates.
- [`malaysia_plate`](https://pub.dev/packages/malaysia-plate) - Malaysia's licence plates.
- [`mali_plate`](https://pub.dev/packages/mali-plate) - Mali's licence plates.
- [`niger_plate`](https://pub.dev/packages/niger-plate) - Niger's licence plates.
- [`palestine_plate`](https://pub.dev/packages/palestine-plate) - Palestine's licence plates.
- [`sudan_plate`](https://pub.dev/packages/sudan-plate) - Sudan's licence plates.
- [`tunisia_plate`](https://pub.dev/packages/tunisia-plate) - Tunisia's licence plates.
- [`venezuela_plate`](https://pub.dev/packages/venezuela-plate) - venezuela_ licence plates.
- [`yemen_plate`](https://pub.dev/packages/yemen-plate) - Yemen's licence plates.
