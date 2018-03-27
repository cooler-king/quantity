part of quantity_ext;

/// A synonym for the standard Si-MKS unit of permeability.
PermeabilityUnits henriesPerMeter = Permeability.henriesPerMeter;

PermeabilityUnits newtonsPerAmpereSquared = Permeability.newtonsPerAmpereSquared;

// Constants.

/// The magnetic permeability in a classical vacuum.
const Permeability magneticConstant = const Permeability.constant(const Double.constant(4.0e-7 * PI));
