import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Speed', () {
    test('constructors', () {
      var q = Speed();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Speed.speedDimensions);
      expect(q.preferredUnits, Speed.metersPerSecond);
      expect(q.relativeUncertainty, 0);

      q = Speed(metersPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Speed.speedDimensions);
      expect(q.preferredUnits, Speed.metersPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = Speed(knots: 1);
      expect(q.valueSI.toDouble(), 5.144444444e-1);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Speed.speedDimensions);
      expect(q.preferredUnits, Speed.knots);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = SpeedUnits.lengthPerTime(Length.meters, Time.seconds);
      expect(u.name, 'meters per second');
      expect(u.singular, 'meter per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "m / sec");
      expect(u.abbrev2, "m s\u{207b}\u{00b9}");

      var kph = SpeedUnits.lengthPerTime(Length.kilometers, Time.minutes);
      expect(kph.name, 'kilometers per minute');
      expect(kph.singular, 'kilometer per minute');
      expect(kph.convToMKS.toDouble(), 1000.0 / 60.0);
      expect(kph.abbrev1, "km / min");
      expect(kph.abbrev2, "km min\u{207b}\u{00b9}");

      var q1 = Speed(metersPerSecond: 1.0);
      var q2 = Speed.inUnits(0.06, kph);
      expect(q1 == q2, true);
      expect(q1.toString(), '1 m s\u{207b}\u{00b9}');
      expect(q2.toString(), '0.06 km min\u{207b}\u{00b9}');
    });
  });
}
