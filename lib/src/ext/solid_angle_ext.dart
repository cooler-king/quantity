part of quantity_ext;

// Metric units
final SolidAngleUnits yottasteradians = SolidAngle.steradians.yotta() as SolidAngleUnits;
final SolidAngleUnits zettasteradians = SolidAngle.steradians.zetta() as SolidAngleUnits;
final SolidAngleUnits exasteradians = SolidAngle.steradians.exa() as SolidAngleUnits;
final SolidAngleUnits petasteradians = SolidAngle.steradians.peta() as SolidAngleUnits;
final SolidAngleUnits terasteradians = SolidAngle.steradians.tera() as SolidAngleUnits;
final SolidAngleUnits gigasteradians = SolidAngle.steradians.giga() as SolidAngleUnits;
final SolidAngleUnits megasteradians = SolidAngle.steradians.mega() as SolidAngleUnits;
final SolidAngleUnits kilosteradians = SolidAngle.steradians.kilo() as SolidAngleUnits;
final SolidAngleUnits hectosteradians = SolidAngle.steradians.hecto() as SolidAngleUnits;
final SolidAngleUnits dekasteradians = SolidAngle.steradians.deka() as SolidAngleUnits;
final SolidAngleUnits steradians = SolidAngle.steradians;
final SolidAngleUnits decisteradians = SolidAngle.steradians.deci() as SolidAngleUnits;
final SolidAngleUnits centisteradians = SolidAngle.steradians.centi() as SolidAngleUnits;
final SolidAngleUnits millisteradians = SolidAngle.steradians.milli() as SolidAngleUnits;
final SolidAngleUnits microsteradians = SolidAngle.steradians.micro() as SolidAngleUnits;
final SolidAngleUnits nanosteradians = SolidAngle.steradians.nano() as SolidAngleUnits;
final SolidAngleUnits picosteradians = SolidAngle.steradians.pico() as SolidAngleUnits;
final SolidAngleUnits femtosteradians = SolidAngle.steradians.femto() as SolidAngleUnits;
final SolidAngleUnits attosteradians = SolidAngle.steradians.atto() as SolidAngleUnits;
final SolidAngleUnits zeptosteradians = SolidAngle.steradians.zepto() as SolidAngleUnits;
final SolidAngleUnits yoctosteradians = SolidAngle.steradians.yocto() as SolidAngleUnits;

// non-SI units

final SolidAngleUnits spats = new SolidAngleUnits('spats', 'sp', null, null, 12.566371, false);

final SolidAngleUnits spheres = new SolidAngleUnits('spheres', null, null, null, 4.0 * polyfill_math.pi, false);

final SolidAngleUnits hemispheres = new SolidAngleUnits('hemispheres', null, null, null, 2.0 * polyfill_math.pi, false);

/// 1/8th of a sphere (a spherical right triangle).
final SolidAngleUnits octants = new SolidAngleUnits('octants', null, null, null, polyfill_math.pi / 2.0, false);

/// Same as [octants].
final SolidAngleUnits sphericalRightTriangles = octants;

final SolidAngleUnits squareDegrees = new SolidAngleUnits.angleUnits(Angle.degrees);

final SolidAngleUnits squareArcMinutes = new SolidAngleUnits.angleUnits(minutesArc);

final SolidAngleUnits squareArcSeconds = new SolidAngleUnits.angleUnits(secondsArc);
