import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('TimeInstant', () {
    test('constructors', () {
      TimeInstant t = new TimeInstant(TAI: 1234.5);
      expect(t, isNotNull);

      expect(t.valueSI is Double, true);
      expect(t.valueSI.toDouble(), 1234.5);
      expect(t.dimensions, TimeInstant.timeInstantDimensions);
      expect(t.preferredUnits, TimeInstant.TAI);
      expect(t.relativeUncertainty, 0);
    });

    test('nearestDateTime', () {
      TimeInstant t = new TimeInstant.dateTime(new DateTime(2015, 9, 23));
      DateTime nearest = t.nearestDateTime;
      expect(nearest, isNotNull);
      expect(nearest.year, 2015);
      expect(nearest.month, 9);
      expect(nearest.day, 23);
    });

    test('FiscalYear', () {
      FiscalYear fy = new FiscalYear(2013);
      expect(fy, isNotNull);
      expect(fy.toString(), "FY13");
    });

    test('CalendarYear', () {
      CalendarYear cy = new CalendarYear(2013);
      expect(cy, isNotNull);
      expect(cy.toString(), "2013");
    });
  });
}
