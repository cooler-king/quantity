import 'package:test/test.dart';
import 'package:quantity/domain/thermodynamic.dart';

main() {
  group('Thermodynamic', () {
    test('units', () {
      expect(unifiedAtomicMassUnits is MassUnits, true);
      expect(unifiedAtomicMassUnits.toMks(1).toDouble(), 1.66053886e-27);

      expect(boltzmannUnit is EntropyUnits, true);
      expect(boltzmannUnit.toMks(1).toDouble(), 1.3806503e-23);
    });

    test('constants', () {
      expect(boltzmannConstant is Entropy, true);
      expect(boltzmannConstant.valueSI.toDouble(), 1.38064852e-23);
      expect(boltzmannConstant.relativeUncertainty, 5.7e-7);

      expect(sackurTetrode100kPa is Entropy, true);
      expect(sackurTetrode100kPa.valueSI.toDouble(), -1.1517084);
      expect(sackurTetrode100kPa.relativeUncertainty, 1.2e-6);

      expect(sackurTetrodeStdAtm is Entropy, true);
      expect(sackurTetrodeStdAtm.valueSI.toDouble(), -1.1648714);
      expect(sackurTetrodeStdAtm.relativeUncertainty, 1.2e-6);

      expect(avogadro is MiscQuantity, true);
      expect(avogadro.valueSI.toDouble(), 6.022140857e23);
      expect(avogadro.relativeUncertainty, 1.2e-8);

      expect(faradayConstant is MiscQuantity, true);
      expect(faradayConstant.valueSI.toDouble(), 96485.33289);
      expect(faradayConstant.relativeUncertainty, 6.2e-9);

      expect(firstRadiationConstant is MiscQuantity, true);
      expect(firstRadiationConstant.valueSI.toDouble(), 3.741771790e-16);
      expect(firstRadiationConstant.relativeUncertainty, 1.2e-8);

      expect(loschmidtStdAtm is MiscQuantity, true);
      expect(loschmidtStdAtm.valueSI.toDouble(), 2.6867811e25);
      expect(loschmidtStdAtm.relativeUncertainty, 5.7e-7);

      expect(molarPlanck is MiscQuantity, true);
      expect(molarPlanck.valueSI.toDouble(), 3.9903127110e-10);
      expect(molarPlanck.relativeUncertainty, 4.5e-10);

      expect(molarVolume100kPa is MiscQuantity, true);
      expect(molarVolume100kPa.valueSI.toDouble(), 22.710947e-3);
      expect(molarVolume100kPa.relativeUncertainty, 5.7e-7);

      expect(molarVolumeStdAtm is MiscQuantity, true);
      expect(molarVolumeStdAtm.valueSI.toDouble(), 22.413962e-3);
      expect(molarVolumeStdAtm.relativeUncertainty, 5.7e-7);

      expect(secondRadiationConstant is MiscQuantity, true);
      expect(secondRadiationConstant.valueSI.toDouble(), 1.43877736e-2);
      expect(secondRadiationConstant.relativeUncertainty, 5.7e-7);

      expect(stefanBoltzmann is MiscQuantity, true);
      expect(stefanBoltzmann.valueSI.toDouble(), 5.670367e-8);
      expect(stefanBoltzmann.relativeUncertainty, 2.3e-6);

      expect(wienDisplacement is MiscQuantity, true);
      expect(wienDisplacement.valueSI.toDouble(), 2.8977729e-3);
      expect(wienDisplacement.relativeUncertainty, 5.7e-7);
    });

    test('synonyms', () {
      expect(NA, avogadro);
      expect(L, avogadro);
      expect(k, boltzmannConstant);
    });
  });
}
