import 'package:test/test.dart';
import 'package:quantity/domain/chemistry.dart';

void main() {
  group('Chemistry Domain', () {
    test('constants', () {
      expect(avogadro.valueSI.toDouble(), 6.02214076e+23);
      expect(gasConstantMolar.valueSI.toDouble(), 8.314462618);
      expect(faradayConstant.valueSI.toDouble(), 96485.33212);
      expect(atomicMass.valueSI.toDouble(), 1.66053906892e-27);
      expect(loschmidtStdAtm.valueSI.toDouble(), 2.686780111e+25);
    });

    test('units', () {
      expect(moles, isA<AmountOfSubstanceUnits>());
    });
  });
}
