part of quantity_ext;

final ChargeUnits coulombs = Charge.coulombs;

final ChargeUnits ampereHours = new ChargeUnits.currentTime(Current.amperes, Time.hours);

final ChargeUnits faradaysC12 =
    new ChargeUnits("faradays (carbon 12)", null, null, "faraday (carbon 12)", 9.6486e4, false);

final ChargeUnits faradaysChemical =
    new ChargeUnits("faradays (chemical)", null, null, "faraday (chemical)", 9.64957e4, false);

final ChargeUnits faradaysPhysical =
    new ChargeUnits("faradays (physical)", null, null, "faraday (physical)", 9.65219e4, false);

final ChargeUnits statcoulombs = new ChargeUnits("statcoulombs", null, null, null, 3.335640e-10, false);

// convenience units
final ChargeUnits abcoulombs = coulombs.deka() as ChargeUnits;

// Constants
const Charge elementaryCharge =
    const Charge.constant(const Double.constant(1.6021766208e-19), uncert: 6.116678943365593e-9);
