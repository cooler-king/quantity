part of quantity_ext;

/// The standard SI unit.
InductanceUnits henries = Inductance.henries;

/// ESU of nductance as a unit.
InductanceUnits esuOfInductance = new InductanceUnits('esu of inductance', null, null, null, 8.9876e11, false);

// Convenience units.

/// Abhenries is a synonym for nanohenries.
InductanceUnits abhenries = henries.nano() as InductanceUnits;

/// EMU of inductance is a synonym for nonohenries.
InductanceUnits emuOfInductance = abhenries;
