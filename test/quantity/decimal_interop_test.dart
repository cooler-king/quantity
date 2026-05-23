import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Decimal Interoperability', () {
    test('Number toDecimal and fromDecimal', () {
      final dec = Decimal.parse('123.456');
      final num = Number.fromDecimal(dec);
      expect(num is Precise, true);
      expect(num.toString(), '123.456');

      final dec2 = num.toDecimal();
      expect(dec2, dec);
    });

    test('Integer and Double toDecimal', () {
      final i = Integer(42);
      expect(i.toDecimal(), Decimal.fromInt(42));

      final d = Double(3.14);
      expect(d.toDecimal(), Decimal.parse('3.14'));
    });

    test('Complex/Imaginary toDecimal should throw StateError', () {
      final im = Imaginary(Double(5));
      expect(() => im.toDecimal(), throwsStateError);

      final c = Complex(Integer(1), Imaginary(Double(2)));
      expect(() => c.toDecimal(), throwsStateError);
    });

    test('Quantity valueSIAsDecimal', () {
      final q1 = Length(m: Decimal.parse('10.25'));
      expect(q1.valueSI is Precise, true);
      expect(q1.valueSIAsDecimal, Decimal.parse('10.25'));

      final q2 = Length(m: 100);
      expect(q2.valueSIAsDecimal, Decimal.fromInt(100));
    });

    test('objToNumber with Decimal', () {
      final dec = Decimal.parse('99.999');
      final quantity = MiscQuantity(dec, Dimensions.fromMap({'Length': 1}));
      expect(quantity.valueSI is Precise, true);
      expect(quantity.valueSI.toString(), '99.999');
      expect(quantity.valueSIAsDecimal, dec);
    });
  });
}
