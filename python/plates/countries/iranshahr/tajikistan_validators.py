"""Port of iranshahr_plate/lib/src/tajikistan/tajikistan_validators.dart. Hand-ported; codegen never overwrites this file."""
from __future__ import annotations

from dataclasses import dataclass

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits, is_digits_of_length)

_LETTERS = frozenset('ABCDEHJKMOPTXYZ')
_REGIONS = frozenset(('01', '05', '02', '06', '03', '04', '07', '08'))
_DIPLOMATIC_CLASSES = frozenset(('CD', 'CMD', 'D', 'T', 'S'))


def _validate_region(region: str) -> PlateValidation:
    if len(region) < 2:
        return PlateValidation.valid()
    if not is_digits_of_length(region, 2):
        return PlateValidation.invalid('A region code is two digits.')
    if region not in _REGIONS:
        return PlateValidation.invalid(f'"{region}" is not a region code Tajikistan issues.')
    return PlateValidation.valid()


def _validate_letters(letters: str, count: int) -> PlateValidation:
    value = letters.upper()
    for letter in value:
        if letter not in _LETTERS:
            return PlateValidation.invalid(f'"{letter}" is not a plate letter.')
    if len(value) > count:
        return PlateValidation.invalid(f'The letter group is {count} letter(s).')
    return PlateValidation.valid()


def _validate_serial(serial: str, length: int) -> PlateValidation:
    if serial and not is_digits(serial):
        return PlateValidation.invalid('The serial must be digits.')
    if len(serial) > length:
        return PlateValidation.invalid(f'The serial is {length} digits.')
    return PlateValidation.valid()


@dataclass(frozen=True)
class TajikistanPlateValidator(GatedPlateValidator):
    serial_length: int = 4
    letter_count: int = 2
    check_region: bool = True
    gate: str = 'region'

    @property
    def gate_group(self) -> str:
        return self.gate

    validate_region = staticmethod(_validate_region)
    validate_letters = staticmethod(_validate_letters)
    validate_serial = staticmethod(_validate_serial)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if self.check_region:
            region = _validate_region(entry.group('region'))
            if not region.is_valid:
                return region
        if self.letter_count > 0:
            letters = _validate_letters(entry.group('letters'), self.letter_count)
            if not letters.is_valid:
                return letters
        return _validate_serial(entry.group('serial'), self.serial_length)


@dataclass(frozen=True)
class TajikistanForeignPlateValidator(GatedPlateValidator):
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        prefix = _validate_serial(entry.group('prefix'), 3)
        if not prefix.is_valid:
            return prefix
        letter = _validate_letters(entry.group('letters'), 1)
        if not letter.is_valid:
            return letter
        return _validate_serial(entry.group('serial'), 3)


@dataclass(frozen=True)
class TajikistanDiplomaticPlateValidator(GatedPlateValidator):
    gate_group = 'tail'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        serial = _validate_serial(entry.group('serial'), 3)
        if not serial.is_valid:
            return serial
        code = entry.group('class').upper()
        if code and code not in _DIPLOMATIC_CLASSES:
            return PlateValidation.invalid('A diplomatic class is CD, CMD, D, T or S.')
        tail = entry.group('tail')
        if tail and not is_digits(tail):
            return PlateValidation.invalid('The trailing group must be digits.')
        if len(tail) > 1:
            return PlateValidation.invalid('The trailing group is one digit.')
        return PlateValidation.valid()
