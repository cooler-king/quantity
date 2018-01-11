/// The core library containing the fundamental
/// quantity classes and types consistent with the
/// [International System of Units](http://physics.nist.gov/cuu/Units/introduction.html)
/// (SI, in the French acronym).
///
library quantity_si;

import 'dart:collection';
import 'dart:math' as math;
import 'package:quantity/number.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart' show NumberFormat;

part 'src/si/quantity.dart';
part 'src/si/units.dart';
part 'src/si/exponential_units.dart';
part 'src/si/dimensions.dart';
part 'src/si/misc_quantity.dart';
part 'src/si/number_format_si.dart';

part 'src/si/dimensions_exception.dart';
part 'src/si/quantity_exception.dart';
part 'src/si/immutable_quantity_exception.dart';

part 'src/si/types/absorbed_dose.dart';
part 'src/si/types/absorbed_dose_rate.dart';
part 'src/si/types/acceleration.dart';
part 'src/si/types/activity.dart';
part 'src/si/types/amount_of_substance.dart';
part 'src/si/types/angle.dart';
part 'src/si/types/angular_acceleration.dart';
part 'src/si/types/angular_momentum.dart';
part 'src/si/types/angular_speed.dart';
part 'src/si/types/area.dart';
part 'src/si/types/capacitance.dart';
part 'src/si/types/catalytic_activity.dart';
part 'src/si/types/charge.dart';
part 'src/si/types/charge_density.dart';
part 'src/si/types/concentration.dart';
part 'src/si/types/conductance.dart';
part 'src/si/types/current.dart';
part 'src/si/types/current_density.dart';
part 'src/si/types/currency.dart';
part 'src/si/types/dose_equivalent.dart';
part 'src/si/types/dynamic_viscosity.dart';
part 'src/si/types/electric_field_strength.dart';
part 'src/si/types/electric_flux_density.dart';
part 'src/si/types/electric_potential_difference.dart';
part 'src/si/types/energy.dart';
part 'src/si/types/energy_density.dart';
part 'src/si/types/energy_flux.dart';
part 'src/si/types/entropy.dart';
part 'src/si/types/exposure.dart';
part 'src/si/types/force.dart';
part 'src/si/types/frequency.dart';
part 'src/si/types/heat_flux_density.dart';
part 'src/si/types/illuminance.dart';
part 'src/si/types/inductance.dart';
part 'src/si/types/information.dart';
part 'src/si/types/information_rate.dart';
part 'src/si/types/kinematic_viscosity.dart';
part 'src/si/types/length.dart';
part 'src/si/types/level.dart';
part 'src/si/types/luminance.dart';
part 'src/si/types/luminous_flux.dart';
part 'src/si/types/luminous_intensity.dart';
part 'src/si/types/magnetic_field_strength.dart';
part 'src/si/types/magnetic_flux.dart';
part 'src/si/types/magnetic_flux_density.dart';
part 'src/si/types/mass.dart';
part 'src/si/types/mass_density.dart';
part 'src/si/types/mass_flow_rate.dart';
part 'src/si/types/mass_flux_density.dart';
part 'src/si/types/molar_energy.dart';
part 'src/si/types/molar_entropy.dart';
part 'src/si/types/permeability.dart';
part 'src/si/types/permittivity.dart';
part 'src/si/types/power.dart';
part 'src/si/types/pressure.dart';
part 'src/si/types/radiance.dart';
part 'src/si/types/radiant_intensity.dart';
part 'src/si/types/resistance.dart';
part 'src/si/types/scalar.dart';
part 'src/si/types/solid_angle.dart';
part 'src/si/types/specific_energy.dart';
part 'src/si/types/specific_heat_capacity.dart';
part 'src/si/types/specific_volume.dart';
part 'src/si/types/spectral_irradiance.dart';
part 'src/si/types/speed.dart';
part 'src/si/types/surface_tension.dart';
part 'src/si/types/temperature.dart';
part 'src/si/types/temperature_interval.dart';
part 'src/si/types/thermal_conductivity.dart';
part 'src/si/types/time.dart';
part 'src/si/types/time_instant.dart';
part 'src/si/types/torque.dart';
part 'src/si/types/volume.dart';
part 'src/si/types/volume_flow_rate.dart';
part 'src/si/types/wave_number.dart';

/// Logger for use across entire library
Logger _logger = new Logger('quantity core');

/// Dynamic quantity typing may be turned off for increased
/// efficiency.  If false, the result of operations where
/// dimensions may change will be MiscQuantity type objects.
bool dynamicQuantityTyping = true;

