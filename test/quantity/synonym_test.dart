import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('Synonym Quantity Types Support', () {
    test('Direct construction using synonym type aliases', () {
      // Irradiance (alias for HeatFluxDensity)
      final solar = Irradiance(wattsPerSquareMeter: 1000);
      expect(solar, isA<HeatFluxDensity>());
      expect(solar.valueSI.toDouble(), equals(1000.0));

      // Stress (alias for Pressure)
      final shearStress = Stress(Pa: 500);
      expect(shearStress, isA<Pressure>());
      expect(shearStress.valueSI.toDouble(), equals(500.0));

      // Work (alias for Energy)
      final liftingWork = Work(J: 200);
      expect(liftingWork, isA<Energy>());
      expect(liftingWork.valueSI.toDouble(), equals(200.0));

      // SoundIntensityLevel (alias for PowerLevel)
      final level = SoundIntensityLevel(Power(W: 10), Power(W: 1));
      expect(level, isA<PowerLevel>());
    });

    test('getRegisteredTypeByName lookup of synonyms', () {
      expect(getRegisteredTypeByName('Irradiance'), equals(HeatFluxDensity));
      expect(getRegisteredTypeByName('EnergyFluxDensity'),
          equals(HeatFluxDensity));
      expect(
          getRegisteredTypeByName('PowerFluxDensity'), equals(HeatFluxDensity));

      expect(getRegisteredTypeByName('ElectromotiveForce'),
          equals(ElectricPotentialDifference));
      expect(
          getRegisteredTypeByName('EMF'), equals(ElectricPotentialDifference));
      expect(getRegisteredTypeByName('Potential'),
          equals(ElectricPotentialDifference));

      expect(getRegisteredTypeByName('QuantityOfHeat'), equals(Energy));
      expect(getRegisteredTypeByName('Work'), equals(Energy));

      expect(getRegisteredTypeByName('HeatCapacity'), equals(Entropy));

      expect(
          getRegisteredTypeByName('SoundIntensityLevel'), equals(PowerLevel));
      expect(getRegisteredTypeByName('SoundPressureLevel'), equals(FieldLevel));

      expect(getRegisteredTypeByName('HeatFlowRate'), equals(Power));
      expect(getRegisteredTypeByName('RadiantFlux'), equals(Power));

      expect(getRegisteredTypeByName('Stress'), equals(Pressure));

      expect(getRegisteredTypeByName('ImpartedSpecificEnergy'),
          equals(SpecificEnergy));
      expect(getRegisteredTypeByName('Kerma'), equals(SpecificEnergy));

      expect(getRegisteredTypeByName('SpecificEntropy'),
          equals(SpecificHeatCapacity));

      expect(getRegisteredTypeByName('Epoch'), equals(TimeInstant));

      expect(getRegisteredTypeByName('MomentOfForce'), equals(Torque));
    });

    test('JSON Deserialization using synonym names', () {
      final jsonSolar = {
        'type': 'Irradiance',
        'value': {'d': 1200.0},
        'dimensions': {'Mass': 1, 'Time': -3},
        'uncertainty': 0.0
      };

      final q = Quantity.fromJson(jsonSolar);
      expect(q, isA<HeatFluxDensity>());
      expect(q.valueSI.toDouble(), equals(1200.0));

      final jsonStress = {
        'type': 'Stress',
        'value': {'d': 101325.0},
        'dimensions': {'Mass': 1, 'Length': -1, 'Time': -2},
        'uncertainty': 0.0
      };

      final p = Quantity.fromJson(jsonStress);
      expect(p, isA<Pressure>());
      expect(p.valueSI.toDouble(), equals(101325.0));
    });

    test('getQuantitySynonyms helper function', () {
      final heatFluxSynonyms = getQuantitySynonyms(HeatFluxDensity);
      expect(heatFluxSynonyms, contains('EnergyFluxDensity'));
      expect(heatFluxSynonyms, contains('Irradiance'));
      expect(heatFluxSynonyms, contains('PowerFluxDensity'));
      expect(heatFluxSynonyms.length, equals(3));

      final pressureSynonyms = getQuantitySynonyms(Pressure);
      expect(pressureSynonyms, contains('Stress'));
      expect(pressureSynonyms.length, equals(1));

      final energySynonyms = getQuantitySynonyms(Energy);
      expect(energySynonyms, contains('QuantityOfHeat'));
      expect(energySynonyms, contains('Work'));
      expect(energySynonyms.length, equals(2));
    });
  });
}
