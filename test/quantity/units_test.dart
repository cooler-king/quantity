import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('units', () {
    test('Units properties and overrides', () {
      final u = Length.meters;
      expect(u.hashCode, u.name.hashCode);
      expect(u.alternateName, u.abbrev1);
      expect(u.toString(), '${u.name} [${u.convToMKS}]');
    });

    test('toMks and fromMks with offset and Precise/Decimal', () {
      // Create a unit with an offset
      final customUnit =
          LengthUnits('custom', 'c', 'c2', 'custom', 5.0, false, 1.5);

      // value is Precise (which triggers the preciseConv branch)
      final pVal = Precise('10.0');
      final mksVal = customUnit.toMks(pVal);
      // toMks: (Precise('5.0') * Precise('10.0')) + Precise('1.5') = 50.0 + 1.5 = 51.5
      expect(mksVal, isA<Precise>());
      expect(mksVal.toDouble(), 51.5);

      // value is Decimal
      final dVal = Decimal.parse('10.0');
      final mksValFromDec = customUnit.toMks(dVal);
      expect(mksValFromDec.toDouble(), 51.5);

      // fromMks with Decimal
      final mksDec = Decimal.parse('51.5');
      final valFromDec = customUnit.fromMks(mksDec);
      // fromMks: (51.5 / 5.0) - 1.5 = 10.3 - 1.5 = 8.8
      expect(valFromDec.toDouble(), closeTo(8.8, 0.0001));
    });

    test('Quantity.to method conversions', () {
      final len = Length(m: 5000);

      // 1. Convert using Units object
      final km = len.to(Length.kilometers);
      expect(km.preferredUnits, Length.kilometers);
      expect(km.toString(), '5 km');

      // 2. Convert using baseUnits String symbol
      final meters = len.to('m');
      expect(meters.preferredUnits, Length.meters);
      expect(meters.toString(), '5000 m');

      // 3. Convert using prefixed resolveUnit String symbol
      final kmStr = len.to('km');
      expect(kmStr.preferredUnits, Length.kilometers);
      expect(kmStr.toString(), '5 km');

      // 3.5. Convert using prefixed symbol with unmatched abbrev suffix (fallback to resolved.unit)
      final res = Resistance(ohms: 5000);
      final kohm = res.to('kohm');
      expect(kohm.preferredUnits, Resistance.ohms);
      expect(kohm.toString(), '5000 \u03a9');

      // 3.7. Convert using compound unit symbols
      final speed = Speed(metersPerSecond: 10);
      final kmh = speed.to('km/h');
      expect(kmh.preferredUnits, kilometersPerHour);
      expect(kmh.toString(), '36 km h⁻¹');

      final torque = Torque(Nm: 15);
      final nm = torque.to('N*m');
      expect(nm.preferredUnits, Torque.newtonMeters);

      // 4. Exception: Unknown symbol
      expect(() => len.to('xyz'), throwsA(isA<QuantityException>()));

      // 5. Exception: Incompatible dimensions (Units object)
      expect(() => len.to(Time.seconds), throwsA(isA<DimensionsException>()));

      // 6. Exception: Incompatible dimensions (String symbol)
      expect(() => len.to('s'), throwsA(isA<DimensionsException>()));

      // 7. Exception: Invalid argument type
      expect(() => len.to(123), throwsA(isA<ArgumentError>()));
    });
  });
}
