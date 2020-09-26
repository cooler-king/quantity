import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Entropy', () {
    test('constructors', () {
      Entropy q = new Entropy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Entropy.entropyDimensions);
      expect(q.preferredUnits, Entropy.joulesPerKelvin);
      expect(q.relativeUncertainty, 0);

      q = new Entropy(joulesPerKelvin: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Entropy.entropyDimensions);
      expect(q.preferredUnits, Entropy.joulesPerKelvin);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
