import 'utilities.dart';
import 'types/absorbed_dose.dart';
import 'types/absorbed_dose_rate.dart';
import 'types/acceleration.dart';
import 'types/activity.dart';
import 'types/amount_of_substance.dart';
import 'types/angle.dart';
import 'types/angular_acceleration.dart';
import 'types/angular_momentum.dart';
import 'types/angular_speed.dart';
import 'types/area.dart';
import 'types/capacitance.dart';
import 'types/catalytic_activity.dart';
import 'types/charge.dart';
import 'types/charge_density.dart';
import 'types/concentration.dart';
import 'types/conductance.dart';
import 'types/currency.dart';
import 'types/current.dart';
import 'types/current_density.dart';
import 'types/dose_equivalent.dart';
import 'types/dynamic_viscosity.dart';
import 'types/electric_field_strength.dart';
import 'types/electric_flux_density.dart';
import 'types/electric_potential_difference.dart';
import 'types/energy.dart';
import 'types/energy_density.dart';
import 'types/energy_flux.dart';
import 'types/entropy.dart';
import 'types/exposure.dart';
import 'types/force.dart';
import 'types/frequency.dart';
import 'types/heat_flux_density.dart';
import 'types/illuminance.dart';
import 'types/inductance.dart';
import 'types/information.dart';
import 'types/information_rate.dart';
import 'types/kinematic_viscosity.dart';
import 'types/token.dart';
import 'types/token_rate.dart';
import 'types/pixel.dart';
import 'types/resolution.dart';
import 'types/pixel_density.dart';
import 'types/length.dart';
import 'types/level.dart';
import 'types/luminance.dart';
import 'types/luminous_flux.dart';
import 'types/luminous_intensity.dart';
import 'types/magnetic_field_strength.dart';
import 'types/magnetic_flux.dart';
import 'types/magnetic_flux_density.dart';
import 'types/mass.dart';
import 'types/mass_density.dart';
import 'types/mass_flow_rate.dart';
import 'types/mass_flux_density.dart';
import 'types/molar_energy.dart';
import 'types/molar_entropy.dart';
import 'types/permeability.dart';
import 'types/permittivity.dart';
import 'types/power.dart';
import 'types/pressure.dart';
import 'types/radiance.dart';
import 'types/radiant_intensity.dart';
import 'types/resistance.dart';
import 'types/scalar.dart';
import 'types/solid_angle.dart';
import 'types/specific_energy.dart';
import 'types/specific_heat_capacity.dart';
import 'types/specific_volume.dart';
import 'types/spectral_irradiance.dart';
import 'types/speed.dart';
import 'types/surface_tension.dart';
import 'types/temperature.dart';
import 'types/temperature_interval.dart';
import 'types/thermal_conductivity.dart';
import 'types/time.dart';
import 'types/time_instant.dart';
import 'types/torque.dart';
import 'types/volume.dart';
import 'types/volume_flow_rate.dart';
import 'types/wave_number.dart';

