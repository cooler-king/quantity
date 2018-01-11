part of quantity_ext;

final EntropyUnits joulesPerKelvin = Entropy.joulesPerKelvin;

/// Entropy as a 'charge'; identical to [joulesPerKelvin]
final EntropyUnits thermalcoulomb = joulesPerKelvin;

/// Boltzmann constant as a unit
final EntropyUnits boltzmannUnit = new EntropyUnits('Boltzmanns', 'kB', 'k', null, 1.3806503e-23, false);

final EntropyUnits clausius = new EntropyUnits('Clausius', null, 'Cl', null, 4.184, false);

final EntropyUnits ergPerKelvin = new EntropyUnits.energyTemperature(ergs, TemperatureInterval.kelvins);

// CONSTANTS

const Entropy boltzmannConstant =
    const Entropy.constant(const Double.constant(1.38064852e-23), uncert: 5.721948696979012e-7);
