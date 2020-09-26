import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Conductance', () {
    test('constructors', () {
      Conductance q = new Conductance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Conductance.electricConductanceDimensions);
      expect(q.preferredUnits, Conductance.siemens);
      expect(q.relativeUncertainty, 0);

      q = new Conductance(S: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Conductance.electricConductanceDimensions);
      expect(q.preferredUnits, Conductance.siemens);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
