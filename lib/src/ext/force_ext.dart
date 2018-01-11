part of quantity_ext;

final ForceUnits newtons = Force.newtons;

ForceUnits dynes = new ForceUnits('dynes', null, null, null, 1.0e-5, true);

ForceUnits kilogramsForce = new ForceUnits('kilograms force', 'kgf', null, 'kilogram force', 9.80665, false);

ForceUnits kips = new ForceUnits('kips', null, null, null, 4.4482216152605e3, false);

ForceUnits poundsForceAvoirdupois =
    new ForceUnits('pounds force (avoirdupois)', 'lbf', null, 'pound force (avoirdupois)', 4.4482216152605, false);

ForceUnits ouncesForceAvoirdupois =
    new ForceUnits('ounces force (avoirdupois)', null, null, 'ounce force (avoirdupois)', 2.7801385e-1, false);

ForceUnits poundals = new ForceUnits('poundals', null, null, null, 1.38254954376e-1, false);

// Convenience
ForceUnits kiloponds = kilogramsForce;
