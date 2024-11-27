import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('AngularAcceleration', () {
    test('constructors', () {
      var q = AngularAcceleration();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularAcceleration.angularAccelerationDimensions);
      expect(q.preferredUnits, AngularAcceleration.radiansPerSecondSquared);
      expect(q.relativeUncertainty, 0);

      q = AngularAcceleration(radiansPerSecondSquared: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularAcceleration.angularAccelerationDimensions);
      expect(q.preferredUnits, AngularAcceleration.radiansPerSecondSquared);
      expect(q.relativeUncertainty, 0.001);

      q = AngularAcceleration(degreesPerSecondSquared: 1);
      expect(q.valueSI.toDouble(), 0.017453292519943);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, AngularAcceleration.angularAccelerationDimensions);
      expect(q.preferredUnits, AngularAcceleration.degreesPerSecondSquared);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = AngularAccelerationUnits.anglePerTimeSquared(
          Angle.radians, Time.seconds);
      expect(u.name, 'radians per second squared');
      expect(u.singular, 'radian per second squared');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'rad / sec\u{00b2}');
      expect(u.abbrev2, 'rad s\u{207b}\u{00b2}');

      var u2 = AngularAccelerationUnits.anglePerTimeSquared(
          Angle.degrees, Time.minutes);
      expect(u2.name, 'degrees per minute squared');
      expect(u2.singular, 'degree per minute squared');
      expect(u2.convToMKS.toDouble(), 1.7453292519943e-2 / (60.0 * 60.0));
      expect(u2.abbrev1, '\u{00b0} / min\u{00b2}');
      expect(u2.abbrev2, 'deg min\u{207b}\u{00b2}');

      var q1 = AngularAcceleration(
          radiansPerSecondSquared: 1.7453292519943e-2 / 3600.0);
      var q2 = AngularAcceleration.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
