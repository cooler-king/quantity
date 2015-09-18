part of quantity_ext;

/// International Atomic Time Scale
TimeInstantUnits TAI = TimeInstant.TAI;

/// Coordinated Universal Time (differs from TAI by a number of leap seconds)
TimeInstantUnits UTC = TimeInstant.UTC;

/// Number of milliseconds since 1 Jan 1970 0h 0m 0s, which is the System
/// time defined by the Java VM */
TimeInstantUnits SYSTEM_JAVA = TimeInstant.SYSTEM_JAVA;

/// Terrestrial Dynamical Time (TDT):  TDT = TAI + 32.184 s
TimeInstantUnits TDT = new TimeInstantUnits("Terrestrial Dynamical Time", "TT", "TDT", null, 1.0, -32.184, false);

/// Terrestrial Time (TT) is the same as TDT:  TDT = TT = TAI + 32.184 s
TimeInstantUnits TT = TDT;

/// Ephemeris Time (ET) is the same as TDT:  ET = TDT = TT = TAI + 32.184 s.
/// Ephemeris Time was renamed Terrestrial Dynamical Time in 1984 (when
/// Barycentric Dynamical Time was also introduced)
TimeInstantUnits ET = TDT;

/// GPS Satellite Time (GPST):  GPST = TAI - 19 s
TimeInstantUnits GPST = new TimeInstantUnits("GPS Satellite Time", null, "GPST", null, 1.0, 19.0, false);

//__________________________________________________________________________________________________________

/// Geocentric Coordinate Time (TCG): TCG = TDT + (6.969291e-10)(JD - 2443144.5)(86400)
class GeocentricCoordinateTime extends TimeInstantUnits {
  GeocentricCoordinateTime()
      : super("Geocentric Coordinate Time", null, "TCG", null, 1.0, 0.0, false, (val) {
          // TCG = TAI + 32.184 + (6.969291e-10)(JD - 2443144.5)(86400)... where the Julian Date is in the TAI scale
          double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
          return new Double(d + 32.184 + (6.969291e-10 * (d - 599616000.0)));
        }, (val) {
          // TAI = TCG - 32.184 - (6.969291e-10)(JD - 2443144.5)(86400)... where the Julian Date is in the TAI scale
          double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
          double taiApprox = d - 32.184 - (6.969291e-10 * (d - 599616000.0)); // get closer to the actual JD TAI (s)
          return d - 32.184 - (6.969291e-10 * (taiApprox - 599616000.0));
        });
}

//__________________________________________________________________________________________________________

/// Barycentric Dynamical Time (TDB):  TDB varies from TDT by periodic variations
TimeInstantUnits TDB =
    new TimeInstantUnits("Barycentric Dynamical Time", null, "TDB", null, 1.0, -32.184, false, (val) {
  // TDB = TAI + 32.184 + 0.001658sin(g) + 0.000014sin(2g)...
  // where g = 357.53 deg + 0.9856003(JD - 2451545.0) deg... (Julian dates are in the TAI time scale)
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double gRad = (357.53 + 0.9856003 * ((d / 86400.0) - 15341.0)) * (Math.PI / 180.0);
  return d + 32.184 + 0.001658 * Math.sin(gRad) + 0.000014 * Math.sin(2.0 * gRad);
}, (val) {
  // TAI = TDB - 32.184 - 0.001658sin(g) - 0.000014sin(2g)...
  // where g = 357.53 deg + 0.9856003(JD - 2451545.0) deg... (Julian dates are in the TAI time scale)

  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Too convoluted to solve analytically (because g is a function of
  // the Julian Date in the TAI scale... instead, get close and then search
  double taiTest = d;
  double step = 10.0;
  double epsilon = 1.0e-8;
  int maxCount = 10000;
  int count = 0;
  double tdbTest = fromMKS(d);
  double delta = tdbTest - taiTest;
  double prevDelta = Double.MAX_VALUE;
  while ((Math.abs(delta) > epsilon) && (count < maxCount)) {
    // See if we got farther away (if so reverse and take smaller steps)
    if (Math.abs(delta) > Math.abs(prevDelta)) step *= -0.5;

    // Step
    taiTest += step;

    prevDelta = delta;
    count++;

    // New value & delta
    tdbTest = fromMKS(taiTest);
    delta = tdbTest - d;
  }

  // taiTest now returns a tcb value within epsilon (or loop count ran out)
  return taiTest;
});

//__________________________________________________________________________________________________________

/// Barycentric Time (TB); same as TDB:  TT = TDB
TimeInstantUnits TB = TDB;

//__________________________________________________________________________________________________________

/// Barycentric Coordinate Time (TCB): TCB = TDB + (1.550505e-8)(JD - 2443144.5)(86400)
TimeInstantUnits TCB = new TimeInstantUnits(
    "Barycentric Coordinate Time", null, "TCB", null, (1.0 - 1.550505e-8), 599616000.0 - 32.184, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double tdb = TDB.fromMKS(d); // TDB seconds
  tdb += 1.550505e-8 * (d - 5.99616e8);
  return tdb;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Too convoluted to solve analytically... instead, get close and then search
  double taiTest = d;
  double step = 10.0;
  double epsilon = 1.0e-8;
  int maxCount = 10000;
  int count = 0;
  double tcbTest = fromMKS(d);
  double delta = tcbTest - taiTest;
  double prevDelta = Double.MAX_VALUE;
  while ((Math.abs(delta) > epsilon) && (count < maxCount)) {
    // See if we got farther away (if so reverse and take smaller steps)
    if (Math.abs(delta) > Math.abs(prevDelta)) step *= -0.5;

    // Step
    taiTest += step;

    prevDelta = delta;
    count++;

    // New value & delta
    tcbTest = fromMKS(taiTest);
    delta = tcbTest - d;
  }

  // taiTest now returns a tcb value within epsilon (or loop count ran out)
  return taiTest;
});

