import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Pressure', () {
    test('constructors', () {
      Pressure q = new Pressure();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.pascals);
      expect(q.relativeUncertainty, 0);

      q = new Pressure(Pa: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.pascals);
      expect(q.relativeUncertainty, 0.001);

      q = new Pressure(bars: 1);
      expect(q.valueSI?.toDouble(), 100000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.bars);
      expect(q.relativeUncertainty, 0);
    });
  });
}
