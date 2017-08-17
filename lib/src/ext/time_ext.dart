part of quantity_ext;

// Metric units
final TimeUnits yottaseconds = Time.seconds.yotta() as TimeUnits;
final TimeUnits zettaseconds = Time.seconds.zetta() as TimeUnits;
final TimeUnits exaseconds = Time.seconds.exa() as TimeUnits;
final TimeUnits petaseconds = Time.seconds.peta() as TimeUnits;
final TimeUnits teraseconds = Time.seconds.tera() as TimeUnits;
final TimeUnits gigaseconds = Time.seconds.giga() as TimeUnits;
final TimeUnits megaseconds = Time.seconds.mega() as TimeUnits;
final TimeUnits kiloseconds = Time.seconds.kilo() as TimeUnits;
final TimeUnits hectoseconds = Time.seconds.hecto() as TimeUnits;
final TimeUnits dekaseconds = Time.seconds.deka() as TimeUnits;
final TimeUnits seconds = Time.seconds;
final TimeUnits deciseconds = Time.seconds.deci() as TimeUnits;
final TimeUnits centiseconds = Time.seconds.centi() as TimeUnits;
final TimeUnits milliseconds = Time.milliseconds;
final TimeUnits microseconds = Time.microseconds;
final TimeUnits nanoseconds = Time.nanoseconds;
final TimeUnits picoseconds = Time.seconds.pico() as TimeUnits;
final TimeUnits femtoseconds = Time.seconds.femto() as TimeUnits;
final TimeUnits attoseconds = Time.seconds.atto() as TimeUnits;
final TimeUnits zeptoseconds = Time.seconds.zepto() as TimeUnits;
final TimeUnits yoctoseconds = Time.seconds.yocto() as TimeUnits;

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

final TimeUnits daysSidereal =
    new TimeUnits("days (sidereal)", null, "days (sid)", "day (sidereal)", 8.6164090e4, false);

final TimeUnits hoursSidereal =
    new TimeUnits("hours (sidereal)", null, "hr (sid)", "hour (sidereal)", 3.5901704e3, false);

final TimeUnits minutesSidereal =
    new TimeUnits("minutes (sidereal)", null, "min (sid)", "minute (sidereal)", 5.9836174e1, false);

final TimeUnits secondsSidereal =
    new TimeUnits("seconds (sidereal)", null, "s (sid)", "second (sidereal)", 9.9726957e-1, false);

final TimeUnits yearsCalendar = new TimeUnits("years", null, "yr", null, 3.1536e7, false);

final TimeUnits yearsSidereal =
    new TimeUnits("years (sidereal)", null, "yr (sid)", "year (sidereal)", 3.1558150e7, false);

final TimeUnits yearsTropical =
    new TimeUnits("years (tropical)", null, "yr (trop)", "year (tropical)", 3.1556926e7, false);

final TimeUnits yearsJulian = new TimeUnits("years (Julian)", null, "yr (Jul)", "year (Julian)", 3.15576e7, false);

final TimeUnits aeons = new TimeUnits("aeons", null, "aeons", null, 3.1536e18, false);

final TimeUnits eons = aeons;

// Constants
const Time planckTime = const Time.constant(const Double.constant(5.39116e-44), uncert: 2.411354884663041e-5);