typedef Quantity QuantityInstantiator(dynamic value, dynamic units, double uncert);

/// Maps each quantity type to a function that can be used to create an instance of that type
final LinkedHashMap<Type, QuantityInstantiator> _typeInstantiatorMap =
    new LinkedHashMap<Type, QuantityInstantiator>.from(<Type, QuantityInstantiator>{
  AbsorbedDose: (dynamic value, AbsorbedDoseUnits units, double uncert) =>
      new AbsorbedDose.inUnits(value, units, uncert),
  AbsorbedDoseRate: (dynamic value, AbsorbedDoseRateUnits units, double uncert) =>
      new AbsorbedDoseRate.inUnits(value, units, uncert),
  Acceleration: (dynamic value, AccelerationUnits units, double uncert) =>
      new Acceleration.inUnits(value, units, uncert),
  Activity: (dynamic value, ActivityUnits units, double uncert) => new Activity.inUnits(value, units, uncert),
  AmountOfSubstance: (dynamic value, AmountOfSubstanceUnits units, double uncert) =>
      new AmountOfSubstance.inUnits(value, units, uncert),
  Angle: (dynamic value, AngleUnits units, double uncert) => new Angle.inUnits(value, units, uncert),
  AngularAcceleration: (dynamic value, AngularAccelerationUnits units, double uncert) =>
      new AngularAcceleration.inUnits(value, units, uncert),
  AngularMomentum: (dynamic value, AngularMomentumUnits units, double uncert) =>
      new AngularMomentum.inUnits(value, units, uncert),
  AngularSpeed: (dynamic value, AngularSpeedUnits units, double uncert) =>
      new AngularSpeed.inUnits(value, units, uncert),
  Area: (dynamic value, AreaUnits units, double uncert) => new Area.inUnits(value, units, uncert),
  Capacitance: (dynamic value, CapacitanceUnits units, double uncert) => new Capacitance.inUnits(value, units, uncert),
  CatalyticActivity: (dynamic value, CatalyticActivityUnits units, double uncert) =>
      new CatalyticActivity.inUnits(value, units, uncert),
  Charge: (dynamic value, ChargeUnits units, double uncert) => new Charge.inUnits(value, units, uncert),
  ChargeDensity: (dynamic value, ChargeDensityUnits units, double uncert) =>
      new ChargeDensity.inUnits(value, units, uncert),
  Concentration: (dynamic value, ConcentrationUnits units, double uncert) =>
      new Concentration.inUnits(value, units, uncert),
  Conductance: (dynamic value, ConductanceUnits units, double uncert) => new Conductance.inUnits(value, units, uncert),
  Currency: (dynamic value, CurrencyUnits units, double uncert) => new Currency.inUnits(value, units, uncert),
  Current: (dynamic value, CurrentUnits units, double uncert) => new Current.inUnits(value, units, uncert),
  CurrentDensity: (dynamic value, CurrentDensityUnits units, double uncert) =>
      new CurrentDensity.inUnits(value, units, uncert),
  DoseEquivalent: (dynamic value, DoseEquivalentUnits units, double uncert) =>
      new DoseEquivalent.inUnits(value, units, uncert),
  DynamicViscosity: (dynamic value, DynamicViscosityUnits units, double uncert) =>
      new DynamicViscosity.inUnits(value, units, uncert),
  ElectricFieldStrength: (dynamic value, ElectricFieldStrengthUnits units, double uncert) =>
      new ElectricFieldStrength.inUnits(value, units, uncert),
  ElectricFluxDensity: (dynamic value, ElectricFluxDensityUnits units, double uncert) =>
      new ElectricFluxDensity.inUnits(value, units, uncert),
  ElectricPotentialDifference: (dynamic value, ElectricPotentialDifferenceUnits units, double uncert) =>
      new ElectricPotentialDifference.inUnits(value, units, uncert),
  Energy: (dynamic value, EnergyUnits units, double uncert) => new Energy.inUnits(value, units, uncert),
  EnergyDensity: (dynamic value, EnergyDensityUnits units, double uncert) =>
      new EnergyDensity.inUnits(value, units, uncert),
  EnergyFlux: (dynamic value, EnergyFluxUnits units, double uncert) => new EnergyFlux.inUnits(value, units, uncert),
  Entropy: (dynamic value, EntropyUnits units, double uncert) => new Entropy.inUnits(value, units, uncert),
  Exposure: (dynamic value, ExposureUnits units, double uncert) => new Exposure.inUnits(value, units, uncert),
  FieldLevel: (dynamic value, LevelUnits units, double uncert) => new FieldLevel.inUnits(value, units, uncert),
  Force: (dynamic value, ForceUnits units, double uncert) => new Force.inUnits(value, units, uncert),
  Frequency: (dynamic value, FrequencyUnits units, double uncert) => new Frequency.inUnits(value, units, uncert),
  HeatFluxDensity: (dynamic value, HeatFluxDensityUnits units, double uncert) =>
      new HeatFluxDensity.inUnits(value, units, uncert),
  Illuminance: (dynamic value, IlluminanceUnits units, double uncert) => new Illuminance.inUnits(value, units, uncert),
  Inductance: (dynamic value, InductanceUnits units, double uncert) => new Inductance.inUnits(value, units, uncert),
  Information: (dynamic value, InformationUnits units, double uncert) => new Information.inUnits(value, units, uncert),
  InformationRate: (dynamic value, InformationRateUnits units, double uncert) =>
      new InformationRate.inUnits(value, units, uncert),
  KinematicViscosity: (dynamic value, KinematicViscosityUnits units, double uncert) =>
      new KinematicViscosity.inUnits(value, units, uncert),
  Length: (dynamic value, LengthUnits units, double uncert) => new Length.inUnits(value, units, uncert),
  Luminance: (dynamic value, LuminanceUnits units, double uncert) => new Luminance.inUnits(value, units, uncert),
  LuminousFlux: (dynamic value, LuminousFluxUnits units, double uncert) =>
      new LuminousFlux.inUnits(value, units, uncert),
  LuminousIntensity: (dynamic value, LuminousIntensityUnits units, double uncert) =>
      new LuminousIntensity.inUnits(value, units, uncert),
  MagneticFieldStrength: (dynamic value, MagneticFieldStrengthUnits units, double uncert) =>
      new MagneticFieldStrength.inUnits(value, units, uncert),
  MagneticFlux: (dynamic value, MagneticFluxUnits units, double uncert) =>
      new MagneticFlux.inUnits(value, units, uncert),
  MagneticFluxDensity: (dynamic value, MagneticFluxDensityUnits units, double uncert) =>
      new MagneticFluxDensity.inUnits(value, units, uncert),
  Mass: (dynamic value, MassUnits units, double uncert) => new Mass.inUnits(value, units, uncert),
  MassDensity: (dynamic value, MassDensityUnits units, double uncert) => new MassDensity.inUnits(value, units, uncert),
  MassFlowRate: (dynamic value, MassFlowRateUnits units, double uncert) =>
      new MassFlowRate.inUnits(value, units, uncert),
  MassFluxDensity: (dynamic value, MassFluxDensityUnits units, double uncert) =>
      new MassFluxDensity.inUnits(value, units, uncert),
  MolarEnergy: (dynamic value, MolarEnergyUnits units, double uncert) => new MolarEnergy.inUnits(value, units, uncert),
  MolarEntropy: (dynamic value, MolarEntropyUnits units, double uncert) =>
      new MolarEntropy.inUnits(value, units, uncert),
  Permeability: (dynamic value, PermeabilityUnits units, double uncert) =>
      new Permeability.inUnits(value, units, uncert),
  Permittivity: (dynamic value, PermittivityUnits units, double uncert) =>
      new Permittivity.inUnits(value, units, uncert),
  Power: (dynamic value, PowerUnits units, double uncert) => new Power.inUnits(value, units, uncert),
  PowerLevel: (dynamic value, LevelUnits units, double uncert) => new PowerLevel.inUnits(value, units, uncert),
  Pressure: (dynamic value, PressureUnits units, double uncert) => new Pressure.inUnits(value, units, uncert),
  Radiance: (dynamic value, RadianceUnits units, double uncert) => new Radiance.inUnits(value, units, uncert),
  RadiantIntensity: (dynamic value, RadiantIntensityUnits units, double uncert) =>
      new RadiantIntensity.inUnits(value, units, uncert),
  Resistance: (dynamic value, ResistanceUnits units, double uncert) => new Resistance.inUnits(value, units, uncert),
  Scalar: (dynamic value, ScalarUnits units, double uncert) => new Scalar.inUnits(value, units, uncert),
  SolidAngle: (dynamic value, SolidAngleUnits units, double uncert) => new SolidAngle.inUnits(value, units, uncert),
  SpecificEnergy: (dynamic value, SpecificEnergyUnits units, double uncert) =>
      new SpecificEnergy.inUnits(value, units, uncert),
  SpecificHeatCapacity: (dynamic value, SpecificHeatCapacityUnits units, double uncert) =>
      new SpecificHeatCapacity.inUnits(value, units, uncert),
  SpecificVolume: (dynamic value, SpecificVolumeUnits units, double uncert) =>
      new SpecificVolume.inUnits(value, units, uncert),
  SpectralIrradiance: (dynamic value, SpectralIrradianceUnits units, double uncert) =>
      new SpectralIrradiance.inUnits(value, units, uncert),
  Speed: (dynamic value, SpeedUnits units, double uncert) => new Speed.inUnits(value, units, uncert),
  SurfaceTension: (dynamic value, SurfaceTensionUnits units, double uncert) =>
      new SurfaceTension.inUnits(value, units, uncert),
  Temperature: (dynamic value, TemperatureUnits units, double uncert) => new Temperature.inUnits(value, units, uncert),
  TemperatureInterval: (dynamic value, TemperatureIntervalUnits units, double uncert) =>
      new TemperatureInterval.inUnits(value, units, uncert),
  ThermalConductivity: (dynamic value, ThermalConductivityUnits units, double uncert) =>
      new ThermalConductivity.inUnits(value, units, uncert),
  Time: (dynamic value, TimeUnits units, double uncert) => new Time.inUnits(value, units, uncert),
  TimeInstant: (dynamic value, TimeInstantUnits units, double uncert) => new TimeInstant.inUnits(value, units, uncert),
  Torque: (dynamic value, TorqueUnits units, double uncert) => new Torque.inUnits(value, units, uncert),
  Volume: (dynamic value, VolumeUnits units, double uncert) => new Volume.inUnits(value, units, uncert),
  VolumeFlowRate: (dynamic value, VolumeFlowRateUnits units, double uncert) =>
      new VolumeFlowRate.inUnits(value, units, uncert),
  WaveNumber: (dynamic value, WaveNumberUnits units, double uncert) => new WaveNumber.inUnits(value, units, uncert)
});

