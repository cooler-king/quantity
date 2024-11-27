import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('ChargeDensity', () {
    test('constructors', () {
      var q = ChargeDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ChargeDensity.electricChargeDensityDimensions);
      expect(q.preferredUnits, ChargeDensity.coulombsPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = ChargeDensity(coulombsPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ChargeDensity.electricChargeDensityDimensions);
      expect(q.preferredUnits, ChargeDensity.coulombsPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = ChargeDensityUnits.chargePerVolume(
          Charge.coulombs, Volume.cubicMeters);
      expect(u.name, 'coulombs per cubic meter');
      expect(u.singular, 'coulomb per cubic meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'C / m\u{00b3}');
      expect(u.abbrev2, 'C m\u{207b}\u{00b3}');

      var u2 =
          ChargeDensityUnits.chargePerVolume(Charge.coulombs, Volume.liters);
      expect(u2.name, 'coulombs per liter');
      expect(u2.singular, 'coulomb per liter');
      expect(u2.convToMKS.toDouble(), 1000.0);
      expect(u2.abbrev1, 'C / L');
      expect(u2.abbrev2, 'C L\u{207b}\u{00b9}');

      var q1 = ChargeDensity(coulombsPerCubicMeter: 1000.0);
      var q2 = ChargeDensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
