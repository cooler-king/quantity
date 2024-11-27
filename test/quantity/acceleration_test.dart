import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Acceleration', () {
    test('constructors', () {
      var q = Acceleration();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Acceleration.accelerationDimensions);
      expect(q.preferredUnits, Acceleration.metersPerSecondSquared);
      expect(q.relativeUncertainty, 0);

      q = Acceleration(metersPerSecondSquared: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Acceleration.accelerationDimensions);
      expect(q.preferredUnits, Acceleration.metersPerSecondSquared);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          AccelerationUnits.lengthPerTimeSquared(Length.meters, Time.seconds);
      expect(u.name, 'meters per second squared');
      expect(u.singular, 'meter per second squared');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'm / sec\u{00b2}');
      expect(u.abbrev2, 'm s\u{207b}\u{00b2}');

      var u2 = AccelerationUnits.lengthPerTimeSquared(
          Length.kilometers, Time.minutes);
      expect(u2.name, 'kilometers per minute squared');
      expect(u2.singular, 'kilometer per minute squared');
      expect(u2.convToMKS.toDouble(), 1000.0 / (60.0 * 60.0));
      expect(u2.abbrev1, 'km / min\u{00b2}');
      expect(u2.abbrev2, 'km min\u{207b}\u{00b2}');

      var q1 = Acceleration(metersPerSecondSquared: 1000.0 / (60.0 * 60.0));
      var q2 = Acceleration.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
