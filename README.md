FREE PALESTINE 🇮🇷🇵🇸 پاینده ایران

GO VEGAN 🌱

==================================

From the mighty people of Iran to the kindred peoples of Iranshahr to view examples:

https://platexample.ir/#/discover/iranshahr

# iranshahr_plate

Licence plates of Afghanistan, Armenia, Azerbaijan, Bahrain, Iraq, Kazakhstan, Kuwait, Oman, Qatar, Tajikistan, Turkey, Turkmenistan, the UAE and Uzbekistan for the `plate_core` library. Data, not code: each country lives in its own `src/` folder and shares no import or constant with any other. 

## Install

```yaml
dependencies:
  plate_core: ^0.12.0
  iranshahr_plate: ^0.1.0
```

## Use

```dart
import 'package:plate_core/plate_core.dart';
import 'package:iranshahr_plate/iranshahr_plate.dart';

PlateCanvas(
  spec: AfghanistanPlates.car,
  theme: AfghanistanThemes.civilian,
  onChooseCharacter: noCharacterChooser,
);
```

## Contains

- `AfghanistanPlates` — 8 plate specs: `car`, `kabul6`, `cycle`, `diplomatic`, `governmental`, `un`, `temporary`, `international`.
- `ArmeniaPlates` — 9 plate specs: `car`, `carTwoRow`, `motorcycle`, `public`, `trailer`, `bus`, `diplomatic`, `un`, `military`.
- `AzerbaijanPlates` — 4 plate specs: `car`, `bicycle`, `diplomatic`, `foreign`.
- `BahrainPlates` — 5 plate specs: `eu`, `us`, `bicycle`, `diplomatic`, `police`.
- `IraqPlates` — 3 plate specs: `large`, `small`, `smallTemporary`.
- `KazakhstanPlates` — 3 plate specs: `private`, `nonPrivate`, `diplomatic`.
- `KuwaitPlates` — 8 plate specs: `civilian`, `transport`, `police`, `diplomatic`, `standard`, `nationalGuard`, `motorcycle`, `policeMotorcycle`.
- `OmanPlates` — 1 plate spec: `standard`.
- `QatarPlates` — 3 plate specs: `civilian`, `motorcycle`, `police`.
- `TajikistanPlates` — 8 plate specs: `car`, `police`, `carTwoRow`, `motorcycle`, `trailer`, `foreign`, `diplomatic`, `governmental`.
- `TurkeyPlates` — 9 plate specs: `strip`, `plain`, `motorcycle`, `temporary`, `temporaryWithStrip`, `governor`, `sample`, `parliament`, `parliamentLabelled`.
- `TurkmenistanPlates` — 10 plate specs: `classic`, `private`, `trailer`, `foreign`, `foreignTrailer`, `export`, `diplomatic`, `government`, `military`, `ceremony`.
- `UaePlates` — 14 plate specs: `abuDhabiLong`, `abuDhabiShort`, `ajmanLong`, `ajmanShort`, `dubaiLong`, `dubaiShort`, `fujairahLong`, `fujairahShort`, `ummAlQuwainLong`, `ummAlQuwainShort`, `rasAlKhaimahLong`, `rasAlKhaimahShort`, `sharjahLong`, `sharjahShort`.
- `UzbekistanPlates` — 8 plate specs: `passenger`, `foreign`, `temporary`, `ambassador`, `diplomat`, `unitedNations`, `trailer`, `motorcycle`.
- 9 bundled assets (`Flag_of_Tajikistan.svg`, `turkmenistan_flag.svg`, `turkmenistan_flag.png`, `turkmenistan_strip.png`, `turkmenistan_crescent.png`, `kazakhstan_flag.svg`…).

Each also ships its `…Country` panel, `…Themes` and, where one exists, an advisory `…Validator`.

## Part of plate

Painted by [`plate_core`](https://pub.dev/packages/plate_core); alphabets shared through [`plate_alphabet`](https://pub.dev/packages/plate_alphabet); optional character picker in [`plate_keypad`](https://pub.dev/packages/plate_keypad).

