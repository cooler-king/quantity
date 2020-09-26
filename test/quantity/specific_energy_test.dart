import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('SpecificEnergy', () {
    test('constructors', () {
      SpecificEnergy q = new SpecificEnergy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificEnergy.specificEnergyDimensions);
      expect(q.preferredUnits, SpecificEnergy.joulesPerKilogram);
      expect(q.relativeUncertainty, 0);

      q = new SpecificEnergy(joulesPerKilogram: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificEnergy.specificEnergyDimensions);
      expect(q.preferredUnits, SpecificEnergy.joulesPerKilogram);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
