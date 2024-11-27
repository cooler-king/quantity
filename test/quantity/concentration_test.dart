import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Concentration', () {
    test('constructors', () {
      var q = Concentration();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Concentration.concentrationDimensions);
      expect(q.preferredUnits, Concentration.molesPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = Concentration(molesPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Concentration.concentrationDimensions);
      expect(q.preferredUnits, Concentration.molesPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = ConcentrationUnits.amountPerVolume(
          AmountOfSubstance.moles, Volume.cubicMeters);
      expect(u.name, 'moles per cubic meter');
      expect(u.singular, 'mole per cubic meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'mol / m\u{00b3}');
      expect(u.abbrev2, 'mol m\u{207b}\u{00b3}');

      var u2 = ConcentrationUnits.amountPerVolume(
          AmountOfSubstance.kilomoles, Volume.liters);
      expect(u2.name, 'kilomoles per liter');
      expect(u2.singular, 'kilomole per liter');
      expect(u2.convToMKS.toDouble(), 1000000.0);
      expect(u2.abbrev1, 'kmol / L');
      expect(u2.abbrev2, 'kmol L\u{207b}\u{00b9}');

      var q1 = Concentration(molesPerCubicMeter: 1000000.0);
      var q2 = Concentration.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
