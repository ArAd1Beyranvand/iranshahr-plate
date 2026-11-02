"""Port of iranshahr_plate/lib/src/afghanistan/afghanistan_themes.dart. Hand-ported; codegen never overwrites this file."""
from __future__ import annotations

from plates.core.theme.plate_theme import PlateTheme

_INK = 0xFF0D0D0D
_INACTIVE_ON_LIGHT = 0x66666666
_INACTIVE_ON_DARK = 0x99FFFFFF


def _theme(field, ink, inactive):
    return PlateTheme.monochrome(field, ink, inactive, 0.035, 0.09)


class AfghanistanThemes:
    civilian = _theme(0xFFFFFFFF, _INK, _INACTIVE_ON_LIGHT)
    transport = _theme(0xFFF5C518, _INK, _INACTIVE_ON_LIGHT)
    diplomatic = _theme(0xFFE01B1B, 0xFFFFFFFF, _INACTIVE_ON_DARK)
    governmental = _theme(0xFF0A0A0A, 0xFFFFFFFF, _INACTIVE_ON_DARK)

    @staticmethod
    def by_class(base, group):
        t = AfghanistanThemes.transport if group("class") in ("T", "B") else AfghanistanThemes.civilian
        return base.copy_with(
            plate_background=t.plate_background, plate_border=t.plate_border, ink=t.ink,
            divider_color=t.divider_color, active_color=t.active_color, inactive_color=t.inactive_color)
