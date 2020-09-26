import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Inductance', () {
    test('constructors', () {
      Inductance q = new Inductance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Inductance.inductanceDimensions);
      expect(q.preferredUnits, Inductance.henries);
      expect(q.relativeUncertainty, 0);

      q = new Inductance(H: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Inductance.inductanceDimensions);
      expect(q.preferredUnits, Inductance.henries);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
