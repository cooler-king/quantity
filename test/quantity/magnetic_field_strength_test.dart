import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('MagneticFieldStrength', () {
    test('constructors', () {
      var q = MagneticFieldStrength();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(
          q.dimensions, MagneticFieldStrength.magneticFieldStrengthDimensions);
      expect(q.preferredUnits, MagneticFieldStrength.amperesPerMeter);
      expect(q.relativeUncertainty, 0);

      q = MagneticFieldStrength(amperesPerMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(
          q.dimensions, MagneticFieldStrength.magneticFieldStrengthDimensions);
      expect(q.preferredUnits, MagneticFieldStrength.amperesPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = MagneticFieldStrengthUnits.currentPerLength(
          Current.amperes, Length.meters);
      expect(u.name, 'amperes per meter');
      expect(u.singular, 'ampere per meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'A / m');
      expect(u.abbrev2, 'A m\u{207b}\u{00b9}');

      var u2 = MagneticFieldStrengthUnits.currentPerLength(
          Current.amperes, Length.millimeters);
      expect(u2.name, 'amperes per millimeter');
      expect(u2.singular, 'ampere per millimeter');
      expect(u2.convToMKS.toDouble(), 1000.0);
      expect(u2.abbrev1, 'A / mm');
      expect(u2.abbrev2, 'A mm\u{207b}\u{00b9}');

      var q1 = MagneticFieldStrength(amperesPerMeter: 1000.0);
      var q2 = MagneticFieldStrength.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
