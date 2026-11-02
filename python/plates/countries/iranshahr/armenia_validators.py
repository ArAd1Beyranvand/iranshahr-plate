"""Port of iranshahr_plate/lib/src/armenia/armenia_validators.dart. Hand-ported; codegen never overwrites this file."""
from __future__ import annotations

from dataclasses import dataclass

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)

_LETTERS = frozenset('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
_STATE_VEHICLES_ONLY = frozenset('GI')

# First (year, month) each letter was issued.
_INTRODUCED = {
    'L': (1996, 1), 'U': (1996, 1), 'S': (1996, 1), 'O': (1996, 1), 'P': (2008, 12),
    'D': (2012, 7), 'N': (2012, 7), 'T': (2012, 7), 'V': (2012, 7),
    'A': (2012, 5), 'M': (2012, 5), 'Q': (2012, 5), 'R': (2012, 5),
    'C': (2013, 10), 'F': (2013, 10), 'Z': (2013, 10), 'G': (2015, 1), 'I': (2015, 1),
    'X': (2016, 1), 'B': (2017, 1), 'H': (2017, 1), 'J': (2018, 1),
    'W': (2019, 1), 'Y': (2019, 1), 'K': (2019, 1), 'E': (2019, 1),
}


def _in_use_on(letter: str, year: int, month: int = 12) -> bool:
    start = _INTRODUCED.get(letter.upper())
    return start is not None and (year > start[0] or (year == start[0] and month >= start[1]))


def _codes(*spans: tuple[int, int]) -> set[str]:
    return {f'{n:02d}' for lo, hi in spans for n in range(lo, hi + 1)}


# Every code 01-99 is a province or an individually issued code.
_REGIONS = _codes((1, 99))

# Letter pairs issued to institutions, with their tails (None: any tail).
_SPECIAL = {
    'OS': {'01'}, 'UU': {'01'}, 'OO': _codes((1, 11)), 'FF': {'01'}, 'LL': {'03', '50', '55', '60', '70'},
    'SS': {'03', '60', '01', '02'}, 'VV': {'01'}, 'NN': {'01'}, 'GG': {'01'}, 'II': None, 'SL': _codes((1, 33)),
}


def validate_region(region: str) -> PlateValidation:
    if len(region) < 2:
        return PlateValidation.valid()
    if not is_digits_of_length(region, 2):
        return PlateValidation.invalid('A region code is two digits.')
    if region not in _REGIONS:
        return PlateValidation.invalid(f'"{region}" is not a region code Armenia issues.')
    return PlateValidation.valid()


def validate_letters(letters: str, count: int, issued_year: int | None = None, issued_month: int = 12) -> PlateValidation:
    value = letters.upper()
    for letter in value:
        if letter not in _LETTERS:
            return PlateValidation.invalid(f'"{letter}" is not a plate letter.')
        if letter in _STATE_VEHICLES_ONLY:
            return PlateValidation.invalid(f'"{letter}" is issued to the Police and the Prosecutor\'s office only.')
        if issued_year is not None and not _in_use_on(letter, issued_year, issued_month):
            return PlateValidation.invalid(f'"{letter}" was not being issued in {issued_year}.')
    if len(value) > count:
        return PlateValidation.invalid(f'The letter block is {count} letter(s).')
    return PlateValidation.valid()


def validate_serial(serial: str, length: int) -> PlateValidation:
    if serial and not is_digits(serial):
        return PlateValidation.invalid('The serial must be digits.')
    if len(serial) > length:
        return PlateValidation.invalid(f'The serial is {length} digits.')
    return PlateValidation.valid()


@dataclass(frozen=True)
class ArmeniaPlateValidator(GatedPlateValidator):
    issued_year: int | None = None
    issued_month: int = 12
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        region = validate_region(entry.group('region'))
        if not region.is_valid:
            return region
        letters = validate_letters(entry.group('letters'), 2, self.issued_year, self.issued_month)
        if not letters.is_valid:
            return letters
        return validate_serial(entry.group('serial'), 3)


@dataclass(frozen=True)
class ArmeniaPublicPlateValidator(GatedPlateValidator):
    gate_group = 'tail'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = validate_serial(entry.group('serial'), 3)
        if not serial.is_valid:
            return serial
        letters, tail = entry.group('letters').upper(), entry.group('tail')
        if len(letters) < 2 or len(tail) < 2:
            return PlateValidation.valid()
        if not is_digits_of_length(tail, 2):
            return PlateValidation.invalid('The last group is two digits.')
        if letters not in _SPECIAL or (_SPECIAL[letters] is not None and tail not in _SPECIAL[letters]):
            return PlateValidation.invalid(f'"{letters} {tail}" is not a combination issued to any institution.')
        return PlateValidation.valid()


@dataclass(frozen=True)
class ArmeniaTrailerPlateValidator(GatedPlateValidator):
    gate_group = 'tail'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = validate_serial(entry.group('serial'), 3)
        if not serial.is_valid:
            return serial
        letters = validate_letters(entry.group('letters'), 1)
        if not letters.is_valid:
            return letters
        tail = entry.group('tail')
        if tail and not is_digits(tail):
            return PlateValidation.invalid('The bottom row must be digits.')
        if len(tail) > 2:
            return PlateValidation.invalid('The bottom row is two digits.')
        return PlateValidation.valid()


@dataclass(frozen=True)
class ArmeniaBusPlateValidator(GatedPlateValidator):
    gate_group = 'class'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group('serial'), 4):
            return PlateValidation.invalid('A bus number is four digits.')
        if entry.group('class').upper() not in ('S', 'L'):
            return PlateValidation.invalid('A bus is "S" (city) or "L" (long-range).')
        return PlateValidation.valid()


@dataclass(frozen=True)
class ArmeniaDiplomaticPlateValidator(GatedPlateValidator):
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        mission = entry.group('mission')
        if len(mission) == 2 and not is_digits_of_length(mission, 2):
            return PlateValidation.invalid('A mission code is two digits.')
        if entry.group('class').upper() not in ('D', 'T'):
            return PlateValidation.invalid('A diplomatic plate is "D" (diplomat) or "T" (technician).')
        return validate_serial(entry.group('serial'), 3)


@dataclass(frozen=True)
class ArmeniaMilitaryPlateValidator(GatedPlateValidator):
    gate_group = 'class'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group('serial'), 4):
            return PlateValidation.invalid('A military number is four digits.')
        if entry.group('class').upper() not in ('M', 'T'):
            return PlateValidation.invalid('A military plate is "Մ" (passenger) or "Տ" (transport).')
        return PlateValidation.valid()


@dataclass(frozen=True)
class ArmeniaSerialPlateValidator(GatedPlateValidator):
    length: int
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return validate_serial(entry.group('serial'), self.length)
