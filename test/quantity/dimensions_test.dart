import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

main() {
  group('Dimensions', () {
    test('base dimensions', () {
      expect(Dimensions.baseLengthKey, "Length");
      expect(Dimensions.baseMassKey, "Mass");
      expect(Dimensions.baseTimeKey, "Time");
      expect(Dimensions.baseCurrentKey, "Current");
      expect(Dimensions.baseIntensityKey, "Intensity");
      expect(Dimensions.baseAmountKey, "Amount");
      expect(Dimensions.baseTemperatureKey, "Temperature");
    });

    test('auxiliary base dimensions', () {
      expect(Dimensions.baseAngleKey, "Angle");
      expect(Dimensions.baseSolidAngleKey, "Solid Angle");
    });

    test('constructors', () {
      Dimensions d = new Dimensions();
      expect(d, isNotNull);

      const Dimensions d2 = const Dimensions.constant(const {"Length": 2});
      expect(d2, isNotNull);
      expect(d2.getComponentExponent(Dimensions.baseLengthKey), 2);

      d = new Dimensions.fromMap({"Time": -1});
      expect(d, isNotNull);
      expect(d.getComponentExponent(Dimensions.baseTimeKey), -1);

      Dimensions d3 = new Dimensions.copy(d);
      expect(d3, isNotNull);
      expect(d3.getComponentExponent(Dimensions.baseTimeKey), -1);
    });

    test('equality', () {
      Dimensions d1 = new Dimensions.fromMap(
          {"Time": -1, "Length": 1, "Angle": 1, "Amount": -2});

      Dimensions d2 = new Dimensions.fromMap(
          {"Angle": 1, "Amount": -2, "Time": -1, "Length": 1});

      expect((d1 == d2), true);
      expect((d1 != d2), false);
      expect((d1 == d1), true);
      expect((d1 != d1), false);
    });

    test('equalsSI', () {
      Dimensions d1 = new Dimensions.fromMap(
          {"Time": -1, "Length": 1, "Angle": 1, "Amount": -2});

      Dimensions d2 =
          new Dimensions.fromMap({"Amount": -2, "Time": -1, "Length": 1});

      Dimensions d3 = new Dimensions.fromMap({
        "Time": -1,
        "Length": 1,
        "Angle": 5,
        "Amount": -2,
        "Solid Angle": 3
      });

      expect((d1 == d2), false);
      expect((d1 == d3), false);
      expect((d2 == d3), false);
      expect(d1.equalsSI(d2), true);
      expect(d2.equalsSI(d1), true);
      expect(d1.equalsSI(d3), true);
      expect(d3.equalsSI(d1), true);
      expect(d2.equalsSI(d3), true);
      expect(d3.equalsSI(d2), true);
    });

    test('hashCode', () {
      Dimensions d1 = new Dimensions.fromMap(
          {"Time": -1, "Length": 1, "Angle": 1, "Amount": -2});

      Dimensions d2 = new Dimensions.fromMap(
          {"Angle": 1, "Amount": -2, "Time": -1, "Length": 1});

      Dimensions d3 = new Dimensions.fromMap({
        "Time": -1,
        "Length": 1,
        "Angle": 5,
        "Amount": -2,
        "Solid Angle": 3
      });

      Map<Dimensions, int> testMap = new Map<Dimensions, int>();
      testMap[d1] = 1;
      testMap[d2] = 2;
      testMap[d3] = 3;

      expect((d1.hashCode == d2.hashCode), true);
      expect((d1.hashCode == d3.hashCode), false);
      expect(testMap.length, 2);
      expect(testMap[d1], 2);
    });

    test('operator *', () {
      Dimensions d1 = new Dimensions.fromMap(
          {"Time": -1, "Length": 1, "Angle": 1, "Amount": -2});

      Dimensions d2 =
          new Dimensions.fromMap({"Amount": 2, "Time": -1, "Length": 2});

      Dimensions d3 =
          new Dimensions.fromMap({"Time": -2, "Length": 3, "Angle": 1});

      Dimensions d4 = new Dimensions.fromMap(
          {"Time": -2, "Length": 2, "Angle": 2, "Amount": -4});

      Dimensions d5 = new Dimensions();

      expect((d1 * d2), d3);
      expect((d2 * d1), d3);
      expect((d1 * d1), d4);
      expect((d1 * d5), d1);
      expect((d5 * d1), d1);
    });

    test('operator /', () {
      Dimensions d1 = new Dimensions.fromMap(
          {"Time": -1, "Length": 1, "Angle": 1, "Amount": -2});

      Dimensions d2 =
          new Dimensions.fromMap({"Amount": 2, "Time": -1, "Length": 2});

      Dimensions d3 =
          new Dimensions.fromMap({"Length": -1, "Angle": 1, "Amount": -4});

      Dimensions d4 =
          new Dimensions.fromMap({"Length": 1, "Angle": -1, "Amount": 4});

      Dimensions d5 = new Dimensions();

      Dimensions d6 = new Dimensions.fromMap(
          {"Time": 1, "Length": -1, "Angle": -1, "Amount": 2});

      expect((d1 / d2), d3);
      expect((d2 / d1), d4);
      expect((d1 / d1), d5);
      expect((d1 / d5), d1);
      expect((d5 / d1), d6);
    });

    test('operator ^', () {
      Dimensions d1 = new Dimensions.fromMap(
          {"Time": -1, "Length": 1, "Angle": 1, "Amount": -2});

      Dimensions d2 =
          new Dimensions.fromMap({"Amount": 2, "Time": -1, "Length": 2});

      Dimensions d3 =
          new Dimensions.fromMap({"Length": -1, "Angle": 1, "Amount": -4});

      Dimensions d4 =
          new Dimensions.fromMap({"Length": 1, "Angle": -1, "Amount": 4});

      Dimensions d5 = new Dimensions();

      Dimensions d6 = new Dimensions.fromMap(
          {"Time": 1, "Length": -1, "Angle": -1, "Amount": 2});

      expect((d1 ^ 1), d1);
      expect((d1 ^ 0), d5);
    });

    test('inverse', () {
      Dimensions d1 = new Dimensions.fromMap({
        "Time": 3,
        "Length": 2,
        "Angle": 1,
        "Amount": 0,
        "Temperature": -1,
        "Mass": -2,
        "Current": -3,
        "Intensity": -4,
        "Solid Angle": -5
      });

      Dimensions d2 = new Dimensions.fromMap({
        "Time": -3,
        "Length": -2,
        "Angle": -1,
        "Amount": 0,
        "Temperature": 1,
        "Mass": 2,
        "Current": 3,
        "Intensity": 4,
        "Solid Angle": 5
      });

      Dimensions d3 = new Dimensions();

      expect(d1.inverse(), d2);
      expect(d2.inverse(), d1);
      expect(d3.inverse(), d3);
    });

    test('determine quantity type', () {
      // BASE QUANTITIES
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Length": 1})),
          Length);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap({"Mass": 1})),
          Mass);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap({"Time": 1})),
          Time);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Temperature": 1})),
          TemperatureInterval);
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Current": 1})),
          Current);
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Intensity": 1})),
          LuminousIntensity);
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Amount": 1})),
          AmountOfSubstance);

      // AUX BASE
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Angle": 1})),
          Angle);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Solid Angle": 1})),
          SolidAngle);

      // THE REST

      // x-AbsorbedDose (SpecificEnergy)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 2, "Time": -3})),
          AbsorbedDoseRate);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 1, "Time": -2})),
          Acceleration);

      // x-Activity (Frequency)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Angle": 1, "Time": -2})),
          AngularAcceleration);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Angle": 1, "Time": -1, "Length": 1})),
          AngularMomentum);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Angle": 1, "Time": -1})),
          AngularSpeed);

      // x-AngularVelocity (AngularSpeed)

      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Length": 2})),
          Area);

      // x-Capacitance (Capacitance)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Amount": 1, "Time": -1})),
          CatalyticActivity);

      // x-Charge (Charge)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Amount": 1, "Length": -3})),
          Concentration);

      // x-Conductance (Conductance)
      // x-Currency (Scalar)
      // x-DoseEquivalent (SpecificEnergy)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Length": -1, "Time": -1})),
          DynamicViscosity);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Time": 4, "Current": 2, "Length": -2, "Mass": -1})),
          Capacitance);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Current": 1, "Time": 1})),
          Charge);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Current": 1, "Time": 1, "Length": -3})),
          ChargeDensity);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Current": 2, "Time": 3, "Length": -2, "Mass": -1})),
          Conductance);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Current": 1, "Length": -2})),
          CurrentDensity);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Current": -1, "Time": -3, "Length": 1, "Mass": 1})),
          ElectricFieldStrength);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Current": 1, "Time": 1, "Length": -2})),
          ElectricFluxDensity);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Current": -1, "Time": -3, "Length": 2, "Mass": 1})),
          ElectricPotentialDifference);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Current": -2, "Time": -3, "Length": 2, "Mass": 1})),
          Resistance);

      // x-ElectromotiveForce (ElectricPotentialDifference)
      // x-Emf (PotentialDifference)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 2, "Mass": 1, "Time": -2})),
          Energy);

      // x-EnergyDensity (Pressure)
      // x-EnergyFlux (Power)
      // x-EnergyFluxDensity (HeatFluxDensity)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 2, "Mass": 1, "Temperature": -1, "Time": -2})),
          Entropy);

      // x-Epoch (TimeInstant)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Current": 1, "Mass": -1, "Time": 1})),
          Exposure);

      // x-FieldLevel (Level)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 1, "Mass": 1, "Time": -2})),
          Force);
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Time": -1})),
          Frequency);

      // x-HeatCapacity (Entropy)
      // x-HeatFlowRate (Power)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Time": -3})),
          HeatFluxDensity);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": -2, "Intensity": 1, "Solid Angle": 1})),
          Illuminance);

      // x-ImpartedSpecificEnergy (SpecificEnergy)
      // x-Information (Scalar)
      // x-InformationRate (Scalar)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 2, "Mass": 1, "Current": -2, "Time": -2})),
          Inductance);

      // x-Irradiance (HeatFluxDensity)
      // x-Kerma (SpecificEnergy)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 2, "Time": -1})),
          KinematicViscosity);

      // x-Level (Scalar)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": -2, "Intensity": 1})),
          Luminance);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Intensity": 1, "Solid Angle": 1})),
          LuminousFlux);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": -1, "Current": 1})),
          MagneticFieldStrength);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 2, "Time": -2, "Current": -1, "Mass": 1})),
          MagneticFlux);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Current": -1, "Time": -2})),
          MagneticFluxDensity);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Length": -3})),
          MassDensity);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Time": -1})),
          MassFlowRate);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Time": -1, "Length": -2})),
          MassFluxDensity);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Mass": 1, "Length": 2, "Time": -2, "Amount": -1})),
          MolarEnergy);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap({
            "Mass": 1,
            "Length": 2,
            "Time": -2,
            "Amount": -1,
            "Temperature": -1
          })),
          MolarEntropy);

      // x-MolarHeatCapacity (MolarEntropy), MomentOfForce (Torque)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 1, "Mass": 1, "Time": -2, "Current": -2})),
          Permeability);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": -3, "Time": 4, "Current": 2, "Mass": -1})),
          Permittivity);

      // x-Potential (PotentialDifference)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 2, "Mass": 1, "Time": -3})),
          Power);

      // x-PowerFluxDensity (HeatFluxDensity)
      // x-PowerLevel (Level)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": -1, "Mass": 1, "Time": -2})),
          Pressure);
      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Mass": 1, "Solid Angle": -1, "Time": -3})),
          Radiance);

      // x-RadiantFlux (Power)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 2, "Mass": 1, "Time": -3, "Solid Angle": -1})),
          RadiantIntensity);

      // x-Resistance (Resistance)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap({})), Scalar);

      // x-SoundIntensity (HeatFluxDensity)
      // x-SoundIntensityLevel (PowerLevel => Level)
      // x-SoundPressureLevel (FieldLevel => Level)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 2, "Time": -2})),
          SpecificEnergy);

      // x-SpecificEntropy (SpecificHeatCapacity)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 2, "Time": -2, "Temperature": -1})),
          SpecificHeatCapacity);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 3, "Mass": -1})),
          SpecificVolume);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 1, "Time": -1})),
          Speed);

      // x-Stress (Pressure)

      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Mass": 1, "Time": -2})),
          SurfaceTension);

      // x-Temperature (TemperatureInterval returned instead)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 1, "Mass": 1, "Time": -3, "Temperature": -1})),
          ThermalConductivity);

      // x-TimeInstant (Time returned instead)

      expect(
          Dimensions.determineQuantityType(new Dimensions.fromMap(
              {"Length": 2, "Time": -2, "Mass": 1, "Angle": -1})),
          Torque);

      // x-Velocity (Speed)

      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Length": -3})),
          Volume);
      expect(
          Dimensions.determineQuantityType(
              new Dimensions.fromMap({"Length": 3, "Time": -1})),
          VolumeFlowRate);
      expect(
          Dimensions
              .determineQuantityType(new Dimensions.fromMap({"Length": -1})),
          WaveNumber);

      // x-Work (Energy)
    });

    test('toQuantity', () {
      Dimensions d1 = new Dimensions.fromMap({"Length": 1});
      Dimensions d2 = new Dimensions.fromMap({"Length": 2});
      Dimensions d3 = new Dimensions();

      Quantity q1 = d1.toQuantity();

      expect(q1, isNotNull);

      print(
          "TODO:  Dimensions.toQuantity() depends on complete Dart SDK mirror impl");
      /* Dimensions uses mirrors to get instance of type:  not yet implemented
       * in Dart SDK (ClassMirror not returned from reflect() as expected).
       * See: Issue 8494: dart:mirrors newInstance from type.
       *
      expect(q1 is Length, true);  */
    });
  });
}
