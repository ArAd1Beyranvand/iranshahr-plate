"""Port of iranshahr_plate/lib/src/kazakhstan/kazakhstan_validators.dart."""
from __future__ import annotations

import re
from dataclasses import dataclass

from plates.core.validators.plate_validator import (
    GatedPlateValidator, PlateEntry, PlateValidation, is_digits_of_length)

NOT_FOUND = 'COUNTRY NOT FOUND'
REFUSED_MISSIONS = ('007',)
REGION_CODES = tuple(f'{i:02d}' for i in range(1, 21))
MISSIONS = {
    '001': 'United States',
    '002': 'Iran',
    '003': 'China',
    '004': 'Turkey',
    '005': 'Germany',
    '006': 'Pakistan',
    '008': 'India',
    '009': 'Canada',
    '010': 'North Korea',
    '011': 'France',
    '012': 'Mongolia',
    '013': 'Italy',
    '014': 'Cuba',
    '015': 'Hungary',
    '016': 'Libya',
    '017': 'Romania',
    '018': 'United Kingdom',
    '019': 'Russia',
    '020': 'Armenia',
    '021': 'Japan',
    '022': 'Switzerland',
    '023': 'Uzbekistan',
    '024': 'Palestine',
    '025': 'South Korea',
    '026': 'Egypt',
    '027': 'Czech Republic',
    '028': 'Lithuania',
    '029': 'Georgia',
    '031': 'Tajikistan',
    '032': 'Poland',
    '033': 'Bulgaria',
    '034': 'Ukraine',
    '035': 'Afghanistan',
    '036': 'Central Asia Regional Economic Cooperation Program',
    '037': 'UNICEF',
    '038': 'Lebanon',
    '039': 'Kyrgyzstan',
    '040': 'European Union',
}


@dataclass(frozen=True)
class KazakhstanValidator(GatedPlateValidator):
    letters: int = 3
    gate_group = 'region'

    REASON_NUMBER = 'The number is three digits.'
    REASON_LETTERS = 'The serial has the wrong number of letters.'
    REASON_REGION = 'The region code is 01 to 20.'

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not is_digits_of_length(entry.group('number'), 3):
            return PlateValidation.invalid(self.REASON_NUMBER)
        if not re.fullmatch(f'[A-Z]{{{self.letters}}}', entry.group('letters')):
            return PlateValidation.invalid(self.REASON_LETTERS)
        if entry.group('region') not in REGION_CODES:
            return PlateValidation.invalid(self.REASON_REGION)
        return PlateValidation.valid()


class KazakhstanDiplomaticValidator(GatedPlateValidator):
    gate_group = 'number'

    REASON_CLASS = 'The class is one letter.'
    REASON_NUMBER = 'The number is three digits.'

    def validate(self, entry: PlateEntry) -> PlateValidation:
        if entry.group('mission') in REFUSED_MISSIONS:
            return PlateValidation.invalid(NOT_FOUND)
        return super().validate(entry)

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not re.fullmatch(r'[A-Z]', entry.group('class')):
            return PlateValidation.invalid(self.REASON_CLASS)
        if entry.group('mission') not in MISSIONS:
            return PlateValidation.invalid(NOT_FOUND)
        if not is_digits_of_length(entry.group('number'), 3):
            return PlateValidation.invalid(self.REASON_NUMBER)
        return PlateValidation.valid()
