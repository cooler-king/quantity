import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('MagneticFieldStrength', () {
    test('constructors', () {
      MagneticFieldStrength q = new MagneticFieldStrength();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MagneticFieldStrength.magneticFieldStrengthDimensions);
      expect(q.preferredUnits, MagneticFieldStrength.amperesPerMeter);
      expect(q.relativeUncertainty, 0);

      q = new MagneticFieldStrength(amperesPerMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MagneticFieldStrength.magneticFieldStrengthDimensions);
      expect(q.preferredUnits, MagneticFieldStrength.amperesPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
