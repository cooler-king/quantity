part of quantity_ext;

MagneticFluxDensityUnits teslas = MagneticFluxDensity.teslas;

MagneticFluxDensityUnits gauss = new MagneticFluxDensityUnits('gauss', null, null, 'gauss', 1.0e-4, true);

MagneticFluxDensityUnits unitPolesDensity =
    new MagneticFluxDensityUnits('unit poles', null, null, null, 1.2566e-7, false);

MagneticFluxDensityUnits magFieldAtomicUnit =
    new MagneticFluxDensityUnits('magnetic field, atomic unit', null, null, null, 1.7153e3, false);

// Convenience Units
MagneticFluxDensityUnits magneticGammas = teslas.nano() as MagneticFluxDensityUnits;
