import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('AbsorbedDoseRate', () {
    test('constructors', () {
      AbsorbedDoseRate q = new AbsorbedDoseRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AbsorbedDoseRate.absorbedDoseRateDimensions);
      expect(q.preferredUnits, AbsorbedDoseRate.graysPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new AbsorbedDoseRate(graysPerSecond: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AbsorbedDoseRate.absorbedDoseRateDimensions);
      expect(q.preferredUnits, AbsorbedDoseRate.graysPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = new AbsorbedDoseRate(radsPerSecond: 1);
      expect(q.valueSI?.toDouble(), 0.01);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, AbsorbedDoseRate.absorbedDoseRateDimensions);
      expect(q.preferredUnits, AbsorbedDoseRate.radsPerSecond);
      expect(q.relativeUncertainty, 0);
    });
  });
}
