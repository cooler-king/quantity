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

final TemperatureUnits degreesCelsius = Temperature.degreesCelsius;

const double fiveNinths = 5.0 / 9.0;

final TemperatureUnits degreesFahrenheit =
    new TemperatureUnits("degrees Fahrenheit", "deg F", null, "degree Fahrenheit", fiveNinths, false, 459.67);

final TemperatureUnits degreesRankine =
    new TemperatureUnits("degrees Rankine", "deg R", null, "degree Rankine", fiveNinths, false, 0.0);

// Constants
const Temperature planckTemperature =
    const Temperature.constant(const Double.constant(1.416808e32), uncert: 2.329179394808612e-5);
