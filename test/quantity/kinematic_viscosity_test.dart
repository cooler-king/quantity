import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('KinematicViscosity', () {
    test('constructors', () {
      var q = KinematicViscosity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, KinematicViscosity.kinematicViscosityDimensions);
      expect(q.preferredUnits, KinematicViscosity.metersSquaredPerSecond);
      expect(q.relativeUncertainty, 0);

      q = KinematicViscosity(metersSquaredPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, KinematicViscosity.kinematicViscosityDimensions);
      expect(q.preferredUnits, KinematicViscosity.metersSquaredPerSecond);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          KinematicViscosityUnits.areaPerTime(Area.squareMeters, Time.seconds);
      expect(u.name, 'square meters per second');
      expect(u.singular, 'square meter per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'm\u{00b2} / sec');
      expect(u.abbrev2, 'm\u{00b2} s\u{207b}\u{00b9}');

      var u2 =
          KinematicViscosityUnits.areaPerTime(Area.squareMeters, Time.minutes);
      expect(u2.name, 'square meters per minute');
      expect(u2.singular, 'square meter per minute');
      expect(u2.convToMKS.toDouble(), 1.0 / 60.0);
      expect(u2.abbrev1, 'm\u{00b2} / min');
      expect(u2.abbrev2, 'm\u{00b2} min\u{207b}\u{00b9}');

      var q1 = KinematicViscosity(metersSquaredPerSecond: 1.0);
      var q2 = KinematicViscosity.inUnits(60.0, u2);
      expect(q1 == q2, true);
    });
  });
}
