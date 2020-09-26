import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('MolarEntropy', () {
    test('constructors', () {
      MolarEntropy q = new MolarEntropy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MolarEntropy.molarEntropyDimensions);
      expect(q.preferredUnits, MolarEntropy.joulesPerMoleKelvin);
      expect(q.relativeUncertainty, 0);

      q = new MolarEntropy(joulesPerMoleKelvin: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MolarEntropy.molarEntropyDimensions);
      expect(q.preferredUnits, MolarEntropy.joulesPerMoleKelvin);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
