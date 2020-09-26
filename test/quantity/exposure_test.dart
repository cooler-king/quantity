import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Exposure', () {
    test('constructors', () {
      Exposure q = new Exposure();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Exposure.exposureDimensions);
      expect(q.preferredUnits, Exposure.coulombsPerKilogram);
      expect(q.relativeUncertainty, 0);

      q = new Exposure(coulombsPerKilogram: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Exposure.exposureDimensions);
      expect(q.preferredUnits, Exposure.coulombsPerKilogram);
      expect(q.relativeUncertainty, 0.001);

      q = new Exposure(R: 1);
      expect(q.valueSI?.toDouble(), 0.000258);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Exposure.exposureDimensions);
      expect(q.preferredUnits, Exposure.roentgens);
      expect(q.relativeUncertainty, 0);
    });
  });
}
