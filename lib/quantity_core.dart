library quantity_core;

import 'dart:collection';
import 'dart:math' as Math;
import 'package:quantity/number.dart';
import 'package:logging/logging.dart';

part 'src/quantity/core/quantity.dart';
part 'src/quantity/core/units.dart';
part 'src/quantity/core/exponential_units.dart';
part 'src/quantity/core/dimensions.dart';
part 'src/quantity/core/misc_quantity.dart';

part 'src/quantity/core/dimensions_exception.dart';
part 'src/quantity/core/quantity_exception.dart';
part 'src/quantity/core/immutable_quantity_exception.dart';

part 'src/quantity/core/types/absorbed_dose.dart';
part 'src/quantity/core/types/absorbed_dose_rate.dart';
part 'src/quantity/core/types/acceleration.dart';
part 'src/quantity/core/types/activity.dart';
part 'src/quantity/core/types/amount_of_substance.dart';
part 'src/quantity/core/types/angle.dart';
part 'src/quantity/core/types/angular_acceleration.dart';
part 'src/quantity/core/types/angular_momentum.dart';
part 'src/quantity/core/types/angular_speed.dart';
part 'src/quantity/core/types/area.dart';
part 'src/quantity/core/types/capacitance.dart';
part 'src/quantity/core/types/catalytic_activity.dart';
part 'src/quantity/core/types/charge.dart';
part 'src/quantity/core/types/charge_density.dart';
part 'src/quantity/core/types/concentration.dart';
part 'src/quantity/core/types/conductance.dart';
part 'src/quantity/core/types/current.dart';
part 'src/quantity/core/types/current_density.dart';
part 'src/quantity/core/types/currency.dart';
part 'src/quantity/core/types/dose_equivalent.dart';
part 'src/quantity/core/types/dynamic_viscosity.dart';
part 'src/quantity/core/types/electric_field_strength.dart';
part 'src/quantity/core/types/electric_flux_density.dart';
part 'src/quantity/core/types/electric_potential_difference.dart';
part 'src/quantity/core/types/energy.dart';
part 'src/quantity/core/types/energy_density.dart';
part 'src/quantity/core/types/energy_flux.dart';
part 'src/quantity/core/types/entropy.dart';
part 'src/quantity/core/types/exposure.dart';
part 'src/quantity/core/types/force.dart';
part 'src/quantity/core/types/frequency.dart';
part 'src/quantity/core/types/heat_flux_density.dart';
part 'src/quantity/core/types/illuminance.dart';
part 'src/quantity/core/types/inductance.dart';
part 'src/quantity/core/types/information.dart';
part 'src/quantity/core/types/information_rate.dart';
part 'src/quantity/core/types/kinematic_viscosity.dart';
part 'src/quantity/core/types/length.dart';
part 'src/quantity/core/types/level.dart';
part 'src/quantity/core/types/luminance.dart';
part 'src/quantity/core/types/luminous_flux.dart';
part 'src/quantity/core/types/luminous_intensity.dart';
part 'src/quantity/core/types/magnetic_field_strength.dart';
part 'src/quantity/core/types/magnetic_flux.dart';
part 'src/quantity/core/types/magnetic_flux_density.dart';
part 'src/quantity/core/types/mass.dart';
part 'src/quantity/core/types/mass_density.dart';
part 'src/quantity/core/types/mass_flow_rate.dart';
part 'src/quantity/core/types/mass_flux_density.dart';
part 'src/quantity/core/types/molar_energy.dart';
part 'src/quantity/core/types/molar_entropy.dart';
part 'src/quantity/core/types/permeability.dart';
part 'src/quantity/core/types/permittivity.dart';
part 'src/quantity/core/types/power.dart';
part 'src/quantity/core/types/pressure.dart';
part 'src/quantity/core/types/radiance.dart';
part 'src/quantity/core/types/radiant_intensity.dart';
part 'src/quantity/core/types/resistance.dart';
part 'src/quantity/core/types/scalar.dart';
part 'src/quantity/core/types/solid_angle.dart';
part 'src/quantity/core/types/specific_energy.dart';
part 'src/quantity/core/types/specific_heat_capacity.dart';
part 'src/quantity/core/types/specific_volume.dart';
part 'src/quantity/core/types/speed.dart';
part 'src/quantity/core/types/surface_tension.dart';
part 'src/quantity/core/types/temperature.dart';
part 'src/quantity/core/types/temperature_interval.dart';
part 'src/quantity/core/types/thermal_conductivity.dart';
part 'src/quantity/core/types/time.dart';
part 'src/quantity/core/types/time_instant.dart';
part 'src/quantity/core/types/torque.dart';
part 'src/quantity/core/types/volume.dart';
part 'src/quantity/core/types/volume_flow_rate.dart';
part 'src/quantity/core/types/wave_number.dart';

