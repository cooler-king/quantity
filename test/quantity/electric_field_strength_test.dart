import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('ElectricFieldStrength', () {
    test('constructors', () {
      ElectricFieldStrength q = new ElectricFieldStrength();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ElectricFieldStrength.electricFieldStrengthDimensions);
      expect(q.preferredUnits, ElectricFieldStrength.voltsPerMeter);
      expect(q.relativeUncertainty, 0);

      q = new ElectricFieldStrength(voltsPerMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ElectricFieldStrength.electricFieldStrengthDimensions);
      expect(q.preferredUnits, ElectricFieldStrength.voltsPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
