part of quantity_ext;

/// The standard SI unit.
final EnergyUnits joules = Energy.joules;

/// Accepted for use with the SI.
final EnergyUnits electronVolts = Energy.electronVolts;

final EnergyUnits btuInternationalTable = new EnergyUnits('Btu (IT)', null, null, null, 1.055056e3, false);

final EnergyUnits btuThermo = new EnergyUnits('Btu (thermochemical)', null, null, null, 1.054350e3, false);

final EnergyUnits btuMean = new EnergyUnits('Btu (mean)', null, null, null, 1.05587e3, false);

final EnergyUnits btu39 = new EnergyUnits('Btu (39 deg F)', null, null, null, 1.05967e3, false);

final EnergyUnits btu60 = new EnergyUnits('Btu (60 deg F)', null, null, null, 1.05468e3, false);

final EnergyUnits caloriesInternationalTable =
    new EnergyUnits('calories (IT)', null, null, 'calorie (IT)', 4.1868, false);

final EnergyUnits caloriesMean = new EnergyUnits('calories (mean)', null, null, 'calorie (mean)', 4.19002, false);

final EnergyUnits caloriesThermo =
    new EnergyUnits('calories (thermochemical)', null, null, 'calorie (thermochemical)', 4.184, false);

final EnergyUnits calories15 = new EnergyUnits('calories (15 deg C)', null, null, 'calorie (15 deg C)', 4.18580, false);

final EnergyUnits calories20 = new EnergyUnits('calories (20 deg C)', null, null, 'calorie (20 deg C)', 4.18190, false);

final EnergyUnits caloriesKgInternationalTable =
    new EnergyUnits('calories (kg, IT)', null, null, 'calorie (kg, IT)', 4.1868e3, false);

final EnergyUnits caloriesKgMean =
    new EnergyUnits('calories (kg, mean)', null, null, 'calorie (kg, mean)', 4.19002e3, false);

final EnergyUnits caloriesKgThermo =
    new EnergyUnits('calories (kg, thermochemical)', null, null, 'calorie (kg, thermochemical)', 4.184e3, false);

final EnergyUnits ergs = new EnergyUnits('ergs', null, null, null, 1.0e-7, true);

final EnergyUnits footPoundsForce =
    new EnergyUnits('foot pounds force', null, 'ft lbf', 'foot pound force', 1.3558179, false);

final EnergyUnits footPoundals = new EnergyUnits('foot-poundals', null, null, null, 4.2140110e-2, false);

final EnergyUnits kilowattHours = new EnergyUnits.powerTime(Power.kilowatts, Time.hours);

final EnergyUnits therms = new EnergyUnits('therms', null, null, null, 1.0551e8, false);

final EnergyUnits tons = new EnergyUnits('tons (equivalent TNT)', null, null, 'ton (equivalent TNT)', 4.184e9, false);

final EnergyUnits wattHour = new EnergyUnits.powerTime(Power.watts, Time.hours);

final EnergyUnits wattSecond = new EnergyUnits.powerTime(Power.watts, Time.seconds);

// convenience units
final EnergyUnits kilojoules = joules.kilo() as EnergyUnits;
final EnergyUnits kilocaloriesThermo = caloriesKgThermo;

// constants
const Energy hartreeEnergy =
    const Energy.constant(const Double.constant(4.359744650e-18), uncert: 1.238604650848072e-8);
