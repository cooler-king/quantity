part of quantity_ext;

// Metric units

/// A unit of 10^24 meters.
final LengthUnits yottameters = Length.meters.yotta() as LengthUnits;

/// A unit of 10^21 meters.
final LengthUnits zettameters = Length.meters.zetta() as LengthUnits;

/// A unit of 10^18 meters.
final LengthUnits exameters = Length.meters.exa() as LengthUnits;

/// A unit of 10^15 meters.
final LengthUnits petameters = Length.meters.peta() as LengthUnits;

/// A unit of 10^12 meters.
final LengthUnits terameters = Length.meters.tera() as LengthUnits;

/// A unit of one billion meters.
final LengthUnits gigameters = Length.meters.giga() as LengthUnits;

/// A unit of one million meters.
final LengthUnits megameters = Length.meters.mega() as LengthUnits;

/// A unit of one thousand meters.
final LengthUnits kilometers = Length.meters.kilo() as LengthUnits;

/// A unit of one hundred meters.
final LengthUnits hectometers = Length.meters.hecto() as LengthUnits;

/// A unit of ten meters.
final LengthUnits dekameters = Length.meters.deka() as LengthUnits;

/// A synonym for the SI-MSH base unit of length.
final LengthUnits meters = Length.meters;

/// A unit of one tenth of a meter.
final LengthUnits decimeters = Length.meters.deci() as LengthUnits;

/// A unit of one hundredth of a meter.
final LengthUnits centimeters = Length.meters.centi() as LengthUnits;

/// A unit of one thousandth of a meter.
final LengthUnits millimeters = Length.millimeters;

/// A unit of one millionth of a meter.
final LengthUnits micrometers = Length.meters.micro() as LengthUnits;

/// A unit of one billionth of a meter.
final LengthUnits nanometers = Length.nanometers;

/// A unit of 10^-12 meters.
final LengthUnits picometers = Length.meters.pico() as LengthUnits;

/// A unit of 10^-15 meters.
final LengthUnits femtometers = Length.meters.femto() as LengthUnits;

/// A unit of 10^-18 meters.
final LengthUnits attometers = Length.meters.atto() as LengthUnits;

/// A unit of 10^-21 meters.
final LengthUnits zeptometers = Length.meters.zepto() as LengthUnits;

/// A unit of 10^-24 meters.
final LengthUnits yoctometers = Length.meters.yocto() as LengthUnits;

final LengthUnits astronomicalUnits = Length.astronomicalUnits;
final LengthUnits fermis = new LengthUnits('fermis', null, null, null, 1.0e-15, true);
final LengthUnits cables = new LengthUnits('cables', null, null, null, 2.19456e2, false);
final LengthUnits calibers = new LengthUnits('calibers', null, null, null, 2.54e-4, false);
final LengthUnits chainsSurveyor =
    new LengthUnits('chains (surveyor)', null, null, 'chain (surveyor)', 2.01168e1, false);
final LengthUnits chainsEngineer = new LengthUnits('chains (engineer)', null, null, 'chain (engineer)', 3.048e1, false);
final LengthUnits cubits = new LengthUnits('cubits', null, null, null, 5.472e-1, false);
final LengthUnits fathoms = new LengthUnits('fathoms', null, null, null, 1.8288, false);
final LengthUnits feet = new LengthUnits('feet', "'", 'ft', 'foot', 3.048e-1, false);
final LengthUnits feetUsSurvey =
    new LengthUnits('feet (US survey)', 'ft (US)', null, 'foot (US survey)', 3.048006096e-1, false);
final LengthUnits furlongs = new LengthUnits('furlongs', null, null, null, 2.01168e2, false);
final LengthUnits hands = new LengthUnits('hands', null, null, null, 1.016e-1, false);
final LengthUnits inches = new LengthUnits('inches', '\'', 'in', 'inch', 2.54e-2, false);
final LengthUnits leaguesUkNautical =
    new LengthUnits('leagues (UK nautical)', null, null, 'league (UK nautical)', 5.559552e3, false);
final LengthUnits leaguesNautical =
    new LengthUnits('leagues (nautical)', null, null, 'league (nautical)', 5.556e3, false);
final LengthUnits leaguesStatute =
    new LengthUnits('leagues (statute)', null, null, 'league (statute)', 4.828032e3, false);

/// The distance light travels in one year.
final LengthUnits lightYears = new LengthUnits('light years', 'LY', null, null, 9.46055e15, false);
final LengthUnits linksEngineer = new LengthUnits('links (engineer)', null, null, 'link (engineer)', 3.048e-1, false);
final LengthUnits linksSurveyor = new LengthUnits('links (surveyor)', null, null, 'link (surveyor)', 2.01168e-1, false);

/// A synonym for micrometers.
final LengthUnits microns = Length.meters.micro() as LengthUnits;
final LengthUnits mils = new LengthUnits('mils', null, null, null, 2.54e-5, false);
final LengthUnits miles = new LengthUnits('miles', 'mi', null, null, 1.609344e3, false);
final LengthUnits nauticalMilesUk =
    new LengthUnits('nautical miles (UK)', 'NM (UK)', null, 'nautical mile (UK)', 1.853184e3, false);
final LengthUnits paces = new LengthUnits('paces', null, null, null, 7.62e-1, false);
final LengthUnits parsecs = new LengthUnits('parsecs', 'pc', null, null, 3.0857e16, false);
final LengthUnits perches = new LengthUnits('perches', null, null, 'perch', 5.0292, false);
final LengthUnits picas = new LengthUnits('picas', null, null, null, 4.2175176e-3, false);
final LengthUnits points = new LengthUnits('points', null, null, null, 3.514598e-4, false);
final LengthUnits poles = new LengthUnits('poles', null, null, null, 5.0292, false);
final LengthUnits rods = new LengthUnits('rods', null, null, null, 5.0292, false);
final LengthUnits skeins = new LengthUnits('skeins', null, null, null, 1.09728e2, false);
final LengthUnits spans = new LengthUnits('spans', null, null, null, 2.286e-1, false);
final LengthUnits yards = new LengthUnits('yards', 'yd', null, null, 9.144e-1, false);
final LengthUnits xUnits = new LengthUnits('X units', 'Siegbahn', 'Xu', null, 1.00208e-13, false);
final LengthUnits angstromStars = new LengthUnits('Angstrom stars', 'A*', null, null, 1.00001495e-10, false);

// CONSTANTS

/// A constant representing zero length.
const Length lengthZero = const Length.constant(Double.zero);

/// The threshold length at which classical ideas about gravity and space-time cease to be valid,
/// and quantum effects dominate.
const Length planckLength = const Length.constant(const Double.constant(1.616229e-35), uncert: 2.3511519716574815e-5);

/// Often used to represent the wavelengths of X rays and the distances between atoms in crystals.
const Length angstromStar = const Length.constant(const Double.constant(1.00001495e-10), uncert: 8.999865452011492e-7);

const Length bohrRadius =
    const Length.constant(const Double.constant(0.52917721067e-10), uncert: 2.2676713505493936e-10);
const Length comptonWavelength =
    const Length.constant(const Double.constant(2.4263102367e-12), uncert: 4.533632935152179e-10);
const Length tauComptonWavelength =
    const Length.constant(const Double.constant(0.697787e-15), uncert: 9.02854309409605e-5);
const Length classicalElectronRadius =
    const Length.constant(const Double.constant(2.8179403227e-15), uncert: 6.742513262947746e-10);
