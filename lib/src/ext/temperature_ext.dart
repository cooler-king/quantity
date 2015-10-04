part of quantity_ext;

// Metric units
final TemperatureUnits yottakelvins = Temperature.kelvins.yotta();
final TemperatureUnits zettakelvins = Temperature.kelvins.zetta();
final TemperatureUnits exakelvins = Temperature.kelvins.exa();
final TemperatureUnits petakelvins = Temperature.kelvins.peta();
final TemperatureUnits terakelvins = Temperature.kelvins.tera();
final TemperatureUnits gigakelvins = Temperature.kelvins.giga();
final TemperatureUnits megakelvins = Temperature.kelvins.mega();
final TemperatureUnits kilokelvins = Temperature.kelvins.kilo();
final TemperatureUnits hectokelvins = Temperature.kelvins.hecto();
final TemperatureUnits dekakelvins = Temperature.kelvins.deka();
final TemperatureUnits kelvins = Temperature.kelvins;
final TemperatureUnits decikelvins = Temperature.kelvins.deci();
final TemperatureUnits centikelvins = Temperature.kelvins.centi();
final TemperatureUnits millikelvins = Temperature.kelvins.milli();
final TemperatureUnits microkelvins = Temperature.kelvins.micro();
final TemperatureUnits nanokelvins = Temperature.kelvins.nano();
final TemperatureUnits picokelvins = Temperature.kelvins.pico();
final TemperatureUnits femtokelvins = Temperature.kelvins.femto();
final TemperatureUnits attokelvins = Temperature.kelvins.atto();
final TemperatureUnits zeptokelvins = Temperature.kelvins.zepto();
final TemperatureUnits yoctokelvins = Temperature.kelvins.yocto();

final TemperatureIntervalUnits deg_YK = TemperatureInterval.kelvins.yotta();
final TemperatureIntervalUnits deg_ZK = TemperatureInterval.kelvins.zetta();
final TemperatureIntervalUnits deg_EK = TemperatureInterval.kelvins.exa();
final TemperatureIntervalUnits deg_PK = TemperatureInterval.kelvins.peta();
final TemperatureIntervalUnits deg_TK = TemperatureInterval.kelvins.tera();
final TemperatureIntervalUnits deg_GK = TemperatureInterval.kelvins.giga();
final TemperatureIntervalUnits deg_MK = TemperatureInterval.kelvins.mega();
final TemperatureIntervalUnits deg_kK = TemperatureInterval.kelvins.kilo();
final TemperatureIntervalUnits deg_hK = TemperatureInterval.kelvins.hecto();
final TemperatureIntervalUnits deg_daK = TemperatureInterval.kelvins.deka();
final TemperatureIntervalUnits deg_K = TemperatureInterval.kelvins;
final TemperatureIntervalUnits deg_dK = TemperatureInterval.kelvins.deci();
final TemperatureIntervalUnits deg_cK = TemperatureInterval.kelvins.centi();
final TemperatureIntervalUnits deg_mK = TemperatureInterval.kelvins.milli();
final TemperatureIntervalUnits deg_uK = TemperatureInterval.kelvins.micro();
final TemperatureIntervalUnits deg_nK = TemperatureInterval.kelvins.nano();
final TemperatureIntervalUnits deg_pK = TemperatureInterval.kelvins.pico();
final TemperatureIntervalUnits deg_fK = TemperatureInterval.kelvins.femto();
final TemperatureIntervalUnits deg_aK = TemperatureInterval.kelvins.atto();
final TemperatureIntervalUnits deg_zK = TemperatureInterval.kelvins.zepto();
final TemperatureIntervalUnits deg_yK = TemperatureInterval.kelvins.yocto();

final TemperatureUnits degreesCelsius = Temperature.degreesCelsius;

const double fiveNinths = 5.0 / 9.0;

final TemperatureUnits Fahrenheit = new TemperatureUnits(
    "degrees Fahrenheit", "F", null, "degree Fahrenheit", fiveNinths, false, 273.15 - (fiveNinths * 32.0));

final TemperatureUnits Rankine =
    new TemperatureUnits("degrees Rankine", "deg R", null, "degree Rankine", fiveNinths, false, 0.0);

final TemperatureIntervalUnits degreesFahrenheit =
    new TemperatureIntervalUnits("degrees Fahrenheit", "deg F", null, "degree Fahrenheit", fiveNinths, false, 0.0);

final degF = degreesFahrenheit;

final TemperatureIntervalUnits degreesRankine =
    new TemperatureIntervalUnits("degrees Rankine", "deg R", null, "degree Rankine", fiveNinths, false, 0.0);

final degR = degreesRankine;

// Constants
const Temperature planckTemperature =
    const Temperature.constant(const Double.constant(1.416808e32), uncert: 2.329179394808612e-5);
