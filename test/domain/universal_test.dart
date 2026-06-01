import 'package:quantity/domain/universal.dart';
import 'package:test/test.dart';

void main() {
  group('Universal', () {
    test('constants', () {
      expect(characteristicImpedanceOfVacuum.valueSI.toDouble(), 376.730313412);
      expect(speedOfLightVacuum.valueSI.toDouble(), 299792458.0);
      expect(
          vacuumMagneticPermeability.valueSI.toDouble(), 0.00000125663706127);
      expect(planckConstant.valueSI.toDouble(), 6.62607015e-34);
      expect(hBar.valueSI.toDouble(), 1.054571817e-34);
      expect(planckLength.valueSI.toDouble(), 1.616255e-35);
      expect(planckMass.valueSI.toDouble(), 2.176434e-8);
      expect(planckTemperature.valueSI.toDouble(), 1.416784e+32);
      expect(planckTime.valueSI.toDouble(), 5.391247e-44);
      expect(vacuumElectricPermittivity.valueSI.toDouble(), 8.8541878188e-12);
      expect(newtonianConstantOfGravitation.valueSI.toDouble(), 6.6743e-11);
      expect(rydberg.valueSI.toDouble(), 10973731.568157);
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
