import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('hashCodes', () {
    test('int and Integer', () {
      final Integer d = const Integer.constant(42);
      expect(d.hashCode, 42.hashCode);

      final Integer d2 = new Integer(-42);
      expect(d2.hashCode, -42.hashCode);

      expect(d.hashCode == d2.hashCode, false);

      expect(Integer.zero.hashCode, 0.hashCode);
      expect(Integer.one.hashCode, 1.hashCode);
      expect(Integer.ten.hashCode, 10.hashCode);
      expect(Integer.hundred.hashCode, 100.hashCode);
      expect(Integer.thousand.hashCode, 1000.hashCode);
    });

    test('Double', () {
      final Double d = new Double(34.56);
      final Double d2 = new Double(3.456e1);
      expect(d.hashCode, d2.hashCode);

      final Double d3 = new Double(-34.56);
      expect(d.hashCode == d3.hashCode, false);

      final Double d4 = new Double(217.0);
      expect(d4.hashCode, 217.hashCode);

      final Double d5 = new Double(217.000000001);
      expect(d5.hashCode == 217.hashCode, false);
      expect(d5.hashCode == d4.hashCode, false);

      final Double d6 = new Double(-217.0);
      expect(d6.hashCode, -217.hashCode);
      expect(d6.hashCode == 217.hashCode, false);
      expect(d6.hashCode == d4.hashCode, false);

      final Double d7 = new Double(1.234e-2);
      final Double d8 = new Double(1.234e2);
      expect(d7.hashCode == d8.hashCode, false);
    });

    test('Imaginary', () {
      final Imaginary d = new Imaginary(7);
      final Imaginary d2 = new Imaginary(7);
      expect(d.hashCode, d2.hashCode);
      expect(d.hashCode == 7.hashCode, false);

      final Imaginary d3 = new Imaginary(-7);
      expect(d3.hashCode == d2.hashCode, false);

      final Imaginary d4 = new Imaginary(23.43);
      expect(d4.hashCode == new Double(23.43).hashCode, false);

      final Imaginary d5 = new Imaginary(0);
      expect(d5.hashCode, 0.hashCode);
    });

    test('Complex', () {
      final Complex d = new Complex(new Double(34.56), new Imaginary(7));
      final Complex d2 = new Complex(new Double(34.56), new Imaginary(7));
      expect(d.hashCode, d2.hashCode);

      final Complex d3 = new Complex(Double.zero, new Imaginary(7));
      expect(d3.hashCode == d2.hashCode, false);

      final Complex d4 = new Complex(new Double(34.56), new Imaginary(0));
      expect(d4.hashCode == d2.hashCode, false);
    });

    test('Precise', () {
      final Precise d = new Precise('32.456');
      final Precise d2 = new Precise('32.456');
      expect(d.hashCode, d2.hashCode);

      final Double d3 = new Double(32.456);
      expect(d2.hashCode, d3.hashCode);

      final Complex d4 = new Complex(new Double(32.456), new Imaginary(0));
      expect(d2.hashCode, d4.hashCode);

      final Precise d5 = new Precise('-32.456');
      expect(d.hashCode == d5.hashCode, false);
    });
  });
}
