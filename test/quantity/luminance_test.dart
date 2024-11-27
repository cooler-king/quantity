import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Luminance', () {
    test('constructors', () {
      var q = Luminance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Luminance.luminanceDimensions);
      expect(q.preferredUnits, Luminance.candelasPerSquareMeter);
      expect(q.relativeUncertainty, 0);

      q = Luminance(candelasPerSquareMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Luminance.luminanceDimensions);
      expect(q.preferredUnits, Luminance.candelasPerSquareMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = LuminanceUnits.intensityPerArea(
          LuminousIntensity.candelas, Area.squareMeters);
      expect(u.name, 'candelas per square meter');
      expect(u.singular, 'candela per square meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'cd / m\u{00b2}');
      expect(u.abbrev2, 'cd m\u{207b}\u{00b2}');

      var u2 = LuminanceUnits.intensityPerArea(
          LuminousIntensity.candelas, Area.hectares);
      expect(u2.name, 'candelas per hectare');
      expect(u2.singular, 'candela per hectare');
      expect(u2.convToMKS.toDouble(), 0.0001);
      expect(u2.abbrev1, 'cd / ha');
      expect(u2.abbrev2, 'cd ha\u{207b}\u{00b9}');

      var q1 = Luminance(candelasPerSquareMeter: 1.0);
      var q2 = Luminance.inUnits(10000.0, u2);
      expect(q1 == q2, true);
    });
  });
}
