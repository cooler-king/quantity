import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Entropy', () {
    test('constructors', () {
      var q = Entropy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Entropy.entropyDimensions);
      expect(q.preferredUnits, Entropy.joulesPerKelvin);
      expect(q.relativeUncertainty, 0);

      q = Entropy(joulesPerKelvin: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Entropy.entropyDimensions);
      expect(q.preferredUnits, Entropy.joulesPerKelvin);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = EntropyUnits.energyPerTemperature(
          Energy.joules, TemperatureInterval.kelvins);
      expect(u.name, 'joules per kelvin');
      expect(u.singular, 'joule per kelvin');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'J / K');
      expect(u.abbrev2, 'J K\u{207b}\u{00b9}');

      var u2 = EntropyUnits.energyPerTemperature(
          Energy.electronVolts, TemperatureInterval.degreesCelsius);
      expect(u2.name, 'electronvolts per degree Celsius');
      expect(u2.singular, 'electronvolt per degree Celsius');
      expect(u2.convToMKS.toDouble(), 1.60217653e-19);
      expect(u2.abbrev1, 'eV / deg C');
      expect(u2.abbrev2, 'eV deg C\u{207b}\u{00b9}');

      var q1 = Entropy(joulesPerKelvin: 1.60217653e-19);
      var q2 = Entropy.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
