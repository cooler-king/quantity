import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('AngularSpeed', () {
    test('constructors', () {
      var q = AngularSpeed();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularSpeed.angularSpeedDimensions);
      expect(q.preferredUnits, AngularSpeed.radiansPerSecond);
      expect(q.relativeUncertainty, 0);

      q = AngularSpeed(radiansPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularSpeed.angularSpeedDimensions);
      expect(q.preferredUnits, AngularSpeed.radiansPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = AngularSpeed(degreesPerSecond: 1);
      expect(q.valueSI.toDouble(), 0.017453292519943);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, AngularSpeed.angularSpeedDimensions);
      expect(q.preferredUnits, AngularSpeed.degreesPerSecond);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = AngularSpeedUnits.anglePerTime(Angle.radians, Time.seconds);
      expect(u.name, 'radians per second');
      expect(u.singular, 'radian per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'rad / sec');
      expect(u.abbrev2, 'rad s\u{207b}\u{00b9}');

      var u2 = AngularSpeedUnits.anglePerTime(Angle.degrees, Time.hours);
      expect(u2.name, 'degrees per hour');
      expect(u2.singular, 'degree per hour');
      expect(u2.convToMKS.toDouble(), 1.7453292519943e-2 / 3600.0);
      expect(u2.abbrev1, '\u{00b0} / hrs');
      expect(u2.abbrev2, 'deg h\u{207b}\u{00b9}');

      var q1 = AngularSpeed(radiansPerSecond: 1.7453292519943e-2 / 3600.0);
      var q2 = AngularSpeed.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
