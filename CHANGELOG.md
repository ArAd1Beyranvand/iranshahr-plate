## Unreleased

- Every sub-country now has one `PlateSlot` per field (serial, region, letters…) instead of one per character. `PlateEntry.values` is one string per field; `entry.group(key)` is unchanged.
- Fields with a legal range are variable (`minLength`..`length`): Afghanistan serial 3–5 (two-wheeler 3–4), Oman number 4–5, Qatar civilian serial 3–5, Turkey letters 1–3 and serial 2–5, UAE serial 1–5.
- Removed, now one spec with variable fields:
  - `AfghanistanPlates.car3/car4/car5` → `car`; `cycle3/cycle4` → `cycle`.
  - `TurkeyPlates.strip(l, d)`, `plain(l, d)`, `motorcycle(l, d)` → `strip`, `plain`, `motorcycle`.
  - `OmanPlates` four/five-digit specs, `standard({digits, letters})`, `oneLetter` and `twoLetters` → `standard`; the code is one letter or a listed two-letter pair.
  - `QatarPlates.civilian4`, `civilian3`, `civilianSizes` → `civilian`.
  - `TurkeyPlates.private`, `taxi`, `istanbulTaxi`, `police`, `gendarmerie`, `coastGuard`, `official`, `provincialGovernment`, `diplomatic`, `consulate`, `internationalOrganization`, `temporaryCustoms`, `foreignResident`, `syrianResident` → `strip`/`plain`; the letters pick the livery. Their validators → `TurkeyPlateValidator.general`/`police`.
  - `ArmeniaPlates.diplomaticArm` → `diplomatic`; `AM`/`ARM` is a slot.
  - `UzbekistanPlates.foreignCitizen`, `foreignCompany` → `foreign`; `H`/`M` is a slot and picks yellow or green.
- Turkmenistan, Uzbekistan and Kazakhstan live only here; the standalone packages are gone.

## 0.1.0

First pub.dev release.
