import '../number/double.dart';
import '../si/types/mass.dart';

// Useful metric units.

/// The standard SI unit.
final MassUnits kilograms = Mass.kilograms;

/// A unit of one gram.
final MassUnits grams = Mass.grams;

/// A unit of one thousandth of a gram.
final MassUnits milligrams = Mass.grams.milli() as MassUnits;

// Metric abbreviations.

/// Kilogram unit synonym.
final MassUnits kg = kilograms;

/// Gram unit synonym.
final MassUnits g = grams;

/// Milligram unit synonym.
final MassUnits mg = milligrams;

// Convenience units.

/// Microgram units.
final MassUnits gammas = Mass.grams.micro() as MassUnits;

/// Accepted for use with the SI.
final MassUnits metricTons = Mass.metricTons;

/// Accepted for use with the SI.
final MassUnits tonnes = metricTons;

/// Accepted for use with the SI.
final MassUnits unifiedAtomicMassUnits = Mass.unifiedAtomicMassUnits;

// Non-SI mass units.

/// Metric carats as a unit.
final MassUnits caratsMetric = MassUnits('carats (metric)', 'carats (metric)',
    'carats (metric)', 'carat (metric)', 2.0e-4, false);

/// Apothecary drams as a unit.
final MassUnits dramsApothecary = MassUnits('drams (apothecary)',
    'drams (apoth)', 'drams (apoth)', 'dram (apothecary)', 3.8879e-3, false);

/// Avoirdupois drams as a unit.
final MassUnits dramsAvoirdupois = MassUnits('drams (avoirdupois)',
    'drams (avoir)', 'drams (avoir)', 'dram (avoirdupois)', 1.7718e-3, false);

/// Grains as a unit.
final MassUnits grains =
    MassUnits('grains', 'grains', 'grains', 'grain', 6.4799e-5, false);

/// Long hundredweight as a unit.
final MassUnits hundredweightLong = MassUnits(
    'hundredweight (long)',
    'hundredweight (long)',
    'hundredweight (long)',
    'hundredweight (long)',
    50.802,
    false);

/// Short hundredweight as a unit.
final MassUnits hundredweightShort = MassUnits(
    'hundredweight (short)',
    'hundredweight (short)',
    'hundredweight (short)',
    'hundredweight (short)',
    45.359,
    false);

/// Avoirdupois ounces as a unit.
final MassUnits ouncesAvoirdupois = MassUnits(
    'ounces (avoirdupois)',
    'oz (avoirdupois)',
    'oz (avoirdupois)',
    'ounce (avoirdupois)',
    2.8350e-2,
    false);

/// Apothecary ounces as a unit.
final MassUnits ouncesApothecary = MassUnits(
    'ounces (apothecary)',
    'oz (apothecary)',
    'oz (apothecary)',
    'ounce (apothecary)',
    3.1103e-2,
    false);

/// Troy pennyweight as a unit.
final MassUnits pennyweightTroy = MassUnits(
    'pennyweight (troy)',
    'pennyweight (troy)',
    'pennyweight (troy)',
    'pennyweight (troy)',
    1.5552e-3,
    false);

/// Avoirdupois pounds as a unit.
final MassUnits poundsAvoirdupois = MassUnits(
    'pounds (avoirdupois)',
    'lbm (avoirdupois)',
    'lbm (avoirdupois)',
    'pound (avoirdupois)',
    0.45359,
    false);

/// Apothecary pounds as a unit.
final MassUnits poundsApothecary = MassUnits(
    'pounds (apothecary)',
    'lbs (apothecary)',
    'lbs (apothecary)',
    'pound (apothecary)',
    0.37324,
    false);

/// A quintal is 100 kilograms.
final MassUnits quintals =
    MassUnits('quintals', 'quintals', 'quintals', 'quintal', 100.0, true);

/// Scruples as a unit.
final MassUnits scruples =
    MassUnits('scruples', 'scruples', 'scruples', 'scruple', 1.2960e-3, false);

/// Slugs as a unit.
final MassUnits slugs =
    MassUnits('slugs', 'slugs', 'slugs', 'slug', 14.594, false);

/// Long tons as a unit.
final MassUnits tonsLong = MassUnits(
    'tons (long)', 'tons (long)', 'tons (long)', 'ton (long)', 1016.0, false);

/// Short tons as a unit.
final MassUnits tonsShort = MassUnits('tons (short)', 'tons (short)',
    'tons (short)', 'ton (short)', 907.18, false);

/// Assay tons as a unit.
final MassUnits tonsAssay = MassUnits('tons (assay)', 'tons (assay)',
    'tons (assay)', 'ton (assay)', 2.9166666e-2, false);

/// Kilogram force second square meter as a unit.
final MassUnits kgfSecondSquaredMeter = MassUnits(
    'kgf second squared meter',
    'kgf second squared meter',
    'kgf second squared meter',
    'kgf second squared meter',
    9.80665,
    false);

// Constants.

/// The unit of mass in the system of natural units known as Planck units. It is approximately 0.02 milligrams.
const Mass planckMass =
    Mass.constant(Double.constant(2.176434e-8), uncert: 0.00001102721240340851);

/// The rest mass of a helium nucleus.
const Mass alphaParticleMass = Mass.constant(Double.constant(6.6446573357e-27),
    uncert: 3.009937004959646e-10);

/// One twelfth of the mass of a carbon-12 atom in its nuclear and electronic ground state.
const Mass atomicMass = Mass.constant(Double.constant(1.66053906660e-27),
    uncert: 3.0110703810405613e-10);

/// The mass of a stationary electron.
const Mass electronMass = Mass.constant(Double.constant(9.1093837015e-31),
    uncert: 3.0737534961217373e-10);

/// The mass of a stationary proton.
const Mass protonMass = Mass.constant(Double.constant(1.67262192369e-27),
    uncert: 3.0491050773439597e-10);

/// The mass of a stationary neutron.
const Mass neutronMass = Mass.constant(Double.constant(1.67492749804e-27),
    uncert: 5.671887297281165e-10);

/// The mass of a stationary tau particle.
const Mass tauMass =
    Mass.constant(Double.constant(3.16754e-27), uncert: 0.00006629750531958555);

/// The mass of a stationary deuteron.
const Mass deuteronMass = Mass.constant(Double.constant(3.3435837724e-27),
    uncert: 2.9908028871733855e-10);

/// The mass of a stationary helion.
const Mass helionMass = Mass.constant(Double.constant(5.0064127796e-27),
    uncert: 2.996157260767951e-10);

/// The mass of a stationary muon particle.
const Mass muonMass = Mass.constant(Double.constant(1.883531627e-28),
    uncert: 2.2298537172373158e-8);
