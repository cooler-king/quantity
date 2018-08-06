part of quantity_ext;

// Metric units
final TemperatureUnits kelvins = Temperature.kelvins;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_K = TemperatureInterval.kelvins;

final TemperatureUnits degreesCelsius = Temperature.degreesCelsius;

/// A ratio used in the conversion between metric temperature scales and Fahrenheit.
const double fiveNinths = 5.0 / 9.0;

// ignore:non_constant_identifier_names
final TemperatureUnits Fahrenheit = new TemperatureUnits(
    'degrees Fahrenheit', 'F', null, 'degree Fahrenheit', fiveNinths, false, 273.15 - (fiveNinths * 32.0));

// ignore:non_constant_identifier_names
final TemperatureUnits Rankine =
    new TemperatureUnits('degrees Rankine', 'deg R', null, 'degree Rankine', fiveNinths, false, 0.0);

final TemperatureIntervalUnits degreesFahrenheit =
    new TemperatureIntervalUnits('degrees Fahrenheit', 'deg F', null, 'degree Fahrenheit', fiveNinths, false, 0.0);

/// A synonym for [degreesFahrenheit].
final TemperatureIntervalUnits degF = degreesFahrenheit;

final TemperatureIntervalUnits degreesRankine =
    new TemperatureIntervalUnits('degrees Rankine', 'deg R', null, 'degree Rankine', fiveNinths, false, 0.0);

/// A synonym for [degreesRankine].
final TemperatureIntervalUnits degR = degreesRankine;

// Constants

/// Contemporary models of physical cosmology postulate that the highest possible temperature is the Planck temperature.
const Temperature planckTemperature =
    const Temperature.constant(const Double.constant(1.416808e32), uncert: 2.329179394808612e-5);
