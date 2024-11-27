import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('MolarEntropy', () {
    test('constructors', () {
      var q = MolarEntropy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MolarEntropy.molarEntropyDimensions);
      expect(q.preferredUnits, MolarEntropy.joulesPerMoleKelvin);
      expect(q.relativeUncertainty, 0);

      q = MolarEntropy(joulesPerMoleKelvin: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MolarEntropy.molarEntropyDimensions);
      expect(q.preferredUnits, MolarEntropy.joulesPerMoleKelvin);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = MolarEntropyUnits.energyPerAmountTemperature(
          Energy.joules, AmountOfSubstance.moles, TemperatureInterval.kelvins);
      expect(u.name, 'joules per mole kelvin');
      expect(u.singular, 'joule per mole kelvin');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'J / mol K');
      expect(u.abbrev2, 'J mol\u{207b}\u{00b9} K\u{207b}\u{00b9}');

      var u2 = MolarEntropyUnits.energyPerAmountTemperature(
          Energy.electronVolts,
          AmountOfSubstance.kilomoles,
          TemperatureInterval.degreesCelsius);
      expect(u2.name, 'electronvolts per kilomole degree Celsius');
      expect(u2.singular, 'electronvolt per kilomole degree Celsius');
      expect(u2.convToMKS.toDouble(), 1.60217653e-19 * 0.001);
      expect(u2.abbrev1, 'eV / kmol deg C');
      expect(u2.abbrev2, 'eV kmol\u{207b}\u{00b9} deg C\u{207b}\u{00b9}');

      var q1 = MolarEntropy(joulesPerMoleKelvin: 1.60217653e-22);
      var q2 = MolarEntropy.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
