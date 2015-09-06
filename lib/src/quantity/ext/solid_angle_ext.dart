part of quantity_ext;

// Metric units
final SolidAngleUnits yottasteradians = SolidAngle.steradians.yotta();
final SolidAngleUnits zettasteradians = SolidAngle.steradians.zetta();
final SolidAngleUnits exasteradians = SolidAngle.steradians.exa();
final SolidAngleUnits petasteradians = SolidAngle.steradians.peta();
final SolidAngleUnits terasteradians = SolidAngle.steradians.tera();
final SolidAngleUnits gigasteradians = SolidAngle.steradians.giga();
final SolidAngleUnits megasteradians = SolidAngle.steradians.mega();
final SolidAngleUnits kilosteradians = SolidAngle.steradians.kilo();
final SolidAngleUnits hectosteradians = SolidAngle.steradians.hecto();
final SolidAngleUnits dekasteradians = SolidAngle.steradians.deka();
final SolidAngleUnits steradians = SolidAngle.steradians;
final SolidAngleUnits decisteradians = SolidAngle.steradians.deci();
final SolidAngleUnits centisteradians = SolidAngle.steradians.centi();
final SolidAngleUnits millisteradians = SolidAngle.steradians.milli();
final SolidAngleUnits microsteradians = SolidAngle.steradians.micro();
final SolidAngleUnits nanosteradians = SolidAngle.steradians.nano();
final SolidAngleUnits picosteradians = SolidAngle.steradians.pico();
final SolidAngleUnits femtosteradians = SolidAngle.steradians.femto();
final SolidAngleUnits attosteradians = SolidAngle.steradians.atto();
final SolidAngleUnits zeptosteradians = SolidAngle.steradians.zepto();
final SolidAngleUnits yoctosteradians = SolidAngle.steradians.yocto();

// non-SI units

final SolidAngleUnits spats = new SolidAngleUnits("spats", "sp", null, null, 12.566371, false);

final SolidAngleUnits spheres = new SolidAngleUnits("spheres", null, null, null, 4.0 * Math.PI, false);

final SolidAngleUnits hemispheres = new SolidAngleUnits("hemispheres", null, null, null, 2.0 * Math.PI, false);

/** 1/8th of a sphere or a spherical right triangle **/
final SolidAngleUnits octants = new SolidAngleUnits("octants", null, null, null, Math.PI / 2.0, false);

/** same as OCTANTS **/
final SolidAngleUnits sphericalRightTriangles = OCTANTS;

final SolidAngleUnits squareDegrees = new SolidAngleUnits(ANGLE.DEGREES);

final SolidAngleUnits squareArcMinutes = new SolidAngleUnits(ANGLE.MINUTES_ARC);

final SolidAngleUnits squareArcSeconds = new SolidAngleUnits(ANGLE.SECONDS_ARC);
