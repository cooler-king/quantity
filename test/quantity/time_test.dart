import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Time', () {
    test('constructors', () {
      var q = Time();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.seconds);
      expect(q.relativeUncertainty, 0);

      q = Time(s: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.seconds);
      expect(q.relativeUncertainty, 0.001);

      q = Time(ns: 1);
      expect(q.valueSI.toDouble(), 0.000000001);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.nanoseconds);
      expect(q.relativeUncertainty, 0);

      q = Time(ms: 1);
      expect(q.valueSI.toDouble(), 0.001);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.milliseconds);
      expect(q.relativeUncertainty, 0);

      q = Time(min: 1);
      expect(q.valueSI.toDouble(), 60);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.minutes);
      expect(q.relativeUncertainty, 0);

      q = Time(h: 1);
      expect(q.valueSI.toDouble(), 3600);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.hours);
      expect(q.relativeUncertainty, 0);

      q = Time(d: 1);
      expect(q.valueSI.toDouble(), 86400);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Time.timeDimensions);
      expect(q.preferredUnits, Time.days);
      expect(q.relativeUncertainty, 0);
    });

    test('duration and constant conversions', () {
      const constTime = Time.constant(Double.constant(5));
      expect(constTime.valueSI.toDouble(), 5.0);

      final runTime = Time.constant(Double(5));
      expect(runTime.valueSI.toDouble(), 5.0);

      final tFromDuration =
          Time.fromDuration(const Duration(seconds: 12, microseconds: 345));
      expect(tFromDuration.valueSI.toDouble(), 12.000345);

      final durationBack = tFromDuration.toDuration();
      expect(durationBack.inMicroseconds, 12000345);
    });
  });
}
