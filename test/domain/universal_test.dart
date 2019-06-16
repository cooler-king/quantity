import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/domain/universal.dart';

void main() {
  group('Universal', () {
    test('constants', () {
      expect(characteristicImpedanceOfVacuum is Resistance, true);
      expect(characteristicImpedanceOfVacuum.valueSI.toDouble(), 376.730313461);

      expect(speedOfLightVacuum is Speed, true);
      expect(speedOfLightVacuum.valueSI.toDouble(), 2.99792458e8);

      expect(vacuumMagneticPermeability is Permeability, true);
      expect(vacuumMagneticPermeability.valueSI.toDouble(), 4.0e-7 * pi);

      expect(planckConstant is AngularMomentum, true);
      expect(planckConstant.valueSI.toDouble(), 6.626070040e-34);

      expect(hBar is AngularMomentum, true);
      expect(hBar.valueSI.toDouble(), 1.054571800e-34);

      expect(planckLength is Length, true);
      expect(planckLength.valueSI.toDouble(), 1.616229e-35);

      expect(planckMass is Mass, true);
      expect(planckMass.valueSI.toDouble(), 2.176470e-8);

      expect(planckTemperature is Temperature, true);
      expect(planckTemperature.valueSI.toDouble(), 1.416808e32);

      expect(planckTime is Time, true);
      expect(planckTime.valueSI.toDouble(), 5.39116e-44);

      expect(vacuumElectricPermittivity is Permittivity, true);
      expect(vacuumElectricPermittivity.valueSI.toDouble(), 8.854187817e-12);

      expect(newtonianConstantOfGravitation is MiscQuantity, true);
      expect(newtonianConstantOfGravitation.valueSI.toDouble(), 6.67408e-11);

      expect(rydberg is WaveNumber, true);
      expect(rydberg.valueSI.toDouble(), 10973731.568508);
    });

    test('synonyms', () {
      expect(c, speedOfLightVacuum);
      expect(c0, c);
      expect(mu0, vacuumMagneticPermeability);
      expect(eps0 == vacuumMagneticPermeability, false);
      expect(eps0, vacuumElectricPermittivity);
      expect(Z0, characteristicImpedanceOfVacuum);
      expect(G, newtonianConstantOfGravitation);
      expect(h, planckConstant);
    });
  });
}
