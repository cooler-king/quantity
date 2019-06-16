part of quantity_ext;

/// The standard SI unit.
KinematicViscosityUnits metersSquaredPerSecond = KinematicViscosity.metersSquaredPerSecond;

/// Stokes as a unit.
KinematicViscosityUnits stokes = new KinematicViscosityUnits('stokes', 'St', null, null, 1.0e-4, true);

/// Centistokes as a unit.
KinematicViscosityUnits centistokes = new KinematicViscosityUnits('centistokes', 'cSt', null, null, 1.0e-6, false);

/// Square feet per second as a unit.
KinematicViscosityUnits squareFeetPerSecond = new KinematicViscosityUnits.areaTime(squareFeet, seconds);
