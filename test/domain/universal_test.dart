import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/domain/universal.dart';

main() {
  group('Universal', () {
    test('constants', () {
      expect(characteristicImpedanceOfVacuum is Resistance, true);
      expect(characteristicImpedanceOfVacuum.valueSI.toDouble(), 376.730313461);
      expect(characteristicImpedanceOfVacuum.relativeUncertainty, 0.0);

      expect(speedOfLightVacuum is Speed, true);
      expect(speedOfLightVacuum.valueSI.toDouble(), 2.99792458e8);
      expect(speedOfLightVacuum.relativeUncertainty, 0.0);

      expect(magneticConstant is Permeability, true);
      expect(magneticConstant.valueSI.toDouble(), 4.0e-7 * PI);
      expect(magneticConstant.relativeUncertainty, 0.0);

      expect(planckConstant is AngularMomentum, true);
      expect(planckConstant.valueSI.toDouble(), 6.626070040e-34);
      expect(planckConstant.relativeUncertainty, 1.2e-8);

      expect(hBar is AngularMomentum, true);
      expect(hBar.valueSI.toDouble(), 1.054571800e-34);
      expect(hBar.relativeUncertainty, 1.2e-8);

      expect(planckLength is Length, true);
      expect(planckLength.valueSI.toDouble(), 1.616229e-35);
      expect(planckLength.relativeUncertainty, 2.3e-5);

      expect(planckMass is Mass, true);
      expect(planckMass.valueSI.toDouble(), 2.176470e-8);
      expect(planckMass.relativeUncertainty, 2.3e-5);

      expect(planckTemperature is Temperature, true);
      expect(planckTemperature.valueSI.toDouble(), 1.416808e32);
      expect(planckTemperature.relativeUncertainty, 2.3e-5);

      expect(planckTime is Time, true);
      expect(planckTime.valueSI.toDouble(), 5.39116e-44);
      expect(planckTime.relativeUncertainty, 2.3e-5);

      expect(electricConstant is Permittivity, true);
      expect(electricConstant.valueSI.toDouble(), 8.854187817e-12);
      expect(electricConstant.relativeUncertainty, 0.0);

      expect(newtonianConstantOfGravitation is MiscQuantity, true);
      expect(newtonianConstantOfGravitation.valueSI.toDouble(), 6.67408e-11);
      expect(newtonianConstantOfGravitation.relativeUncertainty, 4.7e-5);

      expect(rydberg is WaveNumber, true);
      expect(rydberg.valueSI.toDouble(), 10973731.568508);
      expect(rydberg.relativeUncertainty, 5.9e-12);
    });

    test('synonyms', () {
      expect(c, speedOfLightVacuum);
      expect(c0, c);
      expect(mu0, magneticConstant);
      expect(eps0 == magneticConstant, false);
      expect(eps0, electricConstant);
      expect(Z0, characteristicImpedanceOfVacuum);
      expect(G, newtonianConstantOfGravitation);
      expect(h, planckConstant);
    });
  });
}
