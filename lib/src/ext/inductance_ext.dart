part of quantity_ext;

InductanceUnits henries = Inductance.henries;

InductanceUnits esuOfInductance = new InductanceUnits("esu of inductance", null, null, null, 8.9876e11, false);

// convenience units
InductanceUnits abhenries = henries.nano() as InductanceUnits;

InductanceUnits emuOfInductance = abhenries;