/// Registers all the standard SI quantity types and their constructor functions in the registry.
void registerStandardSIQuantities() {
  registerQuantityType(
      AbsorbedDose,
      AbsorbedDose.absorbedDoseDimensions,
      (dynamic value, AbsorbedDoseUnits? units, double uncert) =>
          AbsorbedDose.inUnits(value, units, uncert));
  registerQuantityType(
      AbsorbedDoseRate,
      AbsorbedDoseRate.absorbedDoseRateDimensions,
      (dynamic value, AbsorbedDoseRateUnits? units, double uncert) =>
          AbsorbedDoseRate.inUnits(value, units, uncert));
  registerQuantityType(
      Acceleration,
      Acceleration.accelerationDimensions,
      (dynamic value, AccelerationUnits? units, double uncert) =>
          Acceleration.inUnits(value, units, uncert));
  registerQuantityType(
      Activity,
      Activity.activityDimensions,
      (dynamic value, ActivityUnits? units, double uncert) =>
          Activity.inUnits(value, units, uncert));
  registerQuantityType(
      AmountOfSubstance,
      AmountOfSubstance.amountOfSubstanceDimensions,
      (dynamic value, AmountOfSubstanceUnits? units, double uncert) =>
          AmountOfSubstance.inUnits(value, units, uncert));
  registerQuantityType(
      Angle,
      Angle.angleDimensions,
      (dynamic value, AngleUnits? units, double uncert) =>
          Angle.inUnits(value, units, uncert));
  registerQuantityType(
      AngularAcceleration,
      AngularAcceleration.angularAccelerationDimensions,
      (dynamic value, AngularAccelerationUnits? units, double uncert) =>
          AngularAcceleration.inUnits(value, units, uncert));
  registerQuantityType(
      AngularMomentum,
      AngularMomentum.angularMomentumDimensions,
      (dynamic value, AngularMomentumUnits? units, double uncert) =>
          AngularMomentum.inUnits(value, units, uncert));
  registerQuantityType(
      AngularSpeed,
      AngularSpeed.angularSpeedDimensions,
      (dynamic value, AngularSpeedUnits? units, double uncert) =>
          AngularSpeed.inUnits(value, units, uncert));
  registerQuantityType(
      Area,
      Area.areaDimensions,
      (dynamic value, AreaUnits? units, double uncert) =>
          Area.inUnits(value, units, uncert));
  registerQuantityType(
      Capacitance,
      Capacitance.electricCapacitanceDimensions,
      (dynamic value, CapacitanceUnits? units, double uncert) =>
          Capacitance.inUnits(value, units, uncert));
  registerQuantityType(
      CatalyticActivity,
      CatalyticActivity.catalyticActivityDimensions,
      (dynamic value, CatalyticActivityUnits? units, double uncert) =>
          CatalyticActivity.inUnits(value, units, uncert));
  registerQuantityType(
      Charge,
      Charge.electricChargeDimensions,
      (dynamic value, ChargeUnits? units, double uncert) =>
          Charge.inUnits(value, units, uncert));
  registerQuantityType(
      ChargeDensity,
      ChargeDensity.electricChargeDensityDimensions,
      (dynamic value, ChargeDensityUnits? units, double uncert) =>
          ChargeDensity.inUnits(value, units, uncert));
  registerQuantityType(
      Concentration,
      Concentration.concentrationDimensions,
      (dynamic value, ConcentrationUnits? units, double uncert) =>
          Concentration.inUnits(value, units, uncert));
  registerQuantityType(
      Conductance,
      Conductance.electricConductanceDimensions,
      (dynamic value, ConductanceUnits? units, double uncert) =>
          Conductance.inUnits(value, units, uncert));
  registerQuantityType(
      Currency,
      Currency.currencyDimensions,
      (dynamic value, CurrencyUnits? units, double uncert) =>
          Currency.inUnits(value, units, uncert));
  registerQuantityType(
      Current,
      Current.electricCurrentDimensions,
      (dynamic value, CurrentUnits? units, double uncert) =>
          Current.inUnits(value, units, uncert));
  registerQuantityType(
      CurrentDensity,
      CurrentDensity.electricCurrentDensityDimensions,
      (dynamic value, CurrentDensityUnits? units, double uncert) =>
          CurrentDensity.inUnits(value, units, uncert));
  registerQuantityType(
      DoseEquivalent,
      DoseEquivalent.doseEquivalentDimensions,
      (dynamic value, DoseEquivalentUnits? units, double uncert) =>
          DoseEquivalent.inUnits(value, units, uncert));
  registerQuantityType(
      DynamicViscosity,
      DynamicViscosity.dynamicViscosityDimensions,
      (dynamic value, DynamicViscosityUnits? units, double uncert) =>
          DynamicViscosity.inUnits(value, units, uncert));
  registerQuantityType(
      ElectricFieldStrength,
      ElectricFieldStrength.electricFieldStrengthDimensions,
      (dynamic value, ElectricFieldStrengthUnits? units, double uncert) =>
          ElectricFieldStrength.inUnits(value, units, uncert));
  registerQuantityType(
      ElectricFluxDensity,
      ElectricFluxDensity.electricFluxDensityDimensions,
      (dynamic value, ElectricFluxDensityUnits? units, double uncert) =>
          ElectricFluxDensity.inUnits(value, units, uncert));
  registerQuantityType(
      ElectricPotentialDifference,
      ElectricPotentialDifference.electricPotentialDifferenceDimensions,
      (dynamic value, ElectricPotentialDifferenceUnits? units, double uncert) =>
          ElectricPotentialDifference.inUnits(value, units, uncert));
  registerQuantityType(
      Energy,
      Energy.energyDimensions,
      (dynamic value, EnergyUnits? units, double uncert) =>
          Energy.inUnits(value, units, uncert));
  registerQuantityType(
      EnergyDensity,
      EnergyDensity.energyDensityDimensions,
      (dynamic value, EnergyDensityUnits? units, double uncert) =>
          EnergyDensity.inUnits(value, units, uncert));
  registerQuantityType(
      EnergyFlux,
      EnergyFlux.energyFluxDimensions,
      (dynamic value, EnergyFluxUnits? units, double uncert) =>
          EnergyFlux.inUnits(value, units, uncert));
  registerQuantityType(
      Entropy,
      Entropy.entropyDimensions,
      (dynamic value, EntropyUnits? units, double uncert) =>
          Entropy.inUnits(value, units, uncert));
  registerQuantityType(
      Exposure,
      Exposure.exposureDimensions,
      (dynamic value, ExposureUnits? units, double uncert) =>
          Exposure.inUnits(value, units, uncert));
  registerQuantityType(
      FieldLevel,
      Level.levelDimensions,
      (dynamic value, LevelUnits? units, double uncert) =>
          FieldLevel.inUnits(value, units, uncert));
  registerQuantityType(
      Force,
      Force.forceDimensions,
      (dynamic value, ForceUnits? units, double uncert) =>
          Force.inUnits(value, units, uncert));
  registerQuantityType(
      Frequency,
      Frequency.frequencyDimensions,
      (dynamic value, FrequencyUnits? units, double uncert) =>
          Frequency.inUnits(value, units, uncert));
  registerQuantityType(
      HeatFluxDensity,
      HeatFluxDensity.heatFluxDensityDimensions,
      (dynamic value, HeatFluxDensityUnits? units, double uncert) =>
          HeatFluxDensity.inUnits(value, units, uncert));
  registerQuantityType(
      Illuminance,
      Illuminance.illuminanceDimensions,
      (dynamic value, IlluminanceUnits? units, double uncert) =>
          Illuminance.inUnits(value, units, uncert));
  registerQuantityType(
      Inductance,
      Inductance.inductanceDimensions,
      (dynamic value, InductanceUnits? units, double uncert) =>
          Inductance.inUnits(value, units, uncert));
  registerQuantityType(
      Information,
      Information.informationDimensions,
      (dynamic value, InformationUnits? units, double uncert) =>
          Information.inUnits(value, units, uncert));
  registerQuantityType(
      InformationRate,
      InformationRate.informationRateDimensions,
      (dynamic value, InformationRateUnits? units, double uncert) =>
          InformationRate.inUnits(value, units, uncert));
  registerQuantityType(
      KinematicViscosity,
      KinematicViscosity.kinematicViscosityDimensions,
      (dynamic value, KinematicViscosityUnits? units, double uncert) =>
          KinematicViscosity.inUnits(value, units, uncert));
  registerQuantityType(
      Length,
      Length.lengthDimensions,
      (dynamic value, LengthUnits? units, double uncert) =>
          Length.inUnits(value, units, uncert));
  registerQuantityType(
      Luminance,
      Luminance.luminanceDimensions,
      (dynamic value, LuminanceUnits? units, double uncert) =>
          Luminance.inUnits(value, units, uncert));
  registerQuantityType(
      LuminousFlux,
      LuminousFlux.luminousFluxDimensions,
      (dynamic value, LuminousFluxUnits? units, double uncert) =>
          LuminousFlux.inUnits(value, units, uncert));
  registerQuantityType(
      LuminousIntensity,
      LuminousIntensity.luminousIntensityDimensions,
      (dynamic value, LuminousIntensityUnits? units, double uncert) =>
          LuminousIntensity.inUnits(value, units, uncert));
  registerQuantityType(
      MagneticFieldStrength,
      MagneticFieldStrength.magneticFieldStrengthDimensions,
      (dynamic value, MagneticFieldStrengthUnits? units, double uncert) =>
          MagneticFieldStrength.inUnits(value, units, uncert));
  registerQuantityType(
      MagneticFlux,
      MagneticFlux.magneticFluxDimensions,
      (dynamic value, MagneticFluxUnits? units, double uncert) =>
          MagneticFlux.inUnits(value, units, uncert));
  registerQuantityType(
      MagneticFluxDensity,
      MagneticFluxDensity.magneticFluxDensityDimensions,
      (dynamic value, MagneticFluxDensityUnits? units, double uncert) =>
          MagneticFluxDensity.inUnits(value, units, uncert));
  registerQuantityType(
      Mass,
      Mass.massDimensions,
      (dynamic value, MassUnits? units, double uncert) =>
          Mass.inUnits(value, units, uncert));
  registerQuantityType(
      MassDensity,
      MassDensity.massDensityDimensions,
      (dynamic value, MassDensityUnits? units, double uncert) =>
          MassDensity.inUnits(value, units, uncert));
  registerQuantityType(
      MassFlowRate,
      MassFlowRate.massFlowRateDimensions,
      (dynamic value, MassFlowRateUnits? units, double uncert) =>
          MassFlowRate.inUnits(value, units, uncert));
  registerQuantityType(
      MassFluxDensity,
      MassFluxDensity.massFluxDensityDimensions,
      (dynamic value, MassFluxDensityUnits? units, double uncert) =>
          MassFluxDensity.inUnits(value, units, uncert));
  registerQuantityType(
      MolarEnergy,
      MolarEnergy.molarEnergyDimensions,
      (dynamic value, MolarEnergyUnits? units, double uncert) =>
          MolarEnergy.inUnits(value, units, uncert));
  registerQuantityType(
      MolarEntropy,
      MolarEntropy.molarEntropyDimensions,
      (dynamic value, MolarEntropyUnits? units, double uncert) =>
          MolarEntropy.inUnits(value, units, uncert));
  registerQuantityType(
      Permeability,
      Permeability.permeabilityDimensions,
      (dynamic value, PermeabilityUnits? units, double uncert) =>
          Permeability.inUnits(value, units, uncert));
  registerQuantityType(
      Permittivity,
      Permittivity.permittivityDimensions,
      (dynamic value, PermittivityUnits? units, double uncert) =>
          Permittivity.inUnits(value, units, uncert));
  registerQuantityType(
      Power,
      Power.powerDimensions,
      (dynamic value, PowerUnits? units, double uncert) =>
          Power.inUnits(value, units, uncert));
  registerQuantityType(
      PowerLevel,
      Level.levelDimensions,
      (dynamic value, LevelUnits? units, double uncert) =>
          PowerLevel.inUnits(value, units, uncert));
  registerQuantityType(
      Pressure,
      Pressure.pressureDimensions,
      (dynamic value, PressureUnits? units, double uncert) =>
          Pressure.inUnits(value, units, uncert));
  registerQuantityType(
      Radiance,
      Radiance.radianceDimensions,
      (dynamic value, RadianceUnits? units, double uncert) =>
          Radiance.inUnits(value, units, uncert));
  registerQuantityType(
      RadiantIntensity,
      RadiantIntensity.radiantIntensityDimensions,
      (dynamic value, RadiantIntensityUnits? units, double uncert) =>
          RadiantIntensity.inUnits(value, units, uncert));
  registerQuantityType(
      Resistance,
      Resistance.electricResistanceDimensions,
      (dynamic value, ResistanceUnits? units, double uncert) =>
          Resistance.inUnits(value, units, uncert));
  registerQuantityType(
      Scalar,
      Scalar.scalarDimensions,
      (dynamic value, ScalarUnits? units, double uncert) =>
          Scalar.inUnits(value, units, uncert));
  registerQuantityType(
      SolidAngle,
      SolidAngle.solidAngleDimensions,
      (dynamic value, SolidAngleUnits? units, double uncert) =>
          SolidAngle.inUnits(value, units, uncert));
  registerQuantityType(
      SpecificEnergy,
      SpecificEnergy.specificEnergyDimensions,
      (dynamic value, SpecificEnergyUnits? units, double uncert) =>
          SpecificEnergy.inUnits(value, units, uncert));
  registerQuantityType(
      SpecificHeatCapacity,
      SpecificHeatCapacity.specificHeatCapacityDimensions,
      (dynamic value, SpecificHeatCapacityUnits? units, double uncert) =>
          SpecificHeatCapacity.inUnits(value, units, uncert));
  registerQuantityType(
      SpecificVolume,
      SpecificVolume.specificVolumeDimensions,
      (dynamic value, SpecificVolumeUnits? units, double uncert) =>
          SpecificVolume.inUnits(value, units, uncert));
  registerQuantityType(
      SpectralIrradiance,
      SpectralIrradiance.spectralIrradianceDimensions,
      (dynamic value, SpectralIrradianceUnits? units, double uncert) =>
          SpectralIrradiance.inUnits(value, units, uncert));
  registerQuantityType(
      Speed,
      Speed.speedDimensions,
      (dynamic value, SpeedUnits? units, double uncert) =>
          Speed.inUnits(value, units, uncert));
  registerQuantityType(
      SurfaceTension,
      SurfaceTension.surfaceTensionDimensions,
      (dynamic value, SurfaceTensionUnits? units, double uncert) =>
          SurfaceTension.inUnits(value, units, uncert));
  registerQuantityType(
      Temperature,
      Temperature.temperatureDimensions,
      (dynamic value, TemperatureUnits? units, double uncert) =>
          Temperature.inUnits(value, units, uncert));
  registerQuantityType(
      TemperatureInterval,
      TemperatureInterval.temperatureIntervalDimensions,
      (dynamic value, TemperatureIntervalUnits? units, double uncert) =>
          TemperatureInterval.inUnits(value, units, uncert));
  registerQuantityType(
      ThermalConductivity,
      ThermalConductivity.thermalConductivityDimensions,
      (dynamic value, ThermalConductivityUnits? units, double uncert) =>
          ThermalConductivity.inUnits(value, units, uncert));
  registerQuantityType(
      Time,
      Time.timeDimensions,
      (dynamic value, TimeUnits? units, double uncert) =>
          Time.inUnits(value, units, uncert));
  registerQuantityType(
      TimeInstant,
      TimeInstant.timeInstantDimensions,
      (dynamic value, TimeInstantUnits? units, double uncert) =>
          TimeInstant.inUnits(value, units, uncert));
  registerQuantityType(
      Torque,
      Torque.torqueDimensions,
      (dynamic value, TorqueUnits? units, double uncert) =>
          Torque.inUnits(value, units, uncert));
  registerQuantityType(
      Volume,
      Volume.volumeDimensions,
      (dynamic value, VolumeUnits? units, double uncert) =>
          Volume.inUnits(value, units, uncert));
  registerQuantityType(
      VolumeFlowRate,
      VolumeFlowRate.volumeFlowRateDimensions,
      (dynamic value, VolumeFlowRateUnits? units, double uncert) =>
          VolumeFlowRate.inUnits(value, units, uncert));
  registerQuantityType(
      WaveNumber,
      WaveNumber.waveNumberDimensions,
      (dynamic value, WaveNumberUnits? units, double uncert) =>
          WaveNumber.inUnits(value, units, uncert));
  registerQuantityType(
      Token,
      Token.tokenDimensions,
      (dynamic value, TokenUnits? units, double uncert) =>
          Token.inUnits(value, units, uncert));
  registerQuantityType(
      TokenRate,
      TokenRate.tokenRateDimensions,
      (dynamic value, TokenRateUnits? units, double uncert) =>
          TokenRate.inUnits(value, units, uncert));
  registerQuantityType(
      Pixel,
      Pixel.pixelDimensions,
      (dynamic value, PixelUnits? units, double uncert) =>
          Pixel.inUnits(value, units, uncert));
  registerQuantityType(
      Resolution,
      Resolution.resolutionDimensions,
      (dynamic value, ResolutionUnits? units, double uncert) =>
          Resolution.inUnits(value, units, uncert));
  registerQuantityType(
      PixelDensity,
      PixelDensity.pixelDensityDimensions,
      (dynamic value, PixelDensityUnits? units, double uncert) =>
          PixelDensity.inUnits(value, units, uncert));
}

bool _siRegistered = false;

/// A top-level variable evaluated lazily to auto-trigger registration of all SI quantity types.
bool get siRegistered {
  if (!_siRegistered) {
    _siRegistered = true;
    registerStandardSIQuantities();
  }
  return true;
}
