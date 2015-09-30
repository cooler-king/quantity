import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

main() {
  group('Double', () {
    test('constants', () {
      Double d = const Double.constant(42.0);
      expect(d.value, 42.0);
      expect(Double.zero.value, 0.0);
      expect(Double.one.value, 1.0);
      expect(Double.ten.value, 10.0);
      expect(Double.hundred.value, 100.0);
      expect(Double.thousand.value, 1000.0);
      expect(Double.infinity.value, double.INFINITY);
      expect(Double.negInfinity.value, double.NEGATIVE_INFINITY);
      expect(identical(Double.NaN.value, double.NAN), true);
    });

    test('isNaN', () {
      Double d = const Double.constant(42.0);
      Double d2 = Double.NaN;
      Double d3 = Double.infinity;
      Double d4 = new Double(double.NAN);

      expect(d.isNaN, false);
      expect(d2.isNaN, true);
      expect(d3.isNaN, false);
      expect(d4.isNaN, true);
    });

    test('equality', () {
      Double d = new Double(42.056);
      Double d2 = new Double(14.321);
      Double d3 = new Double(42.056);
      Double d4 = new Double(42.0);
      Double d5 = new Double(42.toDouble());
      expect(d == d, true);
      expect(d == d2, false);
      expect(d == d3, true);
      expect(d == 42.056, true);
      expect(d == 42.0560001, false);
      expect(d4 == d5, true);

      // equality with nums
      expect(d4 == 42, true);
      expect(d5 == 42, true);
      expect(d4 == 42.0, true);
      expect(d5 == 42.0, true);

      // equality with complex
      Complex c1 = new Complex(new Double(42.0), new Imaginary(0.0));
      expect(d4 == c1, true);
    });

    test('addition', () {
      Double d = new Double(42.056);
      Double d2 = new Double(14.321);
      expect((d + d2) is Double, true);
      expect(((d + d2) as Double).value, closeTo(56.377, 0.000001));
      expect((d + 77.7777) is Double, true);
      expect(((d + 77.7777) as Double).value, closeTo(119.8337, 0.000001));
      Imaginary i = new Imaginary(34.21);
      expect((d + i) is Complex, true);
      expect(((d + i) as Complex).real.toDouble(), closeTo(42.056, 0.000001));
      expect(((d + i) as Complex).imag.value.toDouble(), closeTo(34.21, 0.000001));
    });
  });
}
