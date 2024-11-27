import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('MolarEnergy', () {
    test('constructors', () {
      var a = MolarEnergy();
      expect(a, isNotNull);
      expect(a.valueSI, Double.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, MolarEnergy.molarEnergyDimensions);
      expect(a.preferredUnits, MolarEnergy.joulesPerMole);

      a = MolarEnergy(joulesPerMole: 2.4);
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), 2.4);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, MolarEnergy.molarEnergyDimensions);
      expect(a.preferredUnits, MolarEnergy.joulesPerMole);
    });

    test('units', () {
      var u = MolarEnergyUnits.energyPerAmount(
          Energy.joules, AmountOfSubstance.moles);
      expect(u.name, 'joules per mole');
      expect(u.singular, 'joule per mole');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'J / mol');
      expect(u.abbrev2, 'J mol\u{207b}\u{00b9}');

      var u2 = MolarEnergyUnits.energyPerAmount(
          Energy.electronVolts, AmountOfSubstance.kilomoles);
      expect(u2.name, 'electronvolts per kilomole');
      expect(u2.singular, 'electronvolt per kilomole');
      expect(u2.convToMKS.toDouble(), 1.60217653e-19 * 0.001);
      expect(u2.abbrev1, 'eV / kmol');
      expect(u2.abbrev2, 'eV kmol\u{207b}\u{00b9}');

      var q1 = MolarEnergy(joulesPerMole: 1.60217653e-22);
      var q2 = MolarEnergy.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
