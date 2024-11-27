import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('EnergyDensity', () {
    test('constructors', () {
      var q = EnergyDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, EnergyDensity.energyDensityDimensions);
      expect(q.preferredUnits, EnergyDensity.joulesPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = EnergyDensity(joulesPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, EnergyDensity.energyDensityDimensions);
      expect(q.preferredUnits, EnergyDensity.joulesPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          EnergyDensityUnits.energyPerVolume(Energy.joules, Volume.cubicMeters);
      expect(u.name, 'joules per cubic meter');
      expect(u.singular, 'joule per cubic meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'J / m\u{00b3}');
      expect(u.abbrev2, 'J m\u{207b}\u{00b3}');

      var u2 = EnergyDensityUnits.energyPerVolume(
          Energy.electronVolts, Volume.liters);
      expect(u2.name, 'electronvolts per liter');
      expect(u2.singular, 'electronvolt per liter');
      expect(u2.convToMKS.toDouble(), 1.60217653e-19 * 1000.0);
      expect(u2.abbrev1, 'eV / L');
      expect(u2.abbrev2, 'eV L\u{207b}\u{00b9}');

      var q1 = EnergyDensity(joulesPerCubicMeter: 1.60217653e-16);
      var q2 = EnergyDensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
