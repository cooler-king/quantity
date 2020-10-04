import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Integer', () {
    test('constants', () {
      const Integer d = const Integer.constant(42);
      expect(d.value, 42);
      expect(Integer.zero.value, 0);
      expect(Integer.one.value, 1);
      expect(Integer.ten.value, 10);
      expect(Integer.hundred.value, 100);
      expect(Integer.thousand.value, 1000);
    });

    test('operator ==', () {
      final Integer d = new Integer(42);
      final Integer d2 = new Integer(14);
      final Integer d3 = new Integer(42);
      final Integer d4 = new Integer(44);
      final Integer d5 = new Integer(44.234.toInt());
      expect(d == d, true);
      expect(d == d2, false);
      expect(d == d3, true);
      // ignore: unrelated_type_equality_checks
      expect(d == 42, true);
      // ignore: unrelated_type_equality_checks
      expect(d == 42.000, true);
      // ignore: unrelated_type_equality_checks
      expect(d == 42.0000001, false);
      expect(d4 == d5, true);

      // equality with nums
      // ignore: unrelated_type_equality_checks
      expect(d4 == 44, true);
      // ignore: unrelated_type_equality_checks
      expect(d5 == 44, true);
      // ignore: unrelated_type_equality_checks
      expect(d4 == 44.0, true);
      // ignore: unrelated_type_equality_checks
      expect(d5 == 44.0, true);

      // equality with complex
      final Complex c1 = new Complex(new Integer(42), new Imaginary(0.0));
      // ignore: unrelated_type_equality_checks
      expect(d == c1, true);
      final Complex c2 = new Complex(new Integer(42), new Imaginary(0.1));
      // ignore: unrelated_type_equality_checks
      expect(d == c2, false);
      final Complex c3 = new Complex(new Integer(41), new Imaginary(0.0));
      // ignore: unrelated_type_equality_checks
      expect(d == c3, false);
    });

    test('hashcode', () {
      expect(Double.NaN.hashCode, double.nan.hashCode);
      expect(Double.infinity.hashCode, double.infinity.hashCode);
      expect(Double.negInfinity.hashCode, double.negativeInfinity.hashCode);
      expect(new Integer(0).hashCode, 0.hashCode);
      expect(new Integer(1).hashCode, 1.hashCode);
      expect(new Integer(-5).hashCode, -5.hashCode);
      expect(new Integer(99).hashCode, new Precise('99').hashCode);
      expect(new Integer(-99).hashCode, new Precise('-99').hashCode);
      expect(new Integer(-99).hashCode == new Integer(99).hashCode, false);
    });

    test('operator +', () {
      final Integer d = new Integer(42);

      // + int
      expect(d + 77 is Integer, true);
      expect((d + 77 as Integer).value == 119, true);
      expect(d + -53 is Integer, true);
      expect((d + -53 as Integer).value == -11, true);

      // + double
      expect(d + 6.5 is Double, true);
      expect((d + 6.5 as Double).value == 48.5, true);
      expect(d + -12.3 is Double, true);
      expect((d + -12.3 as Double).value == 29.7, true);

      // + Integer
      final Integer d2 = new Integer(14);
      expect(d + d2 is Integer, true);
      expect((d + d2 as Integer).value == 56, true);
      final Integer d3 = new Integer(-901);
      expect(d + d3 is Integer, true);
      expect((d + d3 as Integer).value == -859, true);

      // + Imaginary
      final Imaginary i = new Imaginary(34.21);
      expect(d + i is Complex, true);
      expect((d + i as Complex).real.value == 42, true);
      // ignore: unrelated_type_equality_checks
      expect((d + i as Complex).imag.value == 34.21, true);
      final Imaginary i2 = new Imaginary(-8);
      expect(d + i2 is Complex, true);
      expect((d + i2 as Complex).real.value == 42, true);
      // ignore: unrelated_type_equality_checks
      expect((d + i2 as Complex).imag.value == -8, true);

      // + Complex
      Complex cx = new Complex(new Double(2.1), new Imaginary(9.6));
      dynamic sum = d + cx;
      expect(sum is Complex, true);
      expect((sum as Complex).real.toDouble(), closeTo(44.1, 0.000001));
      expect((sum as Complex).imag.value.toDouble(), 9.6);
      cx = new Complex(new Double(-2.1), new Imaginary(-9.6));
      sum = d + cx;
      expect(sum is Complex, true);
      expect((sum as Complex).real.toDouble(), closeTo(39.9, 0.000001));
      expect((sum as Complex).imag.value.toDouble(), -9.6);

      // + Precise
      Precise p = new Precise('34.21');
      expect(d + p is Precise, true);
      expect((d + p as Precise).value == 76.21, true);
      p = new Precise('-21.7');
      expect(d + p is Precise, true);
      expect((d + p as Precise).value == 20.3, true);
    });

    test('operator -', () {
      final Integer i = new Integer(42);

      // - int
      Number diff = i - 3;
      expect(diff is Integer, true);
      expect((diff as Integer).value.toInt(), 39);
      diff = i - (-4);
      expect(diff is Integer, true);
      expect((diff as Integer).value.toDouble(), 46);

      // - double
      diff = i - 5.1;
      expect(diff is Double, true);
      expect((diff as Double).value.toDouble(), 36.9);
      diff = i - (-5.1);
      expect(diff is Double, true);
      expect((diff as Double).value.toDouble(), 47.1);

      // - Integer
      Integer a = new Integer(4);
      diff = i - a;
      expect(diff is Integer, true);
      expect(diff, new Integer(38));
      a = new Integer(-2);
      diff = i - a;
      expect(diff is Integer, true);
      expect(diff, new Integer(44));

      // - Double
      final Double d = new Double(14.265);
      diff = i - d;
      expect(diff is Double, true);
      expect((diff as Double).value, closeTo(27.735, 0.000001));

      // - Imaginary
      Imaginary imag = new Imaginary(34.21);
      diff = i - imag;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toInt(), 42);
      expect((diff as Complex).imag.value.toDouble(), closeTo(-34.21, 0.000001));
      imag = new Imaginary(-6);
      diff = i - imag;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toInt(), 42);
      expect((diff as Complex).imag.value.toDouble(), 6);

      // - Complex
      Complex cx = new Complex(new Double(2), new Imaginary(9.6));
      diff = i - cx;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toInt(), 40);
      expect((diff as Complex).imag.value.toDouble(), -9.6);
      cx = new Complex(new Double(-2.1), new Imaginary(-9.6));
      diff = i - cx;
      expect(diff is Complex, true);
      expect((diff as Complex).real.toDouble(), closeTo(44.1, 0.000001));
      expect((diff as Complex).imag.value.toDouble(), 9.6);

      // - Precise
      Precise p = new Precise('1');
      diff = i - p;
      expect(diff is Precise, true);
      expect(diff, new Precise('41'));
      p = new Precise('-1.013');
      diff = i - p;
      expect(diff is Precise, true);
      expect(diff, new Precise('43.013'));
    });

    test('operator unary-', () {
      final Integer i0 = new Integer(0);
      final Integer i1 = new Integer(1);
      final Integer iNeg2 = new Integer(-2);
      expect(-i0, new Integer(0));
      expect(-i1, new Integer(-1));
      expect(-iNeg2, new Integer(2));
    });

    test('operator *', () {
      final Integer d = new Integer(5);

      // * int
      Number prod = d * 3;
      expect(prod is Integer, true);
      expect((prod as Integer).value.toInt(), 15);
      prod = d * (-6);
      expect(prod is Integer, true);
      expect((prod as Integer).value.toDouble(), -30);

      // * double
      prod = d * 2.1;
      expect(prod is Double, true);
      expect((prod as Double).value.toDouble(), closeTo(10.5, 0.000001));
      prod = d * (-1.2);
      expect(prod is Integer, true);
      expect((prod as Integer).value.toInt(), -6);

      // * Integer
      Integer a = new Integer(4);
      prod = d * a;
      expect(prod is Integer, true);
      expect(prod, new Integer(20));
      a = new Integer(-2);
      prod = d * a;
      expect(prod is Integer, true);
      expect(prod, new Integer(-10));

      // * Double
      final Double d2 = new Double(-3.1);
      prod = d * d2;
      expect(prod is Double, true);
      expect((prod as Double).value, closeTo(-15.5, 0.000001));

      // * Imaginary
      Imaginary i = new Imaginary(2.3);
      prod = d * i;
      expect(prod is Imaginary, true);
      expect((prod as Imaginary).value.toDouble(), closeTo(11.5, 0.000001));
      i = new Imaginary(-6);
      prod = d * i;
      expect(prod is Imaginary, true);
      expect((prod as Imaginary).value is Integer, true);
      expect((prod as Imaginary).value.toInt(), -30);

      // * Complex
      Complex cx = new Complex(new Double(2.1), new Imaginary(9.6));
      prod = d * cx;
      expect(prod is Complex, true);
      expect((prod as Complex).real.toDouble(), closeTo(10.5, 0.000001));
      expect((prod as Complex).imag.value is Integer, true);
      expect((prod as Complex).imag.value.toDouble(), 48);
      cx = new Complex(new Double(-2.1), new Imaginary(-9.6));
      prod = d * cx;
      expect(prod is Complex, true);
      expect((prod as Complex).real.toDouble(), closeTo(-10.5, 0.000001));
      expect((prod as Complex).imag.value is Integer, true);
      expect((prod as Complex).imag.value.toDouble(), -48);

      // * Precise
      Precise p = new Precise('1.013');
      prod = d * p;
      expect(prod is Precise, true);
      expect(prod, new Precise('5.065'));
      p = new Precise('-1.013');
      prod = d * p;
      expect(prod is Precise, true);
      expect(prod, new Precise('-5.065'));
    });

    test('operator /', () {
      final Integer d = new Integer(4);

      // / int
      Number quot = d / 8;
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(0.5, 0.000001));
      quot = d / (-6);
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(-0.666666666, 0.000001));

      // * double
      quot = d / 0.1;
      expect(quot is Integer, true);
      expect((quot as Integer).value.toInt(), 40);
      quot = d / (-0.044);
      expect(quot is Double, true);
      expect((quot as Double).value.toDouble(), closeTo(-90.90909090909092, 0.000001));

      // / Integer
      Integer a = new Integer(16);
      quot = d / a;
      expect(quot is Double, true);
      expect(quot, new Double(0.25));
      a = new Integer(-2);
      quot = d / a;
      expect(quot is Integer, true);
      expect(quot, new Integer(-2));

      // / Double
      final Double d2 = new Double(3.4);
      quot = d / d2;
      expect(quot is Double, true);
      expect((quot as Double).value, closeTo(1.17647058823529422, 0.000000001));
      final Double d3 = new Double(-0.2);
      quot = d / d3;
      expect(quot is Integer, true);
      expect((quot as Integer).value, -20);

      // / Imaginary
      Imaginary i = new Imaginary(8);
      quot = d / i;
      expect(quot is Imaginary, true);
      expect((quot as Imaginary).value.toDouble(), closeTo(-0.5, 0.000001));
      i = new Imaginary(-2);
      quot = d / i;
      expect(quot is Imaginary, true);
      expect((quot as Imaginary).value is Integer, true);
      expect((quot as Imaginary).value.toInt(), 2);

      // / Complex
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Complex cx = new Complex(new Double(1), new Imaginary(2));
      quot = new Integer(4) / cx;
      expect(quot is Complex, true);
      expect((quot as Complex).real.toDouble(), closeTo(0.8, 0.000001));
      expect((quot as Complex).imag.value.toDouble(), -1.6);
      cx = new Complex(new Double(-1), new Imaginary(-2));
      quot = new Integer(4) / cx;
      expect(quot is Complex, true);
      expect((quot as Complex).real.toDouble(), closeTo(-0.8, 0.000001));
      expect((quot as Complex).imag.value.toDouble(), 1.6);

      // / Precise
      Precise p = new Precise('16.00');
      quot = d / p;
      expect(quot is Precise, true);
      expect(quot, new Precise('0.25'));
      p = new Precise('-4.876876858');
      quot = d / p;
      expect(quot is Precise, true);
      expect(quot.toDouble(), closeTo(-0.0821970475097036, 0.000000000000001));
    });

    test('operator ~/', () {
      final Integer d = new Integer(43);

      // ~/ int
      Number n = d ~/ 8;
      expect(n is Integer, true);
      expect((n as Integer).value.toInt(), 5);
      n = d ~/ (-6);
      expect(n is Integer, true);
      expect((n as Integer).value.toInt(), -7);
      n = d ~/ 1;
      expect(n is Integer, true);
      expect(n, 43);

      // * double
      n = d ~/ 2.01;
      expect((n as Integer).value.toInt(), 21);
      n = d ~/ (-0.4);
      expect((n as Integer).value.toInt(), -107);

      // / Integer
      Integer a = new Integer(16);
      n = d ~/ a;
      expect(n, new Integer(2));
      a = new Integer(-2);
      n = d ~/ a;
      expect(n, new Integer(-21));

      // / Double
      final Double d2 = new Double(3.4);
      n = d ~/ d2;
      expect(n, new Integer(12));
      final Double d3 = new Double(-0.2);
      n = d ~/ d3;
      expect(n, new Integer(-215));

      // / Imaginary
      Imaginary i = new Imaginary(8);
      n = d ~/ i;
      expect(n, new Imaginary(-5));
      i = new Imaginary(-2);
      n = d ~/ i;
      expect(n, new Imaginary(21));

      // / Complex
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      final Complex cx = new Complex(new Double(1), new Imaginary(2));
      n = new Integer(12) ~/ cx;
      expect(n is Complex, true);
      expect((n as Complex).real is Integer, true);
      expect((n as Complex).real, new Integer(2));
      expect((n as Complex).imag.value.toDouble(), -24 / 5);

      // / Precise
      Precise p = new Precise('16.00');
      n = d ~/ p;
      expect(n is Precise, true);
      expect(n, new Precise('2.0'));
      p = new Precise('-4.876876858');
      n = d ~/ p;
      expect(n is Precise, true);
      expect(n, new Precise('-8.0'));
    });

    test('operator <', () {
      expect(new Integer(1) < 0.5, false);
      expect(new Integer(1) < 0, false);
      expect(new Integer(1) < 1, false);
      expect(new Integer(1) < 2, true);
      expect(new Integer(1) < 1.1, true);
      expect(new Integer(42) < new Integer(43), true);
      expect(new Integer(43) < new Integer(43), false);
      expect(new Integer(44) < new Integer(43), false);
      expect(new Integer(1) < new Double(0), false);
      expect(new Integer(0) < new Double(1), true);
      expect(new Integer(0) < new Double(0), false);
      expect(new Integer(-9) < new Double(2), true);
      expect(new Integer(2) < new Double(-9), false);

      // < only looks at real parts.
      expect(new Integer(77) < new Imaginary(5), false);
      expect(new Integer(77) < new Imaginary(85.7), false);
      expect(new Integer(-77) < new Imaginary(6), true);
      expect(new Integer(77) < new Complex(new Double(6.5), new Imaginary(99)), false);
      expect(new Integer(-77) < new Complex(new Double(77.001), new Imaginary(55)), true);

      expect(new Integer(88) < new Precise('87.999999999999999999'), false);
      expect(new Integer(88) < new Precise('88.000000000000000000'), false);
      expect(new Integer(88) < new Precise('88.000000000000000001'), true);
    });

    test('operator <=', () {
      expect(new Integer(1) <= 0.5, false);
      expect(new Integer(1) <= 0, false);
      expect(new Integer(1) <= 1, true);
      expect(new Integer(1) <= 2, true);
      expect(new Integer(1) <= 1.1, true);
      expect(new Integer(42) <= new Integer(43), true);
      expect(new Integer(43) <= new Integer(43), true);
      expect(new Integer(44) <= new Integer(43), false);
      expect(new Integer(1) <= new Double(0), false);
      expect(new Integer(0) <= new Double(1), true);
      expect(new Integer(0) <= new Double(0), true);
      expect(new Integer(-9) <= new Double(2), true);
      expect(new Integer(2) <= new Double(-9), false);

      // < only looks at real parts.
      expect(new Integer(77) <= new Imaginary(5), false);
      expect(new Integer(77) <= new Imaginary(85.7), false);
      expect(new Integer(-77) <= new Imaginary(6), true);
      expect(new Integer(77) <= new Imaginary(77), false);
      expect(new Integer(77) <= new Complex(new Double(6.5), new Imaginary(99)), false);
      expect(new Integer(77) <= new Complex(new Double(77), new Imaginary(55)), true);
      expect(new Integer(77) <= new Complex(new Double(76.999999999), new Imaginary(55)), false);

      expect(new Integer(88) <= new Precise('87.999999999999999999'), false);
      expect(new Integer(88) <= new Precise('88.000000000000000000'), true);
      expect(new Integer(88) <= new Precise('88.000000000000000001'), true);
    });

    test('operator >', () {
      expect(new Integer(1) > 0.5, true);
      expect(new Integer(1) > 0, true);
      expect(new Integer(1) > 1, false);
      expect(new Integer(1) > 2, false);
      expect(new Integer(1) > 1.1, false);
      expect(new Integer(42) > new Integer(43), false);
      expect(new Integer(43) > new Integer(43), false);
      expect(new Integer(44) > new Integer(43), true);
      expect(new Integer(1) > new Double(0), true);
      expect(new Integer(0) > new Double(1), false);
      expect(new Integer(0) > new Double(0), false);
      expect(new Integer(-9) > new Double(2), false);
      expect(new Integer(2) > new Double(-9), true);

      // < only looks at real parts.
      expect(new Integer(77) > new Imaginary(5), true);
      expect(new Integer(77) > new Imaginary(85.7), true);
      expect(new Integer(-77) > new Imaginary(6), false);
      expect(new Integer(77) > new Complex(new Double(6.5), new Imaginary(99)), true);
      expect(new Integer(77) > new Complex(new Double(77.001), new Imaginary(55)), false);

      expect(new Integer(88) > new Precise('87.999999999999999999'), true);
      expect(new Integer(88) > new Precise('88.000000000000000000'), false);
      expect(new Integer(88) > new Precise('88.000000000000000001'), false);
    });

    test('operator >=', () {
      expect(new Integer(1) >= 0.5, true);
      expect(new Integer(1) >= 0, true);
      expect(new Integer(1) >= 1, true);
      expect(new Integer(1) >= 2, false);
      expect(new Integer(1) >= 1.1, false);
      expect(new Integer(42) >= new Integer(43), false);
      expect(new Integer(43) >= new Integer(43), true);
      expect(new Integer(44) >= new Integer(43), true);
      expect(new Integer(1) >= new Double(0), true);
      expect(new Integer(0) >= new Double(1), false);
      expect(new Integer(0) >= new Double(0), true);
      expect(new Integer(-9) >= new Double(2), false);
      expect(new Integer(2) >= new Double(-9), true);

      // < only looks at real parts.
      expect(new Integer(77) >= new Imaginary(5), true);
      expect(new Integer(77) >= new Imaginary(85.7), true);
      expect(new Integer(-77) >= new Imaginary(6), false);
      expect(new Integer(77) >= new Complex(new Double(6.5), new Imaginary(99)), true);
      expect(new Integer(77) >= new Complex(new Double(77.00001), new Imaginary(55)), false);
      expect(new Integer(77) >= new Complex(new Double(77), new Imaginary(55)), false);
      expect(new Integer(77) >= new Complex(new Double(77), new Imaginary(0)), true);

      expect(new Integer(88) >= new Precise('87.999999999999999999'), true);
      expect(new Integer(88) >= new Precise('88.000000000000000000'), true);
      expect(new Integer(88) >= new Precise('88.000000000000000001'), false);
    });

    test('operator ^', () {
      expect(new Integer(2) ^ 0, new Integer(1));
      expect(new Integer(2) ^ 1, new Integer(2));
      expect(new Integer(2) ^ 2, new Integer(4));
      expect(new Integer(2) ^ 3, new Integer(8));
      expect(new Integer(2) ^ 4, new Integer(16));
      expect(new Integer(2) ^ -1, new Double(0.5));
      expect(new Integer(2) ^ -2, new Double(0.25));
      expect(new Integer(2) ^ -3, new Double(0.125));
      expect(new Integer(2) ^ -4, new Double(0.0625));
    });

    test('operator %', () {
      expect(new Integer(14) % 2, new Integer(0));
      expect(new Integer(14) % -3, new Integer(2));
      expect(new Integer(14) % 4, new Integer(2));
      expect(new Integer(14) % -5, new Integer(4));
      expect(new Integer(14) % 6, new Integer(2));
      expect(new Integer(14) % -7, new Integer(0));
      expect(new Integer(14) % 8, new Integer(6));
      expect(new Integer(14) % -9, new Integer(5));
      expect(new Integer(14) % 10, new Integer(4));
      expect(new Integer(14) % -11, new Integer(3));
      expect(new Integer(14) % 12, new Integer(2));
      expect(new Integer(14) % -13, new Integer(1));
      expect(new Integer(14) % 14, new Integer(0));
      expect(new Integer(14) % 15, new Integer(14));
      expect(new Integer(14) % -16, new Integer(14));
    });

    test('operator | (Bitwise OR)', () {
      expect(new Integer(2) | 0, new Integer(2));
      expect(new Integer(2) | 1, new Integer(3));
      expect(new Integer(2) | 2, new Integer(2));
      expect(new Integer(2) | 3, new Integer(3));
      expect(new Integer(3) | 2, new Integer(3));
      expect(new Integer(4) | 3, new Integer(7));
      expect(new Integer(2) | new Integer(0), new Integer(2));
      expect(new Integer(2) | new Integer(1), new Integer(3));
      expect(new Integer(2) | new Integer(2), new Integer(2));
      expect(new Integer(2) | new Integer(3), new Integer(3));
      expect(new Integer(3) | new Integer(2), new Integer(3));
      expect(new Integer(4) | new Integer(3), new Integer(7));
    });

    test('operator & (Bitwise AND)', () {
      expect(new Integer(2) & 0, new Integer(0));
      expect(new Integer(2) & 1, new Integer(0));
      expect(new Integer(2) & 2, new Integer(2));
      expect(new Integer(2) & 3, new Integer(2));
      expect(new Integer(3) & 2, new Integer(2));
      expect(new Integer(4) & 3, new Integer(0));
      expect(new Integer(2) & new Integer(0), new Integer(0));
      expect(new Integer(2) & new Integer(1), new Integer(0));
      expect(new Integer(2) & new Integer(2), new Integer(2));
      expect(new Integer(2) & new Integer(3), new Integer(2));
      expect(new Integer(3) & new Integer(2), new Integer(2));
      expect(new Integer(4) & new Integer(3), new Integer(0));
    });

    test('bitwise XOR (not the ^ operator, which is power for Numbers)', () {
      expect(new Integer(2).bitwiseXor(0), new Integer(2));
      expect(new Integer(2).bitwiseXor(1), new Integer(3));
      expect(new Integer(2).bitwiseXor(2), new Integer(0));
      expect(new Integer(2).bitwiseXor(3), new Integer(1));
      expect(new Integer(3).bitwiseXor(2), new Integer(1));
      expect(new Integer(4).bitwiseXor(3), new Integer(7));
      expect(new Integer(2).bitwiseXor(Integer(0)), new Integer(2));
      expect(new Integer(2).bitwiseXor(Integer(1)), new Integer(3));
      expect(new Integer(2).bitwiseXor(Integer(2)), new Integer(0));
      expect(new Integer(2).bitwiseXor(Integer(3)), new Integer(1));
      expect(new Integer(3).bitwiseXor(Integer(2)), new Integer(1));
      expect(new Integer(4).bitwiseXor(Integer(3)), new Integer(7));
    });

    test('operator << (Bit shift left)', () {
      expect(new Integer(2) << 0, new Integer(2));
      expect(new Integer(2) << 1, new Integer(4));
      expect(new Integer(2) << 2, new Integer(8));
      expect(new Integer(2) << 3, new Integer(16));
      expect(new Integer(3) << 2, new Integer(12));
      expect(new Integer(4) << 3, new Integer(32));
      expect(new Integer(2) << new Integer(0), new Integer(2));
      expect(new Integer(2) << new Integer(1), new Integer(4));
      expect(new Integer(2) << new Integer(2), new Integer(8));
      expect(new Integer(2) << new Integer(3), new Integer(16));
      expect(new Integer(3) << new Integer(2), new Integer(12));
      expect(new Integer(4) << new Integer(3), new Integer(32));
    });

    test('operator >> (Bit shift right)', () {
      expect(new Integer(2) >> 0, new Integer(2));
      expect(new Integer(2) >> 1, new Integer(1));
      expect(new Integer(2) >> 2, new Integer(0));
      expect(new Integer(2) >> 3, new Integer(0));
      expect(new Integer(3) >> 1, new Integer(1));
      expect(new Integer(4) >> 1, new Integer(2));
      expect(new Integer(2) >> new Integer(0), new Integer(2));
      expect(new Integer(2) >> new Integer(1), new Integer(1));
      expect(new Integer(2) >> new Integer(2), new Integer(0));
      expect(new Integer(2) >> new Integer(3), new Integer(0));
      expect(new Integer(3) >> new Integer(1), new Integer(1));
      expect(new Integer(4) >> new Integer(1), new Integer(2));
    });

    test('operator ~ (bit-wise negate)', () {
      final Integer i1 = new Integer(123456789);
      final Integer i2 = new Integer(-234567890);
      expect(~i1, new Integer(-123456790));
      expect(~i2, new Integer(234567889));
    });

    test('clamp', () {
      expect(new Integer(0).clamp(-5, 5), Integer(0));
      expect(new Integer(0).clamp(2, 7), Integer(2));
      expect(new Integer(8).clamp(2, 7), Integer(7));
      expect(new Integer(3).clamp(2.9, 7), Integer(3));
      expect(new Integer(-10).clamp(-9.5, -8.2), Double(-9.5));
      expect(new Integer(10).clamp(-9.5, -8.2), Double(-8.2));
    });

    test('abs', () {
      expect(new Integer(0).abs(), Integer(0));
      expect(new Integer(1).abs(), Integer(1));
      expect(new Integer(-1).abs(), Integer(1));
      expect(Integer.zero.abs(), Integer(0));
      expect(Integer.one.abs(), Integer(1));
      expect(Integer.negOne.abs(), Integer(1));
    });

    test('ceil', () {
      expect(new Integer(0).ceil(), Integer(0));
      expect(new Integer(1).ceil(), Integer(1));
      expect(new Integer(-1).ceil(), Integer(-1));
      expect(Integer.zero.ceil(), Integer(0));
      expect(Integer.one.ceil(), Integer(1));
      expect(Integer.negOne.ceil(), Integer(-1));
    });

    test('floor', () {
      expect(new Integer(0).floor(), Integer(0));
      expect(new Integer(1).floor(), Integer(1));
      expect(new Integer(-1).floor(), Integer(-1));
      expect(Integer.zero.floor(), Integer(0));
      expect(Integer.one.floor(), Integer(1));
      expect(Integer.negOne.floor(), Integer(-1));
    });

    test('reciprocal', () {
      expect(new Integer(0).reciprocal(), Double.NaN);
      expect(new Integer(1).reciprocal(), Integer(1));
      expect(new Integer(-1).reciprocal(), Integer(-1));
      expect(new Integer(2).reciprocal(), Double(0.5));
      expect(new Integer(-2).reciprocal(), Double(-0.5));
    });

    test('remainder', () {
      expect(new Integer(0).remainder(5), Integer(0));
      expect(new Integer(1).remainder(5), Integer(1));
      expect(new Integer(4).remainder(1), Integer(0));
      expect(new Integer(23).remainder(4), Integer(3));
      expect(new Integer(-23).remainder(4), Integer(-3));
      expect(new Integer(23).remainder(-4), Integer(3));
      expect(new Integer(-23).remainder(-4), Integer(-3));
    });

    test('round', () {
      expect(new Integer(0).round(), Integer(0));
      expect(new Integer(1).round(), Integer(1));
      expect(new Integer(-1).round(), Integer(-1));
      expect(new Integer(2).round(), Integer(2));
      expect(new Integer(-2).round(), Integer(-2));
    });

    test('truncate', () {
      expect(new Integer(0).truncate(), Integer(0));
      expect(new Integer(1).truncate(), Integer(1));
      expect(new Integer(-1).truncate(), Integer(-1));
      expect(new Integer(2).truncate(), Integer(2));
      expect(new Integer(-2).truncate(), Integer(-2));
    });

    test('toDouble', () {
      expect(new Integer(0).toDouble(), 0.0);
      expect(new Integer(1).toDouble(), 1.0);
      expect(new Integer(-1).toDouble(), -1.0);
      expect(new Integer(2).toDouble(), 2.0);
      expect(new Integer(-2).toDouble(), -2.0);
    });

    test('toInt', () {
      expect(new Integer(0).toInt(), 0);
      expect(new Integer(1).toInt(), 1);
      expect(new Integer(-1).toInt(), -1);
      expect(new Integer(2).toInt(), 2);
      expect(new Integer(-2).toInt(), -2);
    });

    test('toString', () {
      expect(new Integer(0).toString(), '0');
      expect(new Integer(1).toString(), '1');
      expect(new Integer(-1).toString(), '-1');
      expect(new Integer(2).toString(), '2');
      expect(new Integer(-2).toString(), '-2');
    });

    test('isInfinite', () {
      expect(new Integer(0).isInfinite, false);
      expect(new Integer(double.maxFinite.toInt()).isInfinite, false);
    });

    test('isNaN', () {
      expect(new Integer(0).isNaN, false);
      expect(new Integer(double.maxFinite.toInt()).isNaN, false);
      expect(new Integer(double.minPositive.toInt()).isNaN, false);
    });

    test('isNegative', () {
      expect(new Integer(0).isNegative, false);
      expect(new Integer(1).isNegative, false);
      expect(new Integer(-1).isNegative, true);
    });
  });

  group('Binary', () {
    test('constructor', () {
      expect(new Binary('0'), new Integer(0));
      expect(new Binary('1'), new Integer(1));
      expect(new Binary('10'), new Integer(2));
      expect(new Binary('11'), new Integer(3));
      expect(new Binary('100'), new Integer(4));
      expect(new Binary('101'), new Integer(5));
      expect(new Binary('110'), new Integer(6));
      expect(new Binary('111'), new Integer(7));
      expect(new Binary('0000111'), new Integer(7));
      expect(new Binary('-111'), new Integer(-7));
      expect(new Binary('1000'), new Integer(8));

      dynamic exc;
      try {
        new Binary('2');
      } catch (e) {
        exc = e;
      }
      expect(exc is FormatException, true);
    });

    test('toString', () {
      expect(new Binary('0').toString(), '0');
      expect(new Binary('100').toString(), '100');
      expect(new Binary('0010').toString(), '10');
      expect(new Binary('-00101').toString(), '-101');
      expect(new Binary('111111110').toString(), '111111110');
    });
  });

  group('Octal', () {
    test('constructor', () {
      expect(new Octal('0'), new Integer(0));
      expect(new Octal('1'), new Integer(1));
      expect(new Octal('2'), new Integer(2));
      expect(new Octal('3'), new Integer(3));
      expect(new Octal('4'), new Integer(4));
      expect(new Octal('5'), new Integer(5));
      expect(new Octal('6'), new Integer(6));
      expect(new Octal('7'), new Integer(7));
      expect(new Octal('10'), new Integer(8));
      expect(new Octal('11'), new Integer(9));
      expect(new Octal('100'), new Integer(64));
      expect(new Octal('101'), new Integer(65));
      expect(new Octal('110'), new Integer(72));
      expect(new Octal('111'), new Integer(73));
      expect(new Octal('0000111'), new Integer(73));
      expect(new Octal('-111'), new Integer(-73));
      expect(new Octal('1000'), new Integer(512));

      dynamic exc;
      try {
        new Octal('8');
      } catch (e) {
        exc = e;
      }
      expect(exc is FormatException, true);
    });

    test('toString', () {
      expect(new Octal('0').toString(), '0');
      expect(new Octal('700').toString(), '700');
      expect(new Octal('0070').toString(), '70');
      expect(new Octal('-00701').toString(), '-701');
      expect(new Octal('111711110').toString(), '111711110');
    });
  });

  group('Hexadecimal', () {
    test('constructor', () {
      expect(new Hexadecimal('0'), new Integer(0));
      expect(new Hexadecimal('1'), new Integer(1));
      expect(new Hexadecimal('2'), new Integer(2));
      expect(new Hexadecimal('3'), new Integer(3));
      expect(new Hexadecimal('4'), new Integer(4));
      expect(new Hexadecimal('5'), new Integer(5));
      expect(new Hexadecimal('6'), new Integer(6));
      expect(new Hexadecimal('7'), new Integer(7));
      expect(new Hexadecimal('8'), new Integer(8));
      expect(new Hexadecimal('9'), new Integer(9));
      expect(new Hexadecimal('a'), new Integer(10));
      expect(new Hexadecimal('b'), new Integer(11));
      expect(new Hexadecimal('c'), new Integer(12));
      expect(new Hexadecimal('d'), new Integer(13));
      expect(new Hexadecimal('e'), new Integer(14));
      expect(new Hexadecimal('f'), new Integer(15));
      expect(new Hexadecimal('A'), new Integer(10));
      expect(new Hexadecimal('B'), new Integer(11));
      expect(new Hexadecimal('C'), new Integer(12));
      expect(new Hexadecimal('D'), new Integer(13));
      expect(new Hexadecimal('E'), new Integer(14));
      expect(new Hexadecimal('F'), new Integer(15));
      expect(new Hexadecimal('10'), new Integer(16));
      expect(new Hexadecimal('11'), new Integer(17));
      expect(new Hexadecimal('100'), new Integer(256));
      expect(new Hexadecimal('101'), new Integer(257));
      expect(new Hexadecimal('110'), new Integer(272));
      expect(new Hexadecimal('111'), new Integer(273));
      expect(new Hexadecimal('0000111'), new Integer(273));
      expect(new Hexadecimal('-111'), new Integer(-273));
      expect(new Hexadecimal('1000'), new Integer(4096));

      dynamic exc;
      try {
        new Hexadecimal('g');
      } catch (e) {
        exc = e;
      }
      expect(exc is FormatException, true);
    });

    test('toString', () {
      expect(new Hexadecimal('0').toString(), '0');
      expect(new Hexadecimal('F').toString(), 'f');
      expect(new Hexadecimal('7a0').toString(), '7a0');
      expect(new Hexadecimal('0a70').toString(), 'a70');
      expect(new Hexadecimal('-0b7e1').toString(), '-b7e1');
      expect(new Hexadecimal('1117abc0').toString(), '1117abc0');
    });
  });
}
