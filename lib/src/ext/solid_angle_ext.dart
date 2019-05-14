part of quantity_ext;

// Useful metric units.

/// The standard SI unit.
final SolidAngleUnits steradians = SolidAngle.steradians;

final SolidAngleUnits millisteradians = SolidAngle.steradians.milli() as SolidAngleUnits;

// Non-SI units.

final SolidAngleUnits spats = new SolidAngleUnits('spats', 'sp', null, null, 12.566371, false);

final SolidAngleUnits spheres = new SolidAngleUnits('spheres', null, null, null, 4.0 * polyfill_math.pi, false);

final SolidAngleUnits hemispheres = new SolidAngleUnits('hemispheres', null, null, null, 2.0 * polyfill_math.pi, false);

/// One eighth (1/8) of a sphere (a spherical right triangle).
final SolidAngleUnits octants = new SolidAngleUnits('octants', null, null, null, polyfill_math.pi / 2.0, false);

/// Same as [octants].
final SolidAngleUnits sphericalRightTriangles = octants;

final SolidAngleUnits squareDegrees = new SolidAngleUnits.angleUnits(Angle.degrees);

final SolidAngleUnits squareArcMinutes = new SolidAngleUnits.angleUnits(minutesArc);

final SolidAngleUnits squareArcSeconds = new SolidAngleUnits.angleUnits(secondsArc);
