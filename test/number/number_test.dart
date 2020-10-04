import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Number', () {
    test('simplifyType', () {
      expect(Number.simplifyType(new Integer(0)) is Integer, true);
      expect(Number.simplifyType(new Integer(-2)) is Integer, true);
      expect(Number.simplifyType(new Integer(67)) is Integer, true);

      expect(Number.simplifyType(new Double(0)) is Integer, true);
      expect(Number.simplifyType(new Double(-2)) is Integer, true);
      expect(Number.simplifyType(new Double(67.7)) is Double, true);

      expect(Number.simplifyType(new Imaginary(new Integer(0))) is Integer, true);
      expect(Number.simplifyType(new Imaginary(new Double(0))) is Integer, true);
      expect(Number.simplifyType(new Imaginary(new Integer(-2))) is Imaginary, true);
      expect(Number.simplifyType(new Imaginary(new Double(67.7))) is Imaginary, true);
      expect((Number.simplifyType(new Imaginary(new Double(67.7))) as Imaginary).value is Double, true);
      expect(Number.simplifyType(new Imaginary(new Double(67))) is Imaginary, true);
      expect((Number.simplifyType(new Imaginary(new Double(67))) as Imaginary).value is Integer, true);

      expect(Number.simplifyType(new Complex.coeff(0, 0)) is Integer, true);
      expect(Number.simplifyType(new Complex.coeff(5.5, 0)) is Double, true);
      expect(Number.simplifyType(new Complex.coeff(0, -9)) is Imaginary, true);
      expect((Number.simplifyType(new Complex.coeff(0, -9)) as Imaginary).value is Integer, true);

      expect(Number.simplifyType(new Complex(new Precise('0'), new Imaginary(new Precise('0')))) is Precise, true);
    });
  });
}
