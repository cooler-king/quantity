import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('AmountOfSubstance', () {
    test('constructors', () {
      AmountOfSubstance q = new AmountOfSubstance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AmountOfSubstance.amountOfSubstanceDimensions);
      expect(q.preferredUnits, AmountOfSubstance.moles);
      expect(q.relativeUncertainty, 0);

      q = new AmountOfSubstance(mol: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AmountOfSubstance.amountOfSubstanceDimensions);
      expect(q.preferredUnits, AmountOfSubstance.moles);
      expect(q.relativeUncertainty, 0.001);

      q = new AmountOfSubstance(kmol: 1);
      expect(q.valueSI?.toDouble(), 1000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AmountOfSubstance.amountOfSubstanceDimensions);
      expect(q.preferredUnits, AmountOfSubstance.kilomoles);
      expect(q.relativeUncertainty, 0);
    });
  });
}
