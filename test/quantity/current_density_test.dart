import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('CurrentDensity', () {
    test('constructors', () {
      var q = CurrentDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, CurrentDensity.electricCurrentDensityDimensions);
      expect(q.preferredUnits, CurrentDensity.amperesPerSquareMeter);
      expect(q.relativeUncertainty, 0);

      q = CurrentDensity(amperesPerSquareMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, CurrentDensity.electricCurrentDensityDimensions);
      expect(q.preferredUnits, CurrentDensity.amperesPerSquareMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = CurrentDensityUnits.currentPerArea(
          Current.amperes, Area.squareMeters);
      expect(u.name, 'amperes per square meter');
      expect(u.singular, 'ampere per square meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'A / m\u{00b2}');
      expect(u.abbrev2, 'A m\u{207b}\u{00b2}');

      var u2 =
          CurrentDensityUnits.currentPerArea(Current.amperes, Area.hectares);
      expect(u2.name, 'amperes per hectare');
      expect(u2.singular, 'ampere per hectare');
      expect(u2.convToMKS.toDouble(), 0.0001);
      expect(u2.abbrev1, 'A / ha');
      expect(u2.abbrev2, 'A ha\u{207b}\u{00b9}');

      var q1 = CurrentDensity(amperesPerSquareMeter: 0.0001);
      var q2 = CurrentDensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
