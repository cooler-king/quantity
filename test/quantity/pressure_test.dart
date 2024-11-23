import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Pressure', () {
    test('constructors', () {
      var q = Pressure();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.pascals);
      expect(q.relativeUncertainty, 0);

      q = Pressure(Pa: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.pascals);
      expect(q.relativeUncertainty, 0.001);

      q = Pressure(bars: 1);
      expect(q.valueSI.toDouble(), 100000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.bars);
      expect(q.relativeUncertainty, 0);
    });

    test('force by area equation', () {
      var area = Area(m2: 1);
      var force = Force(N: 10);

      var q = force / area;
      expect(q.valueSI is Integer, true);
      expect(q.valueSI.toDouble(), 10.0);
      expect(q is Pressure, true);
    });
  });
}
