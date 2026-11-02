"""Port of iranshahr_plate/lib/src/uzbekistan/uzbekistan_validators.dart."""
from __future__ import annotations

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

NOT_FOUND = 'COUNTRY NOT FOUND'
REFUSED_MISSIONS = ('011',)
MISSIONS = {
    '001': 'Turkey',
    '002': 'China',
    '003': 'Pakistan',
    '004': 'Germany',
    '005': 'India',
    '006': 'France',
    '007': 'Russia',
    '008': 'Iran',
    '009': 'Italy',
    '010': 'United States',
    '020': 'United States',
    '012': 'Jordan',
    '013': 'Korea',
    '014': 'Afghanistan',
    '015': 'Japan',
    '016': 'United Kingdom',
    '017': 'Vietnam',
    '018': 'Switzerland',
    '021': 'Malaysia',
    '022': 'Algeria',
    '023': 'Indonesia',
    '025': 'Saudi Arabia',
    '026': 'Egypt',
    '029': 'Ukraine',
    '030': 'Kazakhstan',
    '031': 'Poland',
    '032': 'Kyrgyzstan',
    '033': 'Latvia',
    '035': 'South Korea',
    '036': 'Palestine',
    '037': 'Moldova',
    '038': 'Slovakia',
    '039': 'Czech Republic',
    '040': 'Azerbaijan',
    '041': 'South Africa',
    '043': 'Bangladesh',
    '044': 'Belarus',
    '046': 'Georgia',
    '052': 'North Macedonia',
}


class UzbekistanValidator(GatedPlateValidator):
    gate_group = 'region'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        for g in entry.spec.text_groups:
            if g.key is None:
                continue
            expected = sum(entry.spec.slots[i].length for i in g.indices)
            if len(entry.group(g.key)) != expected:
                return PlateValidation.invalid(f'The {g.key} is incomplete.')
        return PlateValidation.valid()


class UzbekistanDiplomaticValidator(GatedPlateValidator):
    gate_group = 'mission'

    def validate(self, entry: PlateEntry) -> PlateValidation:
        if entry.group('mission') in REFUSED_MISSIONS:
            return PlateValidation.invalid(NOT_FOUND)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        mission = entry.group('mission')
        if len(mission) != 3:
            return PlateValidation.invalid('The mission code is incomplete.')
        if mission not in MISSIONS:
            return PlateValidation.invalid(NOT_FOUND)
        if len(entry.group('serial')) != 3:
            return PlateValidation.invalid('The serial is incomplete.')
        return PlateValidation.valid()


class UzbekistanUnitedNationsValidator(GatedPlateValidator):
    gate_group = 'serial'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if is_digits_of_length(entry.group('serial'), 4):
            return PlateValidation.valid()
        return PlateValidation.invalid('The serial is incomplete.')