//__________________________________________________________________________________________________________

/// Universal Time (UT1): UT1 = TDT - Delta T
TimeInstantUnits UT1 = new TimeInstantUnits("Universal Time (UT1)", null, "UT1", null, 1.0, 0.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  return (TDT.fromMKS(d) - TimeInstant.getDeltaT(new TimeInstant(d, TAI)));
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Converge on a Delta T & TAI that work together
  int count = 0;
  double tai = d;
  double epsilon = 0.001;
  double deltaT = 0.0;
  double lastDeltaT = Double.MAX_VALUE;
  while ((Math.abs(deltaT - lastDeltaT) > epsilon) && count < 100) {
    lastDeltaT = deltaT;
    tai = d - 32.184 + deltaT;
    deltaT = TimeInstant.getDeltaT(new TimeInstant(tai, TAI));
    count++;
  }

  // Return seconds in TAI time scale...
  return tai;
});

//__________________________________________________________________________________________________________

/// Universal Time (UT2):
///  UT2 = UT1 + 0.022 sin(2PI*t) - 0.012 cos(2PI*t) - 0.006 sin(4PI*t) + 0.007 cos(4PI*t),
///  where t = the date in Besellian years
TimeInstantUnits UT2 = new TimeInstantUnits("Universal Time (UT2)", null, "UT2", null, 1.0, 0.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d = UT1.fromMKS(d); // UT1
  double twoPI = 2.0 * Math.PI;
  double fourPI = 2.0 * twoPI;
  double t = B.fromMKS(UT1.toMKS(d));
  return (d +
      (0.022 * Math.sin(twoPI * t) -
          0.012 * Math.cos(twoPI * t) -
          0.006 * Math.sin(fourPI * t) +
          0.007 * Math.cos(fourPI * t)));
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double twoPI = 2.0 * Math.PI;
  double fourPI = 2.0 * twoPI;
  double t = B.fromMKS(UT1.toMKS(d)); // besselian -- use UT2 value as UT1... close enough
  d -= (0.022 * Math.sin(twoPI * t) -
      0.012 * Math.cos(twoPI * t) -
      0.006 * Math.sin(fourPI * t) +
      0.007 * Math.cos(fourPI * t)); // UT1

  return UT1.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Julian Date in the TAI scale
TimeInstantUnits JD_TAI = new TimeInstantUnits("Julian Date (TAI)", null, "JD(TAI)", null, 86400.0, -2436204.5, false);

//__________________________________________________________________________________________________________

/// Modified Julian Date in the TAI scale
TimeInstantUnits MJD_TAI =
    new TimeInstantUnits("Modified Julian Date (TAI)", null, "MJD(TAI)", null, 86400.0, -36204.0, false);

//__________________________________________________________________________________________________________

/// Julian Date in the UTC scale
TimeInstantUnits JD_UTC =
    new TimeInstantUnits("Julian Date (UTC)", null, "JD(UTC)", null, 86400.0, -2436204.5, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d = UTC.fromMKS(d); // UTC seconds
  double jd0 = (double)((int)(d / 86400.0)); // integer UTC days

  // Fractional UTC days taking into account any leap seconds
  // for the particular UTC day in question
  double frac = (d - (jd0 * 86400.0)) / TimeInstant.secondsInUTCDay(d);

  return 2436204.5 + jd0 + frac;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Adjust origin to TAI/UTC origin
  d -= 2436204.5;

  // Convert to seconds UTC
  double jd0 = d.toInt().toDouble();
  d = (jd0 * 86400.0) + ((d - jd0) * TimeInstant.secondsInUTCDay(d * 86400.0));

  return UTC.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Modified Julian Date in the UTC scale
TimeInstantUnits MJD_UTC =
    new TimeInstantUnits("Modified Julian Date (UTC)", null, "MJD(UTC)", null, 86400.0, -36204.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_UTC.fromMKS(d);
  return jd - 2400000.5;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d += 2400000.5; // convert MJD(UTC) to JD(UTC)
  return JD_UTC.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Julian Date in the UT1 scale
TimeInstantUnits JD_UT1 =
    new TimeInstantUnits("Julian Date (UT1)", null, "JD(UT1)", null, 86400.0, -2436204.5, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Find average seconds in day for the year in question
  double deltaT0 = TimeInstant.getDeltaT(new TimeInstant(d - 1.57788e7, TAI));
  double deltaT1 = TimeInstant.getDeltaT(new TimeInstant(d + 1.57788e7, TAI));
  double deltaDelta = deltaT1 - deltaT0;
  double secsInDay = 86400.0 + deltaDelta / 365.0;

  // Leap year?
  GregorianCalendar cal = new GregorianCalendar();
  cal.setTime((new TimeInstant(d, TAI)).getNearestDate());
  if (cal.isLeapYear(cal.get(Calendar.YEAR))) secsInDay = 86400.0 + deltaDelta / 366.0;

  d = UT1.fromMKS(d); // UTC seconds
  double jd0 = (double)((int)(d / 86400.0)); // integer UTC days

  // Fractional UT1 days
  // for the particular UTC day in question
  double frac = (d - (jd0 * 86400.0)) / secsInDay;

  return 2436204.5 + jd0 + frac;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Adjust origin to TAI/UT1 origin
  d -= 2436204.5;

  // Get approximate UT1 (not adjusted for length of day/JD fraction)
  double approxUT1 = d * 86400.0;

  // Find average seconds in day for the year in question
  double deltaT0 = TimeInstant.getDeltaT(new TimeInstant(approxUT1 - 1.57788e7, UT1));
  double deltaT1 = TimeInstant.getDeltaT(new TimeInstant(approxUT1 + 1.57788e7, UT1));
  double deltaDelta = deltaT1 - deltaT0;
  double secsInDay = 86400.0 + deltaDelta / 365.0;

  // Leap year?
  GregorianCalendar cal = new GregorianCalendar();
  cal.setTime((new TimeInstant(approxUT1, UT1)).getNearestDate());
  if (cal.isLeapYear(cal.get(Calendar.YEAR))) secsInDay = 86400.0 + deltaDelta / 366.0;

  // Convert to seconds UT1
  double jd0 = d.toInt().toDouble();
  d = (jd0 * 86400.0) + ((d - jd0) * secsInDay);
  return UT1.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Modified Julian Date in the UT1 scale
TimeInstantUnits MJD_UT1 =
    new TimeInstantUnits("Modified Julian Date (UT1)", null, "MJD(UT1)", null, 86400.0, -36204.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_UT1.fromMKS(d);
  return jd - 2400000.5;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d += 2400000.5; // convert MJD(UTC) to JD(UTC)
  return JD_UT1.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Julian Date in the TDT (TT) scale
TimeInstantUnits JD_TDT =
    new TimeInstantUnits("Julian Date (TDT)", null, "JD(TDT)", null, 86400.0, -2436204.5, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  return ((TDT.fromMKS(d) / 86400.0) + 2436204.5);
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;

  // Adjust origin to TAI/UT1 origin
  d -= 2436204.5;

  return TDT.toMKS(d * 86400.0);
});

//__________________________________________________________________________________________________________

/// Modified Julian Date in the TDT scale
TimeInstantUnits MJD_TDT =
    new TimeInstantUnits("Modified Julian Date (TDT)", null, "MJD(TDT)", null, 86400.0, -36204.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_TDT.fromMKS(d);
  return jd - 2400000.5;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d += 2400000.5; // convert MJD(TDT) to JD(TDT)
  return JD_TDT.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Julian Date in the TDB (TB) scale
TimeInstantUnits JD_TDB =
    new TimeInstantUnits("Julian Date (TDB)", null, "JD(TDB)", null, 86400.0, -2436204.5, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  return ((TDB.fromMKS(d) / 86400.0) + 2436204.5);
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d -= 2436204.5;
  return TDB.toMKS(d * 86400.0);
});

//__________________________________________________________________________________________________________

/// Modified Julian Date in the TDB scale
TimeInstantUnits MJD_TDB =
    new TimeInstantUnits("Modified Julian Date (TDT)", null, "MJD(TDT)", null, 86400.0, -36204.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_TDB.fromMKS(d);
  return jd - 2400000.5;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d += 2400000.5; // convert MJD(TDB) to JD(TDB)
  return JD_TDB.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Julian Date in the TCG scale
TimeInstantUnits JD_TCG =
    new TimeInstantUnits("Julian Date (TCG)", null, "JD(TCG)", null, 86400.0, -2436204.5, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  return ((TCG.fromMKS(d) / 86400.0) + 2436204.5);
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d -= 2436204.5;
  return TCG.toMKS(d * 86400.0);
});

//__________________________________________________________________________________________________________

/// Modified Julian Date in the TCG scale
TimeInstantUnits MJD_TCG =
    new TimeInstantUnits("Modified Julian Date (TCG)", null, "MJD(TCG)", null, 86400.0, -36204.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_TCG.fromMKS(d);
  return jd - 2400000.5;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d += 2400000.5; // convert MJD(TCG) to JD(TCG)
  return JD_TCG.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Julian Date in the TCB scale
TimeInstantUnits JD_TCB =
    new TimeInstantUnits("Julian Date (TCB)", null, "JD(TCB)", null, 86400.0, -2436204.5, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  return ((TCB.fromMKS(d) / 86400.0) + 2436204.5);
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d -= 2436204.5;
  return TCB.toMKS(d * 86400.0);
});

//__________________________________________________________________________________________________________

/// Modified Julian Date in the TCB scale
TimeInstantUnits MJD_TCB =
    new TimeInstantUnits("Modified Julian Date (TCB)", null, "MJD(TCB)", null, 86400.0, -36204.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_TCB.fromMKS(d);
  return jd - 2400000.5;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d += 2400000.5; // convert MJD(TCB) to JD(TCB)
  return JD_TCB.toMKS(d);
});

//__________________________________________________________________________________________________________

/// Besselian - Replaced by Julian system, but still of occasional use
TimeInstantUnits B = new TimeInstantUnits("Bessellian", null, "B", null, 1.0, 0.0, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = JD_TAI.fromMKS(d);
  return 1900.0 + ((jd - 2415020.31352) / 365.242198781);
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  double jd = ((d - 1900.0) * 365.242198781) + 2415020.31352;
  return JD_TAI.toMKS(jd);
});

//__________________________________________________________________________________________________________

/// Network Time Protocol (NTP) - NTP is offset from the UTC time scale, with its epoch at 1 Jan 1900 0h
TimeInstantUnits NTP =
    new TimeInstantUnits("Network Time Protocol", null, "NTP", null, 1.0, -1.8302976e9, false, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d = UTC.fromMKS(d);
  d += 1.8302976e9;
  return d;
}, (val) {
  double d = val is num ? val.toDouble() : val is Number ? val.toDouble() : 0.0;
  d -= 1.8302976e9;
  return UTC.toMKS(d);
});

//__________________________________________________________________________________________________________

//===========================================================================
//============================== CONSTANTS ==================================
//===========================================================================

/// J2000.0 as defined by the IAU: Julian date: 2000 Jan 1d 12h UT in the TDT time scale
const TimeInstant J2000 = const TimeInstant.constant(const Double(2451545.0), JD_TDT);
