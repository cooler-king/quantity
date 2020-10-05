import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/number.dart';

void main() {
  group('Imaginary', () {
    test('zeros', () {
      final Imaginary imag0a = new Imaginary(0);
      final Imaginary imag0b = new Imaginary(0.0);
      final Imaginary imag0c = new Imaginary(new Integer(0));
      final Imaginary imag0d = new Imaginary(new Double(0));
      final Complex complex0 = new Complex(new Double(0), new Imaginary(0));

      expect(imag0a.value.toDouble() == 0, true);

      expect(imag0a == imag0b, true);
      expect(imag0b == imag0c, true);
      expect(imag0c == imag0d, true);
      expect(imag0a == complex0, true);
    });

    group('operator +', () {
      test('operator + num', () {
        expect(new Imaginary(0) + 0, Integer(0));
        expect(new Imaginary(0) + 5, Integer(5));
        expect(new Imaginary(0) + 5, isA<Integer>());
        expect(new Imaginary(0) + 5.5, Double(5.5));
        expect(new Imaginary(0) + 5.5, isA<Double>());
        expect(new Imaginary(1) + 0, Imaginary(1));
        expect(new Imaginary(1) + 5, Complex.coeff(5, 1));
        expect(new Imaginary(1.1) + 5.5, Complex.coeff(5.5, 1.1));
        expect(new Imaginary(-1) + 5, Complex.coeff(5, -1));
        expect(new Imaginary(-1.1) + 5.5, Complex.coeff(5.5, -1.1));
      });

      test('operator + Integer', () {
        expect(new Imaginary(0) + new Integer(0), Integer(0));
        expect(new Imaginary(0) + new Integer(5), Integer(5));
        expect(new Imaginary(0) + new Integer(5), isA<Integer>());
        expect(new Imaginary(1) + new Integer(0), Imaginary(1));
        expect(new Imaginary(1) + new Integer(5), Complex.coeff(5, 1));
        expect(new Imaginary(-1) + new Integer(5), Complex.coeff(5, -1));
      });

      test('operator + Double', () {
        expect(new Imaginary(0) + new Double(5.5), Double(5.5));
        expect(new Imaginary(0) + new Double(5.5), isA<Double>());
        expect(new Imaginary(1.1) + new Double(5.5), Complex.coeff(5.5, 1.1));
        expect(new Imaginary(-1.1) + new Double(5.5), Complex.coeff(5.5, -1.1));
      });

      test('operator + Imaginary', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(6);
        final Imaginary imag2 = new Imaginary(9);
        final Imaginary imag3 = new Imaginary(15);
        final Imaginary imag4 = new Imaginary(24.0);
        final Imaginary imag5 = new Imaginary(new Integer(39));
        final Imaginary imag6 = new Imaginary(new Double(63));

        expect(imag0 + imag1 == imag1, true);
        expect(imag1 + imag0 == imag1, true);
        expect(imag1 + imag2 == imag3, true);
        expect(imag2 + imag3 == imag4, true);
        expect(imag3 + imag4 == imag5, true);
        expect(imag4 + imag5 == imag6, true);
      });

      test('operator + Complex', () {
        expect(new Imaginary(0) + new Complex.coeff(5.5, 4.4), new Complex.coeff(5.5, 4.4));
        expect(new Imaginary(1.4) + new Complex.coeff(5.5, -3.4), new Complex.coeff(5.5, -2));
        expect(new Imaginary(-1.1) + new Complex.coeff(5.5, 2.2), new Complex.coeff(5.5, 1.1));
      });

      test('operator + Precise', () {
        expect(new Imaginary(0) + new Precise('5.5'), Precise('5.5'));
        expect(new Imaginary(0) + new Precise('5.5'), isA<Precise>());
        expect(new Imaginary(1.1) + new Precise('5.5'), Complex.coeff(5.5, 1.1));
        expect((new Imaginary(1.1) + new Precise('5.5') as Complex).real, isA<Precise>());
        expect(new Imaginary(-1.1) + new Precise('5.5'), Complex.coeff(5.5, -1.1));
      });
    });

    group('operator -', () {
      test('operator - num', () {
        expect(new Imaginary(0) - 0, Integer(0));
        expect(new Imaginary(0) - 5, Integer(-5));
        expect(new Imaginary(0) - 5, isA<Integer>());
        expect(new Imaginary(0) - 5.5, Double(-5.5));
        expect(new Imaginary(0) - 5.5, isA<Double>());
        expect(new Imaginary(1) - 0, Imaginary(1));
        expect(new Imaginary(1) - 5, Complex.coeff(-5, 1));
        expect(new Imaginary(1.1) - 5.5, Complex.coeff(-5.5, 1.1));
        expect(new Imaginary(-1) - 5, Complex.coeff(-5, -1));
        expect(new Imaginary(-1.1) - 5.5, Complex.coeff(-5.5, -1.1));
      });

      test('operator - Integer', () {
        expect(new Imaginary(0) - new Integer(0), Integer(0));
        expect(new Imaginary(0) - new Integer(5), Integer(-5));
        expect(new Imaginary(0) - new Integer(5), isA<Integer>());
        expect(new Imaginary(1) - new Integer(0), Imaginary(1));
        expect(new Imaginary(1) - new Integer(5), Complex.coeff(-5, 1));
        expect(new Imaginary(-1) - new Integer(5), Complex.coeff(-5, -1));
      });

      test('operator + Double', () {
        expect(new Imaginary(0) - new Double(5.5), Double(-5.5));
        expect(new Imaginary(0) - new Double(5.5), isA<Double>());
        expect(new Imaginary(1.1) - new Double(5.5), Complex.coeff(-5.5, 1.1));
        expect(new Imaginary(-1.1) - new Double(5.5), Complex.coeff(-5.5, -1.1));
      });

      test('operator - Imaginary', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(5.5);
        final Imaginary imag2 = new Imaginary(9.5);
        final Imaginary imag3 = new Imaginary(15);
        final Imaginary imag4 = new Imaginary(24.5);
        final Imaginary imag5 = new Imaginary(new Double(39.5));
        final Imaginary imag6 = new Imaginary(new Double(64));

        expect(imag6 - imag5 == imag4, true);
        expect(imag5 - imag4 == imag3, true);
        expect(imag4 - imag3 == imag2, true);
        expect(imag3 - imag2 == imag1, true);
        expect(imag2 - imag1 == new Imaginary(4), true);
        expect(imag1 - imag0 == imag1, true);
      });

      test('operator - Complex', () {
        expect(new Imaginary(0) - new Complex.coeff(5.5, 4.4), new Complex.coeff(-5.5, -4.4));
        expect(new Imaginary(1.1) - new Complex.coeff(5.5, -3.3), new Complex.coeff(-5.5, 4.4));
        expect(new Imaginary(-1.8) - new Complex.coeff(5.5, 2.2), new Complex.coeff(-5.5, -4));
      });

      test('operator - Precise', () {
        expect(new Imaginary(0) - new Precise('5.5'), Precise('-5.5'));
        expect(new Imaginary(0) - new Precise('5.5'), isA<Precise>());
        expect(new Imaginary(1.1) - new Precise('5.5'), Complex.coeff(-5.5, 1.1));
        expect((new Imaginary(1.1) - new Precise('5.5') as Complex).real, isA<Precise>());
        expect(new Imaginary(-1.1) - new Precise('5.5'), Complex.coeff(-5.5, -1.1));
      });
    });

    group('operator *', () {
      test('operator * num', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 * 0, Imaginary(0));
        expect(imag0 * 1, Imaginary(0));
        expect(imag0 * 2, Imaginary(0));
        expect(imag1 * 0, Imaginary(0));
        expect(imag1 * 1, Imaginary(1));
        expect(imag1 * 2, Imaginary(2));
        expect(imag1 * 2.5, Imaginary(2.5));
        expect(imag1 * -5, Imaginary(-5));
        expect(imag2 * 1, Imaginary(5.6));
        expect(imag2 * 2, Imaginary(11.2));
        expect(imag2 * 2.5, Imaginary(14));
        expect(imag2 * -5, Imaginary(-28));
        expect(imag3 * 1, Imaginary(-9));
        expect(imag3 * 2, Imaginary(-18));
        expect(imag3 * 2.5, Imaginary(-22.5));
        expect(imag3 * -5, Imaginary(45));
        expect(imag4 * 1, Imaginary(-25.987));
        expect(imag4 * 2, Imaginary(-51.974));
        expect(imag4 * 2.5, Imaginary(-64.9675));
        expect(imag4 * -5, Imaginary(129.935));
      });

      test('operator * Integer', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 * Integer(0), Imaginary(0));
        expect(imag0 * Integer(1), Imaginary(0));
        expect(imag0 * Integer(2), Imaginary(0));
        expect(imag1 * Integer(0), Imaginary(0));
        expect(imag1 * Integer(1), Imaginary(1));
        expect(imag1 * Integer(2), Imaginary(2));
        expect(imag1 * Integer(-5), Imaginary(-5));
        expect(imag2 * Integer(1), Imaginary(5.6));
        expect(imag2 * Integer(2), Imaginary(11.2));
        expect(imag2 * Integer(-5), Imaginary(-28));
        expect(imag3 * Integer(1), Imaginary(-9));
        expect(imag3 * Integer(2), Imaginary(-18));
        expect(imag3 * Integer(-5), Imaginary(45));
        expect(imag4 * Integer(1), Imaginary(-25.987));
        expect(imag4 * Integer(2), Imaginary(-51.974));
        expect(imag4 * Integer(-5), Imaginary(129.935));
      });

      test('operator * Double', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 * Double(0), Imaginary(0));
        expect(imag0 * Double(1.1), Imaginary(0));
        expect(imag0 * Double(2.2), Imaginary(0));
        expect(imag1 * Double(0), Imaginary(0));
        expect(imag1 * Double(1.1), Imaginary(1.1));
        expect(imag1 * Double(2.2), Imaginary(2.2));
        expect(imag1 * Double(-5.5), Imaginary(-5.5));
        expect(imag2 * Double(1.1), Imaginary(6.16));
        expect(imag2 * Double(2.2), Imaginary(12.32));
        expect((imag2 * Double(-5.5) as Imaginary).value.toDouble(), closeTo(-30.8, 1e-12));
        expect(imag3 * Double(1.1), Imaginary(-9.9));
        expect(imag3 * Double(2.2), Imaginary(-19.8));
        expect(imag3 * Double(-5.5), Imaginary(49.5));
        expect(imag4 * Double(1.1), Imaginary(-28.5857));
        expect(imag4 * Double(2.2), Imaginary(-57.1714));
        expect((imag4 * Double(-5.5) as Imaginary).value.toDouble(), closeTo(142.9285, 1e-12));
      });

      test('operator * Imaginary', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 * imag0, Integer(0));
        expect(imag0 * imag1, Integer(0));
        expect(imag0 * imag2, Integer(0));
        expect(imag0 * imag3, Integer(0));
        expect(imag0 * imag4, Integer(0));
        expect(imag1 * imag0, Integer(0));
        expect(imag1 * imag1, Integer(-1));
        expect(imag1 * imag2, Double(-5.6));
        expect(imag1 * imag3, Integer(9));
        expect(imag1 * imag4, Double(25.987));
        expect(imag1 * imag2, Double(-5.6));
        expect(imag2 * imag3, Double(50.4));
        expect(imag3 * imag0, Integer(0));
        expect(imag3 * imag1, Integer(9));
        expect(imag3 * imag2, Double(50.4));
        expect(imag3 * imag3, Integer(-81));
        expect((imag3 * imag4).toDouble(), closeTo(-233.883, 1e-12));
      });

      test('operator * Complex', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(-25.987);

        final Complex complex00 = new Complex(new Integer(0), new Imaginary(0));
        final Complex complex01 = new Complex(new Integer(0), new Imaginary(1));
        final Complex complex10 = new Complex(new Integer(1), new Imaginary(0));
        final Complex complex11 = new Complex(new Integer(1), new Imaginary(1));
        final Complex complex99 = new Complex(new Double(99.9), new Imaginary(65.2));

        expect(imag0 * complex00, Imaginary(0));
        expect(imag0 * complex01, Imaginary(0));
        expect(imag0 * complex10, Imaginary(0));
        expect(imag0 * complex11, Imaginary(0));
        expect(imag1 * complex00, Imaginary(0));
        expect(imag1 * complex01, Integer(-1));
        expect(imag1 * complex10, Imaginary(1));
        expect(imag1 * complex11, Complex(new Integer(-1), new Imaginary(1)));
        expect(imag2 * complex99, Complex(new Double(1694.3524), new Imaginary(-2596.1013)));
      });

      test('operator * Precise', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 * Precise('0'), Imaginary(0));
        expect(imag0 * Precise('1.1'), Imaginary(0));
        expect((imag0 * Precise('1.1') as Imaginary).value, isA<Precise>());
        expect(imag0 * Precise('2.2'), Imaginary(0));
        expect(imag1 * Precise('0'), Imaginary(0));
        expect((imag1 * Precise('0') as Imaginary).value, isA<Precise>());
        expect(imag1 * Precise('1.1'), Imaginary(1.1));
        expect(imag1 * Precise('2.2'), Imaginary(2.2));
        expect(imag1 * Precise('-5.5'), Imaginary(-5.5));
        expect(imag2 * Precise('1.1'), Imaginary(6.16));
        expect(imag2 * Precise('2.2'), Imaginary(12.32));
        expect((imag2 * Precise('-5.5') as Imaginary).value.toDouble(), closeTo(-30.8, 1e-12));
        expect((imag2 * Precise('-5.5') as Imaginary).value, isA<Precise>());
        expect(imag3 * Precise('1.1'), Imaginary(-9.9));
        expect(imag3 * Precise('2.2'), Imaginary(-19.8));
        expect(imag3 * Precise('-5.5'), Imaginary(49.5));
        expect(imag4 * Precise('1.1'), Imaginary(-28.5857));
        expect(imag4 * Precise('2.2'), Imaginary(-57.1714));
        expect((imag4 * Precise('-5.5') as Imaginary).value.toDouble(), closeTo(142.9285, 1e-12));
      });
    });

    group('operator / ', () {
      test('operator / num', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 / 1, Imaginary(0));
        expect(imag0 / 2, Imaginary(0));
        expect(imag1 / 1, Imaginary(1));
        expect(imag1 / 2, Imaginary(0.5));
        expect(imag1 / 2.5, Imaginary(0.4));
        expect(imag1 / -5, Imaginary(-0.2));
        expect(imag2 / 1, Imaginary(5.6));
        expect(imag2 / 2, Imaginary(2.8));
        expect(imag2 / 2.5, Imaginary(2.2399999999999998));
        expect(imag2 / -5, Imaginary(-1.1199999999999999));
        expect(imag3 / 1, Imaginary(-9));
        expect(imag3 / 2, Imaginary(-4.5));
        expect(imag3 / 2.5, Imaginary(-3.6));
        expect(imag3 / -5, Imaginary(1.8));
        expect(imag4 / 1, Imaginary(-25.987));
        expect(imag4 / 2, Imaginary(-12.9935));
        expect(imag4 / 2.5, Imaginary(-10.3948));
        expect(imag4 / -5, Imaginary(5.1974));

        expect((imag0 / 0 as Imaginary).value.toDouble(), isNaN);
        expect(imag1 / 0, Imaginary(Double.infinity));
      });

      test('operator / Integer', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 / new Integer(1), Imaginary(0));
        expect(imag0 / new Integer(2), Imaginary(0));
        expect(imag1 / new Integer(1), Imaginary(1));
        expect(imag1 / new Integer(2), Imaginary(0.5));
        expect(imag1 / new Integer(-5), Imaginary(-0.2));
        expect(imag2 / new Integer(1), Imaginary(5.6));
        expect(imag2 / new Integer(2), Imaginary(2.8));
        expect(imag2 / new Integer(-5), Imaginary(-1.1199999999999999));
        expect(imag3 / new Integer(1), Imaginary(-9));
        expect(imag3 / new Integer(2), Imaginary(-4.5));
        expect(imag3 / new Integer(-5), Imaginary(1.8));
        expect(imag4 / new Integer(1), Imaginary(-25.987));
        expect(imag4 / new Integer(2), Imaginary(-12.9935));
        expect(imag4 / new Integer(-5), Imaginary(5.1974));

        expect((imag0 / new Integer(0) as Imaginary).value.toDouble(), isNaN);
        expect(imag1 / new Integer(0), Imaginary(Double.infinity));
      });

      test('operator / Double', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 / new Double(2.5), Imaginary(0));
        expect(imag1 / new Double(2.5), Imaginary(0.4));
        expect(imag2 / new Double(2.5), Imaginary(2.2399999999999998));
        expect(imag3 / new Double(2.5), Imaginary(-3.6));
        expect(imag4 / new Double(2.5), Imaginary(-10.3948));
        expect(imag0 / new Double(-2.5), Imaginary(0));
        expect(imag1 / new Double(-2.5), Imaginary(-0.4));
        expect(imag2 / new Double(-2.5), Imaginary(-2.2399999999999998));
        expect(imag3 / new Double(-2.5), Imaginary(3.6));
        expect(imag4 / new Double(-2.5), Imaginary(10.3948));

        expect((imag0 / new Double(0) as Imaginary).value.toDouble(), isNaN);
        expect(imag1 / new Double(0), Imaginary(Double.infinity));
      });

      test('operator / Imaginary', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 / new Imaginary(2.5), Integer(0));
        expect(imag1 / new Imaginary(2.5), Double(0.4));
        expect(imag2 / new Imaginary(2.5), Double(2.2399999999999998));
        expect(imag3 / new Imaginary(2.5), Double(-3.6));
        expect(imag4 / new Imaginary(2.5), Double(-10.3948));
        expect(imag0 / new Imaginary(-2.5), Integer(0));
        expect(imag1 / new Imaginary(-2.5), Double(-0.4));
        expect(imag2 / new Imaginary(-2.5), Double(-2.2399999999999998));
        expect(imag3 / new Imaginary(-2.5), Double(3.6));
        expect(imag4 / new Imaginary(-2.5), Double(10.3948));

        expect((imag0 / new Imaginary(0) as Double).value.toDouble(), isNaN);
        expect(imag1 / new Imaginary(0), Double.infinity);
      });

      test('operator / Complex', () {
        final Imaginary i0 = new Imaginary(0);
        expect(i0 / new Complex.coeff(1, 1), new Integer(0));
        expect(i0 / new Complex.coeff(1, 1) is Integer, true);
        expect(i0 / new Complex.coeff(3, 3), new Integer(0));
        expect(i0 / new Complex.coeff(3, 3) is Integer, true);
        expect(i0 / new Complex.coeff(-9.9, -9.9), new Integer(0));
        expect(i0 / new Complex.coeff(-9.9, -9.9) is Integer, true);
        expect(i0 / new Complex.coeff(1, 0), new Integer(0));
        expect(i0 / new Complex.coeff(0, 1), new Integer(0));
        expect(i0 / new Complex.coeff(0, 0), new Complex(Double.NaN, new Imaginary(Double.NaN)));

        final Imaginary i1 = new Imaginary(8);
        expect(i1 / new Complex.coeff(1, 1), new Complex.coeff(4, 4));
        expect(i1 / new Complex.coeff(4, 2), new Complex.coeff(0.8, 1.6));
        expect(i1 / new Complex.coeff(1, 0), new Imaginary(8));
        expect(i1 / new Complex.coeff(0, 1), new Integer(8));
        expect(i1 / new Complex.coeff(0, 0), new Complex(Double.infinity, new Imaginary(Double.infinity)));

        final Imaginary i2 = new Imaginary(-2);
        expect(i2 / new Complex.coeff(4, 2), new Complex.coeff(-0.2, -0.4));
        expect(i2 / new Complex.coeff(-4, -2), new Complex.coeff(0.2, 0.4));
        expect(i2 / new Complex.coeff(1, 0), new Imaginary(-2));
        expect(i2 / new Complex.coeff(0, 1), new Integer(-2));
        expect(i2 / new Complex.coeff(0, 0), new Complex(Double.negInfinity, new Imaginary(Double.negInfinity)));

        final Imaginary i3 = new Imaginary(5);
        expect(i3 / new Complex.coeff(2, 6), new Complex.coeff(0.75, 0.25));

        final Imaginary i4 = new Imaginary(1);
        expect(i4 / new Complex.coeff(1, 1), new Complex.coeff(0.5, 0.5));
      });

      test('operator / Precise', () {
        final Imaginary imag0 = new Imaginary(0);
        final Imaginary imag1 = new Imaginary(1);
        final Imaginary imag2 = new Imaginary(5.6);
        final Imaginary imag3 = new Imaginary(-9);
        final Imaginary imag4 = new Imaginary(-25.987);

        expect(imag0 / new Precise('2.5'), Imaginary(0));
        expect((imag0 / new Precise('2.5') as Imaginary).value, isA<Precise>());
        expect(imag1 / new Precise('2.5'), Imaginary(0.4));
        expect(imag2 / new Precise('2.5'), Imaginary(2.24));
        expect(imag3 / new Precise('2.5'), Imaginary(-3.6));
        expect(imag4 / new Precise('2.5'), Imaginary(-10.3948));
        expect(imag0 / new Precise('-2.5'), Imaginary(0));
        expect(imag1 / new Precise('-2.5'), Imaginary(-0.4));
        expect(imag2 / new Precise('-2.5'), Imaginary(-2.24));
        expect((imag2 / new Precise('2.5') as Imaginary).value, isA<Precise>());
        expect(imag3 / new Precise('-2.5'), Imaginary(3.6));
        expect(imag4 / new Precise('-2.5'), Imaginary(10.3948));

        expect((imag0 / new Precise('0') as Imaginary).value.toDouble(), isNaN);
        expect(imag1 / new Precise('0'), Imaginary(Double.infinity));
      });
    });

    group('operator <', () {
      test('operator < num', () {
        expect(new Imaginary(3) < 2, true);
        expect(new Imaginary(-3) < 0, false);
        expect(new Imaginary(-3) < -1, false);
      });

      test('operator < Integer', () {
        expect(new Imaginary(3) < new Integer(2), true);
        expect(new Imaginary(-3) < new Integer(0), false);
        expect(new Imaginary(-3) < new Integer(-1), false);
      });

      test('operator < Double', () {
        expect(new Imaginary(3) < new Double(2.2), true);
        expect(new Imaginary(-3) < new Double(0), false);
        expect(new Imaginary(-3) < new Double(-1.1), false);
      });

      test('operator < Imaginary', () {
        expect(new Imaginary(3) < new Imaginary(4), true);
        expect(new Imaginary(-3) < new Imaginary(-3), false);
        expect(new Imaginary(-3) < new Imaginary(-4.5), false);
      });

      test('operator < Complex', () {
        expect(new Imaginary(3) < new Complex.coeff(4, 5), true);
        expect(new Imaginary(-3) < new Complex.coeff(-3, -7), false);
        expect(new Imaginary(-35) < new Complex.coeff(-4.5, 4), false);
      });

      test('operator < Precise', () {
        expect(new Imaginary(3) < new Precise('2.2'), true);
        expect(new Imaginary(-3) < new Precise('0'), false);
        expect(new Imaginary(-3) < new Precise('-1.1'), false);
      });
    });

    group('operator <=', () {
      test('operator <= num', () {
        expect(new Imaginary(3) <= 2, true);
        expect(new Imaginary(-3) <= 0, true);
        expect(new Imaginary(-3) <= -1, false);
      });

      test('operator <= Integer', () {
        expect(new Imaginary(3) <= new Integer(2), true);
        expect(new Imaginary(0) <= new Integer(0), true);
        expect(new Imaginary(-3) <= new Integer(-1), false);
      });

      test('operator <= Double', () {
        expect(new Imaginary(3) <= new Double(2.2), true);
        expect(new Imaginary(0) <= new Double(0), true);
        expect(new Imaginary(-3) <= new Double(-1.1), false);
      });

      test('operator <= Imaginary', () {
        expect(new Imaginary(3) <= new Imaginary(4), true);
        expect(new Imaginary(-3) <= new Imaginary(-3), true);
        expect(new Imaginary(-3) <= new Imaginary(-4.5), false);
      });

      test('operator <= Complex', () {
        expect(new Imaginary(3) <= new Complex.coeff(4, 5), true);
        expect(new Imaginary(-3) <= new Complex.coeff(-3, -7), false);
        expect(new Imaginary(-35) <= new Complex.coeff(-4.5, 4), false);
      });

      test('operator <= Precise', () {
        expect(new Imaginary(3) <= new Precise('2.2'), true);
        expect(new Imaginary(-3) <= new Precise('0'), true);
        expect(new Imaginary(-3) <= new Precise('-1.1'), false);
      });
    });

    group('operator >', () {
      test('operator > num', () {
        expect(new Imaginary(3) > 2, false);
        expect(new Imaginary(-3) > 0, false);
        expect(new Imaginary(-3) > -1, true);
      });

      test('operator > Integer', () {
        expect(new Imaginary(3) > new Integer(2), false);
        expect(new Imaginary(-3) > new Integer(0), false);
        expect(new Imaginary(-3) > new Integer(-1), true);
      });

      test('operator > Double', () {
        expect(new Imaginary(3) > new Double(2.2), false);
        expect(new Imaginary(-3) > new Double(0), false);
        expect(new Imaginary(-3) > new Double(-1.1), true);
      });

      test('operator > Imaginary', () {
        expect(new Imaginary(3) > new Imaginary(4), false);
        expect(new Imaginary(-3) > new Imaginary(-3), false);
        expect(new Imaginary(-3) > new Imaginary(-4.5), true);
      });

      test('operator > Complex', () {
        expect(new Imaginary(3) > new Complex.coeff(4, 5), false);
        expect(new Imaginary(-3) > new Complex.coeff(-3, -7), true);
        expect(new Imaginary(-35) > new Complex.coeff(-4.5, 4), true);
      });

      test('operator > Precise', () {
        expect(new Imaginary(3) > new Precise('2.2'), false);
        expect(new Imaginary(-3) > new Precise('0'), false);
        expect(new Imaginary(-3) > new Precise('-1.1'), true);
      });
    });

    group('operator >=', () {
      test('operator >= num', () {
        expect(new Imaginary(3) >= 2, false);
        expect(new Imaginary(-3) >= 0, true);
        expect(new Imaginary(-3) >= -1, true);
      });

      test('operator >= Integer', () {
        expect(new Imaginary(3) >= new Integer(2), false);
        expect(new Imaginary(-3) >= new Integer(0), true);
        expect(new Imaginary(-3) >= new Integer(-1), true);
      });

      test('operator >= Double', () {
        expect(new Imaginary(3) >= new Double(2.2), false);
        expect(new Imaginary(-3) >= new Double(0), true);
        expect(new Imaginary(-3) >= new Double(-1.1), true);
      });

      test('operator >= Imaginary', () {
        expect(new Imaginary(3) >= new Imaginary(4), false);
        expect(new Imaginary(-3) >= new Imaginary(-3), true);
        expect(new Imaginary(-3) >= new Imaginary(-4.5), true);
      });

      test('operator >= Complex', () {
        expect(new Imaginary(3) >= new Complex.coeff(4, 5), false);
        expect(new Imaginary(-3) >= new Complex.coeff(-3, -7), true);
        expect(new Imaginary(-35) >= new Complex.coeff(-4.5, 4), true);
      });

      test('operator >= Precise', () {
        expect(new Imaginary(3) >= new Precise('2.2'), false);
        expect(new Imaginary(-3) >= new Precise('0'), true);
        expect(new Imaginary(-3) >= new Precise('-1.1'), true);
      });
    });

    test('abs()', () {
      expect(new Imaginary(0).abs(), Integer(0));
      expect(new Imaginary(1).abs(), Integer(1));
      expect(new Imaginary(-1).abs(), Integer(1));
      expect(new Imaginary(12.345).abs(), Double(12.345));
      expect(new Imaginary(-12.345).abs(), Double(12.345));
    });

    test('complexModulus', () {
      expect(new Imaginary(0).complexModulus, Integer(0));
      expect(new Imaginary(1).complexModulus, Integer(1));
      expect(new Imaginary(-1).complexModulus, Integer(1));
      expect(new Imaginary(12.345).complexModulus, Double(12.345));
      expect(new Imaginary(-12.345).complexModulus, Double(12.345));
    });

    test('ceil()', () {
      expect(new Imaginary(0).ceil(), Integer(0));
      expect(new Imaginary(1).ceil(), Integer(0));
      expect(new Imaginary(12.345).ceil(), Integer(0));
      expect(new Imaginary(-12.345).ceil(), Integer(0));
    });

    test('floor()', () {
      expect(new Imaginary(0).floor(), Integer(0));
      expect(new Imaginary(1).floor(), Integer(0));
      expect(new Imaginary(12.345).floor(), Integer(0));
      expect(new Imaginary(-12.345).floor(), Integer(0));
    });

    test('clamp()', () {
      expect(new Imaginary(0).clamp(-3, 3), Integer(0));
      expect(new Imaginary(0).clamp(-3, -2), Integer(-2));
      expect(new Imaginary(0).clamp(3, 4), Integer(3));
      expect(new Imaginary(1).clamp(5, 10), Complex.coeff(5, 1));
      expect(new Imaginary(12.345).clamp(-12.1, -4.3), Complex.coeff(-4.3, 12.345));
      expect(new Imaginary(-12.345).clamp(43, 44), Complex.coeff(43, -12.345));
    });

    test('complexArgument', () {
      expect(new Imaginary(0).complexArgument, pi / 2);
      expect(new Imaginary(1).complexArgument, pi / 2);
      expect(new Imaginary(12.345).complexArgument, pi / 2);
      expect(new Imaginary(-12.345).complexArgument, -pi / 2);
    });

    test('phase', () {
      expect(new Imaginary(0).phase, pi / 2);
      expect(new Imaginary(1).phase, pi / 2);
      expect(new Imaginary(12.345).phase, pi / 2);
      expect(new Imaginary(-12.345).phase, -pi / 2);
    });

    test('toComplex()', () {
      expect(new Imaginary(0).toComplex(), new Complex.coeff(0, 0));
      expect(new Imaginary(0).toComplex().imag.value is Integer, true);
      expect(new Imaginary(1).toComplex(), new Complex.coeff(0, 1));
      expect(new Imaginary(1).toComplex().imag.value is Integer, true);
      expect(new Imaginary(12.3).toComplex(), new Complex.coeff(0, 12.3));
      expect(new Imaginary(12.3).toComplex().imag.value is Double, true);
      expect(new Imaginary(-5).toComplex(), new Complex.coeff(0, -5));
      expect(new Imaginary(-5).toComplex().imag.value is Integer, true);
      expect(new Imaginary(-5.9).toComplex(), new Complex.coeff(0, -5.9));
      expect(new Imaginary(-5.9).toComplex().imag.value is Double, true);
    });

    test('isInfinite', () {
      expect(new Imaginary(0).isInfinite, false);
      expect(new Imaginary(double.infinity).isInfinite, false);
      expect(new Imaginary(double.negativeInfinity).isInfinite, false);
      expect(new Imaginary(double.nan).isInfinite, false);
      expect(new Imaginary(Double(0)).isInfinite, false);
      expect(new Imaginary(Double.infinity).isInfinite, false);
      expect(new Imaginary(Double.negInfinity).isInfinite, false);
      expect(new Imaginary(Double.NaN).isInfinite, false);
    });

    test('isInteger', () {
      expect(new Imaginary(0).isInteger, true);
      expect(new Imaginary(1).isInteger, true);
      expect(new Imaginary(-1).isInteger, true);
      expect(new Imaginary(1.1).isInteger, true);
      expect(new Imaginary(-1.1).isInteger, true);
      expect(new Imaginary(double.infinity).isInteger, true);
      expect(new Imaginary(double.negativeInfinity).isInteger, true);
      expect(new Imaginary(double.nan).isInteger, true);
      expect(new Imaginary(Double(0)).isInteger, true);
      expect(new Imaginary(Double.infinity).isInteger, true);
      expect(new Imaginary(Double.negInfinity).isInteger, true);
      expect(new Imaginary(Double.NaN).isInteger, true);
    });

    test('isNaN', () {
      expect(new Imaginary(0).isNaN, false);
      expect(new Imaginary(double.infinity).isNaN, false);
      expect(new Imaginary(double.negativeInfinity).isNaN, false);
      expect(new Imaginary(double.nan).isNaN, false);
      expect(new Imaginary(Double(0)).isNaN, false);
      expect(new Imaginary(Double.infinity).isNaN, false);
      expect(new Imaginary(Double.negInfinity).isNaN, false);
      expect(new Imaginary(Double.NaN).isNaN, false);
    });

    test('isNegative', () {
      expect(new Imaginary(0).isNegative, false);
      expect(new Imaginary(1).isNegative, false);
      expect(new Imaginary(-2).isNegative, false);
      expect(new Imaginary(double.infinity).isNegative, false);
      expect(new Imaginary(double.negativeInfinity).isNegative, false);
      expect(new Imaginary(double.nan).isNegative, false);
      expect(new Imaginary(Double(0)).isNegative, false);
      expect(new Imaginary(Double.infinity).isNegative, false);
      expect(new Imaginary(Double.negInfinity).isNegative, false);
      expect(new Imaginary(Double.NaN).isNegative, false);
    });

    test('reciprocal', () {
      expect(new Imaginary(0).reciprocal(), Imaginary(Double.NaN));
      expect(new Imaginary(1).reciprocal(), Imaginary(-1));
      expect(new Imaginary(-2).reciprocal(), Imaginary(0.5));
      expect(new Imaginary(double.infinity).reciprocal(), Integer(0));
      expect(new Imaginary(double.negativeInfinity).reciprocal(), Integer(0));
      expect(new Imaginary(double.nan).reciprocal(), Imaginary(Double.NaN));
      expect(new Imaginary(Double(0)).reciprocal(), Imaginary(Double.NaN));
      expect(new Imaginary(Double.infinity).reciprocal(), Integer(0));
      expect(new Imaginary(Double.negInfinity).reciprocal(), Integer(0));
      expect(new Imaginary(Double.NaN).reciprocal(), Imaginary(Double.NaN));
    });

    test('remainder()', () {
      expect(new Imaginary(0).round(), Integer(0));
      expect(new Imaginary(1).round(), Integer(0));
      expect(new Imaginary(-1).round(), Integer(0));
      expect(new Imaginary(12.345).round(), Integer(0));
      expect(new Imaginary(-12.345).round(), Integer(0));
    });

    test('round()', () {
      expect(new Imaginary(0).round(), Integer(0));
      expect(new Imaginary(1).round(), Integer(0));
      expect(new Imaginary(-1).round(), Integer(0));
      expect(new Imaginary(12.345).round(), Integer(0));
      expect(new Imaginary(-12.345).round(), Integer(0));
    });

    test('toInt()', () {
      expect(new Imaginary(0).toInt(), Integer(0));
      expect(new Imaginary(1).toInt(), Integer(0));
      expect(new Imaginary(-1).toInt(), Integer(0));
      expect(new Imaginary(12.345).toInt(), Integer(0));
      expect(new Imaginary(-12.345).toInt(), Integer(0));
    });

    test('truncate()', () {
      expect(new Imaginary(0).truncate(), Integer(0));
      expect(new Imaginary(1).truncate(), Integer(0));
      expect(new Imaginary(-1).truncate(), Integer(0));
      expect(new Imaginary(12.345).truncate(), Integer(0));
      expect(new Imaginary(-12.345).truncate(), Integer(0));
    });

    test('toDouble()', () {
      expect(new Imaginary(0).round(), Double(0));
      expect(new Imaginary(1).round(), Double(0));
      expect(new Imaginary(-1).round(), Double(0));
      expect(new Imaginary(12.345).round(), Double(0));
      expect(new Imaginary(-12.345).round(), Double(0));
    });

    test('toJson', () {
      final Imaginary i = new Imaginary(-9.34);
      final Map<String, dynamic> json = i.toJson();
      expect(json['imag']['d'], -9.34);
    });

    test('toString', () {
      final Imaginary i = new Imaginary(-9.34);
      expect(i.toString(), '-9.34i');
    });

    test('operator % (exception)', () {
      expect(() => new Imaginary(5) % 2, throwsA(isA<NumberException>()));
    });

    group('operator ~/', () {
      test('operator ~/ num', () {
        final Imaginary c0 = new Imaginary(0);
        expect(c0 ~/ 1, new Imaginary(0));

        final Imaginary c1 = new Imaginary(65);
        expect(c1 ~/ 1, new Imaginary(65));
        expect(c1 ~/ 5, new Imaginary(13));
        expect(c1 ~/ -5, new Imaginary(-13));
        expect(c1 ~/ 5.1, new Imaginary(12));
        expect(c1 ~/ -5.1, new Imaginary(-12));
      });

      test('operator ~/ Integer', () {
        final Imaginary c0 = new Imaginary(0);
        expect(c0 ~/ new Integer(1), new Imaginary(0));

        final Imaginary c1 = new Imaginary(65);
        expect(c1 ~/ new Integer(1), new Imaginary(65));
        expect(c1 ~/ new Integer(5), new Imaginary(13));
        expect(c1 ~/ new Integer(-5), new Imaginary(-13));
      });

      test('operator ~/ Double', () {
        final Imaginary c0 = new Imaginary(0);
        expect(c0 ~/ new Double(1.5), new Imaginary(0));

        final Imaginary c1 = new Imaginary(65);
        expect(c1 ~/ new Double(5.1), new Imaginary(12));
        expect(c1 ~/ new Double(-5.1), new Imaginary(-12));
      });

      test('operator ~/ Imaginary', () {
        final Imaginary c0 = new Imaginary(0);
        expect(c0 ~/ new Imaginary(1.5), new Imaginary(0));

        final Imaginary c1 = new Imaginary(65);
        expect(c1 ~/ new Imaginary(5), new Integer(13));
        expect(c1 ~/ new Imaginary(-5.1), new Integer(-12));
      });
    });

    test('operator - (unary negation)', () {
      expect(-(new Imaginary(5)), new Imaginary(-5));
      expect(-(new Imaginary(-5)), new Imaginary(5));
      expect(-(new Imaginary(0)), new Imaginary(0));
    });
  });
}
