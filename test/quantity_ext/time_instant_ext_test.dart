import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

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
      final t1 = TimeInstant(TAI: 1234.567);
      final t2 = TimeInstant.inUnits(1234.567, TDT);

      expect(t2.valueSI.toDouble(), 1202.383);
      expect(t2.valueInUnits(TAI), Double(1202.383));
      expect(t2.valueInUnits(TDT), Double(1234.567));

      expect(t1.valueSI.toDouble(), 1234.567);
      expect(t1.valueInUnits(TAI), Double(1234.567));
      expect(t1.valueInUnits(TDT), Double(1266.751));

      expect(areWithin(t1 - t2, Time(s: 32.184), Time(ns: 1)), true);
      expect(TimeInstant(TAI: 0).valueInUnits(TDT), Double(32.184));

      final t3 = TimeInstant.inUnits(0, TDT);
      expect(t3.mks.toDouble(), -32.184);
      expect(t3.valueInUnits(TAI), Double(-32.184));
      expect(t3.valueInUnits(TDT).toDouble(), 0);
    });

    test('GPST', () {
      final t1 = TimeInstant(TAI: 1234);
      final t2 = TimeInstant.inUnits(1234, GPST);

      expect(t2.valueSI.toDouble(), 1253);
      expect(t2.valueInUnits(TAI), Integer(1253));
      expect(t2.valueInUnits(GPST), Integer(1234));

      expect(t1.valueInUnits(GPST), Integer(1215));

      expect(areWithin(t1 - t2, Time(s: -19), Time(ns: 1)), true);

      expect(TimeInstant(TAI: 0).valueInUnits(GPST), Integer(-19));

      final t3 = TimeInstant.inUnits(0, GPST);
      expect(t3.mks.toDouble(), 19);
      expect(t3.valueInUnits(TAI), Integer(19));
      expect(t3.valueInUnits(GPST).toDouble(), 0);
    });

    test('TAI 2000000000', () {
      final tai = TimeInstant(TAI: 2000000000);

      expect(tai.valueInUnits(TAI).toDouble(), 2000000000);
      expect(tai.valueInUnits(UTC).toDouble(), 1999999963);
      expect(tai.valueInUnits(system).toDouble(), 1621308763000);
      expect(
          tai.valueInUnits(UT1).toDouble(), closeTo(1999999962.824, 0.000001));
      expect(tai.valueInUnits(UT2).toDouble(),
          closeTo(1999999962.8541603, 0.000001));
      expect(tai.valueInUnits(TDT).toDouble(), 2000000032.184);
      expect(tai.valueInUnits(TT).toDouble(), 2000000032.184);
      expect(tai.valueInUnits(ET).toDouble(), 2000000032.184);
      expect(tai.valueInUnits(TDB).toDouble(),
          closeTo(2000000032.1852133, 0.000001));
      expect(tai.valueInUnits(TCG).toDouble(),
          closeTo(2000000033.1599684, 0.000001));
      expect(tai.valueInUnits(TCB).toDouble(),
          closeTo(2000000053.8982372, 0.000001));
      expect(tai.valueInUnits(GPST).toDouble(), 1999999981);
      expect(tai.valueInUnits(NTP).toDouble(), 3830297563);
      expect(tai.valueInUnits(B).toDouble(),
          closeTo(2021.3779097160957, 0.000000000001));
      expect(tai.valueInUnits(JD_TAI).toDouble(),
          closeTo(2459352.6481481483, 0.00000000001));
      expect(tai.valueInUnits(JD_TCB).toDouble(),
          closeTo(2459352.6487719705, 0.00000000001));
      expect(tai.valueInUnits(JD_TCG).toDouble(),
          closeTo(2459352.648531944, 0.00000000001));
      expect(tai.valueInUnits(JD_TDB).toDouble(),
          closeTo(2459352.648520662, 0.00000000001));
      expect(tai.valueInUnits(JD_TDT).toDouble(),
          closeTo(2459352.648520648, 0.00000000001));
      expect(tai.valueInUnits(JD_UT1).toDouble(),
          closeTo(2459352.6477178703, 0.00000000001));
      expect(tai.valueInUnits(JD_UTC).toDouble(),
          closeTo(2459352.6477199076, 0.00000000001));
      expect(tai.valueInUnits(MJD_TAI).toDouble(),
          closeTo(59352.1481481483, 0.000000001));
      expect(tai.valueInUnits(MJD_TCB).toDouble(),
          closeTo(59352.1487719705, 0.000000001));
      expect(tai.valueInUnits(MJD_TCG).toDouble(),
          closeTo(59352.148531944, 0.000000001));
      expect(tai.valueInUnits(MJD_TDB).toDouble(),
          closeTo(59352.148520662, 0.000000001));
      expect(tai.valueInUnits(MJD_TDT).toDouble(),
          closeTo(59352.148520648, 0.000000001));
      expect(tai.valueInUnits(MJD_UT1).toDouble(),
          closeTo(59352.1477178703, 0.000000001));
      expect(tai.valueInUnits(MJD_UTC).toDouble(),
          closeTo(59352.1477199076, 0.000000001));
    });

    test('round-trip and inverse conversions for all time scales', () {
      final scales = [
        TCG,
        TDB,
        TCB,
        UT1,
        UT2,
        UTC,
        B,
        NTP,
        JD_TAI,
        JD_TCB,
        JD_TCG,
        JD_TDB,
        JD_TDT,
        JD_UT1,
        JD_UTC,
        MJD_TAI,
        MJD_TCB,
        MJD_TCG,
        MJD_TDB,
        MJD_TDT,
        MJD_UT1,
        MJD_UTC
      ];

      for (final scale in scales) {
        // Test with num input
        final tNum = TimeInstant.inUnits(1000.0, scale);
        final valTAI = tNum.valueInUnits(TAI);
        final tRound = TimeInstant(TAI: valTAI);
        final tolerance = 3000000.0;
        expect(
            tRound.valueInUnits(scale).toDouble(), closeTo(1000.0, tolerance));

        // Test with Number input
        final tNumber = TimeInstant.inUnits(Double(1000.0), scale);
        expect(tNumber.valueInUnits(TAI).toDouble(),
            closeTo(valTAI.toDouble(), 0.001));
      }

      // Test fallback branches of custom closures directly
      expect(TCG.toMks('invalid').toDouble(), isNotNull);
      expect(TCG.fromMks('invalid').toDouble(), isNotNull);
      expect(TDB.toMks('invalid').toDouble(), isNotNull);
      expect(TDB.fromMks('invalid').toDouble(), isNotNull);
      expect(TCB.toMks('invalid').toDouble(), isNotNull);
      expect(TCB.fromMks('invalid').toDouble(), isNotNull);

      expect(JD_UT1.fromMks(0.0).toDouble(), isNotNull);
      expect(JD_TDB.fromMks(0.0).toDouble(), isNotNull);
      expect(JD_TCG.fromMks(0.0).toDouble(), isNotNull);

      // Test derive method on TimeInstantUnits
      final derivedTime = TAI.derive('testPrefix', 'tp', 2.0);
      expect(derivedTime.name, 'testPrefixInternational Atomic Time');
      expect(derivedTime.quantityType, TimeInstant);
    });
  });
}
