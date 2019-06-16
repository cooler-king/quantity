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

    test('operator + -- imaginary only', () {
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
  });
}
