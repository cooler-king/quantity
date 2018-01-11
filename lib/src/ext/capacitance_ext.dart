part of quantity_ext;

/// The standard SI unit.
final CapacitanceUnits farads = Capacitance.farads;

final CapacitanceUnits emuCapacitance = new CapacitanceUnits('emu (capacitance)', null, null, null, 1.0e8, true);

final CapacitanceUnits statfarads = new CapacitanceUnits('statfarads', null, null, null, 1.1127e-12, false);

// convenience units
final CapacitanceUnits abfarads = farads.giga() as CapacitanceUnits;

final CapacitanceUnits esuCapacitance = statfarads;
