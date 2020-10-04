import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Double', () {
    test('constants', () {
      const Double d = const Double.constant(42);
      expect(d.value, 42.0);
      expect(Double.zero.value, 0.0);
      expect(Double.one.value, 1.0);
      expect(Double.ten.value, 10.0);
      expect(Double.hundred.value, 100.0);
      expect(Double.thousand.value, 1000.0);
      expect(Double.infinity.value, double.infinity);
      expect(Double.negInfinity.value, double.negativeInfinity);
      expect(identical(Double.NaN.value, double.nan), true);
    });

    test('operator ==', () {
      final Double d = new Double(42.056);
      final Double d2 = new Double(14.321);
      final Double d3 = new Double(42.056);
      final Double d4 = new Double(42);
      final Double d5 = new Double(42.toDouble());
      expect(d == d, true);
      expect(d == d2, false);
      expect(d == d3, true);
      expect(d.toDouble() == 42.056, true);
      expect(d.toDouble() == 42.0560001, false);
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
      final Complex c1 = new Complex(new Double(42), new Imaginary(0));
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

    test('operator unary-', () {
      final Double d0 = new Double(0);
      final Double d1 = new Double(14.6);
      final Double d2 = new Double(-22.13);
      expect(-d0, new Double(0));
      expect(-d1, new Double(-14.6));
      expect(-d2, new Double(22.13));
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
      expect(quot is Integer, true);
      expect(quot, new Integer(10));
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
      Complex cx = new Complex(new Double(1), new Imaginary(2));
      quot = new Double(4) / cx;
      expect(quot is Complex, true);
      expect((quot as Complex).real.toDouble(), closeTo(0.8, 0.000001));
      expect((quot as Complex).imag.value.toDouble(), -1.6);
      cx = new Complex(new Double(-1), new Imaginary(-2));
      quot = new Double(4) / cx;
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

    test('operator >', () {
      expect(new Double(1) > new Double(0), true);
      expect(new Double(0) > new Double(1), false);
      expect(new Double(-9) > new Double(2), false);
      expect(new Double(2) > new Double(-9), true);
      expect(new Double(-99.99) > new Double(22.22), false);
      expect(new Double(22.22) > new Double(-99.99), true);
      expect(new Double(1) > new Double(0.999999), true);
      expect(new Double(1) > new Double(1), false);
      expect(new Double(1) > 0.5, true);
      expect(new Double(1) > 1, false);
      expect(new Double(1) > -8.8, true);
      expect(new Double(44) > new Integer(44), false);
      expect(new Double(44) > new Integer(43), true);
      expect(new Double(44.1) > new Integer(44), true);
      expect(new Double(43.9999999) > new Integer(44), false);
      expect(new Double(44.0000001) > new Integer(44), true);

      // > only looks at real parts.
      expect(new Double(77) > new Imaginary(5), true);
      expect(new Double(77) > new Imaginary(85.7), true);
      expect(new Double(-77) > new Imaginary(6), false);
      expect(new Double(77) > new Complex(new Double(6.5), new Imaginary(99)), true);
      expect(new Double(-77.7) > new Complex(new Double(6.5), new Imaginary(99)), false);

      expect(new Double(88.99999) > new Precise('88.99999'), false);
      expect(new Double(88.99999) > new Precise('88.999989999'), true);
      expect(new Double(88.99999) > new Precise('89.000000000'), false);
      expect(new Double(-88.99999) > new Precise('-88.99999'), false);
      expect(new Double(-88.99999) > new Precise('-88.999989999'), false);
      expect(new Double(-88.99999) > new Precise('-89.000000000'), true);
    });

    test('operator >=', () {
      expect(new Double(1) >= new Double(0), true);
      expect(new Double(0) >= new Double(1), false);
      expect(new Double(-9) >= new Double(2), false);
      expect(new Double(2) >= new Double(-9), true);
      expect(new Double(-99.99) >= new Double(22.22), false);
      expect(new Double(22.22) >= new Double(-99.99), true);
      expect(new Double(1) >= new Double(0.999999), true);
      expect(new Double(1) >= new Double(1), true);
      expect(new Double(1) >= 0.5, true);
      expect(new Double(1) >= 1, true);
      expect(new Double(1) >= -8.8, true);
      expect(new Double(44) >= new Integer(44), true);
      expect(new Double(44) >= new Integer(43), true);
      expect(new Double(44.1) >= new Integer(44), true);
      expect(new Double(43.9999999) >= new Integer(44), false);
      expect(new Double(44.0000001) >= new Integer(44), true);

      // >= only looks at real parts.
      expect(new Double(77) >= new Imaginary(5), true);
      expect(new Double(77) >= new Imaginary(85.7), true);
      expect(new Double(-77) >= new Imaginary(6), false);
      expect(new Double(77) >= new Complex(new Double(6.5), new Imaginary(99)), true);
      expect(new Double(77) >= new Complex(new Double(77), new Imaginary(99)), true);
      expect(new Double(77) >= new Complex(new Double(77.0001), new Imaginary(99)), false);
      expect(new Double(-77.7) >= new Complex(new Double(6.5), new Imaginary(99)), false);

      //expect(new Double(88.99999) >= new Precise('88.99999'), true);
      expect(new Double(88.99999) >= new Precise('88.999989999'), true);
      expect(new Double(88.99999) >= new Precise('89.000000000'), false);
      expect(new Double(-88.99999) >= new Precise('-88.99999'), true);
      expect(new Double(-88.99999) >= new Precise('-88.999989999'), false);
      expect(new Double(-88.99999) >= new Precise('-89.000000000'), true);
    });

    test('operator <', () {
      expect(new Double(1) < new Double(0), false);
      expect(new Double(0) < new Double(1), true);
      expect(new Double(-9) < new Double(2), true);
      expect(new Double(2) < new Double(-9), false);
      expect(new Double(-99.99) < new Double(22.22), true);
      expect(new Double(22.22) < new Double(-99.99), false);
      expect(new Double(1) < new Double(0.999999), false);
      expect(new Double(1) < new Double(1), false);
      expect(new Double(1) < 0.5, false);
      expect(new Double(1) < 1, false);
      expect(new Double(1) < 8.8, true);
      expect(new Double(44) < new Integer(44), false);
      expect(new Double(42) < new Integer(43), true);
      expect(new Double(44.1) < new Integer(44), false);
      expect(new Double(43.9999999) < new Integer(44), true);
      expect(new Double(44.0000001) < new Integer(44), false);

      // < only looks at real parts.
      expect(new Double(77) < new Imaginary(5), false);
      expect(new Double(77) < new Imaginary(85.7), false);
      expect(new Double(-77) < new Imaginary(6), true);
      expect(new Double(77) < new Complex(new Double(6.5), new Imaginary(99)), false);
      expect(new Double(-77.7) < new Complex(new Double(6.5), new Imaginary(99)), true);

      expect(new Double(88.99999) < new Precise('88.99999'), false);
      expect(new Double(88.99999) < new Precise('88.999989999'), false);
      expect(new Double(88.99999) < new Precise('89.000000000'), true);
      expect(new Double(-88.99999) < new Precise('-88.99999'), false);
      expect(new Double(-88.99999) < new Precise('-88.999989999'), true);
      expect(new Double(-88.99999) < new Precise('-89.000000000'), false);
    });

    test('operator <=', () {
      expect(new Double(1) <= new Double(0), false);
      expect(new Double(0) <= new Double(1), true);
      expect(new Double(-9) <= new Double(2), true);
      expect(new Double(2) <= new Double(-9), false);
      expect(new Double(-99.99) <= new Double(22.22), true);
      expect(new Double(22.22) <= new Double(-99.99), false);
      expect(new Double(1) <= new Double(0.999999), false);
      expect(new Double(1) <= new Double(1), true);
      expect(new Double(1) <= 0.5, false);
      expect(new Double(1) <= 1, true);
      expect(new Double(1) <= 8.8, true);
      expect(new Double(44) <= new Integer(44), true);
      expect(new Double(42) <= new Integer(43), true);
      expect(new Double(44.1) <= new Integer(44), false);
      expect(new Double(43.9999999) <= new Integer(44), true);
      expect(new Double(44.0000001) <= new Integer(44), false);

      // <= only looks at real parts.
      expect(new Double(77) <= new Imaginary(5), false);
      expect(new Double(77) <= new Imaginary(85.7), false);
      expect(new Double(-77) <= new Imaginary(6), true);
      expect(new Double(77) <= new Complex(new Double(6.5), new Imaginary(99)), false);
      expect(new Double(77) <= new Complex(new Double(77), new Imaginary(22)), true);
      expect(new Double(-77.7) <= new Complex(new Double(6.5), new Imaginary(99)), true);

      expect(new Double(88.99999) <= new Precise('88.99999'), true);
      expect(new Double(88.99999) <= new Precise('88.999989999'), false);
      expect(new Double(88.99999) <= new Precise('89.000000000'), true);
      expect(new Double(-88.99999) <= new Precise('-88.99999'), true);
      expect(new Double(-88.99999) <= new Precise('-88.999989999'), true);
      expect(new Double(-88.99999) <= new Precise('-89.000000000'), false);
    });

    test('operator ^', () {
      expect(new Double(2) ^ 0, new Integer(1));
      expect(new Double(2) ^ 1, new Integer(2));
      expect(new Double(2) ^ 2, new Integer(4));
      expect(new Double(2) ^ 3, new Integer(8));
      expect(new Double(2) ^ 4, new Integer(16));
      expect(new Double(2) ^ -1, new Double(0.5));
      expect(new Double(2) ^ -2, new Double(0.25));
      expect(new Double(2) ^ -3, new Double(0.125));
      expect(new Double(2) ^ -4, new Double(0.0625));
    });

    test('hashcode', () {
      expect(Double.NaN.hashCode, double.nan.hashCode);
      expect(Double.infinity.hashCode, double.infinity.hashCode);
      expect(Double.negInfinity.hashCode, double.negativeInfinity.hashCode);
      expect(new Double(0).hashCode, 0.hashCode);
      expect(new Double(1).hashCode, 1.hashCode);
      expect(new Double(-5).hashCode, -5.hashCode);
      expect(new Double(99.99).hashCode, new Precise('99.99').hashCode);
      expect(new Double(98765.4321).hashCode, new Precise('98765.4321').hashCode);
      expect(new Double(-98765.4321).hashCode, new Precise('-98765.4321').hashCode);
    });

    test('clamp', () {
      expect(new Double(0).clamp(-5, 5), Integer(0));
      expect(new Double(0).clamp(2, 7), Integer(2));
      expect(new Double(8).clamp(2, 7), Integer(7));
      expect(new Double(8.7).clamp(2.9, 7), Integer(7));
      expect(new Double(-9.7).clamp(-9.5, -8.2), Double(-9.5));
      expect(new Double(10.3).clamp(-9.5, -8.2), Double(-8.2));
    });

    test('abs', () {
      expect(new Double(0).abs(), Double(0));
      expect(new Double(1).abs(), Double(1));
      expect(new Double(1.23).abs(), Double(1.23));
      expect(new Double(-1).abs(), Double(1));
      expect(new Double(-1.23).abs(), Double(1.23));
    });

    test('ceil', () {
      expect(new Double(0).ceil(), Integer(0));
      expect(new Double(0.999).ceil(), Integer(1));
      expect(new Double(1).ceil(), Integer(1));
      expect(new Double(1.001).ceil(), Integer(2));
      expect(new Double(-1).ceil(), Integer(-1));
      expect(new Double(-0.999).ceil(), Integer(0));
      expect(new Double(-1.001).ceil(), Integer(-1));
    });

    test('floor', () {
      expect(new Double(0).floor(), Integer(0));
      expect(new Double(0.999).floor(), Integer(0));
      expect(new Double(1).floor(), Integer(1));
      expect(new Double(1.001).floor(), Integer(1));
      expect(new Double(-1).floor(), Integer(-1));
      expect(new Double(-0.999).floor(), Integer(-1));
      expect(new Double(-1.001).floor(), Integer(-2));
    });

    test('reciprocal', () {
      expect(new Double(0).reciprocal(), Double.NaN);
      expect(new Double(1).reciprocal(), Integer(1));
      expect(new Double(-1).reciprocal(), Integer(-1));
      expect(new Double(2).reciprocal(), Double(0.5));
      expect(new Double(-2).reciprocal(), Double(-0.5));
      expect(new Double(2.5).reciprocal(), Double(0.4));
      expect(new Double(-2.5).reciprocal(), Double(-0.4));
      expect(new Double(0.25).reciprocal(), Integer(4));
      expect(new Double(-0.25).reciprocal(), Integer(-4));
    });

    test('remainder', () {
      expect(new Double(0).remainder(5), Integer(0));
      expect(new Double(1).remainder(5), Integer(1));
      expect(new Double(4).remainder(1), Integer(0));
      expect(new Double(23.7).remainder(4).toDouble(), closeTo(3.7, 1e-12));
      expect(new Double(-23.7).remainder(4).toDouble(), closeTo(-3.7, 1e-12));
      expect(new Double(23.7).remainder(-4).toDouble(), closeTo(3.7, 1e-12));
      expect(new Double(-23.7).remainder(-4).toDouble(), closeTo(-3.7, 1e-12));
    });

    test('round', () {
      expect(new Double(0).round(), Integer(0));
      expect(new Double(1).round(), Integer(1));
      expect(new Double(2.2).round(), Integer(2));
      expect(new Double(2.5).round(), Integer(3));
      expect(new Double(2.7).round(), Integer(3));
      expect(new Double(-2.2).round(), Integer(-2));
      expect(new Double(-2.5).round(), Integer(-3));
      expect(new Double(-2.7).round(), Integer(-3));
    });

    test('truncate', () {
      expect(new Double(0).truncate(), Integer(0));
      expect(new Double(1).truncate(), Integer(1));
      expect(new Double(2.2).truncate(), Integer(2));
      expect(new Double(2.5).truncate(), Integer(2));
      expect(new Double(2.7).truncate(), Integer(2));
      expect(new Double(-2.2).truncate(), Integer(-2));
      expect(new Double(-2.5).truncate(), Integer(-2));
      expect(new Double(-2.7).truncate(), Integer(-2));
    });

    test('toDouble', () {
      expect(new Double(0).toDouble(), 0.0);
      expect(new Double(1).toDouble(), 1.0);
      expect(new Double(2.5).toDouble(), 2.5);
      expect(new Double(-2.5).toDouble(), -2.5);
      expect(Double.zero.toDouble(), 0.0);
      expect(Double.one.toDouble(), 1.0);
      expect(Double.ten.toDouble(), 10.0);
      expect(Double.hundred.toDouble(), 100.0);
      expect(Double.thousand.toDouble(), 1000.0);
      expect(Double.infinity.toDouble(), double.infinity);
      expect(Double.negInfinity.toDouble(), double.negativeInfinity);
      expect(Double.NaN.toDouble().isNaN, true);
    });

    test('toInt', () {
      expect(new Double(0).toInt(), 0);
      expect(new Double(1).toInt(), 1);
      expect(new Double(2.5).toInt(), 2);
      expect(new Double(-2.5).toInt(), -2);
      expect(Double.zero.toInt(), 0);
      expect(Double.one.toInt(), 1);
      expect(Double.ten.toInt(), 10);
      expect(Double.hundred.toInt(), 100);
      expect(Double.thousand.toInt(), 1000);
    });

    test('toString', () {
      expect(new Double(0).toString(), '0.0');
      expect(new Double(1).toString(), '1.0');
      expect(new Double(2.5).toString(), '2.5');
      expect(new Double(-2.5).toString(), '-2.5');
      expect(new Double(-15.2345e-28).toString(), '-1.52345e-27');
    });

    test('isInfinite', () {
      expect(new Double(0).isInfinite, false);
      expect(new Double(999999999999999.9).isInfinite, false);
      expect(new Double(double.infinity).isInfinite, true);
      expect(new Double(double.negativeInfinity).isInfinite, true);
      expect(Double.infinity.isInfinite, true);
      expect(Double.negInfinity.isInfinite, true);
      expect(Double.NaN.isInfinite, false);
    });

    test('isNaN', () {
      expect(new Double(0).isNaN, false);
      expect(new Double(double.nan).isNaN, true);
      expect(new Double(double.infinity).isNaN, false);
      expect(new Double(double.negativeInfinity).isNaN, false);
      expect(Double.infinity.isNaN, false);
      expect(Double.negInfinity.isNaN, false);
      expect(Double.NaN.isNaN, true);
    });

    test('isNegative', () {
      expect(new Double(0).isNegative, false);
      expect(new Double(0.00001).isNegative, false);
      expect(new Double(-0.00001).isNegative, true);
      expect(new Double(1224.87878e76).isNegative, false);
      expect(new Double(-1224.87878e76).isNegative, true);
      expect(new Double(1224.87878e-76).isNegative, false);
      expect(new Double(-1224.87878e-76).isNegative, true);
      expect(new Double(double.infinity).isNegative, false);
      expect(new Double(double.negativeInfinity).isNegative, true);
      expect(Double.infinity.isNegative, false);
      expect(Double.negInfinity.isNegative, true);
      expect(Double.NaN.isNegative, false);
    });

    test('isInteger', () {
      expect(new Double(0).isInteger, true);
      expect(new Double(0.00001).isInteger, false);
      expect(new Double(-0.00001).isInteger, false);
      expect(new Double(-1224).isInteger, true);
      expect(new Double(double.infinity).isInteger, false);
      expect(new Double(double.negativeInfinity).isInteger, false);
      expect(new Double(double.nan).isInteger, false);
      expect(new Double(double.minPositive).isInteger, false);
      expect(new Double(double.maxFinite).isInteger, false);
      expect(Double.infinity.isInteger, false);
      expect(Double.negInfinity.isInteger, false);
      expect(Double.NaN.isInteger, false);
      expect(Double.zero.isInteger, true);
    });
  });
}
