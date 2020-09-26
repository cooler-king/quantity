import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Mass', () {
    test('constructors', () {
      Mass q = new Mass();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Mass.massDimensions);
      expect(q.preferredUnits, Mass.kilograms);
      expect(q.relativeUncertainty, 0);

      q = new Mass(kg: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Mass.massDimensions);
      expect(q.preferredUnits, Mass.kilograms);
      expect(q.relativeUncertainty, 0.001);

      q = new Mass(g: 1);
      expect(q.valueSI?.toDouble(), 0.001);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Mass.massDimensions);
      expect(q.preferredUnits, Mass.grams);
      expect(q.relativeUncertainty, 0);

      q = new Mass(u: 1);
      expect(q.valueSI?.toDouble(), 1.66053886e-27);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Mass.massDimensions);
      expect(q.preferredUnits, Mass.unifiedAtomicMassUnits);
      expect(q.relativeUncertainty, 0);
    });

    test('toEnergy', () {
      Mass m = new Mass(kg: 1);
      Energy e = m.toEnergy();

      expect(e is Energy, true);
      expect(e.valueSI.toDouble(), 8.9875517873681764e16);

      m = new Mass(g: 1);
      e = m.toEnergy();
      expect(e.valueSI.toDouble(), 8.9875517873681764e13);

      m = new Mass(kg: 2.2);
      e = m.toEnergy();
      expect(e.valueSI.toDouble(), 1.97726139322099870e17);
    });
  });
}
