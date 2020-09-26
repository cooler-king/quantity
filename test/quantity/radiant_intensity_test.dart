import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('RadiantIntensity', () {
    test('constructors', () {
      RadiantIntensity q = new RadiantIntensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, RadiantIntensity.radiantIntensityDimensions);
      expect(q.preferredUnits, RadiantIntensity.wattsPerSteradian);
      expect(q.relativeUncertainty, 0);

      q = new RadiantIntensity(wattsPerSteradian: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, RadiantIntensity.radiantIntensityDimensions);
      expect(q.preferredUnits, RadiantIntensity.wattsPerSteradian);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
