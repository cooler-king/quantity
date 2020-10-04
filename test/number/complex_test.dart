import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/number.dart';

void main() {
  group('Complex', () {
    test('zeros', () {
      final Complex complex0a = new Complex(Integer.zero, new Imaginary(0));
      final Complex complex0b = new Complex(Double(0), new Imaginary(new Double(0)));

      expect(complex0a.real.toDouble() == 0, true);
      expect(complex0a.imaginary.value.toDouble() == 0, true);

      expect(complex0a == complex0b, true);
    });

    group('constructors', () {
      test('coeff', () {
        final Complex c1 = new Complex.coeff(1, 2);
        expect(c1.real is Integer, true);
        expect(c1.real, new Integer(1));
        expect(c1.imag is Imaginary, true);
        expect(c1.imag.value is Integer, true);
        expect(c1.imag.value, new Integer(2));

        final Complex c2 = new Complex.coeff(3.3, 4.4);
        expect(c2.real is Double, true);
        expect(c2.real, new Double(3.3));
        expect(c2.imag is Imaginary, true);
        expect(c2.imag.value is Double, true);
        expect(c2.imag.value, new Double(4.4));
      });
    });

    group('operator +', () {
      test('operator + num', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 + 7, new Integer(7));
        expect(c0 + 7 is Integer, true);
        expect(c0 + 0.001, new Double(0.001));
        expect(c0 + 0.001 is Double, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 + 8, new Complex.coeff(9.1, 2.2));
        expect(c1 + 0.02, new Complex.coeff(1.12, 2.2));
      });

      test('operator + Integer', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 + new Integer(7), new Integer(7));
        expect(c0 + new Integer(7) is Integer, true);
        expect(c0 + new Integer(-10), new Integer(-10));
        expect(c0 + new Integer(-10) is Integer, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 + new Integer(8), new Complex.coeff(9.1, 2.2));
      });

      test('operator + Double', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 + new Double(7.5), new Double(7.5));
        expect(c0 + new Double(7.5) is Double, true);
        expect(c0 + new Double(-10.1), new Double(-10.1));
        expect(c0 + new Double(-10.1) is Double, true);
        expect(c0 + new Double(17), new Integer(17));
        expect(c0 + new Double(17) is Integer, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 + new Double(0.02), new Complex.coeff(1.12, 2.2));
      });

      test('operator + Imaginary', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 + new Imaginary(0), new Complex.coeff(0, 0));
        expect(c0 + new Imaginary(5.6), new Imaginary(5.6));
        expect(c0 + new Imaginary(-21.01), new Imaginary(-21.01));

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 + new Imaginary(0), new Complex.coeff(1.1, 2.2));
        expect(c1 + new Imaginary(5.6), new Complex.coeff(1.1, 7.8));
        expect(c1 + new Imaginary(-21), new Complex.coeff(1.1, -18.8));
      });

      test('operator + Complex', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 + new Complex.coeff(0, 0), Integer(0));
        expect(c0 + new Complex.coeff(0, 0) is Integer, true);
        expect(c0 + new Complex.coeff(0, 5), Imaginary(5));
        expect(c0 + new Complex.coeff(0, 5) is Imaginary, true);
        expect(c0 + new Complex.coeff(5, 0), Integer(5));
        expect(c0 + new Complex.coeff(5, 0) is Integer, true);
        expect(c0 + new Complex.coeff(6.7, 0), Double(6.7));
        expect(c0 + new Complex.coeff(6.7, 0) is Double, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 + new Complex.coeff(0, 0), new Complex.coeff(1.1, 2.2));
        expect(c1 + new Complex.coeff(4.3, 0), new Complex.coeff(5.4, 2.2));
        expect(c1 + new Complex.coeff(0, 6.2), new Complex.coeff(1.1, 8.4));
      });

      test('operator + Precise', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 + new Precise('7.5'), new Precise('7.5'));
        expect(c0 + new Precise('7.5') is Precise, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 + new Precise('0.00000000000000000000000002'),
            new Complex(new Precise('1.10000000000000000000000002'), new Imaginary(2.2)));
      });
    });

    group('operator -', () {
      test('operator - num', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 - 7, new Integer(-7));
        expect(c0 - 7 is Integer, true);
        expect(c0 - 0.001, new Double(-0.001));
        expect(c0 - 0.001 is Double, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 - 8, new Complex.coeff(-6.9, 2.2));
        expect(c1 - 0.02, new Complex.coeff(1.08, 2.2));
      });

      test('operator - Integer', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 - new Integer(7), new Integer(-7));
        expect(c0 - new Integer(7) is Integer, true);
        expect(c0 - new Integer(-10), new Integer(10));
        expect(c0 - new Integer(-10) is Integer, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 - new Integer(8), new Complex.coeff(-6.9, 2.2));
      });

      test('operator - Double', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 - new Double(7.5), new Double(-7.5));
        expect(c0 - new Double(7.5) is Double, true);
        expect(c0 - new Double(-10.1), new Double(10.1));
        expect(c0 - new Double(-10.1) is Double, true);
        expect(c0 - new Double(17), new Integer(-17));
        expect(c0 - new Double(17) is Integer, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 - new Double(0.02), new Complex.coeff(1.08, 2.2));
      });

      test('operator - Imaginary', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 - new Imaginary(0), new Complex.coeff(0, 0));
        expect(c0 - new Imaginary(5.6), new Imaginary(-5.6));
        expect(c0 - new Imaginary(-21.01), new Imaginary(21.01));

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 - new Imaginary(0), new Complex.coeff(1.1, 2.2));
        expect(c1 - new Imaginary(5.5), new Complex.coeff(1.1, -3.3));
        expect(c1 - new Imaginary(-21), new Complex.coeff(1.1, 23.2));
      });

      test('operator - Complex', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 - new Complex.coeff(0, 0), Integer(0));
        expect(c0 - new Complex.coeff(0, 0) is Integer, true);
        expect(c0 - new Complex.coeff(0, 5), Imaginary(-5));
        expect(c0 - new Complex.coeff(0, 5) is Imaginary, true);
        expect(c0 - new Complex.coeff(5, 0), Integer(-5));
        expect(c0 - new Complex.coeff(5, 0) is Integer, true);
        expect(c0 - new Complex.coeff(6.7, 0), Double(-6.7));
        expect(c0 - new Complex.coeff(6.7, 0) is Double, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 - new Complex.coeff(0, 0), new Complex.coeff(1.1, 2.2));
        expect(c1 - new Complex.coeff(4.7, 0), new Complex.coeff(-3.6, 2.2));
        expect(c1 - new Complex.coeff(0, 6.2), new Complex.coeff(1.1, -4));
      });

      test('operator - Precise', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 - new Precise('7.5'), new Precise('-7.5'));
        expect(c0 - new Precise('7.5') is Precise, true);

        final Complex c1 = new Complex.coeff(1.1, 2.2);
        expect(c1 - new Precise('0.00000000000000000000000002'),
            new Complex(new Precise('1.09999999999999999999999998'), new Imaginary(2.2)));
      });
    });

    group('operator *', () {
      test('operator * num', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 * 0, new Integer(0));
        expect(c0 * 0 is Integer, true);
        expect(c0 * 1, new Integer(0));
        expect(c0 * 1 is Integer, true);
        expect(c0 * 3.6, new Integer(0));
        expect(c0 * 3.6 is Integer, true);
        expect(c0 * -9.1, new Integer(0));
        expect(c0 * -9.1 is Integer, true);

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 * 0, new Integer(0));
        expect(c1 * 0 is Integer, true);
        expect(c1 * 1, new Complex.coeff(2, 3));
        expect(c1 * 3.6, new Complex.coeff(7.2, 10.8));
        expect(c1 * -2.5, new Complex.coeff(-5, -7.5));
      });

      test('operator * Integer', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 * new Integer(0), new Integer(0));
        expect(c0 * new Integer(0) is Integer, true);
        expect(c0 * new Integer(1), new Integer(0));
        expect(c0 * new Integer(1) is Integer, true);
        expect(c0 * new Integer(-9), new Integer(0));
        expect(c0 * new Integer(-9) is Integer, true);

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 * new Integer(0), new Integer(0));
        expect(c1 * new Integer(0) is Integer, true);
        expect(c1 * new Integer(1), new Complex.coeff(2, 3));
        expect(c1 * new Integer(3), new Complex.coeff(6, 9));
        expect(c1 * new Integer(-2), new Complex.coeff(-4, -6));
      });

      test('operator * Double', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 * new Double(0), new Integer(0));
        expect(c0 * new Double(0) is Integer, true);
        expect(c0 * new Double(1), new Integer(0));
        expect(c0 * new Double(1) is Integer, true);
        expect(c0 * new Double(-9), new Integer(0));
        expect(c0 * new Double(-9) is Integer, true);

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 * new Double(0), new Integer(0));
        expect(c1 * new Double(0) is Integer, true);
        expect(c1 * new Double(1.5), new Complex.coeff(3, 4.5));
        expect(c1 * new Double(-2.5), new Complex.coeff(-5, -7.5));
      });

      test('operator * Imaginary', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 * new Imaginary(0), new Integer(0));
        expect(c0 * new Imaginary(1), new Integer(0));
        expect(c0 * new Imaginary(-9), new Integer(0));

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 * new Imaginary(0), new Integer(0));
        expect(c1 * new Imaginary(1), new Complex.coeff(-3, 2));
        expect(c1 * new Imaginary(3), new Complex.coeff(-9, 6));
        expect(c1 * new Imaginary(-2.5), new Complex.coeff(7.5, -5));
      });

      test('operator * Complex', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 * new Complex.coeff(0, 0), new Integer(0));
        expect(c0 * new Complex.coeff(5, 6), new Integer(0));
        expect(c0 * new Complex.coeff(-9.1, -12.1), new Integer(0));

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 * new Complex.coeff(0, 0), new Integer(0));
        expect(c1 * new Complex.coeff(1, 2), new Complex.coeff(-4, 7));
        expect(c1 * new Complex.coeff(-3, -4), new Complex.coeff(6, -17));
        expect(c1 * new Complex.coeff(2.5, 1.5), new Complex.coeff(0.5, 10.5));
      });

      test('operator * Precise', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 * new Precise('0'), new Precise('0'));
        expect(c0 * new Precise('0') is Precise, true);
        expect(c0 * new Precise('1'), new Precise('0'));
        expect(c0 * new Precise('1') is Precise, true);
        expect(c0 * new Precise('-9'), new Precise('0'));
        expect(c0 * new Precise('-9') is Precise, true);

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 * new Precise('0'), new Precise('0'));
        expect(c1 * new Precise('1'), new Complex.coeff(2, 3));
        expect(c1 * new Precise('-9'), new Complex.coeff(-18, -27));

        final Complex c2 = Complex.coeff(2, 3) * new Precise('-2.000000000000000000002') as Complex;
        expect(c2.real is Precise, true);
        expect(c2.real, new Precise('-4.000000000000000000004'));
        expect(c2.imag.value is Precise, true);
        expect(c2.imag.value, new Precise('-6.000000000000000000006'));
      });
    });

    group('operator /', () {
      test('operator / num', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 / 1, new Integer(0));
        expect(c0 / 1 is Integer, true);
        expect(c0 / 3.6, new Integer(0));
        expect(c0 / 3.6 is Integer, true);
        expect(c0 / -9.1, new Integer(0));
        expect(c0 / -9.1 is Integer, true);
        expect(c0 / 0, new Complex(Double.NaN, new Imaginary(Double.NaN)));
        expect(c0 / double.infinity, new Integer(0));
        expect(c0 / double.negativeInfinity, new Integer(0));
        expect(c0 / double.nan, new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 / 1, new Complex.coeff(2, 3));
        expect(c1 / 4, new Complex.coeff(0.5, 0.75));
        expect(c1 / 0, new Complex(Double.infinity, new Imaginary(Double.infinity)));

        final Complex c2 = new Complex.coeff(-5, -2);
        expect(c2 / 1, new Complex.coeff(-5, -2));
        expect(c2 / -4, new Complex.coeff(1.25, 0.5));
        expect(c2 / 0, new Complex(Double.negInfinity, new Imaginary(Double.negInfinity)));
      });

      test('operator / Integer', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 / new Integer(1), new Integer(0));
        expect(c0 / new Integer(1) is Integer, true);
        expect(c0 / new Integer(3), new Integer(0));
        expect(c0 / new Integer(3) is Integer, true);
        expect(c0 / new Integer(-9), new Integer(0));
        expect(c0 / new Integer(-9) is Integer, true);
        expect(c0 / new Integer(0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 / new Integer(1), new Complex.coeff(2, 3));
        expect(c1 / new Integer(4), new Complex.coeff(0.5, 0.75));
        expect(c1 / new Integer(0), new Complex(Double.infinity, new Imaginary(Double.infinity)));

        final Complex c2 = new Complex.coeff(-5, -2);
        expect(c2 / new Integer(4), new Complex.coeff(-1.25, -0.5));
        expect(c2 / new Integer(-4), new Complex.coeff(1.25, 0.5));
        expect(c2 / new Integer(0), new Complex(Double.negInfinity, new Imaginary(Double.negInfinity)));
      });

      test('operator / Double', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 / new Double(1), new Integer(0));
        expect(c0 / new Double(1) is Integer, true);
        expect(c0 / new Double(3.3), new Integer(0));
        expect(c0 / new Double(3.3) is Integer, true);
        expect(c0 / new Double(-9.9), new Integer(0));
        expect(c0 / new Double(-9.9) is Integer, true);
        expect(c0 / new Double(0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c1 = new Complex.coeff(2, 3);
        expect(c1 / new Double(0.5), new Complex.coeff(4, 6));
        expect(c1 / new Double(-0.25), new Complex.coeff(-8, -12));
        expect(c1 / new Double(0), new Complex(Double.infinity, new Imaginary(Double.infinity)));

        final Complex c2 = new Complex.coeff(-5, -2);
        expect(c2 / new Double(0.2), new Complex.coeff(-25, -10));
        expect(c2 / new Double(-0.1), new Complex.coeff(50, 20));
        expect(c2 / new Double(0), new Complex(Double.negInfinity, new Imaginary(Double.negInfinity)));
      });

      test('operator / Imaginary', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 / new Imaginary(1), new Integer(0));
        expect(c0 / new Imaginary(1) is Integer, true);
        expect(c0 / new Imaginary(3), new Integer(0));
        expect(c0 / new Imaginary(3) is Integer, true);
        expect(c0 / new Imaginary(-9), new Integer(0));
        expect(c0 / new Imaginary(-9) is Integer, true);
        expect(c0 / new Imaginary(0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c1 = new Complex.coeff(2, 8);
        expect(c1 / new Imaginary(1), new Complex.coeff(8, -2));
        expect(c1 / new Imaginary(4), new Complex.coeff(2, -0.5));
        expect(c1 / new Imaginary(0), new Complex(Double.infinity, new Imaginary(Double.negInfinity)));

        final Complex c2 = new Complex.coeff(-5, -2);
        expect(c2 / new Imaginary(4), new Complex.coeff(-0.5, 1.25));
        expect(c2 / new Imaginary(-4), new Complex.coeff(0.5, -1.25));
        expect(c2 / new Imaginary(0), new Complex(Double.negInfinity, new Imaginary(Double.infinity)));
      });

      test('operator / Complex', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 / new Complex.coeff(1, 1), new Integer(0));
        expect(c0 / new Complex.coeff(1, 1) is Integer, true);
        expect(c0 / new Complex.coeff(3, 3), new Integer(0));
        expect(c0 / new Complex.coeff(3, 3) is Integer, true);
        expect(c0 / new Complex.coeff(-9.9, -9.9), new Integer(0));
        expect(c0 / new Complex.coeff(-9.9, -9.9) is Integer, true);
        expect(c0 / new Complex.coeff(1, 0), new Integer(0));
        expect(c0 / new Complex.coeff(0, 1), new Integer(0));
        expect(c0 / new Complex.coeff(0, 0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c1 = new Complex.coeff(2, 8);
        expect(c1 / new Complex.coeff(1, 1), new Complex.coeff(5, 3));
        expect(c1 / new Complex.coeff(4, 2), new Complex.coeff(1.2, 1.4));
        expect(c1 / new Complex.coeff(1, 0), new Complex.coeff(2, 8));
        expect(c1 / new Complex.coeff(0, 1), new Complex.coeff(8, -2));
        expect(c1 / new Complex.coeff(0, 0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c2 = new Complex.coeff(-5, -2);
        expect(c2 / new Complex.coeff(4, 2), new Complex.coeff(-1.2, 0.1));
        expect(c2 / new Complex.coeff(-4, -2), new Complex.coeff(1.2, -0.1));
        expect(c2 / new Complex.coeff(1, 0), new Complex.coeff(-5, -2));
        expect(c2 / new Complex.coeff(0, 1), new Complex.coeff(-2, 5));
        expect(c2 / new Complex.coeff(0, 0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Complex c3 = new Complex.coeff(3, 2);
        expect(c3 / new Complex.coeff(4, -3), new Complex.coeff(0.24, 0.68));
      });
    });

    group('operator ~/', () {
      test('operator ~/ num', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 ~/ 1, new Complex.coeff(0, 0));

        final Complex c1 = new Complex.coeff(45, 65);
        expect(c1 ~/ 1, new Complex.coeff(45, 65));
        expect(c1 ~/ 5, new Complex.coeff(9, 13));
        expect(c1 ~/ -5, new Complex.coeff(-9, -13));
        expect(c1 ~/ 5.1, new Complex.coeff(8, 12));
        expect(c1 ~/ -5.1, new Complex.coeff(-8, -12));
      });

      test('operator ~/ Integer', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 ~/ new Integer(1), new Complex.coeff(0, 0));

        final Complex c1 = new Complex.coeff(45, 65);
        expect(c1 ~/ new Integer(1), new Complex.coeff(45, 65));
        expect(c1 ~/ new Integer(5), new Complex.coeff(9, 13));
        expect(c1 ~/ new Integer(-5), new Complex.coeff(-9, -13));
      });

      test('operator ~/ Double', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 ~/ new Double(1.5), new Complex.coeff(0, 0));

        final Complex c1 = new Complex.coeff(45, 65);
        expect(c1 ~/ new Double(5.1), new Complex.coeff(8, 12));
        expect(c1 ~/ new Double(-5.1), new Complex.coeff(-8, -12));
      });

      test('operator ~/ Imaginary', () {
        final Complex c0 = new Complex.coeff(0, 0);
        expect(c0 ~/ new Imaginary(1.5), new Complex.coeff(0, 0));

        final Complex c1 = new Complex.coeff(45, 65);
        expect(c1 ~/ new Imaginary(5), new Complex.coeff(13, -9));
        expect(c1 ~/ new Imaginary(-5.1), new Complex.coeff(-12, 8));
      });
    });

    group('operator ^', () {
      test('operator ^ num', () {
        final Number c0 = new Complex.coeff(4, 3) ^ 0;
        expect(c0, new Integer(1));
        expect(c0, isA<Integer>());

        final Complex c1 = new Complex.coeff(4, 3) ^ 1 as Complex;
        expect(c1, new Complex.coeff(4, 3));

        final Complex c2 = new Complex.coeff(4, 3) ^ 4 as Complex;
        expect(c2.real.toDouble(), -527);
        expect(c2.imag.value.toDouble(), closeTo(336, 0.000000000001));
      });

      test('operator ^ Integer', () {
        final Number c0 = new Complex.coeff(4, 3) ^ new Integer(0);
        expect(c0, new Integer(1));
        expect(c0, isA<Integer>());

        final Complex c1 = new Complex.coeff(4, 3) ^ new Integer(1) as Complex;
        expect(c1, new Complex.coeff(4, 3));

        final Complex c2 = new Complex.coeff(4, 3) ^ new Integer(4) as Complex;
        expect(c2.real.toDouble(), -527);
        expect(c2.imag.value.toDouble(), closeTo(336, 0.000000000001));
      });

      test('operator ^ Double', () {
        final Number c0 = new Complex.coeff(4, 3) ^ new Double(0);
        expect(c0, new Integer(1));
        expect(c0, isA<Integer>());

        final Complex c1 = new Complex.coeff(4, 3) ^ new Double(1) as Complex;
        expect(c1, new Complex.coeff(4, 3));

        final Complex c2 = new Complex.coeff(4, 3) ^ new Double(4) as Complex;
        expect(c2.real.toDouble(), -527);
        expect(c2.imag.value.toDouble(), closeTo(336, 0.000000000001));
      });

      test('operator ^ Imaginary (exception)', () {
        expect(() => new Complex.coeff(1, 2) ^ new Imaginary(3), throwsA(isA<NumberException>()));
      });

      test('operator ^ Complex (exception)', () {
        expect(() => new Complex.coeff(1, 2) ^ new Complex.coeff(2, 5), throwsA(isA<NumberException>()));
      });
    });

    test('operator % (exception)', () {
      expect(() => new Complex.coeff(1, 2) % 2, throwsA(isA<NumberException>()));
    });

    test('negation operator -', () {
      expect(-new Complex.coeff(1, 2), new Complex.coeff(-1, -2));
      expect(-new Complex.coeff(0, -2), new Complex.coeff(0, 2));
      expect(-new Complex.coeff(-1, 0), new Complex.coeff(1, 0));
    });

    group('operator <', () {
      test('operator < num', () {
        expect(new Complex.coeff(6, 2) < 4, false);
        expect(new Complex.coeff(6, 6) < 6, false);
        expect(new Complex.coeff(2, 8) < 4, true);

        expect(new Complex.coeff(6, 2) < 4.5, false);
        expect(new Complex.coeff(6, 6) < 6.0, false);
        expect(new Complex.coeff(2, 8) < 4.5, true);
      });

      test('operator < Integer', () {
        expect(new Complex.coeff(6, 2) < new Integer(4), false);
        expect(new Complex.coeff(6, 6) < new Integer(6), false);
        expect(new Complex.coeff(2, 8) < new Integer(4), true);
      });

      test('operator < Double', () {
        expect(new Complex.coeff(6, 2) < new Double(4.5), false);
        expect(new Complex.coeff(6.1, 6.1) < new Double(6.1), false);
        expect(new Complex.coeff(2, 8) < new Double(4.5), true);
      });

      test('operator < Imaginary', () {
        expect(new Complex.coeff(1, 2) < new Imaginary(4.5), false);
        expect(new Complex.coeff(6.1, 6.1) < new Imaginary(6.1), false);
        expect(new Complex.coeff(-2, 8) < new Imaginary(-4.5), true);
      });

      test('operator < Complex', () {
        expect(new Complex.coeff(1, 2) < new Complex.coeff(0.5, 4), false);
        expect(new Complex.coeff(6.1, 6.1) < new Complex.coeff(6.1, 6.1), false);
        expect(new Complex.coeff(-2, 8) < new Complex.coeff(-1.5, 9), true);
      });

      test('operator < Precise', () {
        expect(new Complex.coeff(6, 2) < new Precise('4.5'), false);
        expect(new Complex.coeff(6.1, 6.1) < new Precise('6.10000000000000000000'), false);
        expect(new Complex.coeff(2, 8) < new Precise('4.5'), true);
      });
    });

    group('operator <=', () {
      test('operator <= num', () {
        expect(new Complex.coeff(6, 2) <= 4, false);
        expect(new Complex.coeff(6, 6) <= 6, true);
        expect(new Complex.coeff(2, 8) <= 4, true);

        expect(new Complex.coeff(6, 2) <= 4.5, false);
        expect(new Complex.coeff(6, 6) <= 6.0, true);
        expect(new Complex.coeff(2, 8) <= 4.5, true);
      });

      test('operator <= Integer', () {
        expect(new Complex.coeff(6, 2) <= new Integer(4), false);
        expect(new Complex.coeff(6, 6) <= new Integer(6), true);
        expect(new Complex.coeff(2, 8) <= new Integer(4), true);
      });

      test('operator <= Double', () {
        expect(new Complex.coeff(6, 2) <= new Double(4.5), false);
        expect(new Complex.coeff(6.1, 6.1) <= new Double(6.1), true);
        expect(new Complex.coeff(2, 8) <= new Double(4.5), true);
      });

      test('operator <= Imaginary', () {
        expect(new Complex.coeff(1, 2) <= new Imaginary(4.5), false);
        expect(new Complex.coeff(6.1, 6.1) <= new Imaginary(6.1), false);
        expect(new Complex.coeff(-2, 8) <= new Imaginary(-4.5), true);
      });

      test('operator < Complex', () {
        expect(new Complex.coeff(1, 2) <= new Complex.coeff(0.5, 4), false);
        expect(new Complex.coeff(6.1, 6.1) <= new Complex.coeff(6.1, 6.1), true);
        expect(new Complex.coeff(-2, 8) <= new Complex.coeff(-1.5, 9), true);
      });

      test('operator < Precise', () {
        expect(new Complex.coeff(6, 2) <= new Precise('4.5'), false);
        expect(new Complex.coeff(6.1, 6.1) <= new Precise('6.10000000000000000000'), true);
        expect(new Complex.coeff(2, 8) <= new Precise('4.5'), true);
      });
    });

    group('operator >', () {
      test('operator > num', () {
        expect(new Complex.coeff(6, 2) > 4, true);
        expect(new Complex.coeff(6, 6) > 6, false);
        expect(new Complex.coeff(2, 8) > 4, false);

        expect(new Complex.coeff(6, 2) > 4.5, true);
        expect(new Complex.coeff(6, 6) > 6.0, false);
        expect(new Complex.coeff(2, 8) > 4.5, false);
      });

      test('operator > Integer', () {
        expect(new Complex.coeff(6, 2) > new Integer(4), true);
        expect(new Complex.coeff(6, 6) > new Integer(6), false);
        expect(new Complex.coeff(2, 8) > new Integer(4), false);
      });

      test('operator > Double', () {
        expect(new Complex.coeff(6, 2) > new Double(4.5), true);
        expect(new Complex.coeff(6.1, 6.1) > new Double(6.1), false);
        expect(new Complex.coeff(2, 8) > new Double(4.5), false);
      });

      test('operator > Imaginary', () {
        expect(new Complex.coeff(1, 2) > new Imaginary(4.5), true);
        expect(new Complex.coeff(6.1, 6.1) > new Imaginary(6.1), true);
        expect(new Complex.coeff(-2, 8) > new Imaginary(-4.5), false);
      });

      test('operator > Complex', () {
        expect(new Complex.coeff(1, 2) > new Complex.coeff(0.5, 4), true);
        expect(new Complex.coeff(6.1, 6.1) > new Complex.coeff(6.1, 6.1), false);
        expect(new Complex.coeff(-2, 8) > new Complex.coeff(-1.5, 9), false);
      });

      test('operator > Precise', () {
        expect(new Complex.coeff(6, 2) > new Precise('4.5'), true);
        expect(new Complex.coeff(6.1, 6.1) > new Precise('6.10000000000000000000'), false);
        expect(new Complex.coeff(2, 8) > new Precise('4.5'), false);
      });
    });

    group('operator >=', () {
      test('operator >= num', () {
        expect(new Complex.coeff(6, 2) >= 4, true);
        expect(new Complex.coeff(6, 6) >= 6, true);
        expect(new Complex.coeff(2, 8) >= 4, false);

        expect(new Complex.coeff(6, 2) >= 4.5, true);
        expect(new Complex.coeff(6, 6) >= 6.0, true);
        expect(new Complex.coeff(2, 8) >= 4.5, false);
      });

      test('operator >= Integer', () {
        expect(new Complex.coeff(6, 2) >= new Integer(4), true);
        expect(new Complex.coeff(6, 6) >= new Integer(6), true);
        expect(new Complex.coeff(2, 8) >= new Integer(4), false);
      });

      test('operator >= Double', () {
        expect(new Complex.coeff(6, 2) >= new Double(4.5), true);
        expect(new Complex.coeff(6.1, 6.1) >= new Double(6.1), true);
        expect(new Complex.coeff(2, 8) >= new Double(4.5), false);
      });

      test('operator >= Imaginary', () {
        expect(new Complex.coeff(1, 2) >= new Imaginary(4.5), true);
        expect(new Complex.coeff(6.1, 6.1) >= new Imaginary(6.1), true);
        expect(new Complex.coeff(-2, 8) >= new Imaginary(-4.5), false);
      });

      test('operator >= Complex', () {
        expect(new Complex.coeff(1, 2) >= new Complex.coeff(0.5, 4), true);
        expect(new Complex.coeff(6.1, 6.1) >= new Complex.coeff(6.1, 6.1), true);
        expect(new Complex.coeff(-2, 8) >= new Complex.coeff(-1.5, 9), false);
      });

      test('operator >= Precise', () {
        expect(new Complex.coeff(6, 2) >= new Precise('4.5'), true);
        expect(new Complex.coeff(6.1, 6.1) >= new Precise('6.10000000000000000000'), true);
        expect(new Complex.coeff(2, 8) >= new Precise('4.5'), false);
      });
    });

    group('operator ==', () {
      test('operator == num', () {
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5, 0) == 5, true);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5, 1) == 5, false);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, 0) == 5.5, true);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, -1) == 5.5, false);
      });

      test('operator == Integer', () {
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5, 0) == new Integer(5), true);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5, 1) == new Integer(5), false);
      });

      test('operator == Double', () {
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, 0) == new Double(5.5), true);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, -1) == new Double(5.5), false);
      });

      test('operator == Imaginary', () {
        expect(new Complex.coeff(0, 5.5) == new Imaginary(5.5), true);
        expect(new Complex.coeff(5.5, 5.5) == new Imaginary(5.5), false);
      });

      test('operator == Complex', () {
        expect(new Complex.coeff(0, 5.5) == new Complex.coeff(0, 5.5), true);
        expect(new Complex.coeff(5.5, 5.5) == new Complex.coeff(5, 5.5), false);
        expect(new Complex.coeff(5.5, 0) == new Complex.coeff(5.5, 0), true);
        expect(new Complex.coeff(-2.5, -5.5) == new Complex.coeff(2.5, 5.5), false);
        expect(new Complex.coeff(-2.5, -5.5) == new Complex.coeff(-2.5, -5.5), true);
      });

      test('operator == Precise', () {
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, 0) == new Precise('5.5000000'), true);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, -1) == new Precise('5.5'), false);
        // ignore: unrelated_type_equality_checks
        expect(new Complex.coeff(5.5, 0) == new Precise('5.50000000000000000000001'), false);
      });

      test('operator == Reals', () {
        expect(new Complex(Integer(0), new Imaginary(8)), new Imaginary(8));
        expect(new Complex(Double(0), new Imaginary(new Double(8))), new Imaginary(new Integer(8)));
        expect(new Complex(Double(8), new Imaginary(0)), new Double(8));
        expect(new Complex(Integer(5), new Imaginary(8)), new Complex(Integer(5), new Imaginary(8)));
        expect(new Complex(Double(5), new Imaginary(8)), new Complex(Integer(5), new Imaginary(8)));
        expect(new Complex(Integer(5), new Imaginary(new Integer(8))), new Complex(Integer(5), new Imaginary(8)));
        expect(new Complex(Integer(5), new Imaginary(new Double(8))), new Complex(Integer(5), new Imaginary(8)));
        expect(new Complex(Double(5), new Imaginary(new Double(8))), new Complex(Integer(5), new Imaginary(8)));
        expect(
            new Complex(Precise('5.00000'), new Imaginary(new Double(8))), new Complex(Integer(5), new Imaginary(8)));
        expect(new Complex(Precise('5.00000'), new Imaginary(new Precise('8'))),
            new Complex(Integer(5), new Imaginary(8)));
      });
    });

    test('abs()', () {
      expect(new Complex(Integer(0), new Imaginary(8)).abs(), new Integer(8));
      expect(new Complex(Integer(0), new Imaginary(8)).abs() is Integer, true);
      expect(new Complex(Integer(22), new Imaginary(0)).abs(), new Integer(22));
      expect(new Complex(Integer(3), new Imaginary(4)).abs(), new Integer(5));
      expect(new Complex(Integer(4), new Imaginary(5)).abs(), new Double(sqrt(41)));
      expect(new Complex(Integer(4), new Imaginary(5)).abs() is Double, true);
    });

    test('complexModulus', () {
      expect(new Complex(Integer(0), new Imaginary(8)).complexModulus, new Integer(8));
      expect(new Complex(Integer(0), new Imaginary(8)).complexModulus is Integer, true);
      expect(new Complex(Integer(22), new Imaginary(0)).complexModulus, new Integer(22));
      expect(new Complex(Integer(3), new Imaginary(4)).complexModulus, new Integer(5));
      expect(new Complex(Integer(4), new Imaginary(5)).complexModulus, new Double(sqrt(41)));
      expect(new Complex(Integer(4), new Imaginary(5)).complexModulus is Double, true);
    });

    test('complexNorm', () {
      expect(new Complex(Integer(0), new Imaginary(8)).complexNorm, new Integer(8));
      expect(new Complex(Integer(0), new Imaginary(8)).complexNorm is Integer, true);
      expect(new Complex(Integer(22), new Imaginary(0)).complexNorm, new Integer(22));
      expect(new Complex(Integer(3), new Imaginary(4)).complexNorm, new Integer(5));
      expect(new Complex(Integer(4), new Imaginary(5)).complexNorm, new Double(sqrt(41)));
      expect(new Complex(Integer(4), new Imaginary(5)).complexNorm is Double, true);
    });

    test('absoluteSquare', () {
      expect(new Complex(Integer(3), new Imaginary(4)).absoluteSquare, new Double(25));
      expect(new Complex(Integer(4), new Imaginary(5)).absoluteSquare, new Double(41));
    });

    test('ceil', () {
      expect(new Complex(Double(3.2), new Imaginary(43)).ceil(), new Integer(4));
      expect(new Complex(Double(-4.9), new Imaginary(55)).ceil(), new Integer(-4));
    });

    test('clamp', () {
      expect(new Complex(Double(3.2), new Imaginary(43)).clamp(0, 2), new Complex(Integer(2), new Imaginary(43)));
      expect(new Complex(Double(-4.9), new Imaginary(55)).clamp(-4.5, -2.1), new Complex.coeff(-4.5, 55));
    });

    test('complexArgument', () {
      expect(new Complex.coeff(1, 0).complexArgument, new Integer(0));
      expect(new Complex.coeff(1, 1).complexArgument, new Double(0.25 * pi));
      expect(new Complex.coeff(0, 1).complexArgument, new Double(0.5 * pi));
      expect(new Complex.coeff(-1, 0).complexArgument, new Double(pi));
      expect(new Complex.coeff(0, -1).complexArgument, new Double(-0.5 * pi));
    });

    test('phase', () {
      expect(new Complex.coeff(1, 0).phase, new Integer(0));
      expect(new Complex.coeff(1, 1).phase, new Double(0.25 * pi));
      expect(new Complex.coeff(0, 1).phase, new Double(0.5 * pi));
      expect(new Complex.coeff(-1, 0).phase, new Double(pi));
      expect(new Complex.coeff(0, -1).phase, new Double(-0.5 * pi));
    });

    test('floor', () {
      expect(new Complex(Double(3.2), new Imaginary(43)).floor(), new Integer(3));
      expect(new Complex(Double(-4.9), new Imaginary(55)).floor(), new Integer(-5));
    });

    test('isInfinite', () {
      expect(new Complex.coeff(0, 0).isInfinite, false);
      expect(new Complex.coeff(1, 1).isInfinite, false);
      expect(new Complex.coeff(double.infinity, 1).isInfinite, true);
      expect(new Complex.coeff(double.negativeInfinity, 1).isInfinite, true);
      expect(new Complex.coeff(1, double.infinity).isInfinite, false);
      expect(new Complex.coeff(1, double.negativeInfinity).isInfinite, false);
      expect(new Complex(Double.infinity, new Imaginary(1)).isInfinite, true);
      expect(new Complex(Double.negInfinity, new Imaginary(1)).isInfinite, true);
      expect(new Complex(new Double(1), new Imaginary(double.infinity)).isInfinite, false);
      expect(new Complex(new Double(1), new Imaginary(Double.negInfinity)).isInfinite, false);
    });

    test('isInteger', () {
      expect(new Complex.coeff(0, 0.3).isInteger, true);
      expect(new Complex.coeff(1, 1.6).isInteger, true);
      expect(new Complex.coeff(0.5, 0).isInteger, false);
      expect(new Complex.coeff(1.3, 6).isInteger, false);
    });

    test('isNaN', () {
      expect(new Complex.coeff(0, 0).isNaN, false);
      expect(new Complex.coeff(double.nan, 5).isNaN, true);
      expect(new Complex.coeff(5, double.nan).isNaN, false);
    });

    test('reciprocal', () {
      expect(new Complex.coeff(2, 4).reciprocal(), new Complex.coeff(0.1, -0.2));
      expect(new Complex.coeff(-2, -4).reciprocal(), new Complex.coeff(-0.1, 0.2));
      expect(new Complex.coeff(0, 0).reciprocal(), new Complex.coeff(double.nan, double.nan));
    });

    test('isNegative', () {
      expect(new Complex.coeff(0, 0).isNegative, false);
      expect(new Complex.coeff(0, -1).isNegative, false);
      expect(new Complex.coeff(1, -1).isNegative, false);
      expect(new Complex.coeff(-1, 1).isNegative, true);
    });

    test('round', () {
      expect(new Complex.coeff(2.8, 4.3).round(), new Integer(3));
      expect(new Complex.coeff(2.5, 4.3).round(), new Integer(3));
      expect(new Complex.coeff(2.499, 4.3).round(), new Integer(2));
      expect(new Complex.coeff(-2.8, 4.3).round(), new Integer(-3));
      expect(new Complex.coeff(-2.5, 4.3).round(), new Integer(-3));
      expect(new Complex.coeff(-2.499, 4.3).round(), new Integer(-2));
    });

    test('truncate', () {
      expect(new Complex.coeff(2.8, 4.3).truncate(), new Integer(2));
      expect(new Complex.coeff(2.5, 4.3).truncate(), new Integer(2));
      expect(new Complex.coeff(2.99999, 4.3).truncate(), new Integer(2));
      expect(new Complex.coeff(-2.8, 4.3).truncate(), new Integer(-2));
      expect(new Complex.coeff(-2.5, 4.3).truncate(), new Integer(-2));
      expect(new Complex.coeff(-3, 4.3).truncate(), new Integer(-3));
    });

    test('toInt', () {
      expect(new Complex.coeff(2.8, 4.3).toInt(), 2);
      expect(new Complex.coeff(2.5, 4.3).toInt(), 2);
      expect(new Complex.coeff(2.99999, 4.3).toInt(), 2);
      expect(new Complex.coeff(-2.8, 4.3).toInt(), -2);
      expect(new Complex.coeff(-2.5, 4.3).toInt(), -2);
      expect(new Complex.coeff(-3, 4.3).toInt(), -3);
    });

    test('toDouble', () {
      expect(new Complex.coeff(2.8, 4.3).toDouble(), 2.8);
      expect(new Complex.coeff(2.99999, 4.3).toDouble(), 2.99999);
      expect(new Complex.coeff(-2.8, 4.3).toDouble(), -2.8);
      expect(new Complex.coeff(-3, 4.3).toDouble(), -3);
    });

    test('remainder', () {
      expect(new Complex.coeff(2.8, 4.3).remainder(2).toDouble(), closeTo(0.8, 0.000001));
      expect(new Complex.coeff(-2.8, 4.3).remainder(2).toDouble(), closeTo(-0.8, 0.000001));
    });

    test('toJson', () {
      final Complex c = new Complex.coeff(-9.34, 5);
      final Map<String, dynamic> json = c.toJson();
      expect(json['real'], isA<Map<String, dynamic>>());
      expect(json['real']['d'], -9.34);
      expect(json['imag'], isA<Map<String, dynamic>>());
      expect(json['imag']['imag'], isA<Map<String, dynamic>>());
      expect(json['imag']['imag']['i'], 5);
    });

    test('remainder', () {
      expect(new Complex.coeff(2.8, 4.3).toString(), '2.8 + 4.3i');
      expect(new Complex.coeff(-2.8, -4.3).toString(), '-2.8 - 4.3i');
    });
  });
}
