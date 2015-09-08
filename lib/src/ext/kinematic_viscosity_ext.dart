part of quantity_ext;

KinematicViscosityUnits metersSquaredPerSecond = KinematicViscosity.metersSquaredPerSecond;

KinematicViscosityUnits stokes = new KinematicViscosityUnits("stokes", "St", null, null, 1.0e-4, true);

KinematicViscosityUnits centistokes = new KinematicViscosityUnits("centistokes", "cSt", null, null, 1.0e-6, false);

KinematicViscosityUnits squareFeetPerSecond = new KinematicViscosityUnits.areaTime(squareFeet, seconds);
