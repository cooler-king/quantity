part of quantity_ext;

/// The standard SI unit.
PermeabilityUnits henriesPerMeter = Permeability.henriesPerMeter;

/// Newtons per ampere as a unit.
PermeabilityUnits newtonsPerAmpereSquared = Permeability.newtonsPerAmpereSquared;

// Constants.

/// The magnetic permeability in a classical vacuum.
const Permeability vacuumMagneticPermeability =
    const Permeability.constant(const Double.constant(1.25663706212e-6), uncert: 1.511971958549925e-10);
