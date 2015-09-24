library astronomical;

/// A collection of units and constants commonly encountered in the field of
/// Astronomy and related sciences.

import 'package:quantity/quantity.dart';

export 'package:quantity/quantity.dart'
    show
        gees,
        yearsTropical,
        yearsSidereal,
        yearsJulian,
        astronomicalUnits,
        parsecs,
        lightYears,
        xUnits,
        solarLuminosity,
        janskys,
        Acceleration,
        AccelerationUnits,
        Frequency,
        EnergyFlux,
        Length,
        Mass,
        Power,
        SpectralIrradianceUnits,
        TimeUnits,
        LengthUnits;

export 'package:quantity/domain/thermodynamic.dart' show wienDisplacement;

SpectralIrradianceUnits microjanskys = janskys.micro();

// ---------------------

// Astronomical Constants

const Acceleration gravitySolarSurface = const Acceleration.constant(const Double.constant(274.0));

const Frequency hubbleConstant = const Frequency.constant(const Double.constant(2.4e-18), uncert: 0.3333333333);

/// The mean solar electromagnetic radiation (the solar irradiance) per unit area that would be incident on a
/// plane perpendicular to the rays, at a distance of one astronomical unit (AU) from the Sun.
///
/// The solar 'constant' is actually not constant.  It has been shown to vary historically in the past 400 years
/// over a range of less than 0.2 percent.
const EnergyFlux solarConstant = const EnergyFlux.constant(const Double.constant(1370.0));

const Length solarRadius = const Length.constant(const Double.constant(6.9599e8));
const Length earthRadiusEquatorial = const Length.constant(const Double.constant(6378.164));

const Mass solarMass = const Mass.constant(const Double.constant(1.989e30));
const Mass earthMass = const Mass.constant(const Double.constant(5.972e24));