/// Logger for use across entire library
Logger _logger = new Logger("quantity core");

/// Dynamic quantity typing may be turned off for increased
/// efficiency.  If false, the result of operations where
/// dimensions may change will be MiscQuantity type objects.
bool dynamicQuantityTyping = true;

typedef Quantity QuantityInstantiator(value, Units units, num uncert);

/// Maps each quantity type to a function that can be used to create an instance of that type
final LinkedHashMap<Type, QuantityInstantiator> _typeInstantiatorMap = {
  AbsorbedDose: (value, units, uncert) => new AbsorbedDose.inUnits(value, units, uncert),
  AbsorbedDoseRate: (value, units, uncert) => new AbsorbedDoseRate.inUnits(value, units, uncert),
  Acceleration: (value, units, uncert) => new Acceleration.inUnits(value, units, uncert),
  Activity: (value, units, uncert) => new Activity.inUnits(value, units, uncert),
  AmountOfSubstance: (value, units, uncert) => new AmountOfSubstance.inUnits(value, units, uncert),
  Angle: (value, units, uncert) => new Angle.inUnits(value, units, uncert),
  AngularAcceleration: (value, units, uncert) => new AngularAcceleration.inUnits(value, units, uncert),
  AngularMomentum: (value, units, uncert) => new AngularMomentum.inUnits(value, units, uncert),
  AngularSpeed: (value, units, uncert) => new AngularSpeed.inUnits(value, units, uncert),
  Area: (value, units, uncert) => new Area.inUnits(value, units, uncert),
  Capacitance: (value, units, uncert) => new Capacitance.inUnits(value, units, uncert),
  CatalyticActivity: (value, units, uncert) => new CatalyticActivity.inUnits(value, units, uncert),
  Charge: (value, units, uncert) => new Charge.inUnits(value, units, uncert),
  ChargeDensity: (value, units, uncert) => new ChargeDensity.inUnits(value, units, uncert),
  Concentration: (value, units, uncert) => new Concentration.inUnits(value, units, uncert),
  Conductance: (value, units, uncert) => new Conductance.inUnits(value, units, uncert),
  Currency: (value, units, uncert) => new Currency.inUnits(value, units, uncert),
  Current: (value, units, uncert) => new Current.inUnits(value, units, uncert),
  CurrentDensity: (value, units, uncert) => new CurrentDensity.inUnits(value, units, uncert),
  DoseEquivalent: (value, units, uncert) => new DoseEquivalent.inUnits(value, units, uncert),
  DynamicViscosity: (value, units, uncert) => new DynamicViscosity.inUnits(value, units, uncert),
  ElectricFieldStrength: (value, units, uncert) => new ElectricFieldStrength.inUnits(value, units, uncert),
  ElectricFluxDensity: (value, units, uncert) => new ElectricFluxDensity.inUnits(value, units, uncert),
  ElectricPotentialDifference: (value, units, uncert) => new ElectricPotentialDifference.inUnits(value, units, uncert),
  Energy: (value, units, uncert) => new Energy.inUnits(value, units, uncert),
  EnergyDensity: (value, units, uncert) => new EnergyDensity.inUnits(value, units, uncert),
  EnergyFlux: (value, units, uncert) => new EnergyFlux.inUnits(value, units, uncert),
  Entropy: (value, units, uncert) => new Entropy.inUnits(value, units, uncert),
  Exposure: (value, units, uncert) => new Exposure.inUnits(value, units, uncert),
  FieldLevel: (value, units, uncert) => new FieldLevel.inUnits(value, units, uncert),
  Force: (value, units, uncert) => new Force.inUnits(value, units, uncert),
  Frequency: (value, units, uncert) => new Frequency.inUnits(value, units, uncert),
  HeatFluxDensity: (value, units, uncert) => new HeatFluxDensity.inUnits(value, units, uncert),
  Illuminance: (value, units, uncert) => new Illuminance.inUnits(value, units, uncert),
  Inductance: (value, units, uncert) => new Inductance.inUnits(value, units, uncert),
  Information: (value, units, uncert) => new Information.inUnits(value, units, uncert),
  InformationRate: (value, units, uncert) => new InformationRate.inUnits(value, units, uncert),
  KinematicViscosity: (value, units, uncert) => new KinematicViscosity.inUnits(value, units, uncert),
  Length: (value, units, uncert) => new Length.inUnits(value, units, uncert),
  Luminance: (value, units, uncert) => new Luminance.inUnits(value, units, uncert),
  LuminousFlux: (value, units, uncert) => new LuminousFlux.inUnits(value, units, uncert),
  LuminousIntensity: (value, units, uncert) => new LuminousIntensity.inUnits(value, units, uncert),
  MagneticFieldStrength: (value, units, uncert) => new MagneticFieldStrength.inUnits(value, units, uncert),
  MagneticFlux: (value, units, uncert) => new MagneticFlux.inUnits(value, units, uncert),
  MagneticFluxDensity: (value, units, uncert) => new MagneticFluxDensity.inUnits(value, units, uncert),
  Mass: (value, units, uncert) => new Mass.inUnits(value, units, uncert),
  MassDensity: (value, units, uncert) => new MassDensity.inUnits(value, units, uncert),
  MassFlowRate: (value, units, uncert) => new MassFlowRate.inUnits(value, units, uncert),
  MassFluxDensity: (value, units, uncert) => new MassFluxDensity.inUnits(value, units, uncert),
  MolarEnergy: (value, units, uncert) => new MolarEnergy.inUnits(value, units, uncert),
  MolarEntropy: (value, units, uncert) => new MolarEntropy.inUnits(value, units, uncert),
  Permeability: (value, units, uncert) => new Permeability.inUnits(value, units, uncert),
  Permittivity: (value, units, uncert) => new Permittivity.inUnits(value, units, uncert),
  Power: (value, units, uncert) => new Power.inUnits(value, units, uncert),
  PowerLevel: (value, units, uncert) => new PowerLevel.inUnits(value, units, uncert),
  Pressure: (value, units, uncert) => new Pressure.inUnits(value, units, uncert),
  Radiance: (value, units, uncert) => new Radiance.inUnits(value, units, uncert),
  RadiantIntensity: (value, units, uncert) => new RadiantIntensity.inUnits(value, units, uncert),
  Resistance: (value, units, uncert) => new Resistance.inUnits(value, units, uncert),
  Scalar: (value, units, uncert) => new Scalar.inUnits(value, units, uncert),
  SolidAngle: (value, units, uncert) => new SolidAngle.inUnits(value, units, uncert),
  SpecificEnergy: (value, units, uncert) => new SpecificEnergy.inUnits(value, units, uncert),
  SpecificHeatCapacity: (value, units, uncert) => new SpecificHeatCapacity.inUnits(value, units, uncert),
  SpecificVolume: (value, units, uncert) => new SpecificVolume.inUnits(value, units, uncert),
  Speed: (value, units, uncert) => new Speed.inUnits(value, units, uncert),
  SurfaceTension: (value, units, uncert) => new SurfaceTension.inUnits(value, units, uncert),
  Temperature: (value, units, uncert) => new Temperature.inUnits(value, units, uncert),
  TemperatureInterval: (value, units, uncert) => new TemperatureInterval.inUnits(value, units, uncert),
  ThermalConductivity: (value, units, uncert) => new ThermalConductivity.inUnits(value, units, uncert),
  Time: (value, units, uncert) => new Time.inUnits(value, units, uncert),
  TimeInstant: (value, units, uncert) => new TimeInstant.inUnits(value, units, uncert),
  Torque: (value, units, uncert) => new Torque.inUnits(value, units, uncert),
  Volume: (value, units, uncert) => new Volume.inUnits(value, units, uncert),
  VolumeFlowRate: (value, units, uncert) => new VolumeFlowRate.inUnits(value, units, uncert),
  WaveNumber: (value, units, uncert) => new WaveNumber.inUnits(value, units, uncert)
};

