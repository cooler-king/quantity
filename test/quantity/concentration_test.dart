import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Concentration', () {
    test('constructors', () {
      Concentration q = new Concentration();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Concentration.concentrationDimensions);
      expect(q.preferredUnits, Concentration.molesPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = new Concentration(molesPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Concentration.concentrationDimensions);
      expect(q.preferredUnits, Concentration.molesPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
