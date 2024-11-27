import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Area', () {
    test('constructors', () {
      var q = Area();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Area.areaDimensions);
      expect(q.preferredUnits, Area.squareMeters);
      expect(q.relativeUncertainty, 0);

      q = Area(m2: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Area.areaDimensions);
      expect(q.preferredUnits, Area.squareMeters);
      expect(q.relativeUncertainty, 0.001);

      q = Area(b: 1);
      expect(q.valueSI.toDouble(), 1.0e-28);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Area.areaDimensions);
      expect(q.preferredUnits, Area.barns);
      expect(q.relativeUncertainty, 0);

      q = Area(ha: 1);
      expect(q.valueSI.toDouble(), 10000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Area.areaDimensions);
      expect(q.preferredUnits, Area.hectares);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = AreaUnits.lengthSquared(Length.meters);
      expect(u.name, 'square meters');
      expect(u.singular, 'square meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'm\u{00b2}');
      expect(u.abbrev2, 'm\u{00b2}');

      var u2 = AreaUnits.lengthSquared(Length.nanometers);
      expect(u2.name, 'square nanometers');
      expect(u2.singular, 'square nanometer');
      expect(u2.convToMKS.toDouble(), 1.0e-18);
      expect(u2.abbrev1, 'nm\u{00b2}');
      expect(u2.abbrev2, 'nm\u{00b2}');

      var q1 = Area(m2: 1.0e-18);
      var q2 = Area.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
