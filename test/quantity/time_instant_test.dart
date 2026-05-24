import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('TimeInstant', () {
    test('constructors', () {
      var q = TimeInstant();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, TimeInstant.timeInstantDimensions);
      expect(q.preferredUnits, TimeInstant.TAI);
      expect(q.relativeUncertainty, 0);

      q = TimeInstant(TAI: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, TimeInstant.timeInstantDimensions);
      expect(q.preferredUnits, TimeInstant.TAI);
      expect(q.relativeUncertainty, 0.001);

      q = TimeInstant(UTC: 1900000000);
      expect(q.valueSI.toDouble(), 1900000037);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, TimeInstant.timeInstantDimensions);
      expect(q.preferredUnits, TimeInstant.UTC);
      expect(q.relativeUncertainty, 0);
    });

    test('nearestDateTime', () {
      final t = TimeInstant.dateTime(DateTime(2015, 9, 23));
      final nearest = t.nearestDateTime;
      expect(nearest, isNotNull);
      expect(nearest.year, 2015);
      expect(nearest.month, 9);
      expect(nearest.day, 23);
    });

    test('FiscalYear', () {
      final fy = FiscalYear(2013);
      expect(fy, isNotNull);
      expect(fy.toString(), 'FY13');
    });

    test('CalendarYear', () {
      final cy = CalendarYear(2013);
      expect(cy, isNotNull);
      expect(cy.toString(), '2013');
    });

    test('comparisons and subtraction', () {
      final t1 = TimeInstant(TAI: 100);
      final t2 = TimeInstant(TAI: 50);

      // comparisons
      expect(t2.isBefore(t1), true);
      expect(t1.isAfter(t2), true);

      // subtraction of Time
      final tMinusTime = t1 - Time(s: 30);
      expect(tMinusTime, isA<TimeInstant>());
      expect(tMinusTime.valueSI.toDouble(), 70);
    });

    test('deltaT calculations', () {
      // year < 948
      final t500 = TimeInstant.dateTime(DateTime(500, 1, 1));
      expect(getDeltaT(t500), isNotNull);

      // year < 1620
      final t1500 = TimeInstant.dateTime(DateTime(1500, 1, 1));
      expect(getDeltaT(t1500), isNotNull);

      // year in future out of table range
      final t3000 = TimeInstant.dateTime(DateTime(3000, 1, 1));
      expect(getDeltaT(t3000), isNotNull);
    });

    test('pre-1972 TAI leap seconds linear interpolation', () {
      final tais = [
        110000000.0,
        120000000.0,
        180000000.0,
        185000000.0,
        195000000.0,
        205000000.0,
        215000000.0,
        225000000.0,
        230000000.0,
        240000000.0,
        250000000.0,
        300000000.0,
        320000000.0
      ];
      for (final taiVal in tais) {
        final ti = TimeInstant(TAI: taiVal);
        final utcVal = ti.valueInUnits(TimeInstant.UTC);
        expect(utcVal, isNotNull);

        // Call getLeapSeconds directly with pre1972LeapSeconds enabled to cover historical equations
        final ls = getLeapSeconds(taiVal, pre1972LeapSeconds: true);
        expect(ls, isNotNull);
      }
    });

    test('UTC conversion fallbacks', () {
      // Test the closures in UTC conversion for different parameter types
      expect(TimeInstant.UTC.toMks(1900000000.0), isA<Number>());
      expect(TimeInstant.UTC.toMks(Integer(1900000000)), isA<Number>());
      expect(TimeInstant.UTC.toMks('not a number'), Integer(0));

      expect(TimeInstant.UTC.fromMks(1900000000.0), isA<Number>());
      expect(TimeInstant.UTC.fromMks(Integer(1900000000)), isA<Number>());
      expect(TimeInstant.UTC.fromMks('not a number'), Integer(0));
    });
  });
}
