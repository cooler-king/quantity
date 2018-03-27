part of quantity_ext;

// Metric units
final TemperatureUnits yottakelvins = Temperature.kelvins.yotta() as TemperatureUnits;
final TemperatureUnits zettakelvins = Temperature.kelvins.zetta() as TemperatureUnits;
final TemperatureUnits exakelvins = Temperature.kelvins.exa() as TemperatureUnits;
final TemperatureUnits petakelvins = Temperature.kelvins.peta() as TemperatureUnits;
final TemperatureUnits terakelvins = Temperature.kelvins.tera() as TemperatureUnits;
final TemperatureUnits gigakelvins = Temperature.kelvins.giga() as TemperatureUnits;
final TemperatureUnits megakelvins = Temperature.kelvins.mega() as TemperatureUnits;
final TemperatureUnits kilokelvins = Temperature.kelvins.kilo() as TemperatureUnits;
final TemperatureUnits hectokelvins = Temperature.kelvins.hecto() as TemperatureUnits;
final TemperatureUnits dekakelvins = Temperature.kelvins.deka() as TemperatureUnits;
final TemperatureUnits kelvins = Temperature.kelvins;
final TemperatureUnits decikelvins = Temperature.kelvins.deci() as TemperatureUnits;
final TemperatureUnits centikelvins = Temperature.kelvins.centi() as TemperatureUnits;
final TemperatureUnits millikelvins = Temperature.kelvins.milli() as TemperatureUnits;
final TemperatureUnits microkelvins = Temperature.kelvins.micro() as TemperatureUnits;
final TemperatureUnits nanokelvins = Temperature.kelvins.nano() as TemperatureUnits;
final TemperatureUnits picokelvins = Temperature.kelvins.pico() as TemperatureUnits;
final TemperatureUnits femtokelvins = Temperature.kelvins.femto() as TemperatureUnits;
final TemperatureUnits attokelvins = Temperature.kelvins.atto() as TemperatureUnits;
final TemperatureUnits zeptokelvins = Temperature.kelvins.zepto() as TemperatureUnits;
final TemperatureUnits yoctokelvins = Temperature.kelvins.yocto() as TemperatureUnits;


// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_YK = TemperatureInterval.kelvins.yotta() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_ZK = TemperatureInterval.kelvins.zetta() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_EK = TemperatureInterval.kelvins.exa() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_PK = TemperatureInterval.kelvins.peta() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_TK = TemperatureInterval.kelvins.tera() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_GK = TemperatureInterval.kelvins.giga() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_MK = TemperatureInterval.kelvins.mega() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_kK = TemperatureInterval.kelvins.kilo() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_hK = TemperatureInterval.kelvins.hecto() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_daK = TemperatureInterval.kelvins.deka() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_K = TemperatureInterval.kelvins;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_dK = TemperatureInterval.kelvins.deci() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_cK = TemperatureInterval.kelvins.centi() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_mK = TemperatureInterval.kelvins.milli() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_uK = TemperatureInterval.kelvins.micro() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_nK = TemperatureInterval.kelvins.nano() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_pK = TemperatureInterval.kelvins.pico() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_fK = TemperatureInterval.kelvins.femto() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_aK = TemperatureInterval.kelvins.atto() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_zK = TemperatureInterval.kelvins.zepto() as TemperatureIntervalUnits;

// ignore:non_constant_identifier_names
final TemperatureIntervalUnits deg_yK = TemperatureInterval.kelvins.yocto() as TemperatureIntervalUnits;

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
