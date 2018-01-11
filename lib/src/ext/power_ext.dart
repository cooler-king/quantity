part of quantity_ext;

PowerUnits watts = Power.watts;

PowerUnits btuThermsPerHour = new PowerUnits.energyTime(btuThermo, hours);

PowerUnits btuThermsPerSecond = new PowerUnits.energyTime(btuThermo, seconds);

PowerUnits caloriesThermoPerSecond = new PowerUnits.energyTime(caloriesThermo, seconds);

PowerUnits ergsPerSecond = new PowerUnits.energyTime(ergs, seconds);

PowerUnits forceDeCheval = new PowerUnits('force de cheval', null, null, 'force de cheval', 735.5, false);

PowerUnits horsepower550 =
    new PowerUnits('horsepower (550 ft lbs/s)', null, null, 'horsepower (550 ft lbs/s)', 745.70, false);

PowerUnits horsepowerBoiler = new PowerUnits('horsepower (boiler)', null, null, 'horsepower (boiler)', 9809.5, false);

PowerUnits horsepowerElectric =
    new PowerUnits('horsepower (electric)', null, null, 'horsepower (electric)', 746.0, false);

PowerUnits horsepowerMetric = new PowerUnits('horsepower (metric)', null, null, 'horsepower (metric)', 735.5, false);

PowerUnits horsepowerWater = new PowerUnits('horsepower (water)', null, null, 'horsepower (water)', 746.04, false);

/// A power commonly used as the reference power for calculation of sound power _levels_.
PowerUnits referenceSound = new PowerUnits('reference (sound)', null, null, 'reference (sound)', 1.0e-12, false);

// convenience units
PowerUnits kilowatts = Power.kilowatts;

// constants
const Power solarLuminosity = const Power.constant(const Double.constant(3.846e26));
