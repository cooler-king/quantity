import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Number', () {
    test('simplifyType', () {
      expect(Number.simplifyType(Integer(0)) is Integer, true);
      expect(Number.simplifyType(Integer(-2)) is Integer, true);
      expect(Number.simplifyType(Integer(67)) is Integer, true);

      expect(Number.simplifyType(Double(0)) is Integer, true);
      expect(Number.simplifyType(Double(-2)) is Integer, true);
      expect(Number.simplifyType(Double(67.7)) is Double, true);

      expect(Number.simplifyType(Imaginary(Integer(0))) is Integer, true);
      expect(Number.simplifyType(Imaginary(Double(0))) is Integer, true);
      expect(Number.simplifyType(Imaginary(Integer(-2))) is Imaginary, true);
      expect(Number.simplifyType(Imaginary(Double(67.7))) is Imaginary, true);
      expect(
          (Number.simplifyType(Imaginary(Double(67.7))) as Imaginary).value
              is Double,
          true);
      expect(Number.simplifyType(Imaginary(Double(67))) is Imaginary, true);
      expect(
          (Number.simplifyType(Imaginary(Double(67))) as Imaginary).value
              is Integer,
          true);

      expect(Number.simplifyType(Complex.coeff(0, 0)) is Integer, true);
      expect(Number.simplifyType(Complex.coeff(5.5, 0)) is Double, true);
      expect(Number.simplifyType(Complex.coeff(0, -9)) is Imaginary, true);
      expect(
          (Number.simplifyType(Complex.coeff(0, -9)) as Imaginary).value
              is Integer,
          true);

      expect(
          Number.simplifyType(Complex(Precise('0'), Imaginary(Precise('0'))))
              is Precise,
          true);
    });

    test('Fraction', () {
      final f = Fraction(3, 4);
      expect(f.numerator, 3);
      expect(f.denominator, 4);
      expect(f.toDouble(), 0.75);

      final mixed = Fraction.mixed(2, 1, 2);
      expect(mixed.numerator, 5);
      expect(mixed.denominator, 2);
      expect(mixed.toDouble(), 2.5);
    });

    test('isFinite and sign', () {
      final c1 = Complex(Double(1.2), Imaginary(3.4));
      expect(c1.isFinite, true);

      expect(Integer(5).sign, 1);
      expect(Double(-5.5).sign, -1.0);
      expect(Double(0.0).sign, 0.0);
      expect(Double(double.nan).sign.isNaN, true);
    });

    test('compareTo fallback', () {
      final i1 = Imaginary(5);
      final i2 = Imaginary(10);
      expect(i1.compareTo(i2), 0);
      expect(i1.compareTo(5.0), -1);
      expect(i1.compareTo('string'), 0);
    });

    test('Real arithmetic and comparisons', () {
      expect(Integer(-5).abs(), Integer(5));
      expect(Double(-5.5).abs(), Double(5.5));

      expect(Double(-5.0) / 0, Double.negInfinity);
      expect(Double(-5.0) / 'string', Double.negInfinity);

      expect(Double(5) > Complex.coeff(3, 4), true);
      expect(Double(2) > Complex.coeff(3, 4), false);

      expect(Double(5) > 'string', true);
      expect(Double(-5) > 'string', false);

      expect(Double(5.5).remainder(Double(2.0)), Double(1.5));
      expect(Integer(5).remainder(Integer(2)), Integer(1));
      expect(() => Integer(5).remainder('string'), throwsA(anything));
    });
  });
}
