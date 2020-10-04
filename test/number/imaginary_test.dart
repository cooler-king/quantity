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
    });

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

    test('abs()', () {
      expect(new Imaginary(0).abs(), Integer(0));
      expect(new Imaginary(1).abs(), Integer(1));
      expect(new Imaginary(12.345).abs(), Double(12.345));
      expect(new Imaginary(-12.345).abs(), Double(-12.345));
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
  });
}
