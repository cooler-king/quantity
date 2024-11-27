import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('WaveNumber', () {
    test('constructors', () {
      var q = WaveNumber();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, WaveNumber.waveNumberDimensions);
      expect(q.preferredUnits, WaveNumber.reciprocalMeters);
      expect(q.relativeUncertainty, 0);

      q = WaveNumber(reciprocalMeters: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, WaveNumber.waveNumberDimensions);
      expect(q.preferredUnits, WaveNumber.reciprocalMeters);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = WaveNumberUnits.inverseLength(Length.meters);
      expect(u.name, 'reciprocal meters');
      expect(u.singular, 'reciprocal meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "1 / m");
      expect(u.abbrev2, "m\u{207b}\u{00b9}");

      var u2 = WaveNumberUnits.inverseLength(Length.kilometers);
      expect(u2.name, 'reciprocal kilometers');
      expect(u2.singular, 'reciprocal kilometer');
      expect(u2.convToMKS.toDouble(), 0.001);
      expect(u2.abbrev1, "1 / km");
      expect(u2.abbrev2, "km\u{207b}\u{00b9}");

      var q1 = WaveNumber(reciprocalMeters: 1.0);
      var q2 = WaveNumber.inUnits(1000.0, u2);
      expect(q1 == q2, true);
      expect(q1.toString(), '1 m\u{207b}\u{00b9}');
      expect(q2.toString(), '1000 km\u{207b}\u{00b9}');
    });
  });
}
