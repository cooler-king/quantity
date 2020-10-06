import '../number/double.dart';
import '../si/types/length.dart';

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

/// The standard SI unit.
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

/// The mean distance from the center of the earth to the center of the sun.
final LengthUnits astronomicalUnits = Length.astronomicalUnits;

/// A non-standard unit of length.
final LengthUnits fermis = LengthUnits('fermis', null, null, null, 1.0e-15, true);

/// A non-standard unit of length.
final LengthUnits cables = LengthUnits('cables', null, null, null, 2.19456e2, false);

/// A non-standard unit of length.
final LengthUnits calibers = LengthUnits('calibers', null, null, null, 2.54e-4, false);

/// A non-standard unit of length.
final LengthUnits chainsSurveyor = LengthUnits('chains (surveyor)', null, null, 'chain (surveyor)', 2.01168e1, false);

/// A non-standard unit of length.
final LengthUnits chainsEngineer = LengthUnits('chains (engineer)', null, null, 'chain (engineer)', 3.048e1, false);

/// A non-standard unit of length.
final LengthUnits cubits = LengthUnits('cubits', null, null, null, 5.472e-1, false);

/// A non-standard unit of length.
final LengthUnits fathoms = LengthUnits('fathoms', null, null, null, 1.8288, false);

/// A non-standard unit of length.
final LengthUnits feet = LengthUnits('feet', "'", 'ft', 'foot', 3.048e-1, false);

/// A non-standard unit of length.
final LengthUnits feetUsSurvey =
    LengthUnits('feet (US survey)', 'ft (US)', null, 'foot (US survey)', 3.048006096e-1, false);

/// A non-standard unit of length.
final LengthUnits furlongs = LengthUnits('furlongs', null, null, null, 2.01168e2, false);

/// A non-standard unit of length.
final LengthUnits hands = LengthUnits('hands', null, null, null, 1.016e-1, false);

/// A non-standard unit of length.
final LengthUnits inches = LengthUnits('inches', '\'', 'in', 'inch', 2.54e-2, false);

/// A non-standard unit of length.
final LengthUnits leaguesUkNautical =
    LengthUnits('leagues (UK nautical)', null, null, 'league (UK nautical)', 5.559552e3, false);

/// A non-standard unit of length.
final LengthUnits leaguesNautical = LengthUnits('leagues (nautical)', null, null, 'league (nautical)', 5.556e3, false);

/// A non-standard unit of length.
final LengthUnits leaguesStatute = LengthUnits('leagues (statute)', null, null, 'league (statute)', 4.828032e3, false);

/// The distance light travels in one year.
final LengthUnits lightYears = LengthUnits('light years', 'LY', null, null, 9.46055e15, false);

/// A non-standard unit of length.
final LengthUnits linksEngineer = LengthUnits('links (engineer)', null, null, 'link (engineer)', 3.048e-1, false);

/// A non-standard unit of length.
final LengthUnits linksSurveyor = LengthUnits('links (surveyor)', null, null, 'link (surveyor)', 2.01168e-1, false);

/// A synonym for micrometers.
final LengthUnits microns = Length.meters.micro() as LengthUnits;

/// A non-standard unit of length.
final LengthUnits mils = LengthUnits('mils', null, null, null, 2.54e-5, false);

/// A non-standard unit of length.
final LengthUnits miles = LengthUnits('miles', 'mi', null, null, 1.609344e3, false);

/// A non-standard unit of length.
final LengthUnits nauticalMilesUk =
    LengthUnits('nautical miles (UK)', 'NM (UK)', null, 'nautical mile (UK)', 1.853184e3, false);

/// A non-standard unit of length.
final LengthUnits paces = LengthUnits('paces', null, null, null, 7.62e-1, false);

/// A non-standard unit of length.
final LengthUnits parsecs = LengthUnits('parsecs', 'pc', null, null, 3.0857e16, false);

/// A non-standard unit of length.
final LengthUnits perches = LengthUnits('perches', null, null, 'perch', 5.0292, false);

/// A non-standard unit of length.
final LengthUnits picas = LengthUnits('picas', null, null, null, 4.2175176e-3, false);

/// A non-standard unit of length.
final LengthUnits points = LengthUnits('points', null, null, null, 3.514598e-4, false);

/// A non-standard unit of length.
final LengthUnits poles = LengthUnits('poles', null, null, null, 5.0292, false);

/// A non-standard unit of length.
final LengthUnits rods = LengthUnits('rods', null, null, null, 5.0292, false);

/// A non-standard unit of length.
final LengthUnits skeins = LengthUnits('skeins', null, null, null, 1.09728e2, false);

/// A non-standard unit of length.
final LengthUnits spans = LengthUnits('spans', null, null, null, 2.286e-1, false);

/// A non-standard unit of length.
final LengthUnits yards = LengthUnits('yards', 'yd', null, null, 9.144e-1, false);

/// A non-standard unit of length.
final LengthUnits xUnits = LengthUnits('X units', 'Siegbahn', 'Xu', null, 1.00208e-13, false);

/// A non-standard unit of length.
final LengthUnits angstromStars = LengthUnits('Angstrom stars', 'A*', null, null, 1.00001495e-10, false);

// CONSTANTS.

/// A constant representing zero length.
const Length lengthZero = Length.constant(Double.zero);

/// The threshold length at which classical ideas about gravity and space-time cease to be valid
/// and quantum effects dominate.
const Length planckLength = Length.constant(Double.constant(1.616255e-35), uncert: 0.000011136856498510445);

/// Often used to represent the wavelengths of X rays and the distances between atoms in crystals.
const Length angstromStar = Length.constant(Double.constant(1.00001495e-10), uncert: 8.999865452011492e-7);

/// The mean radius of the orbit of an electron around the nucleus of a hydrogen atom at its ground state.
const Length bohrRadius = Length.constant(Double.constant(5.29177210903e-11), uncert: 1.511780899700616e-10);

/// The wavelength of a photon whose energy is the same as the mass energy equivalent of that particle.
const Length comptonWavelength = Length.constant(Double.constant(2.42631023867e-12), uncert: 3.0086836727035986e-10);

/// The tau Compton wavelength.
const Length tauComptonWavelength = Length.constant(Double.constant(6.97771e-16), uncert: 0.00006735734216526625);

/// The classical electron radius is a combination of fundamental physical quantities that define a length scale
/// for problems involving an electron interacting with electromagnetic radiation.
const Length classicalElectronRadius =
    Length.constant(Double.constant(2.8179403262e-15), uncert: 4.6132985426027577e-10);
