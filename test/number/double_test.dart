import 'package:dart2_constant/core.dart' as polyfill_core;
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Double', () {
    test('constants', () {
      const Double d = const Double.constant(42.0);
      expect(d.value, 42.0);
      expect(Double.zero.value, 0.0);
      expect(Double.one.value, 1.0);
      expect(Double.ten.value, 10.0);
      expect(Double.hundred.value, 100.0);
      expect(Double.thousand.value, 1000.0);
      expect(Double.infinity.value, polyfill_core.double.infinity);
      expect(Double.negInfinity.value, polyfill_core.double.negativeInfinity);
      expect(identical(Double.NaN.value, polyfill_core.double.nan), true);
    });

    test('isNaN', () {
      const Double d = const Double.constant(42.0);
      const Double d2 = Double.NaN;
      const Double d3 = Double.infinity;
      final Double d4 = new Double(polyfill_core.double.nan);

      expect(d.isNaN, false);
      expect(d2.isNaN, true);
      expect(d3.isNaN, false);
      expect(d4.isNaN, true);
    });

    test('operator ==', () {
      final Double d = new Double(42.056);
      final Double d2 = new Double(14.321);
      final Double d3 = new Double(42.056);
      final Double d4 = new Double(42.0);
      final Double d5 = new Double(42.toDouble());
      expect(d == d, true);
      expect(d == d2, false);
      expect(d == d3, true);
      expect(d?.toDouble() == 42.056, true);
      expect(d?.toDouble() == 42.0560001, false);
      expect(d4 == d5, true);

      // equality with nums
      // ignore: unrelated_type_equality_checks
      expect(d4 == 42, true);
      // ignore: unrelated_type_equality_checks
      expect(d5 == 42, true);
      // ignore: unrelated_type_equality_checks
      expect(d4 == 42.0, true);
      // ignore: unrelated_type_equality_checks
      expect(d5 == 42.0, true);

      // equality with complex
      final Complex c1 = new Complex(new Double(42.0), new Imaginary(0.0));
      // ignore: unrelated_type_equality_checks
      expect(d4 == c1, true);
    });

    test('operator +', () {
      final Double d = new Double(42.056);
      final Double d2 = new Double(14.321);

      // + int
      Number sum = d + 4;
      expect(sum is Double, true);
      expect((sum as Double).value.toDouble(), 46.056);
      sum = d + (-4);
      expect(sum is Double, true);
      expect((sum as Double).value.toDouble(), 38.056);

      // + double
      sum = d + 5.1;
      expect(sum is Double, true);
      expect((sum as Double).value.toDouble(), 47.156);
      sum = d + (-5.1);
      expect(sum is Double, true);
      expect((sum as Double).value.toDouble(), closeTo(36.956, 0.000001));

      // + Double
      expect(d + d2 is Double, true);
      expect((d + d2 as Double).value, closeTo(56.377, 0.000001));
      expect(d + 77.7777 is Double, true);
      expect((d + 77.7777 as Double).value, closeTo(119.8337, 0.000001));
      final Double d3 = new Double(-1.4);
      expect(d + d3 is Double, true);
      expect((d + d3 as Double).value, closeTo(40.656, 0.000001));

      // + Integer
      Integer a = new Integer(4);
      sum = d + a;
      expect(sum is Double, true);
      expect(sum, new Double(46.056));
      a = new Integer(-31);
      sum = d + a;
      expect(sum is Double, true);
      expect((sum as Double).value, closeTo(11.056, 0.000001));

      // + Imaginary
      Imaginary i = new Imaginary(34.21);
      expect(d + i is Complex, true);
      expect((d + i as Complex).real.toDouble(), closeTo(42.056, 0.000001));
      expect((d + i as Complex).imag.value.toDouble(), closeTo(34.21, 0.000001));
      i = new Imaginary(-34.21);
      expect(d + i is Complex, true);
      expect((d + i as Complex).real.toDouble(), closeTo(42.056, 0.000001));
      expect((d + i as Complex).imag.value.toDouble(), closeTo(-34.21, 0.000001));

      // + Complex
      Complex cx = new Complex(new Double(2.1), new Imaginary(9.6));
      sum = d + cx;
      expect(sum is Complex, true);
      expect((sum as Complex).real.toDouble(), closeTo(44.156, 0.000001));
      expect((sum as Complex).imag.value.toDouble(), 9.6);
      cx = new Complex(new Double(-2.1), new Imaginary(-9.6));
      sum = d + cx;
      expect(sum is Complex, true);
      expect((sum as Complex).real.toDouble(), closeTo(39.956, 0.000001));
      expect((sum as Complex).imag.value.toDouble(), -9.6);

      // + Precise
      Precise p = new Precise('123.456');
      sum = d + p;
      expect(sum is Precise, true);
      expect(sum, new Precise('165.512'));
      p = new Precise('-0.024');
      sum = d + p;
      expect(sum is Precise, true);
      expect(sum, new Precise('42.032'));
    });

    test('operator -', () {
      final Double d = new Double(42.056);
      final Double d2 = new Double(14.321);

      // - int
      Number diff = d - 3;
      expect(diff is Double, true);
      expect((diff as Double).value.toDouble(), 39.056);
      diff = d - (-4);
      expect(diff is Double, true);
      expect((diff as Double).value.toDouble(), 46.056);

      // - double
      diff = d - 5.1;
      expect(diff is Double, true);
      expect((diff as Double).value.toDouble(), closeTo(36.956, 0.000001));
      diff = d - (-5.1);
      expect(diff is Double, true);
      expect((diff as Double).value.toDouble(), closeTo(47.156, 0.000001));

      // - Double
      diff = d - d2;
      expect(diff is Double, true);
      expect((diff as Double).value, closeTo(27.735, 0.000001));
      diff = d2 - d;
      expect(diff is Double, true);
      expect((diff as Double).value, closeTo(-27.735, 0.000001));
      final Double d3 = new Double(-1.23);
      diff = d2 - d3;
      expect(diff is Double, true);
      expect((diff as Double).value, closeTo(15.551, 0.000001));
      diff = d3 - d2;
      expect(diff is Double, true);
      expect((diff as Double).value, closeTo(-15.551, 0.000001));

      // - Integer
      Integer a = new Integer(4);
      diff = d - a;
      expect(diff is Double, true);
      expect(diff, new Double(38.056));
      a = new Integer(-2);
      diff = d - a;
      expect(diff is Double, true);
      expect(diff, new Double(44.056));

      // - Imaginary
      Imaginary i = new Imaginary(34.21);
      diff = d - i;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toDouble(), closeTo(42.056, 0.000001));
      expect((diff as Complex).imag.value.toDouble(), closeTo(-34.21, 0.000001));
      i = new Imaginary(-6);
      diff = d - i;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toDouble(), closeTo(42.056, 0.000001));
      expect((diff as Complex).imag.value.toDouble(), 6);

      // - Complex
      Complex cx = new Complex(new Double(2.1), new Imaginary(9.6));
      diff = d - cx;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toDouble(), closeTo(39.956, 0.000001));
      expect((diff as Complex).imag.value.toDouble(), -9.6);
      cx = new Complex(new Double(-2.1), new Imaginary(-9.6));
      diff = d - cx;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toDouble(), closeTo(44.156, 0.000001));
      expect((diff as Complex).imag.value.toDouble(), 9.6);

      // - Precise
      Precise p = new Precise('1.013');
      diff = d - p;
      expect(diff is Precise, true);
      expect(diff, new Precise('41.043'));
      p = new Precise('-1.013');
      diff = d - p;
      expect(diff is Precise, true);
      expect(diff, new Precise('43.069'));
    });

    test('operator *', () {
      final Double d = new Double(1.2);
      final Double d2 = new Double(3.4);

      // * int
      Number prod = d * 3;
      expect(prod is Double, true);
      expect((prod as Double).value.toDouble(), closeTo(3.6, 0.000001));
      prod = d * (-6);
      expect(prod is Double, true);
      expect((prod as Double).value.toDouble(), closeTo(-7.2, 0.000001));

      // * double
      prod = d * 2.1;
      expect(prod is Double, true);
      expect((prod as Double).value.toDouble(), closeTo(2.52, 0.000001));
      prod = d * (-1.2);
      expect(prod is Double, true);
      expect((prod as Double).value.toDouble(), closeTo(-1.44, 0.000001));

      // * Double
      prod = d * d2;
      expect(prod is Double, true);
      expect((prod as Double).value, closeTo(4.08, 0.000001));
      final Double d3 = new Double(-0.6);
      prod = d2 * d3;
      expect(prod is Double, true);
      expect((prod as Double).value, closeTo(-2.04, 0.000001));

      // * Integer
      Integer a = new Integer(4);
      prod = d * a;
      expect(prod is Double, true);
      expect(prod, new Double(4.8));
      a = new Integer(-2);
      prod = d * a;
      expect(prod is Double, true);
      expect(prod, new Double(-2.4));

      // * Imaginary
      Imaginary i = new Imaginary(2.6);
      prod = d * i;
      expect(prod is Imaginary, true);
      expect((prod as Imaginary).value.toDouble(), closeTo(3.12, 0.000001));
      i = new Imaginary(-6);
      prod = d * i;
      expect(prod is Imaginary, true);
      expect((prod as Imaginary).value.toDouble(), closeTo(-7.2, 0.000001));

      // * Complex
      Complex cx = new Complex(new Double(2.1), new Imaginary(9.6));
      prod = d * cx;
      expect(prod is Complex, true);
      expect((prod as Complex).real.toDouble(), closeTo(2.52, 0.000001));
      expect((prod as Complex).imag.value.toDouble(), 11.52);
      cx = new Complex(new Double(-2.1), new Imaginary(-9.6));
      prod = d * cx;
      expect(prod is Complex, true);
      expect((prod as Complex).real.toDouble(), closeTo(-2.52, 0.000001));
      expect((prod as Complex).imag.value.toDouble(), -11.52);

      // * Precise
      Precise p = new Precise('1.013');
      prod = d * p;
      expect(prod is Precise, true);
      expect(prod, new Precise('1.2156'));
      p = new Precise('-1.013');
      prod = d * p;
      expect(prod is Precise, true);
      expect(prod, new Precise('-1.2156'));
    });

    test('operator /', () {
      final Double d = new Double(1.2);
      final Double d2 = new Double(3.4);

      // / int
      Number quot = d / 3;
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(0.4, 0.000001));
      quot = d / (-6);
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(-0.2, 0.000001));

      // * double
      quot = d / 0.12;
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(10.0, 0.000001));
      quot = d / (-0.4);
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(-3.0, 0.000001));

      // / Double
      quot = d / d2;
      expect(quot is Double, true);
      expect((quot as Double).value, closeTo(0.3529411764705882, 0.000001));
      final Double d3 = new Double(-0.6);
      quot = d2 / d3;
      expect(quot is Double, true);
      expect((quot as Double).value, closeTo(-5.666666666666667, 0.000001));

      // / Integer
      Integer a = new Integer(4);
      quot = d / a;
      expect(quot is Double, true);
      expect(quot, new Double(0.3));
      a = new Integer(-2);
      quot = d / a;
      expect(quot is Double, true);
      expect(quot, new Double(-0.6));

      // / Imaginary
      Imaginary i = new Imaginary(2.4);
      quot = d / i;
      expect(quot is Imaginary, true);
      expect((quot as Imaginary).value.toDouble(), closeTo(-0.5, 0.000001));
      i = new Imaginary(-6);
      quot = d / i;
      expect(quot is Imaginary, true);
      expect((quot as Imaginary).value.toDouble(), closeTo(0.2, 0.000001));

      // / Complex
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Complex cx = new Complex(new Double(1.0), new Imaginary(2));
      quot = new Double(4.0) / cx;
      expect(quot is Complex, true);
      expect((quot as Complex).real.toDouble(), closeTo(0.8, 0.000001));
      expect((quot as Complex).imag.value.toDouble(), -1.6);
      cx = new Complex(new Double(-1.0), new Imaginary(-2));
      quot = new Double(4.0) / cx;
      expect(quot is Complex, true);
      expect((quot as Complex).real.toDouble(), closeTo(-0.8, 0.000001));
      expect((quot as Complex).imag.value.toDouble(), 1.6);

      // / Precise
      Precise p = new Precise('4.8');
      quot = d / p;
      expect(quot is Precise, true);
      expect(quot, new Precise('0.25'));
      p = new Precise('-4.8');
      quot = d / p;
      expect(quot is Precise, true);
      expect(quot, new Precise('-0.25'));
    });
  });
}
