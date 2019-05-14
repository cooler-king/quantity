part of quantity_ext;

/// The standard SI unit.
MagneticFluxUnits webers = MagneticFlux.webers;

MagneticFluxUnits maxwells = new MagneticFluxUnits('maxwells', null, null, null, 1.0e-8, true);

MagneticFluxUnits unitPoles = new MagneticFluxUnits('unit poles', null, null, null, 1.2566e-7, false);

// Constants
const MagneticFlux magneticFluxQuantum =
    const MagneticFlux.constant(const Double.constant(2.067833831e-15), uncert: 6.286772082509758e-9);
