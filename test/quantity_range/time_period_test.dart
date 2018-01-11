import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_range.dart';

void main() {
  group('TimePeriod', () {
    test('constructors', () {
      final TimePeriod period =
          new TimePeriod(new TimeInstant.dateTime(new DateTime(1999)), new TimeInstant.dateTime(new DateTime(2007, 3)));
      expect(period, isNotNull);
      expect(period.q1 == new TimeInstant.dateTime(new DateTime(1999)), true);
      expect(period.q2 == new TimeInstant.dateTime(new DateTime(2007, 3)), true);
    });

    test('operator ==', () {
      final FiscalYear p1 = new FiscalYear(2015);
      final FiscalYear p2 = new FiscalYear(2017);
      final FiscalYear p3 = new FiscalYear(2015);
      expect(p1 == p2, false);
      expect(p2 == p3, false);
      expect(p1 == p3, true);
      expect(p3 == p1, true);
    });

    test('hashCode', () {
      final FiscalYear p1 = new FiscalYear(2015);
      final FiscalYear p2 = new FiscalYear(2017);
      final FiscalYear p3 = new FiscalYear(2015);

      expect(p1.hashCode == p2.hashCode, false);
      expect(p2.hashCode == p3.hashCode, false);
      expect(p1.hashCode == p3.hashCode, true);
    });
  });
}
