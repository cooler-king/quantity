import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Luminance', () {
    test('constructors', () {
      Luminance q = new Luminance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Luminance.luminanceDimensions);
      expect(q.preferredUnits, Luminance.candelasPerSquareMeter);
      expect(q.relativeUncertainty, 0);

      q = new Luminance(candelasPerSquareMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Luminance.luminanceDimensions);
      expect(q.preferredUnits, Luminance.candelasPerSquareMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
