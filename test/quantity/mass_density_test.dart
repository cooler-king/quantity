import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('MassDensity', () {
    test('constructors', () {
      MassDensity q = new MassDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassDensity.massDensityDimensions);
      expect(q.preferredUnits, MassDensity.kilogramsPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = new MassDensity(kilogramsPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassDensity.massDensityDimensions);
      expect(q.preferredUnits, MassDensity.kilogramsPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
