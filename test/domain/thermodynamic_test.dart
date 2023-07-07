import 'package:test/test.dart';
import 'package:quantity/domain/thermodynamic.dart';

void main() {
  group('Thermodynamic', () {
    test('units', () {
      expect(unifiedAtomicMassUnits.toMks(1).toDouble(), 1.66053886e-27);
      expect(boltzmannUnit.toMks(1).toDouble(), 1.3806503e-23);
    });

    test('constants', () {
      expect(boltzmannConstant.valueSI.toDouble(), 1.380649e-23);
      expect(sackurTetrode100kPa.valueSI.toDouble(), -1.15170753706);
      expect(sackurTetrodeStdAtm.valueSI.toDouble(), -1.16487052358);
      expect(avogadro.valueSI.toDouble(), 6.02214076e23);
      expect(faradayConstant.valueSI.toDouble(), 96485.332122222222);
      expect(firstRadiationConstant.valueSI.toDouble(), 3.7417718522222222e-16);
      expect(loschmidtStdAtm.valueSI.toDouble(), 2.6867801111111111e25);
      expect(molarPlanck.valueSI.toDouble(), 3.9903127122222222e-10);
      expect(molarVolume100kPa.valueSI.toDouble(), 22.710954644444444e-3);
      expect(molarVolumeStdAtm.valueSI.toDouble(), 22.413969544444444e-3);
      expect(secondRadiationConstant.valueSI.toDouble(), 1.4387768777777777e-2);
      expect(stefanBoltzmann.valueSI.toDouble(), 5.6703744199999999e-8);
      expect(wienDisplacement.valueSI.toDouble(), 2.8977719555555555e-3);
    });

    test('synonyms', () {
      expect(NA, avogadro);
      expect(L, avogadro);
      expect(k, boltzmannConstant);
    });
  });
}
