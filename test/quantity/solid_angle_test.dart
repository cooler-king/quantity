import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('SolidAngle', () {
    test('constructors', () {
      var q = SolidAngle();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SolidAngle.solidAngleDimensions);
      expect(q.preferredUnits, SolidAngle.steradians);
      expect(q.relativeUncertainty, 0);

      q = SolidAngle(sr: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SolidAngle.solidAngleDimensions);
      expect(q.preferredUnits, SolidAngle.steradians);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = SolidAngleUnits.angleSquared(Angle.radians);
      expect(u.name, 'radians squared');
      expect(u.singular, 'radian squared');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "rad\u{00b2}");
      expect(u.abbrev2, "rad\u{00b2}");

      var u2 = SolidAngleUnits.angleSquared(Angle.degrees);
      expect(u2.name, 'degrees squared');
      expect(u2.singular, 'degree squared');
      expect(u2.convToMKS.toDouble(),
          closeTo(0.0174532925 * 0.0174532925, .000000000001));
      expect(u2.abbrev1, "\u{00b0}\u{00b2}");
      expect(u2.abbrev2, "deg\u{00b2}");

      var q1 = SolidAngle(sr: 1.0);
      var q2 = SolidAngle.inUnits(3282.80635004, u2);
      expect(q1.valueSI.toDouble(), closeTo(q2.valueSI.toDouble(), 0.00000001));
      expect(q1.toString(), '1 sr');
      expect(q2.toString(), '3282.806 350 04 deg\u{00b2}');
    });
  });
}
