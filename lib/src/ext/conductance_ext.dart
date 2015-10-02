part of quantity_ext;

final ConductanceUnits siemens = Conductance.siemens;

final ConductanceUnits statmhos = new ConductanceUnits("statmhos", null, null, null, 1.1127e-12, false);

// convenience units
final ConductanceUnits mho = siemens;
final ConductanceUnits abmho = siemens.giga() as ConductanceUnits;

// Constants
const Conductance conductanceQuantum =
    const Conductance.constant(const Double.constant(7.7480917310e-5), uncert: 2.3231526709966877e-10);
