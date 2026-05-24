import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

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
      final customUnit = LengthUnits('custom', 'c', 'c2', 'custom', 5.0, false, 1.5);

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
  });
}
