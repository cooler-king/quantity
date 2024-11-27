import 'dart:math';
import '../si/types/angle.dart';
import '../si/types/solid_angle.dart';
import 'angle_ext.dart';

// Useful metric units.

/// The standard SI unit.
final SolidAngleUnits steradians = SolidAngle.steradians;

/// Millisteradians as a unit.
final SolidAngleUnits millisteradians =
    SolidAngle.steradians.milli() as SolidAngleUnits;

// Non-SI units.

/// Spats as a unit.
final SolidAngleUnits spats =
    SolidAngleUnits('spats', 'sp', 'sp', 'spat', 12.566371, false);

/// Spheres as a unit.
final SolidAngleUnits spheres =
    SolidAngleUnits('spheres', 'spheres', 'spheres', 'sphere', 4.0 * pi, false);

/// Hemispheres as a unit.
final SolidAngleUnits hemispheres = SolidAngleUnits(
    'hemispheres', 'hemispheres', 'hemispheres', 'hemisphere', 2.0 * pi, false);

/// One eighth (1/8) of a sphere (a spherical right triangle).
final SolidAngleUnits octants =
    SolidAngleUnits('octants', 'octants', 'octants', 'octant', pi / 2.0, false);

/// Same as [octants].
final SolidAngleUnits sphericalRightTriangles = octants;

/// Square degrees as a unit.
final SolidAngleUnits squareDegrees =
    SolidAngleUnits.angleSquared(Angle.degrees);

/// Square arc minutes as a unit.
final SolidAngleUnits squareArcMinutes =
    SolidAngleUnits.angleSquared(minutesArc);

/// Square arc seconds as a unit.
final SolidAngleUnits squareArcSeconds =
    SolidAngleUnits.angleSquared(secondsArc);
