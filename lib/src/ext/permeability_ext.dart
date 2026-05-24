import '../number/double.dart';
import '../si/types/permeability.dart';

/// The standard SI unit.
PermeabilityUnits henriesPerMeter = Permeability.henriesPerMeter;

/// Newtons per ampere as a unit.
PermeabilityUnits newtonsPerAmpereSquared =
    Permeability.newtonsPerAmpereSquared;

// Constants.

/// The magnetic permeability in a classical vacuum.
const Permeability vacuumMagneticPermeability = Permeability.constant(
    Double.constant(0.00000125663706127),
    uncert: 1.59154943112909e-10);
