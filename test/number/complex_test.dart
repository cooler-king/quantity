import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/number.dart';

void main() {
  group('Complex', () {
    test('zeros', () {
      final complex0a = Complex(Integer.zero, Imaginary(0));
      final complex0b = Complex(Double(0), Imaginary(Double(0)));

      expect(complex0a.real.toDouble() == 0, true);
      expect(complex0a.imaginary.value.toDouble() == 0, true);

      expect(complex0a == complex0b, true);
    });

    group('constructors', () {
      test('coeff', () {
        final c1 = Complex.coeff(1, 2);
        expect(c1.real is Integer, true);
        expect(c1.real, Integer(1));
        expect(c1.imag.value is Integer, true);
        expect(c1.imag.value, Integer(2));

        final c2 = Complex.coeff(3.3, 4.4);
        expect(c2.real is Double, true);
        expect(c2.real, Double(3.3));
        expect(c2.imag.value is Double, true);
        expect(c2.imag.value, Double(4.4));
      });
    });

    group('operator +', () {
      test('operator + num', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 + 7, Integer(7));
        expect(c0 + 7 is Integer, true);
        expect(c0 + 0.001, Double(0.001));
        expect(c0 + 0.001 is Double, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 + 8, Complex.coeff(9.1, 2.2));
        expect(c1 + 0.02, Complex.coeff(1.12, 2.2));
      });

      test('operator + Integer', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 + Integer(7), Integer(7));
        expect(c0 + Integer(7) is Integer, true);
        expect(c0 + Integer(-10), Integer(-10));
        expect(c0 + Integer(-10) is Integer, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 + Integer(8), Complex.coeff(9.1, 2.2));
      });

      test('operator + Double', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 + Double(7.5), Double(7.5));
        expect(c0 + Double(7.5) is Double, true);
        expect(c0 + Double(-10.1), Double(-10.1));
        expect(c0 + Double(-10.1) is Double, true);
        expect(c0 + Double(17), Integer(17));
        expect(c0 + Double(17) is Integer, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 + Double(0.02), Complex.coeff(1.12, 2.2));
      });

      test('operator + Imaginary', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 + Imaginary(0), Complex.coeff(0, 0));
        expect(c0 + Imaginary(5.6), Imaginary(5.6));
        expect(c0 + Imaginary(-21.01), Imaginary(-21.01));

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 + Imaginary(0), Complex.coeff(1.1, 2.2));
        expect(c1 + Imaginary(5.6), Complex.coeff(1.1, 7.8));
        expect(c1 + Imaginary(-21), Complex.coeff(1.1, -18.8));
      });

      test('operator + Complex', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 + Complex.coeff(0, 0), Integer(0));
        expect(c0 + Complex.coeff(0, 0) is Integer, true);
        expect(c0 + Complex.coeff(0, 5), Imaginary(5));
        expect(c0 + Complex.coeff(0, 5) is Imaginary, true);
        expect(c0 + Complex.coeff(5, 0), Integer(5));
        expect(c0 + Complex.coeff(5, 0) is Integer, true);
        expect(c0 + Complex.coeff(6.7, 0), Double(6.7));
        expect(c0 + Complex.coeff(6.7, 0) is Double, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 + Complex.coeff(0, 0), Complex.coeff(1.1, 2.2));
        expect(c1 + Complex.coeff(4.3, 0), Complex.coeff(5.4, 2.2));
        expect(c1 + Complex.coeff(0, 6.2), Complex.coeff(1.1, 8.4));
      });

      test('operator + Precise', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 + Precise('7.5'), Precise('7.5'));
        expect(c0 + Precise('7.5') is Precise, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 + Precise('0.0000000002'),
            Complex(Precise('1.1000000002'), Imaginary(2.2)));
      });
    });

    group('operator -', () {
      test('operator - num', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 - 7, Integer(-7));
        expect(c0 - 7 is Integer, true);
        expect(c0 - 0.001, Double(-0.001));
        expect(c0 - 0.001 is Double, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 - 8, Complex.coeff(-6.9, 2.2));
        expect(c1 - 0.02, Complex.coeff(1.08, 2.2));
      });

      test('operator - Integer', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 - Integer(7), Integer(-7));
        expect(c0 - Integer(7) is Integer, true);
        expect(c0 - Integer(-10), Integer(10));
        expect(c0 - Integer(-10) is Integer, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 - Integer(8), Complex.coeff(-6.9, 2.2));
      });

      test('operator - Double', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 - Double(7.5), Double(-7.5));
        expect(c0 - Double(7.5) is Double, true);
        expect(c0 - Double(-10.1), Double(10.1));
        expect(c0 - Double(-10.1) is Double, true);
        expect(c0 - Double(17), Integer(-17));
        expect(c0 - Double(17) is Integer, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 - Double(0.02), Complex.coeff(1.08, 2.2));
      });

      test('operator - Imaginary', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 - Imaginary(0), Complex.coeff(0, 0));
        expect(c0 - Imaginary(5.6), Imaginary(-5.6));
        expect(c0 - Imaginary(-21.01), Imaginary(21.01));

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 - Imaginary(0), Complex.coeff(1.1, 2.2));
        expect(c1 - Imaginary(5.5), Complex.coeff(1.1, -3.3));
        expect(c1 - Imaginary(-21), Complex.coeff(1.1, 23.2));
      });

      test('operator - Complex', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 - Complex.coeff(0, 0), Integer(0));
        expect(c0 - Complex.coeff(0, 0) is Integer, true);
        expect(c0 - Complex.coeff(0, 5), Imaginary(-5));
        expect(c0 - Complex.coeff(0, 5) is Imaginary, true);
        expect(c0 - Complex.coeff(5, 0), Integer(-5));
        expect(c0 - Complex.coeff(5, 0) is Integer, true);
        expect(c0 - Complex.coeff(6.7, 0), Double(-6.7));
        expect(c0 - Complex.coeff(6.7, 0) is Double, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 - Complex.coeff(0, 0), Complex.coeff(1.1, 2.2));
        expect(c1 - Complex.coeff(4.7, 0), Complex.coeff(-3.6, 2.2));
        expect(c1 - Complex.coeff(0, 6.2), Complex.coeff(1.1, -4));
      });

      test('operator - Precise', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 - Precise('7.5'), Precise('-7.5'));
        expect(c0 - Precise('7.5') is Precise, true);

        final c1 = Complex.coeff(1.1, 2.2);
        expect(c1 - Precise('0.0000000002'),
            Complex(Precise('1.0999999998'), Imaginary(2.2)));
      });
    });

    group('operator *', () {
      test('operator * num', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 * 0, Integer(0));
        expect(c0 * 0 is Integer, true);
        expect(c0 * 1, Integer(0));
        expect(c0 * 1 is Integer, true);
        expect(c0 * 3.6, Integer(0));
        expect(c0 * 3.6 is Integer, true);
        expect(c0 * -9.1, Integer(0));
        expect(c0 * -9.1 is Integer, true);

        final c1 = Complex.coeff(2, 3);
        expect(c1 * 0, Integer(0));
        expect(c1 * 0 is Integer, true);
        expect(c1 * 1, Complex.coeff(2, 3));
        expect(c1 * 3.6, Complex.coeff(7.2, 10.8));
        expect(c1 * -2.5, Complex.coeff(-5, -7.5));
      });

      test('operator * Integer', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 * Integer(0), Integer(0));
        expect(c0 * Integer(0) is Integer, true);
        expect(c0 * Integer(1), Integer(0));
        expect(c0 * Integer(1) is Integer, true);
        expect(c0 * Integer(-9), Integer(0));
        expect(c0 * Integer(-9) is Integer, true);

        final c1 = Complex.coeff(2, 3);
        expect(c1 * Integer(0), Integer(0));
        expect(c1 * Integer(0) is Integer, true);
        expect(c1 * Integer(1), Complex.coeff(2, 3));
        expect(c1 * Integer(3), Complex.coeff(6, 9));
        expect(c1 * Integer(-2), Complex.coeff(-4, -6));
      });

      test('operator * Double', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 * Double(0), Integer(0));
        expect(c0 * Double(0) is Integer, true);
        expect(c0 * Double(1), Integer(0));
        expect(c0 * Double(1) is Integer, true);
        expect(c0 * Double(-9), Integer(0));
        expect(c0 * Double(-9) is Integer, true);

        final c1 = Complex.coeff(2, 3);
        expect(c1 * Double(0), Integer(0));
        expect(c1 * Double(0) is Integer, true);
        expect(c1 * Double(1.5), Complex.coeff(3, 4.5));
        expect(c1 * Double(-2.5), Complex.coeff(-5, -7.5));
      });

      test('operator * Imaginary', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 * Imaginary(0), Integer(0));
        expect(c0 * Imaginary(1), Integer(0));
        expect(c0 * Imaginary(-9), Integer(0));

        final c1 = Complex.coeff(2, 3);
        expect(c1 * Imaginary(0), Integer(0));
        expect(c1 * Imaginary(1), Complex.coeff(-3, 2));
        expect(c1 * Imaginary(3), Complex.coeff(-9, 6));
        expect(c1 * Imaginary(-2.5), Complex.coeff(7.5, -5));
      });

      test('operator * Complex', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 * Complex.coeff(0, 0), Integer(0));
        expect(c0 * Complex.coeff(5, 6), Integer(0));
        expect(c0 * Complex.coeff(-9.1, -12.1), Integer(0));

        final c1 = Complex.coeff(2, 3);
        expect(c1 * Complex.coeff(0, 0), Integer(0));
        expect(c1 * Complex.coeff(1, 2), Complex.coeff(-4, 7));
        expect(c1 * Complex.coeff(-3, -4), Complex.coeff(6, -17));
        expect(c1 * Complex.coeff(2.5, 1.5), Complex.coeff(0.5, 10.5));
      });

      test('operator * Precise', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 * Precise('0'), Precise('0'));
        expect(c0 * Precise('0') is Precise, true);
        expect(c0 * Precise('1'), Precise('0'));
        expect(c0 * Precise('1') is Precise, true);
        expect(c0 * Precise('-9'), Precise('0'));
        expect(c0 * Precise('-9') is Precise, true);

        final c1 = Complex.coeff(2, 3);
        expect(c1 * Precise('0'), Precise('0'));
        expect(c1 * Precise('1'), Complex.coeff(2, 3));
        expect(c1 * Precise('-9'), Complex.coeff(-18, -27));

        final c2 = Complex.coeff(2, 3) * Precise('-2.0000002') as Complex;
        expect(c2.real is Precise, true);
        expect(c2.real, Precise('-4.0000004'));
        expect(c2.imag.value is Precise, true);
        expect(c2.imag.value, Precise('-6.0000006'));
      });
    });

    group('operator /', () {
      test('operator / num', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 / 1, Integer(0));
        expect(c0 / 1 is Integer, true);
        expect(c0 / 3.6, Integer(0));
        expect(c0 / 3.6 is Integer, true);
        expect(c0 / -9.1, Integer(0));
        expect(c0 / -9.1 is Integer, true);
        expect(c0 / 0, Complex(Double.NaN, Imaginary(Double.NaN)));
        expect(c0 / double.infinity, Integer(0));
        expect(c0 / double.negativeInfinity, Integer(0));
        expect(c0 / double.nan, Complex(Double.NaN, Imaginary(Double.NaN)));

        final c1 = Complex.coeff(2, 3);
        expect(c1 / 1, Complex.coeff(2, 3));
        expect(c1 / 4, Complex.coeff(0.5, 0.75));
        expect(c1 / 0, Complex(Double.infinity, Imaginary(Double.infinity)));

        final c2 = Complex.coeff(-5, -2);
        expect(c2 / 1, Complex.coeff(-5, -2));
        expect(c2 / -4, Complex.coeff(1.25, 0.5));
        expect(
            c2 / 0, Complex(Double.negInfinity, Imaginary(Double.negInfinity)));
      });

      test('operator / Integer', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 / Integer(1), Integer(0));
        expect(c0 / Integer(1) is Integer, true);
        expect(c0 / Integer(3), Integer(0));
        expect(c0 / Integer(3) is Integer, true);
        expect(c0 / Integer(-9), Integer(0));
        expect(c0 / Integer(-9) is Integer, true);
        expect(c0 / Integer(0), Complex(Double.NaN, Imaginary(Double.NaN)));

        final c1 = Complex.coeff(2, 3);
        expect(c1 / Integer(1), Complex.coeff(2, 3));
        expect(c1 / Integer(4), Complex.coeff(0.5, 0.75));
        expect(c1 / Integer(0),
            Complex(Double.infinity, Imaginary(Double.infinity)));

        final c2 = Complex.coeff(-5, -2);
        expect(c2 / Integer(4), Complex.coeff(-1.25, -0.5));
        expect(c2 / Integer(-4), Complex.coeff(1.25, 0.5));
        expect(c2 / Integer(0),
            Complex(Double.negInfinity, Imaginary(Double.negInfinity)));
      });

      test('operator / Double', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 / Double(1), Integer(0));
        expect(c0 / Double(1) is Integer, true);
        expect(c0 / Double(3.3), Integer(0));
        expect(c0 / Double(3.3) is Integer, true);
        expect(c0 / Double(-9.9), Integer(0));
        expect(c0 / Double(-9.9) is Integer, true);
        expect(c0 / Double(0), Complex(Double.NaN, Imaginary(Double.NaN)));

        final c1 = Complex.coeff(2, 3);
        expect(c1 / Double(0.5), Complex.coeff(4, 6));
        expect(c1 / Double(-0.25), Complex.coeff(-8, -12));
        expect(c1 / Double(0),
            Complex(Double.infinity, Imaginary(Double.infinity)));

        final c2 = Complex.coeff(-5, -2);
        expect(c2 / Double(0.2), Complex.coeff(-25, -10));
        expect(c2 / Double(-0.1), Complex.coeff(50, 20));
        expect(c2 / Double(0),
            Complex(Double.negInfinity, Imaginary(Double.negInfinity)));
      });

      test('operator / Imaginary', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 / Imaginary(1), Integer(0));
        expect(c0 / Imaginary(1) is Integer, true);
        expect(c0 / Imaginary(3), Integer(0));
        expect(c0 / Imaginary(3) is Integer, true);
        expect(c0 / Imaginary(-9), Integer(0));
        expect(c0 / Imaginary(-9) is Integer, true);
        expect(c0 / Imaginary(0), Complex(Double.NaN, Imaginary(Double.NaN)));

        final c1 = Complex.coeff(2, 8);
        expect(c1 / Imaginary(1), Complex.coeff(8, -2));
        expect(c1 / Imaginary(4), Complex.coeff(2, -0.5));
        expect(c1 / Imaginary(0),
            Complex(Double.infinity, Imaginary(Double.negInfinity)));

        final c2 = Complex.coeff(-5, -2);
        expect(c2 / Imaginary(4), Complex.coeff(-0.5, 1.25));
        expect(c2 / Imaginary(-4), Complex.coeff(0.5, -1.25));
        expect(c2 / Imaginary(0),
            Complex(Double.negInfinity, Imaginary(Double.infinity)));
      });

      test('operator / Complex', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 / Complex.coeff(1, 1), Integer(0));
        expect(c0 / Complex.coeff(1, 1) is Integer, true);
        expect(c0 / Complex.coeff(3, 3), Integer(0));
        expect(c0 / Complex.coeff(3, 3) is Integer, true);
        expect(c0 / Complex.coeff(-9.9, -9.9), Integer(0));
        expect(c0 / Complex.coeff(-9.9, -9.9) is Integer, true);
        expect(c0 / Complex.coeff(1, 0), Integer(0));
        expect(c0 / Complex.coeff(0, 1), Integer(0));
        expect(c0 / Complex.coeff(0, 0),
            Complex(Double.NaN, Imaginary(Double.NaN)));

        final c1 = Complex.coeff(2, 8);
        expect(c1 / Complex.coeff(1, 1), Complex.coeff(5, 3));
        expect(c1 / Complex.coeff(4, 2), Complex.coeff(1.2, 1.4));
        expect(c1 / Complex.coeff(1, 0), Complex.coeff(2, 8));
        expect(c1 / Complex.coeff(0, 1), Complex.coeff(8, -2));
        expect(c1 / Complex.coeff(0, 0),
            Complex(Double.NaN, Imaginary(Double.NaN)));

        final c2 = Complex.coeff(-5, -2);
        expect(c2 / Complex.coeff(4, 2), Complex.coeff(-1.2, 0.1));
        expect(c2 / Complex.coeff(-4, -2), Complex.coeff(1.2, -0.1));
        expect(c2 / Complex.coeff(1, 0), Complex.coeff(-5, -2));
        expect(c2 / Complex.coeff(0, 1), Complex.coeff(-2, 5));
        expect(c2 / Complex.coeff(0, 0),
            Complex(Double.NaN, Imaginary(Double.NaN)));

        final c3 = Complex.coeff(3, 2);
        expect(c3 / Complex.coeff(4, -3), Complex.coeff(0.24, 0.68));
      });
    });

    group('operator ~/', () {
      test('operator ~/ num', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 ~/ 1, Complex.coeff(0, 0));

        final c1 = Complex.coeff(45, 65);
        expect(c1 ~/ 1, Complex.coeff(45, 65));
        expect(c1 ~/ 5, Complex.coeff(9, 13));
        expect(c1 ~/ -5, Complex.coeff(-9, -13));
        expect(c1 ~/ 5.1, Complex.coeff(8, 12));
        expect(c1 ~/ -5.1, Complex.coeff(-8, -12));
      });

      test('operator ~/ Integer', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 ~/ Integer(1), Complex.coeff(0, 0));

        final c1 = Complex.coeff(45, 65);
        expect(c1 ~/ Integer(1), Complex.coeff(45, 65));
        expect(c1 ~/ Integer(5), Complex.coeff(9, 13));
        expect(c1 ~/ Integer(-5), Complex.coeff(-9, -13));
      });

      test('operator ~/ Double', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 ~/ Double(1.5), Complex.coeff(0, 0));

        final c1 = Complex.coeff(45, 65);
        expect(c1 ~/ Double(5.1), Complex.coeff(8, 12));
        expect(c1 ~/ Double(-5.1), Complex.coeff(-8, -12));
      });

      test('operator ~/ Imaginary', () {
        final c0 = Complex.coeff(0, 0);
        expect(c0 ~/ Imaginary(1.5), Complex.coeff(0, 0));

        final c1 = Complex.coeff(45, 65);
        expect(c1 ~/ Imaginary(5), Complex.coeff(13, -9));
        expect(c1 ~/ Imaginary(-5.1), Complex.coeff(-12, 8));
      });
    });

    group('operator ^', () {
      test('operator ^ num', () {
        final c0 = Complex.coeff(4, 3) ^ 0;
        expect(c0, Integer(1));
        expect(c0, isA<Integer>());

        final c1 = Complex.coeff(4, 3) ^ 1 as Complex;
        expect(c1, Complex.coeff(4, 3));

        final c2 = Complex.coeff(4, 3) ^ 4 as Complex;
        expect(c2.real.toDouble(), -527);
        expect(c2.imag.value.toDouble(), closeTo(336, 0.000000000001));
      });

      test('operator ^ Integer', () {
        final c0 = Complex.coeff(4, 3) ^ Integer(0);
        expect(c0, Integer(1));
        expect(c0, isA<Integer>());

        final c1 = Complex.coeff(4, 3) ^ Integer(1) as Complex;
        expect(c1, Complex.coeff(4, 3));

        final c2 = Complex.coeff(4, 3) ^ Integer(4) as Complex;
        expect(c2.real.toDouble(), -527);
        expect(c2.imag.value.toDouble(), closeTo(336, 0.000000000001));
      });

      test('operator ^ Double', () {
        final c0 = Complex.coeff(4, 3) ^ Double(0);
        expect(c0, Integer(1));
        expect(c0, isA<Integer>());

        final c1 = Complex.coeff(4, 3) ^ Double(1) as Complex;
        expect(c1, Complex.coeff(4, 3));

        final c2 = Complex.coeff(4, 3) ^ Double(4) as Complex;
        expect(c2.real.toDouble(), -527);
        expect(c2.imag.value.toDouble(), closeTo(336, 0.000000000001));
      });

      test('operator ^ Imaginary (exception)', () {
        expect(() => Complex.coeff(1, 2) ^ Imaginary(3),
            throwsA(isA<NumberException>()));
      });

      test('operator ^ Complex (exception)', () {
        expect(() => Complex.coeff(1, 2) ^ Complex.coeff(2, 5),
            throwsA(isA<NumberException>()));
      });
    });

    test('operator % (exception)', () {
      expect(() => Complex.coeff(1, 2) % 2, throwsA(isA<NumberException>()));
    });

    test('negation operator -', () {
      expect(-Complex.coeff(1, 2), Complex.coeff(-1, -2));
      expect(-Complex.coeff(0, -2), Complex.coeff(0, 2));
      expect(-Complex.coeff(-1, 0), Complex.coeff(1, 0));
    });

    group('operator <', () {
      test('operator < num', () {
        expect(Complex.coeff(6, 2) < 4, false);
        expect(Complex.coeff(6, 6) < 6, false);
        expect(Complex.coeff(2, 8) < 4, true);

        expect(Complex.coeff(6, 2) < 4.5, false);
        expect(Complex.coeff(6, 6) < 6.0, false);
        expect(Complex.coeff(2, 8) < 4.5, true);
      });

      test('operator < Integer', () {
        expect(Complex.coeff(6, 2) < Integer(4), false);
        expect(Complex.coeff(6, 6) < Integer(6), false);
        expect(Complex.coeff(2, 8) < Integer(4), true);
      });

      test('operator < Double', () {
        expect(Complex.coeff(6, 2) < Double(4.5), false);
        expect(Complex.coeff(6.1, 6.1) < Double(6.1), false);
        expect(Complex.coeff(2, 8) < Double(4.5), true);
      });

      test('operator < Imaginary', () {
        expect(Complex.coeff(1, 2) < Imaginary(4.5), false);
        expect(Complex.coeff(6.1, 6.1) < Imaginary(6.1), false);
        expect(Complex.coeff(-2, 8) < Imaginary(-4.5), true);
      });

      test('operator < Complex', () {
        expect(Complex.coeff(1, 2) < Complex.coeff(0.5, 4), false);
        expect(Complex.coeff(6.1, 6.1) < Complex.coeff(6.1, 6.1), false);
        expect(Complex.coeff(-2, 8) < Complex.coeff(-1.5, 9), true);
      });

      test('operator < Precise', () {
        expect(Complex.coeff(6, 2) < Precise('4.5'), false);
        expect(
            Complex.coeff(6.1, 6.1) < Precise('6.10000000000000000000'), false);
        expect(Complex.coeff(2, 8) < Precise('4.5'), true);
      });
    });

    group('operator <=', () {
      test('operator <= num', () {
        expect(Complex.coeff(6, 2) <= 4, false);
        expect(Complex.coeff(6, 6) <= 6, true);
        expect(Complex.coeff(2, 8) <= 4, true);

        expect(Complex.coeff(6, 2) <= 4.5, false);
        expect(Complex.coeff(6, 6) <= 6.0, true);
        expect(Complex.coeff(2, 8) <= 4.5, true);
      });

      test('operator <= Integer', () {
        expect(Complex.coeff(6, 2) <= Integer(4), false);
        expect(Complex.coeff(6, 6) <= Integer(6), true);
        expect(Complex.coeff(2, 8) <= Integer(4), true);
      });

      test('operator <= Double', () {
        expect(Complex.coeff(6, 2) <= Double(4.5), false);
        expect(Complex.coeff(6.1, 6.1) <= Double(6.1), true);
        expect(Complex.coeff(2, 8) <= Double(4.5), true);
      });

      test('operator <= Imaginary', () {
        expect(Complex.coeff(1, 2) <= Imaginary(4.5), false);
        expect(Complex.coeff(6.1, 6.1) <= Imaginary(6.1), false);
        expect(Complex.coeff(-2, 8) <= Imaginary(-4.5), true);
      });

      test('operator < Complex', () {
        expect(Complex.coeff(1, 2) <= Complex.coeff(0.5, 4), false);
        expect(Complex.coeff(6.1, 6.1) <= Complex.coeff(6.1, 6.1), true);
        expect(Complex.coeff(-2, 8) <= Complex.coeff(-1.5, 9), true);
      });

      test('operator < Precise', () {
        expect(Complex.coeff(6, 2) <= Precise('4.5'), false);
        expect(
            Complex.coeff(6.1, 6.1) <= Precise('6.10000000000000000000'), true);
        expect(Complex.coeff(2, 8) <= Precise('4.5'), true);
      });
    });

    group('operator >', () {
      test('operator > num', () {
        expect(Complex.coeff(6, 2) > 4, true);
        expect(Complex.coeff(6, 6) > 6, false);
        expect(Complex.coeff(2, 8) > 4, false);

        expect(Complex.coeff(6, 2) > 4.5, true);
        expect(Complex.coeff(6, 6) > 6.0, false);
        expect(Complex.coeff(2, 8) > 4.5, false);
      });

      test('operator > Integer', () {
        expect(Complex.coeff(6, 2) > Integer(4), true);
        expect(Complex.coeff(6, 6) > Integer(6), false);
        expect(Complex.coeff(2, 8) > Integer(4), false);
      });

      test('operator > Double', () {
        expect(Complex.coeff(6, 2) > Double(4.5), true);
        expect(Complex.coeff(6.1, 6.1) > Double(6.1), false);
        expect(Complex.coeff(2, 8) > Double(4.5), false);
      });

      test('operator > Imaginary', () {
        expect(Complex.coeff(1, 2) > Imaginary(4.5), true);
        expect(Complex.coeff(6.1, 6.1) > Imaginary(6.1), true);
        expect(Complex.coeff(-2, 8) > Imaginary(-4.5), false);
      });

      test('operator > Complex', () {
        expect(Complex.coeff(1, 2) > Complex.coeff(0.5, 4), true);
        expect(Complex.coeff(6.1, 6.1) > Complex.coeff(6.1, 6.1), false);
        expect(Complex.coeff(-2, 8) > Complex.coeff(-1.5, 9), false);
      });

      test('operator > Precise', () {
        expect(Complex.coeff(6, 2) > Precise('4.5'), true);
        expect(
            Complex.coeff(6.1, 6.1) > Precise('6.10000000000000000000'), false);
        expect(Complex.coeff(2, 8) > Precise('4.5'), false);
      });
    });

    group('operator >=', () {
      test('operator >= num', () {
        expect(Complex.coeff(6, 2) >= 4, true);
        expect(Complex.coeff(6, 6) >= 6, true);
        expect(Complex.coeff(2, 8) >= 4, false);

        expect(Complex.coeff(6, 2) >= 4.5, true);
        expect(Complex.coeff(6, 6) >= 6.0, true);
        expect(Complex.coeff(2, 8) >= 4.5, false);
      });

      test('operator >= Integer', () {
        expect(Complex.coeff(6, 2) >= Integer(4), true);
        expect(Complex.coeff(6, 6) >= Integer(6), true);
        expect(Complex.coeff(2, 8) >= Integer(4), false);
      });

      test('operator >= Double', () {
        expect(Complex.coeff(6, 2) >= Double(4.5), true);
        expect(Complex.coeff(6.1, 6.1) >= Double(6.1), true);
        expect(Complex.coeff(2, 8) >= Double(4.5), false);
      });

      test('operator >= Imaginary', () {
        expect(Complex.coeff(1, 2) >= Imaginary(4.5), true);
        expect(Complex.coeff(6.1, 6.1) >= Imaginary(6.1), true);
        expect(Complex.coeff(-2, 8) >= Imaginary(-4.5), false);
      });

      test('operator >= Complex', () {
        expect(Complex.coeff(1, 2) >= Complex.coeff(0.5, 4), true);
        expect(Complex.coeff(6.1, 6.1) >= Complex.coeff(6.1, 6.1), true);
        expect(Complex.coeff(-2, 8) >= Complex.coeff(-1.5, 9), false);
      });

      test('operator >= Precise', () {
        expect(Complex.coeff(6, 2) >= Precise('4.5'), true);
        expect(
            Complex.coeff(6.1, 6.1) >= Precise('6.10000000000000000000'), true);
        expect(Complex.coeff(2, 8) >= Precise('4.5'), false);
      });
    });

    group('operator ==', () {
      test('operator == num', () {
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5, 0) == 5, true);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5, 1) == 5, false);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, 0) == 5.5, true);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, -1) == 5.5, false);
      });

      test('operator == Integer', () {
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5, 0) == Integer(5), true);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5, 1) == Integer(5), false);
      });

      test('operator == Double', () {
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, 0) == Double(5.5), true);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, -1) == Double(5.5), false);
      });

      test('operator == Imaginary', () {
        expect(Complex.coeff(0, 5.5) == Imaginary(5.5), true);
        expect(Complex.coeff(5.5, 5.5) == Imaginary(5.5), false);
      });

      test('operator == Complex', () {
        expect(Complex.coeff(0, 5.5) == Complex.coeff(0, 5.5), true);
        expect(Complex.coeff(5.5, 5.5) == Complex.coeff(5, 5.5), false);
        expect(Complex.coeff(5.5, 0) == Complex.coeff(5.5, 0), true);
        expect(Complex.coeff(-2.5, -5.5) == Complex.coeff(2.5, 5.5), false);
        expect(Complex.coeff(-2.5, -5.5) == Complex.coeff(-2.5, -5.5), true);
      });

      test('operator == Precise', () {
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, 0) == Precise('5.5000000'), true);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, -1) == Precise('5.5'), false);
        // ignore: unrelated_type_equality_checks
        expect(Complex.coeff(5.5, 0) == Precise('5.50000000000000000000001'),
            false);
      });

      test('operator == Reals', () {
        expect(Complex(Integer(0), Imaginary(8)), Imaginary(8));
        expect(Complex(Double(0), Imaginary(Double(8))), Imaginary(Integer(8)));
        expect(Complex(Double(8), Imaginary(0)), Double(8));
        expect(Complex(Integer(5), Imaginary(8)),
            Complex(Integer(5), Imaginary(8)));
        expect(Complex(Double(5), Imaginary(8)),
            Complex(Integer(5), Imaginary(8)));
        expect(Complex(Integer(5), Imaginary(Integer(8))),
            Complex(Integer(5), Imaginary(8)));
        expect(Complex(Integer(5), Imaginary(Double(8))),
            Complex(Integer(5), Imaginary(8)));
        expect(Complex(Double(5), Imaginary(Double(8))),
            Complex(Integer(5), Imaginary(8)));
        expect(Complex(Precise('5.00000'), Imaginary(Double(8))),
            Complex(Integer(5), Imaginary(8)));
        expect(Complex(Precise('5.00000'), Imaginary(Precise('8'))),
            Complex(Integer(5), Imaginary(8)));
      });
    });

    test('abs()', () {
      expect(Complex(Integer(0), Imaginary(8)).abs(), Integer(8));
      expect(Complex(Integer(0), Imaginary(8)).abs() is Integer, true);
      expect(Complex(Integer(22), Imaginary(0)).abs(), Integer(22));
      expect(Complex(Integer(3), Imaginary(4)).abs(), Integer(5));
      expect(Complex(Integer(4), Imaginary(5)).abs(), Double(sqrt(41)));
      expect(Complex(Integer(4), Imaginary(5)).abs() is Double, true);
    });

    test('complexModulus', () {
      expect(Complex(Integer(0), Imaginary(8)).complexModulus, Integer(8));
      expect(Complex(Integer(0), Imaginary(8)).complexModulus is Integer, true);
      expect(Complex(Integer(22), Imaginary(0)).complexModulus, Integer(22));
      expect(Complex(Integer(3), Imaginary(4)).complexModulus, Integer(5));
      expect(
          Complex(Integer(4), Imaginary(5)).complexModulus, Double(sqrt(41)));
      expect(Complex(Integer(4), Imaginary(5)).complexModulus is Double, true);
    });

    test('complexNorm', () {
      expect(Complex(Integer(0), Imaginary(8)).complexNorm, Integer(8));
      expect(Complex(Integer(0), Imaginary(8)).complexNorm is Integer, true);
      expect(Complex(Integer(22), Imaginary(0)).complexNorm, Integer(22));
      expect(Complex(Integer(3), Imaginary(4)).complexNorm, Integer(5));
      expect(Complex(Integer(4), Imaginary(5)).complexNorm, Double(sqrt(41)));
      expect(Complex(Integer(4), Imaginary(5)).complexNorm is Double, true);
    });

    test('absoluteSquare', () {
      expect(Complex(Integer(3), Imaginary(4)).absoluteSquare, Double(25));
      expect(Complex(Integer(4), Imaginary(5)).absoluteSquare, Double(41));
    });

    test('ceil', () {
      expect(Complex(Double(3.2), Imaginary(43)).ceil(), Integer(4));
      expect(Complex(Double(-4.9), Imaginary(55)).ceil(), Integer(-4));
    });

    test('clamp', () {
      expect(Complex(Double(3.2), Imaginary(43)).clamp(0, 2),
          Complex(Integer(2), Imaginary(43)));
      expect(Complex(Double(-4.9), Imaginary(55)).clamp(-4.5, -2.1),
          Complex.coeff(-4.5, 55));
    });

    test('complexArgument', () {
      expect(Complex.coeff(1, 0).complexArgument, Integer(0));
      expect(Complex.coeff(1, 1).complexArgument, Double(0.25 * pi));
      expect(Complex.coeff(0, 1).complexArgument, Double(0.5 * pi));
      expect(Complex.coeff(-1, 0).complexArgument, Double(pi));
      expect(Complex.coeff(0, -1).complexArgument, Double(-0.5 * pi));
    });

    test('phase', () {
      expect(Complex.coeff(1, 0).phase, Integer(0));
      expect(Complex.coeff(1, 1).phase, Double(0.25 * pi));
      expect(Complex.coeff(0, 1).phase, Double(0.5 * pi));
      expect(Complex.coeff(-1, 0).phase, Double(pi));
      expect(Complex.coeff(0, -1).phase, Double(-0.5 * pi));
    });

    test('floor', () {
      expect(Complex(Double(3.2), Imaginary(43)).floor(), Integer(3));
      expect(Complex(Double(-4.9), Imaginary(55)).floor(), Integer(-5));
    });

    test('isInfinite', () {
      expect(Complex.coeff(0, 0).isInfinite, false);
      expect(Complex.coeff(1, 1).isInfinite, false);
      expect(Complex.coeff(double.infinity, 1).isInfinite, true);
      expect(Complex.coeff(double.negativeInfinity, 1).isInfinite, true);
      expect(Complex.coeff(1, double.infinity).isInfinite, false);
      expect(Complex.coeff(1, double.negativeInfinity).isInfinite, false);
      expect(Complex(Double.infinity, Imaginary(1)).isInfinite, true);
      expect(Complex(Double.negInfinity, Imaginary(1)).isInfinite, true);
      expect(Complex(Double(1), Imaginary(double.infinity)).isInfinite, false);
      expect(
          Complex(Double(1), Imaginary(Double.negInfinity)).isInfinite, false);
    });

    test('isInteger', () {
      expect(Complex.coeff(0, 0.3).isInteger, true);
      expect(Complex.coeff(1, 1.6).isInteger, true);
      expect(Complex.coeff(0.5, 0).isInteger, false);
      expect(Complex.coeff(1.3, 6).isInteger, false);
    });

    test('isNaN', () {
      expect(Complex.coeff(0, 0).isNaN, false);
      expect(Complex.coeff(double.nan, 5).isNaN, true);
      expect(Complex.coeff(5, double.nan).isNaN, false);
    });

    test('reciprocal', () {
      expect(Complex.coeff(2, 4).reciprocal(), Complex.coeff(0.1, -0.2));
      expect(Complex.coeff(-2, -4).reciprocal(), Complex.coeff(-0.1, 0.2));
      expect(Complex.coeff(0, 0).reciprocal(),
          Complex.coeff(double.nan, double.nan));
    });

    test('isNegative', () {
      expect(Complex.coeff(0, 0).isNegative, false);
      expect(Complex.coeff(0, -1).isNegative, false);
      expect(Complex.coeff(1, -1).isNegative, false);
      expect(Complex.coeff(-1, 1).isNegative, true);
    });

    test('round', () {
      expect(Complex.coeff(2.8, 4.3).round(), Integer(3));
      expect(Complex.coeff(2.5, 4.3).round(), Integer(3));
      expect(Complex.coeff(2.499, 4.3).round(), Integer(2));
      expect(Complex.coeff(-2.8, 4.3).round(), Integer(-3));
      expect(Complex.coeff(-2.5, 4.3).round(), Integer(-3));
      expect(Complex.coeff(-2.499, 4.3).round(), Integer(-2));
    });

    test('truncate', () {
      expect(Complex.coeff(2.8, 4.3).truncate(), Integer(2));
      expect(Complex.coeff(2.5, 4.3).truncate(), Integer(2));
      expect(Complex.coeff(2.99999, 4.3).truncate(), Integer(2));
      expect(Complex.coeff(-2.8, 4.3).truncate(), Integer(-2));
      expect(Complex.coeff(-2.5, 4.3).truncate(), Integer(-2));
      expect(Complex.coeff(-3, 4.3).truncate(), Integer(-3));
    });

    test('toInt', () {
      expect(Complex.coeff(2.8, 4.3).toInt(), 2);
      expect(Complex.coeff(2.5, 4.3).toInt(), 2);
      expect(Complex.coeff(2.99999, 4.3).toInt(), 2);
      expect(Complex.coeff(-2.8, 4.3).toInt(), -2);
      expect(Complex.coeff(-2.5, 4.3).toInt(), -2);
      expect(Complex.coeff(-3, 4.3).toInt(), -3);
    });

    test('toDouble', () {
      expect(Complex.coeff(2.8, 4.3).toDouble(), 2.8);
      expect(Complex.coeff(2.99999, 4.3).toDouble(), 2.99999);
      expect(Complex.coeff(-2.8, 4.3).toDouble(), -2.8);
      expect(Complex.coeff(-3, 4.3).toDouble(), -3);
    });

    test('remainder', () {
      expect(Complex.coeff(2.8, 4.3).remainder(2).toDouble(),
          closeTo(0.8, 0.000001));
      expect(Complex.coeff(-2.8, 4.3).remainder(2).toDouble(),
          closeTo(-0.8, 0.000001));
    });

    test('toJson', () {
      final c = Complex.coeff(-9.34, 5);
      final json = c.toJson();
      expect(json['real'], isA<Map<String, dynamic>>());
      expect(json['real']['d'], -9.34);
      expect(json['imag'], isA<Map<String, dynamic>>());
      expect(json['imag']['imag'], isA<Map<String, dynamic>>());
      expect(json['imag']['imag']['i'], 5);
    });

    test('remainder', () {
      expect(Complex.coeff(2.8, 4.3).toString(), '2.8 + 4.3i');
      expect(Complex.coeff(-2.8, -4.3).toString(), '-2.8 - 4.3i');
    });
  });
}
