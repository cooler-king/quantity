import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Energy', () {
    test('constructors', () {
      Energy q = new Energy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Energy.energyDimensions);
      expect(q.preferredUnits, Energy.joules);
      expect(q.relativeUncertainty, 0);

      q = new Energy(J: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Energy.energyDimensions);
      expect(q.preferredUnits, Energy.joules);
      expect(q.relativeUncertainty, 0.001);

      q = new Energy(eV: 1);
      expect(q.valueSI?.toDouble(), 1.60217653e-19);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Energy.energyDimensions);
      expect(q.preferredUnits, Energy.electronVolts);
      expect(q.relativeUncertainty, 0);
    });

    test('toMass', () {
      Energy e = new Energy(J: 1);
      Mass m = e.toMass();

      expect(m is Mass, true);
      expect(m.valueSI.toDouble(), 1.1126500560536185e-17);

      e = new Energy(J: 2.2);
      m = e.toMass();
      expect(m.valueSI.toDouble(), 2.447830123317961e-17);
    });
  });
}
