import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('ChargeDensity', () {
    test('constructors', () {
      ChargeDensity q = new ChargeDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ChargeDensity.electricChargeDensityDimensions);
      expect(q.preferredUnits, ChargeDensity.coulombsPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = new ChargeDensity(coulombsPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ChargeDensity.electricChargeDensityDimensions);
      expect(q.preferredUnits, ChargeDensity.coulombsPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
