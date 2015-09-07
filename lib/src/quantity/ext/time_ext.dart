part of quantity_ext;

// Metric units
final TimeUnits yottaseconds = Time.seconds.yotta();
final TimeUnits zettaseconds = Time.seconds.zetta();
final TimeUnits exaseconds = Time.seconds.exa();
final TimeUnits petaseconds = Time.seconds.peta();
final TimeUnits teraseconds = Time.seconds.tera();
final TimeUnits gigaseconds = Time.seconds.giga();
final TimeUnits megaseconds = Time.seconds.mega();
final TimeUnits kiloseconds = Time.seconds.kilo();
final TimeUnits hectoseconds = Time.seconds.hecto();
final TimeUnits dekaseconds = Time.seconds.deka();
final TimeUnits seconds = Time.seconds;
final TimeUnits deciseconds = Time.seconds.deci();
final TimeUnits centiseconds = Time.seconds.centi();
final TimeUnits milliseconds = Time.milliseconds;
final TimeUnits microseconds = Time.microseconds;
final TimeUnits nanoseconds = Time.nanoseconds;
final TimeUnits picoseconds = Time.seconds.pico();
final TimeUnits femtoseconds = Time.seconds.femto();
final TimeUnits attoseconds = Time.seconds.atto();
final TimeUnits zeptoseconds = Time.seconds.zepto();
final TimeUnits yoctoseconds = Time.seconds.yocto();

/// Accepted for use with the SI.
final TimeUnits daysMeanSolar = Time.daysMeanSolar;

/// Accepted for use with the SI.
final TimeUnits hoursMeanSolar = Time.hoursMeanSolar;

/// Accepted for use with the SI.
final TimeUnits minutesMeanSolar = Time.minutesMeanSolar;

/// Accepted for use with the SI.
final TimeUnits minutes = minutesMeanSolar;

/// Accepted for use with the SI.
final TimeUnits hours = hoursMeanSolar;

/// Accepted for use with the SI.
final TimeUnits days = daysMeanSolar;

// non-SI units

final TimeUnits daysSidereal = new TimeUnits("days (sidereal)", null,
    "days (sid)", "day (sidereal)", 8.6164090e4, false);

final TimeUnits hoursSidereal = new TimeUnits("hours (sidereal)", null,
    "hr (sid)", "hour (sidereal)", 3.5901704e3, false);

final TimeUnits minutesSidereal = new TimeUnits("minutes (sidereal)", null,
    "min (sid)", "minute (sidereal)", 5.9836174e1, false);

final TimeUnits secondsSidereal = new TimeUnits("seconds (sidereal)", null,
    "s (sid)", "second (sidereal)", 9.9726957e-1, false);

final TimeUnits yearsCalendar =
    new TimeUnits("years", null, "yr", null, 3.1536e7, false);

final TimeUnits yearsSidereal = new TimeUnits("years (sidereal)", null,
    "yr (sid)", "year (sidereal)", 3.1558150e7, false);

final TimeUnits yearsTropical = new TimeUnits("years (tropical)", null,
    "yr (trop)", "year (tropical)", 3.1556926e7, false);

final TimeUnits yearsJulian = new TimeUnits(
    "years (Julian)", null, "yr (Jul)", "year (Julian)", 3.15576e7, false);

final TimeUnits aeons =
    new TimeUnits("aeons", null, "aeons", null, 3.1536e18, false);

final TimeUnits eons = aeons;

// Constants
final Time planckTime = new Time(s: 5.39106e-44, uncert: 6.0e-5);
