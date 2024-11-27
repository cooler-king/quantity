import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('ElectricFieldStrength', () {
    test('constructors', () {
      var q = ElectricFieldStrength();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(
          q.dimensions, ElectricFieldStrength.electricFieldStrengthDimensions);
      expect(q.preferredUnits, ElectricFieldStrength.voltsPerMeter);
      expect(q.relativeUncertainty, 0);

      q = ElectricFieldStrength(voltsPerMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(
          q.dimensions, ElectricFieldStrength.electricFieldStrengthDimensions);
      expect(q.preferredUnits, ElectricFieldStrength.voltsPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = ElectricFieldStrengthUnits.potentialPerLength(
          ElectricPotentialDifference.volts, Length.meters);
      expect(u.name, 'volts per meter');
      expect(u.singular, 'volt per meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'V / m');
      expect(u.abbrev2, 'V m\u{207b}\u{00b9}');

      var u2 = ElectricFieldStrengthUnits.potentialPerLength(
          ElectricPotentialDifference.volts, Length.kilometers);
      expect(u2.name, 'volts per kilometer');
      expect(u2.singular, 'volt per kilometer');
      expect(u2.convToMKS.toDouble(), 0.001);
      expect(u2.abbrev1, 'V / km');
      expect(u2.abbrev2, 'V km\u{207b}\u{00b9}');

      var q1 = ElectricFieldStrength(voltsPerMeter: 0.001);
      var q2 = ElectricFieldStrength.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
