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
  });
}
