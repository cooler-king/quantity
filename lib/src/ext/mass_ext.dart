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
final MassUnits caratsMetric = new MassUnits('carats (metric)', null, null, 'carat (metric)', 2.0e-4, false);

/// Apothecary drams as a unit.
final MassUnits dramsApothecary =
    new MassUnits('drams (apothecary)', null, null, 'dram (apothecary)', 3.8879e-3, false);

/// Avoirdupois drams as a unit.
final MassUnits dramsAvoirdupois =
    new MassUnits('drams (avoirdupois)', null, null, 'dram (avoirdupois)', 1.7718e-3, false);

/// Grains as a unit.
final MassUnits grains = new MassUnits('grains', null, null, null, 6.4799e-5, false);

/// Long hundredweight as a unit.
final MassUnits hundredweightLong =
    new MassUnits('hundredweight (long)', null, null, 'hundredweight (long)', 50.802, false);

/// Short hundredweight as a unit.
final MassUnits hundredweightShort =
    new MassUnits('hundredweight (short)', null, null, 'hundredweight (short)', 45.359, false);

/// Avoirdupois ounces as a unit.
final MassUnits ouncesAvoirdupois =
    new MassUnits('ounces (avoirdupois)', 'oz (avoirdupois)', null, 'ounce (avoirdupois)', 2.8350e-2, false);

/// Apothecary ounces as a unit.
final MassUnits ouncesApothecary =
    new MassUnits('ounces (apothecary)', 'oz (apothecary)', null, 'ounce (apothecary)', 3.1103e-2, false);

/// Troy pennyweight as a unit.
final MassUnits pennyweightTroy =
    new MassUnits('pennyweight (troy)', null, null, 'pennyweight (troy)', 1.5552e-3, false);

/// Avoirdupois pounds as a unit.
final MassUnits poundsAvoirdupois =
    new MassUnits('pounds (avoirdupois)', 'lbm (avoirdupois)', null, 'pound (avoirdupois)', 0.45359, false);

/// Apothecary pounds as a unit.
final MassUnits poundsApothecary =
    new MassUnits('pounds (apothecary)', 'lbs (apothecary)', null, 'pound (apothecary)', 0.37324, false);

/// A quintal is 100 kilograms.
final MassUnits quintals = new MassUnits('quintals', null, null, null, 100.0, true);

/// Scruples as a unit.
final MassUnits scruples = new MassUnits('scruples', null, null, null, 1.2960e-3, false);

/// Slugs as a unit.
final MassUnits slugs = new MassUnits('slugs', null, null, null, 14.594, false);

/// Long tons as a unit.
final MassUnits tonsLong = new MassUnits('tons (long)', null, null, 'ton (long)', 1016.0, false);

/// Short tons as a unit.
final MassUnits tonsShort = new MassUnits('tons (short)', null, null, 'ton (short)', 907.18, false);

/// Assay tons as a unit.
final MassUnits tonsAssay = new MassUnits('tons (assay)', null, null, 'ton (assay)', 2.9166666e-2, false);

/// Kilogram force second square meter as a unit.
final MassUnits kgfSecondSquaredMeter = new MassUnits('kgf second squared meter', null, null, null, 9.80665, false);

// Constants.

/// The unit of mass in the system of natural units known as Planck units. It is approximately 0.02 milligrams.
const Mass planckMass = const Mass.constant(const Double.constant(2.176434e-8), uncert: 0.00001102721240340851);

/// The rest mass of a helium nucleus.
const Mass alphaParticleMass =
    const Mass.constant(const Double.constant(6.6446573357e-27), uncert: 3.009937004959646e-10);

/// One twelfth of the mass of a carbon-12 atom in its nuclear and electronic ground state.
const Mass atomicMass = const Mass.constant(const Double.constant(1.66053906660e-27), uncert: 3.0110703810405613e-10);

/// The mass of a stationary electron.
const Mass electronMass = const Mass.constant(const Double.constant(9.1093837015e-31), uncert: 3.0737534961217373e-10);

/// The mass of a stationary proton.
const Mass protonMass = const Mass.constant(const Double.constant(1.67262192369e-27), uncert: 3.0491050773439597e-10);

/// The mass of a stationary neutron.
const Mass neutronMass = const Mass.constant(const Double.constant(1.67492749804e-27), uncert: 5.671887297281165e-10);

/// The mass of a stationary tau particle.
const Mass tauMass = const Mass.constant(const Double.constant(3.16754e-27), uncert: 0.00006629750531958555);

/// The mass of a stationary deuteron.
const Mass deuteronMass = const Mass.constant(const Double.constant(3.3435837724e-27), uncert: 2.9908028871733855e-10);

/// The mass of a stationary helion.
const Mass helionMass = const Mass.constant(const Double.constant(5.0064127796e-27), uncert: 2.996157260767951e-10);

/// The mass of a stationary muon particle.
const Mass muonMass = const Mass.constant(const Double.constant(1.883531627e-28), uncert: 2.2298537172373158e-8);
