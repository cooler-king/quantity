import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('SpecificHeatCapacity', () {
    test('constructors', () {
      var q = SpecificHeatCapacity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificHeatCapacity.specificHeatCapacityDimensions);
      expect(q.preferredUnits, SpecificHeatCapacity.joulesPerKilogramKelvin);
      expect(q.relativeUncertainty, 0);

      q = SpecificHeatCapacity(joulesPerKilogramKelvin: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificHeatCapacity.specificHeatCapacityDimensions);
      expect(q.preferredUnits, SpecificHeatCapacity.joulesPerKilogramKelvin);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = SpecificHeatCapacityUnits.energyPerMassTemperature(
          Energy.joules, Mass.kilograms, TemperatureInterval.kelvins);
      expect(u.name, 'joules per kilogram kelvin');
      expect(u.singular, 'joule per kilogram kelvin');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "J / kg K");
      expect(u.abbrev2, "J kg\u{207b}\u{00b9} K\u{207b}\u{00b9}");

      var u2 = SpecificHeatCapacityUnits.energyPerMassTemperature(
          Energy.electronVolts, Mass.grams, TemperatureInterval.kelvins);
      expect(u2.name, 'electronvolts per gram kelvin');
      expect(u2.singular, 'electronvolt per gram kelvin');
      expect(u2.convToMKS.toDouble(), 1.60217653e-16);
      expect(u2.abbrev1, "eV / g K");
      expect(u2.abbrev2, "eV g\u{207b}\u{00b9} K\u{207b}\u{00b9}");

      var q1 = SpecificHeatCapacity(joulesPerKilogramKelvin: 1.60217653e-16);
      var q2 = SpecificHeatCapacity.inUnits(1.0, u2);
      expect(q1 == q2, true);
      expect(q1.toString(),
          '1.602 176 53e-16 J kg\u{207b}\u{00b9} K\u{207b}\u{00b9}');
      expect(q2.toString(), '1 eV g\u{207b}\u{00b9} K\u{207b}\u{00b9}');
    });
  });
}
