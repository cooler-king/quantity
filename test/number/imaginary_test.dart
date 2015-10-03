import 'package:test/test.dart';
import 'package:quantity/number.dart';

main() {
  group('Imaginary', () {
    test('zeros', () {
      Imaginary imag0a = new Imaginary(0);
      Imaginary imag0b = new Imaginary(0.0);
      Imaginary imag0c = new Imaginary(new Integer(0));
      Imaginary imag0d = new Imaginary(new Double(0.0));
      Complex complex0 = new Complex(new Double(0.0), new Imaginary(0));

      expect(imag0a.value == 0, true);

      expect(imag0a == imag0b, true);
      expect(imag0b == imag0c, true);
      expect(imag0c == imag0d, true);
      expect(imag0a == complex0, true);
    });

    test('operator + -- imaginary only', () {
      Imaginary imag0 = new Imaginary(0);
      Imaginary imag1 = new Imaginary(6);
      Imaginary imag2 = new Imaginary(9);
      Imaginary imag3 = new Imaginary(15);
      Imaginary imag4 = new Imaginary(24.0);
      Imaginary imag5 = new Imaginary(new Integer(39));
      Imaginary imag6 = new Imaginary(new Double(63.0));

      expect(imag0 + imag1 == imag1, true);
      expect(imag1 + imag0 == imag1, true);
      expect(imag1 + imag2 == imag3, true);
      expect(imag2 + imag3 == imag4, true);
      expect(imag3 + imag4 == imag5, true);
      expect(imag4 + imag5 == imag6, true);
    });
  });
}
