library astronomical;

/// A collection of units and constants commonly encountered in the field of
/// Astronomy and related sciences.

//import 'quantity_ext.dart' show gees;

export 'package:quantity/quantity_ext.dart'
    show gees, yearsTropical, yearsSidereal, yearsJulian, astronomicalUnits, parsecs, lightYears, xUnits;

/// Acceleration units equal to gravity at the Earth's surface.
//final AccelerationUnits gees = Acceleration.gees; // gravity at Earth's surface

/*
// duration units
final DurationUnits yearsTropical = DURATION.YEARS_TROPICAL;
final DurationUnits YEARS_SIDEREAL = DURATION.YEARS_SIDEREAL;
final DurationUnits YEARS_JULIAN = DURATION.YEARS_JULIAN;

// flux density
final FluxDensity.FluxDensityUnits JANSKYS = FLUX_DENSITY.JANSKYS;
final FluxDensity.FluxDensityUnits MICROJANSKYS =
    (FluxDensity.FluxDensityUnits) FLUX_DENSITY.JANSKYS.micro();

// length units
final Length.LengthUnits ASTRONOMICAL_UNITS = LENGTH.ASTRONOMICAL_UNITS;
final Length.LengthUnits PARSECS = LENGTH.PARSECS;
final Length.LengthUnits LIGHT_YEARS = LENGTH.LIGHT_YEARS;
final Length.LengthUnits X_UNITS = LENGTH.X_UNITS;



// ---------------------

// Astronomical Constants

// acceleration constants
final Acceleration GRAVITY_SOLAR_SURFACE =
    new Acceleration(274.0,Acceleration.METER_PER_SECOND_SQUARED,0.0,true);

// Hubble constants
final Frequency HUBBLE_CONSTANT =
    new Frequency(2.4e-18,Frequency.HERTZ,0.3333333333,true);  // length per time per length = frequency

// irradiance
final Irradiance SOLAR_CONSTANT = new Irradiance(1370.0,
    Irradiance.WATT_PER_SQUARE_METER,0.0,true);

// length constants
final Length SOLAR_RADIUS = new Length(6.9599e8,Length.METERS,0.0,true);
final Length EARTH_RADIUS_EQUATORIAL = new Length(6378.164,Length.KILOMETERS,0.0,true);

// mass constants
final Mass SOLAR_MASS = new Mass(1.989e30,Mass.KILOGRAMS,0.0,true);
final Mass EARTH_MASS = new Mass(5.972e24,Mass.KILOGRAMS,0.0,true);

// radiant flux (power) constants
final RadiantFlux SOLAR_LUMINOSITY = POWER.SOLAR_LUMINOSITY;

final MiscQuantity WIEN_DISPLACEMENT = THERMODYNAMIC.WIEN_DISPLACEMENT;
*/
