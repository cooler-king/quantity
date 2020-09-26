import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Capacitance', () {
    test('constructors', () {
      Capacitance q = new Capacitance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Capacitance.electricCapacitanceDimensions);
      expect(q.preferredUnits, Capacitance.farads);
      expect(q.relativeUncertainty, 0);

      q = new Capacitance(F: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Capacitance.electricCapacitanceDimensions);
      expect(q.preferredUnits, Capacitance.farads);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
