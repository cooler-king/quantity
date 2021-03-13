import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

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
  });
}
