import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Illuminance', () {
    test('constructors', () {
      Illuminance q = new Illuminance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Illuminance.illuminanceDimensions);
      expect(q.preferredUnits, Illuminance.lux);
      expect(q.relativeUncertainty, 0);

      q = new Illuminance(lux: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Illuminance.illuminanceDimensions);
      expect(q.preferredUnits, Illuminance.lux);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
