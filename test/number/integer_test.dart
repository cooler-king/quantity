import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

main() {
  group('Integer', () {
    test('constants', () {
      Integer d = const Integer.constant(42);
      expect(d.value, 42);
      expect(Integer.zero.value, 0);
      expect(Integer.one.value, 1);
      expect(Integer.ten.value, 10);
      expect(Integer.hundred.value, 100);
      expect(Integer.thousand.value, 1000);
    });

    test('equality', () {
      Integer d = new Integer(42);
      Integer d2 = new Integer(14);
      Integer d3 = new Integer(42);
      Integer d4 = new Integer(44);
      Integer d5 = new Integer(44.234.toInt());
      expect(d == d, true);
      expect(d == d2, false);
      expect(d == d3, true);
      expect(d == 42, true);
      expect(d == 42.000, true);
      expect(d == 42.0000001, false);
      expect(d4 == d5, true);

      // equality with nums
      expect(d4 == 44, true);
      expect(d5 == 44, true);
      expect(d4 == 44.0, true);
      expect(d5 == 44.0, true);

      // equality with complex
      Complex c1 = new Complex(new Integer(42), new Imaginary(0.0));
    });

    test('addition', () {
      Integer d = new Integer(42);

      // + int
      expect((d + 77) is Integer, true);
      expect(((d + 77) as Integer).value == 119, true);
      expect((d + -53) is Integer, true);
      expect(((d + -53) as Integer).value == -11, true);

      // + double
      expect((d + 6.5) is Double, true);
      expect(((d + 6.5) as Double).value == 48.5, true);
      expect((d + -12.3) is Double, true);
      expect(((d + -12.3) as Double).value == 29.7, true);

      // + Integer
      Integer d2 = new Integer(14);
      expect((d + d2) is Integer, true);
      expect(((d + d2) as Integer).value == 56, true);
      Integer d3 = new Integer(-901);
      expect((d + d3) is Integer, true);
      expect(((d + d3) as Integer).value == -859, true);

      // + Imaginary
      Imaginary i = new Imaginary(34.21);
      expect((d + i) is Complex, true);
      expect(((d + i) as Complex).real.value == 42, true);
      expect(((d + i) as Complex).imag.value == 34.21, true);
      Imaginary i2 = new Imaginary(-8);
      expect((d + i2) is Complex, true);
      expect(((d + i2) as Complex).real.value == 42, true);
      expect(((d + i2) as Complex).imag.value == -8, true);
    });
  });
}
