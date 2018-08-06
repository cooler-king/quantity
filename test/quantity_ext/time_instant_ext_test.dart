import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart';

void main() {
  group('time instant ext', () {
    test('shortcuts', () {
      expect(identical(TAI, TimeInstant.TAI), true);
      expect(identical(UTC, TimeInstant.UTC), true);
      expect(identical(system, TimeInstant.system), true);
      expect(identical(TT, TDT), true);
      expect(identical(ET, TDT), true);
      expect(identical(TB, TDB), true);
    });

    test('TDT', () {
      final TimeInstant t1 = new TimeInstant(TAI: 1234.567);
      final TimeInstant t2 = new TimeInstant.inUnits(1234.567, TDT);

      expect(t2.valueSI.toDouble(), 1202.383);
      expect(t2.valueInUnits(TAI), new Double(1202.383));
      expect(t2.valueInUnits(TDT), new Double(1234.567));

      expect(t1.valueSI.toDouble(), 1234.567);
      expect(t1.valueInUnits(TAI), new Double(1234.567));
      expect(t1.valueInUnits(TDT), new Double(1266.751));

      expect(areWithin(t1 - t2, new Time(s: 32.184), new Time(ns: 1)), true);
      expect(new TimeInstant(TAI: 0).valueInUnits(TDT), new Double(32.184));

      final TimeInstant t3 = new TimeInstant.inUnits(0, TDT);
      expect(t3.mks.toDouble(), -32.184);
      expect(t3.valueInUnits(TAI), new Double(-32.184));
      expect(t3.valueInUnits(TDT).toDouble(), 0);
    });

    test('GPST', () {
      final TimeInstant t1 = new TimeInstant(TAI: 1234);
      final TimeInstant t2 = new TimeInstant.inUnits(1234, GPST);

      expect(t2.valueSI.toDouble(), 1253);
      expect(t2.valueInUnits(TAI), new Integer(1253));
      expect(t2.valueInUnits(GPST), new Integer(1234));

      expect(t1.valueInUnits(GPST), new Integer(1215));

      expect(areWithin(t1 - t2, new Time(s: -19), new Time(ns: 1)), true);

      expect(new TimeInstant(TAI: 0).valueInUnits(GPST), new Integer(-19));

      final TimeInstant t3 = new TimeInstant.inUnits(0, GPST);
      expect(t3.mks.toDouble(), 19);
      expect(t3.valueInUnits(TAI), new Integer(19));
      expect(t3.valueInUnits(GPST).toDouble(), 0);
    });
  });
}
