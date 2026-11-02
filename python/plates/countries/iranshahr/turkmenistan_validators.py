"""Port of iranshahr_plate/lib/src/turkmenistan/turkmenistan_validators.dart. Hand-ported; codegen never overwrites this file."""
from __future__ import annotations

import re
from dataclasses import dataclass

from plates.core.validators.plate_validator import GatedPlateValidator, PlateEntry, PlateValidation

_PROVINCE_CODES = ('AG', 'AH', 'AK', 'BN', 'DZ', 'LB', 'MR')


@dataclass(frozen=True)
class TurkmenistanPart:
    group: str
    length: int
    digits: bool = False
    allowed: tuple[str, ...] | None = None

    def accepts(self, value: str) -> bool:
        kind = '[0-9]' if self.digits else '[A-Z]'
        if re.fullmatch(f'{kind}{{{self.length}}}', value) is None:
            return False
        return self.allowed is None or value in self.allowed

    @property
    def reason(self) -> str:
        if self.allowed is not None:
            return f"The {self.group} is one of {', '.join(self.allowed)}."
        return f"The {self.group} is {self.length} {'digits' if self.digits else 'letters'}."


def _part(group, length, digits=False, allowed=None):
    return TurkmenistanPart(group, length, digits, allowed)


_province = _part('region', 2, allowed=_PROVINCE_CODES)
_private = (_part('series', 2), _part('number', 4, True), _province)


@dataclass(frozen=True)
class TurkmenistanValidator(GatedPlateValidator):
    parts: tuple = _private

    def __post_init__(self):
        parts = tuple(p if isinstance(p, TurkmenistanPart) else TurkmenistanPart(**{**p, 'allowed': None if p.get('allowed') is None else tuple(p['allowed'])})
                      for p in self.parts)
        object.__setattr__(self, 'parts', parts)

    @property
    def gate_group(self) -> str:
        return self.parts[-1].group

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for part in self.parts:
            if not part.accepts(entry.group(part.group)):
                return PlateValidation.invalid(part.reason)
        return PlateValidation.valid()


TurkmenistanValidator.classic = TurkmenistanValidator((_part('series', 1), _part('first', 2, True), _part('second', 2, True), _province))
TurkmenistanValidator.trailer = TurkmenistanValidator((_part('series', 2), _part('number', 4, True), _part('letters', 2)))
TurkmenistanValidator.foreign = TurkmenistanValidator((_part('class', 1, True), _part('letter', 1, allowed=('H',)), _part('number', 5, True)))
TurkmenistanValidator.foreign_trailer = TurkmenistanValidator((_part('class', 1, True), _part('letters', 2, allowed=('HT',)), _part('number', 4, True)))
TurkmenistanValidator.export = TurkmenistanValidator((_part('letters', 3), _part('number', 4, True)))
TurkmenistanValidator.diplomatic = TurkmenistanValidator((_part('embassy', 2, True), _part('letters', 2, allowed=('CD',)), _part('number', 3, True)))
TurkmenistanValidator.government = TurkmenistanValidator((_part('number', 4, True), _part('letters', 3)))
TurkmenistanValidator.military = TurkmenistanValidator((_part('number', 4, True), _part('letters', 2)))
TurkmenistanValidator.ceremony = TurkmenistanValidator((_part('letters', 6), _part('number', 1, True)))
