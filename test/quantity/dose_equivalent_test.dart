import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('DoseEquivalent', () {
    test('constructors', () {
      DoseEquivalent q = new DoseEquivalent();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, DoseEquivalent.doseEquivalentDimensions);
      expect(q.preferredUnits, DoseEquivalent.seiverts);
      expect(q.relativeUncertainty, 0);

      q = new DoseEquivalent(Sv: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, DoseEquivalent.doseEquivalentDimensions);
      expect(q.preferredUnits, DoseEquivalent.seiverts);
      expect(q.relativeUncertainty, 0.001);

      q = new DoseEquivalent(rems: 1);
      expect(q.valueSI?.toDouble(), 0.01);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, DoseEquivalent.doseEquivalentDimensions);
      expect(q.preferredUnits, DoseEquivalent.rems);
      expect(q.relativeUncertainty, 0);
    });
  });
}
