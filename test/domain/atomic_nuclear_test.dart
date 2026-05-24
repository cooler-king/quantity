import 'package:test/test.dart';
import 'package:quantity/domain/atomic_nuclear.dart';

void main() {
  group('Atomic/Nuclear Domain', () {
    test('constants', () {
      expect(alphaParticleMass.valueSI.toDouble(), 6.644657345e-27);
      expect(electronMass.valueSI.toDouble(), 9.1093837139e-31);
      expect(protonMass.valueSI.toDouble(), 1.67262192595e-27);
      expect(neutronMass.valueSI.toDouble(), 1.67492750056e-27);
      expect(elementaryCharge.valueSI.toDouble(), 1.602176634e-19);
      expect(planckConstant.valueSI.toDouble(), 6.62607015e-34);
      expect(fineStructureConstant.valueSI.toDouble(), 0.0072973525643);
      expect(rydberg.valueSI.toDouble(), 10973731.568157);
      expect(bohrRadius.valueSI.toDouble(), 5.29177210544e-11);
      expect(comptonWavelength.valueSI.toDouble(), 2.42631023538e-12);
      expect(classicalElectronRadius.valueSI.toDouble(), 2.8179403205e-15);
    });

    test('units', () {
      expect(barns, isA<AreaUnits>());
      expect(Activity.becquerels, isA<ActivityUnits>());
      expect(Activity.curies, isA<ActivityUnits>());
      expect(AbsorbedDose.grays, isA<AbsorbedDoseUnits>());
      expect(AbsorbedDose.rads, isA<AbsorbedDoseUnits>());
      expect(DoseEquivalent.seiverts, isA<DoseEquivalentUnits>());
      expect(DoseEquivalent.rems, isA<DoseEquivalentUnits>());
      expect(electronVolts, isA<EnergyUnits>());
    });
  });
}
