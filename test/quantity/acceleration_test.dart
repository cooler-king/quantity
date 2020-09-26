import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Acceleration', () {
    test('constructors', () {
      Acceleration q = new Acceleration();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Acceleration.accelerationDimensions);
      expect(q.preferredUnits, Acceleration.metersPerSecondSquared);
      expect(q.relativeUncertainty, 0);

      q = new Acceleration(metersPerSecondSquared: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Acceleration.accelerationDimensions);
      expect(q.preferredUnits, Acceleration.metersPerSecondSquared);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
