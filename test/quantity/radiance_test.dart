import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Radiance', () {
    test('constructors', () {
      var q = Radiance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Radiance.radianceDimensions);
      expect(q.preferredUnits, Radiance.wattsPerSquareMeterSteradian);
      expect(q.relativeUncertainty, 0);

      q = Radiance(wattsPerSquareMeterSteradian: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Radiance.radianceDimensions);
      expect(q.preferredUnits, Radiance.wattsPerSquareMeterSteradian);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