///  Returns whether or not [q] is one of the seven SI base quantities.
///
///  * If a quantity is not one of the seven base SI quantities, then it is
///  a derived quantity.
///  * The seven base SI Quantities are [Length], [Mass], [Duration],
///  [Temperature], [ElectricCurrent], [LuminousIntensity] and [AmountOfSubstance].
///
bool siBaseQuantity(Quantity q) {
  return (q is Length ||
      q is Mass ||
      q is Time ||
      q is Current ||
      q is TemperatureInterval ||
      q is Temperature ||
      q is AmountOfSubstance ||
      q is LuminousIntensity);
}

/// Returns whether or not the magnitude of the difference between two
/// quantities is less than or equal to the specified [tolerance].
///
bool areWithin(Quantity q1, Quantity q2, Quantity tolerance) {
  if (q1.dimensions != q2.dimensions || q2.dimensions != tolerance.dimensions) {
    throw new ArgumentError("The two quantities and tolerance must have the same dimensions");
  }

  //print("${(q1 - q2).abs()} <= ${tolerance.valueSI}");
  return (q1 - q2).abs().valueSI <= tolerance.valueSI;
}

/// Returns whether or not [q] is a derived quantity (as
/// opposed to one of the seven base SI quantities).
///
/// * If a quantity is not one of the seven base SI quantities, then it is
///   a derived quantity.<br>
/// * The seven base SI Quantities are Length, Mass, Duration,
///   Temperature, ElectricCurrent, LuminousIntensity and AmountOfSubstance.
/// * The two auxiliary angle-related base quantities (Angle and SolidAngle)
///   will return true as they are not proper base quantities but special
///   cases of Scalar quantities used by convention.
///
bool siDerivedQuantity(Quantity q) => !siBaseQuantity(q);

/// Returns an iterable of Type objects representing all of the quantity types
/// supported by this library (for example, Angle, Duration, Length, etc.).
///
///  * The Iterable provides the types in alphabetical order.
///  * [MiscQuantity] is not included (as it is a catch-all for
///    all quantity types that are NOT explicitly supported).
///
///
Iterable<Type> get allQuantityTypes => _typeInstantiatorMap.keys;

/// Creates a new instance of a typed quantity of type [t] having the specified
/// [value] in [units].
///
/// If type [t] is not recognized a [MiscQuantity] with [value] and the dimensions
/// of [units] will be created and returned instead.
///
/// The quantity's relative [uncert]ainty can optionally be provided (defaults to 0).
///
Quantity createTypedQuantityInstance(Type t, value, Units units, [double uncert = 0.0]) {
  QuantityInstantiator qi = _typeInstantiatorMap[t];
  if (qi != null) {
    try {
      return Function.apply(qi, [value, units, uncert]);
    } catch (e) {
      print(e);
    }
  }

  // Fall back to MiscQuantity
  return new MiscQuantity(value, (units as Quantity).dimensions, uncert);
}