///  Returns whether or not [q] is one of the seven SI base quantities.
///
///  * If a quantity is not one of the seven base SI quantities, then it is a derived quantity.
///  * The seven base SI Quantities are [Length], [Mass], [Duration],
///  [Temperature], [Current], [LuminousIntensity] and [AmountOfSubstance].
bool siBaseQuantity(Quantity q) => (q is Length ||
      q is Mass ||
      q is Time ||
      q is Current ||
      q is TemperatureInterval ||
      q is Temperature ||
      q is AmountOfSubstance ||
      q is LuminousIntensity);


/// Returns whether or not the magnitude of the difference between two
/// quantities is less than or equal to the specified [tolerance].
bool areWithin(Quantity q1, Quantity q2, Quantity tolerance) {
  if (q1.dimensions != q2.dimensions || q2.dimensions != tolerance.dimensions) {
    throw new DimensionsException('The two quantities and tolerance must have the same dimensions');
  }

  return (q1 - q2).abs().valueSI <= tolerance.valueSI;
}

/// Returns whether or not [q] is a derived quantity (as
/// opposed to one of the seven base SI quantities).
///
/// * If a quantity is not one of the seven base SI quantities, then it is
///   a derived quantity.
/// * The seven base SI Quantities are Length, Mass, Duration,
///   Temperature, ElectricCurrent, LuminousIntensity and AmountOfSubstance.
/// * The two auxiliary angle-related base quantities (Angle and SolidAngle)
///   will return true as they are not proper base quantities but special
///   cases of Scalar quantities used by convention.
bool siDerivedQuantity(Quantity q) => !siBaseQuantity(q);

/// Returns an iterable of Type objects representing all of the quantity types
/// supported by this library (for example, Angle, Length, etc.).
///
///  * The Iterable provides the types in alphabetical order.
///  * [MiscQuantity] is not included (as it is a catch-all for
///    all quantity types that are NOT explicitly supported).
Iterable<Type> get allQuantityTypes => _typeInstantiatorMap.keys;

/// Creates a new instance of a typed quantity of type [t] having the specified
/// [value] in [units].
///
/// If type [t] is not recognized a [MiscQuantity] with [value] and the dimensions
/// of [units] will be created and returned instead.
///
/// The quantity's relative [uncert]ainty can optionally be provided (defaults to 0).
Quantity createTypedQuantityInstance(Type t, dynamic value, Units units, [double uncert = 0.0]) {
  final QuantityInstantiator qi = _typeInstantiatorMap[t];
  if (qi != null) return Function.apply(qi, <dynamic>[value, units, uncert]) as Quantity;

  // Fall back to MiscQuantity
  return new MiscQuantity(value, (units as Quantity).dimensions, uncert);
}
