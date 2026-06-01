import 'package:quantity/domain/thermodynamic.dart';
import 'package:test/test.dart';

void main() {
  group('Thermodynamic', () {
    test('units', () {
      expect(unifiedAtomicMassUnits.toMks(1).toDouble(), 1.66053886e-27);
      expect(boltzmannUnit.toMks(1).toDouble(), 1.3806503e-23);
    });

    test('constants', () {
      expect(boltzmannConstant.valueSI.toDouble(), 1.380649e-23);
      expect(sackurTetrode100kPa.valueSI.toDouble(), -1.15170753496);
      expect(sackurTetrodeStdAtm.valueSI.toDouble(), -1.16487052149);
      expect(avogadro.valueSI.toDouble(), 6.02214076e+23);
      expect(faradayConstant.valueSI.toDouble(), 96485.33212);
      expect(firstRadiationConstant.valueSI.toDouble(), 3.741771852e-16);
      expect(loschmidtStdAtm.valueSI.toDouble(), 2.686780111e+25);
      expect(molarPlanck.valueSI.toDouble(), 3.990312712e-10);
      expect(molarVolume100kPa.valueSI.toDouble(), 0.02271095464);
      expect(molarVolumeStdAtm.valueSI.toDouble(), 0.02241396954);
      expect(secondRadiationConstant.valueSI.toDouble(), 0.01438776877);
      expect(stefanBoltzmann.valueSI.toDouble(), 5.670374419e-8);
      expect(wienDisplacement.valueSI.toDouble(), 0.002897771955);
    });

    test('synonyms', () {
      expect(NA, avogadro);
      expect(L, avogadro);
      expect(k, boltzmannConstant);
    });
  });
}
