import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('EngineeringFormatSI', () {
    group('format', () {
      test('real only; num; regular spaces', () {
        final EngineeringFormatSI f1 = new EngineeringFormatSI(unicode: false);
        expect(f1.format(1), '1.0');
        expect(f1.format(12), '12.0');
        expect(f1.format(123), '123.0');
        expect(f1.format(1234), '1.234 x 10^3');
        expect(f1.format(12345), '12.345 x 10^3');
        expect(f1.format(123456), '123.456 x 10^3');
        expect(f1.format(1234567), '1.234 567 x 10^6');
        expect(f1.format(12345678), '12.345 678 x 10^6');
        expect(f1.format(123456789), '123.456 789 x 10^6');
        expect(f1.format(1234567890), '1.234 567 89 x 10^9');

        expect(f1.format(-1), '-1.0');
        expect(f1.format(-12), '-12.0');
        expect(f1.format(-123), '-123.0');
        expect(f1.format(-1234), '-1.234 x 10^3');
        expect(f1.format(-12345), '-12.345 x 10^3');
        expect(f1.format(-123456), '-123.456 x 10^3');
        expect(f1.format(-1234567), '-1.234 567 x 10^6');
        expect(f1.format(-12345678), '-12.345 678 x 10^6');
        expect(f1.format(-123456789), '-123.456 789 x 10^6');
        expect(f1.format(-1234567890), '-1.234 567 890 x 10^9');

        expect(f1.format(0.0), '0.0');
        expect(f1.format(1.001), '1.001');
        expect(f1.format(1.0012), '1.0012');
        expect(f1.format(1.00123), '1.001 23');
        expect(f1.format(10.01), '10.01');
        expect(f1.format(100.01), '100.01');
        expect(f1.format(100.001), '100.001');
        expect(f1.format(100.0012), '100.0012');
        expect(f1.format(100.00123), '100.001 23');
        expect(f1.format(1000.0001), '1.000 000 1 x 10^3');
        expect(f1.format(10000.00001), '10.000 000 01 x 10^3');
        expect(f1.format(9876543210.1234), '9.876 543 210 123 4 x 10^9');
        expect(f1.format(987654321.01234), '987.654 321 012 34 x 10^6');
        expect(f1.format(1234.9876543219), '1.234 987 654 321 9 x 10^3');

        expect(f1.format(-0.0), '0.0');
        expect(f1.format(-1.001), '-1.001');
        expect(f1.format(-1.0012), '-1.0012');
        expect(f1.format(-1.00123), '-1.001 23');
        expect(f1.format(-10.01), '-10.01');
        expect(f1.format(-100.01), '-100.01');
        expect(f1.format(-100.001), '-100.001');
        expect(f1.format(-100.0012), '-100.0012');
        expect(f1.format(-100.00123), '-100.001 23');
        expect(f1.format(-1000.0001), '-1.000 000 1 x 10^3');
        expect(f1.format(-10000.00001), '-10.000 000 01 x 10^3');
        expect(f1.format(-9876543210.1234), '-9.876 543 210 123 4 x 10^9');
        expect(f1.format(-987654321.01234), '-987.654 321 012 34 x 10^6');
        expect(f1.format(-1234.9876543219), '-1.234 987 654 321 9 x 10^3');

        expect(f1.format(0.1), '100.0 x 10^-3');
        expect(f1.format(0.01), '10.0 x 10^-3');
        expect(f1.format(0.001), '1.0 x 10^-3');
        expect(f1.format(0.0001), '100.0 x 10^-6');
        expect(f1.format(0.00001), '10.0 x 10^-6');
        expect(f1.format(0.000001), '1.0 x 10^-6');
        expect(f1.format(0.01002), '10.02 x 10^-3');
        expect(f1.format(0.010002), '10.002 x 10^-3');
        expect(f1.format(0.0100002), '10.0002 x 10^-3');
        expect(f1.format(0.01000023), '10.000 23 x 10^-3');
        expect(f1.format(0.00010020034), '100.200 34 x 10^-6');

        expect(f1.format(-0.1), '-100.0 x 10^-3');
        expect(f1.format(-0.01), '-10.0 x 10^-3');
        expect(f1.format(-0.001), '-1.0 x 10^-3');
        expect(f1.format(-0.0001), '-100.0 x 10^-6');
        expect(f1.format(-0.00001), '-10.0 x 10^-6');
        expect(f1.format(-0.000001), '-1.0 x 10^-6');
        expect(f1.format(-0.01002), '-10.02 x 10^-3');
        expect(f1.format(-0.010002), '-10.002 x 10^-3');
        expect(f1.format(-0.0100002), '-10.0002 x 10^-3');
        expect(f1.format(-0.01000023), '-10.000 23 x 10^-3');
        expect(f1.format(-0.00010020034), '-100.200 34 x 10^-6');
      });

      group('format', () {
        test('real only; num; unicode', () {
          final EngineeringFormatSI f1 = new EngineeringFormatSI(unicode: true);
          expect(f1.format(1), '1.0');
          expect(f1.format(12), '12.0');
          expect(f1.format(123), '123.0');
          expect(f1.format(1234), '1.234 \u{00d7} 10\u{00b3}');
          expect(f1.format(12345), '12.345 \u{00d7} 10\u{00b3}');
          expect(f1.format(123456), '123.456 \u{00d7} 10\u{00b3}');
          expect(f1.format(1234567), '1.234\u{2009}567 \u{00d7} 10\u{2076}');
          expect(f1.format(12345678), '12.345\u{2009}678 \u{00d7} 10\u{2076}');
          expect(f1.format(123456789), '123.456\u{2009}789 \u{00d7} 10\u{2076}');
          expect(f1.format(1234567890), '1.234\u{2009}567\u{2009}89 \u{00d7} 10\u{2079}');

          expect(f1.format(-1), '-1.0');
          expect(f1.format(-12), '-12.0');
          expect(f1.format(-123), '-123.0');
          expect(f1.format(-1234), '-1.234 \u{00d7} 10\u{00b3}');
          expect(f1.format(-12345), '-12.345 \u{00d7} 10\u{00b3}');
          expect(f1.format(-123456), '-123.456 \u{00d7} 10\u{00b3}');
          expect(f1.format(-1234567), '-1.234\u{2009}567 \u{00d7} 10\u{2076}');
          expect(f1.format(-12345678), '-12.345\u{2009}678 \u{00d7} 10\u{2076}');
          expect(f1.format(-123456789), '-123.456\u{2009}789 \u{00d7} 10\u{2076}');
          expect(f1.format(-1234567890), '-1.234\u{2009}567\u{2009}890 \u{00d7} 10\u{2079}');

          expect(f1.format(0.0), '0.0');
          expect(f1.format(1.001), '1.001');
          expect(f1.format(1.0012), '1.0012');
          expect(f1.format(1.00123), '1.001\u{2009}23');
          expect(f1.format(10.01), '10.01');
          expect(f1.format(100.01), '100.01');
          expect(f1.format(100.001), '100.001');
          expect(f1.format(1000.0001), '1.000\u{2009}000\u{2009}1 \u{00d7} 10\u{00b3}');
          expect(f1.format(10000.00001), '10.000\u{2009}000\u{2009}01 \u{00d7} 10\u{00b3}');
          expect(f1.format(9876543210.1234), '9.876\u{2009}543\u{2009}210\u{2009}123\u{2009}4 \u{00d7} 10\u{2079}');
          expect(f1.format(1234.9876543219), '1.234\u{2009}987\u{2009}654\u{2009}321\u{2009}9 \u{00d7} 10\u{00b3}');

          expect(f1.format(-0.0), '0.0');
          expect(f1.format(-1.001), '-1.001');
          expect(f1.format(-1.0012), '-1.0012');
          expect(f1.format(-1.00123), '-1.001\u{2009}23');
          expect(f1.format(-10.01), '-10.01');
          expect(f1.format(-100.01), '-100.01');
          expect(f1.format(-100.001), '-100.001');
          expect(f1.format(-1000.0001), '-1.000\u{2009}000\u{2009}1 \u{00d7} 10\u{00b3}');
          expect(f1.format(-10000.00001), '-10.000\u{2009}000\u{2009}01 \u{00d7} 10\u{00b3}');
          expect(f1.format(-9876543210.1234), '-9.876\u{2009}543\u{2009}210\u{2009}123\u{2009}4 \u{00d7} 10\u{2079}');
          expect(f1.format(-1234.9876543219), '-1.234\u{2009}987\u{2009}654\u{2009}321\u{2009}9 \u{00d7} 10\u{00b3}');

          expect(f1.format(0.1), '100.0 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.01), '10.0 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.001), '1.0 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.0001), '100.0 \u{00d7} 10\u{207b}\u{2076}');
          expect(f1.format(0.00001), '10.0 \u{00d7} 10\u{207b}\u{2076}');
          expect(f1.format(0.000001), '1.0 \u{00d7} 10\u{207b}\u{2076}');
          expect(f1.format(0.01002), '10.02 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.010002), '10.002 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.0100002), '10.0002 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.01000002), '10.000\u{2009}02 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(0.00010020034), '100.200\u{2009}34 \u{00d7} 10\u{207b}\u{2076}');

          expect(f1.format(-0.1), '-100.0 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.01), '-10.0 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.001), '-1.0 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.0001), '-100.0 \u{00d7} 10\u{207b}\u{2076}');
          expect(f1.format(-0.00001), '-10.0 \u{00d7} 10\u{207b}\u{2076}');
          expect(f1.format(-0.000001), '-1.0 \u{00d7} 10\u{207b}\u{2076}');
          expect(f1.format(-0.01002), '-10.02 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.010002), '-10.002 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.0100002), '-10.0002 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.01000002), '-10.000\u{2009}02 \u{00d7} 10\u{207b}\u{00b3}');
          expect(f1.format(-0.00010020034), '-100.200\u{2009}34 \u{00d7} 10\u{207b}\u{2076}');
        });
      });

      test('real only; Number; regular spaces', () {
        final EngineeringFormatSI f1 = new EngineeringFormatSI(unicode: false);
        expect(f1.format(new Integer(1)), '1.0');
        expect(f1.format(new Integer(12)), '12.0');
        expect(f1.format(new Integer(123)), '123.0');
        expect(f1.format(new Integer(1234)), '1.234 x 10^3');
        expect(f1.format(new Integer(12345)), '12.345 x 10^3');
        expect(f1.format(new Integer(123456)), '123.456 x 10^3');
        expect(f1.format(new Integer(1234567)), '1.234 567 x 10^6');
        expect(f1.format(new Integer(12345678)), '12.345 678 x 10^6');
        expect(f1.format(new Integer(123456789)), '123.456 789 x 10^6');
        expect(f1.format(new Integer(1234567890)), '1.234 567 89 x 10^9');
        expect(f1.format(new Integer(12345678901)), '12.345 678 901 x 10^9');

        expect(f1.format(new Integer(-1)), '-1.0');
        expect(f1.format(new Integer(-12)), '-12.0');
        expect(f1.format(new Integer(-123)), '-123.0');
        expect(f1.format(new Integer(-1234)), '-1.234 x 10^3');
        expect(f1.format(new Integer(-12345)), '-12.345 x 10^3');
        expect(f1.format(new Integer(-123456)), '-123.456 x 10^3');
        expect(f1.format(new Integer(-1234567)), '-1.234 567 x 10^6');
        expect(f1.format(new Integer(-12345678)), '-12.345 678 x 10^6');
        expect(f1.format(new Integer(-123456789)), '-123.456 789 x 10^6');
        expect(f1.format(new Integer(-1234567890)), '-1.234 567 890 x 10^9');
        expect(f1.format(new Integer(-12345678901)), '-12.345 678 901 x 10^9');

        expect(f1.format(new Double(0)), '0.0');
        expect(f1.format(new Double(10.01)), '10.01');
        expect(f1.format(new Double(100.001)), '100.001');
        expect(f1.format(new Double(1000.0001)), '1.000 000 1 x 10^3');
        expect(f1.format(new Double(10000.00001)), '10.000 000 01 x 10^3');
        expect(f1.format(new Double(9876543210.1234)), '9.876 543 210 123 4 x 10^9');
        expect(f1.format(new Double(1234.9876543219)), '1.234 987 654 321 9 x 10^3');

        expect(f1.format(new Double(-0)), '0.0');
        expect(f1.format(new Double(-10.01)), '-10.01');
        expect(f1.format(new Double(-100.001)), '-100.001');
        expect(f1.format(new Double(-1000.0001)), '-1.000 000 1 x 10^3');
        expect(f1.format(new Double(-10000.00001)), '-10.000 000 01 x 10^3');
        expect(f1.format(new Double(-9876543210.1234)), '-9.876 543 210 123 4 x 10^9');
        expect(f1.format(new Double(-1234.9876543219)), '-1.234 987 654 321 9 x 10^3');
      });

      test('imaginary only; regular spaces', () {
        final EngineeringFormatSI f1 = new EngineeringFormatSI(unicode: false);
        expect(f1.format(new Imaginary(1)), '1.0i');
        expect(f1.format(new Imaginary(12)), '12.0i');
        expect(f1.format(new Imaginary(123)), '123.0i');
        expect(f1.format(new Imaginary(1234)), '1.234i x 10^3');
        expect(f1.format(new Imaginary(12345)), '12.345i x 10^3');
        expect(f1.format(new Imaginary(123456)), '123.456i x 10^3');
        expect(f1.format(new Imaginary(1234567)), '1.234 567i x 10^6');
        expect(f1.format(new Imaginary(12345678)), '12.345 678i x 10^6');
        expect(f1.format(new Imaginary(123456789)), '123.456 789i x 10^6');
        expect(f1.format(new Imaginary(1234567890)), '1.234 567 89i x 10^9');

        expect(f1.format(new Imaginary(-1)), '-1.0i');
        expect(f1.format(new Imaginary(-12)), '-12.0i');
        expect(f1.format(new Imaginary(-123)), '-123.0i');
        expect(f1.format(new Imaginary(-1234)), '-1.234i x 10^3');
        expect(f1.format(new Imaginary(-12345)), '-12.345i x 10^3');
        expect(f1.format(new Imaginary(-123456)), '-123.456i x 10^3');
        expect(f1.format(new Imaginary(-1234567)), '-1.234 567i x 10^6');
        expect(f1.format(new Imaginary(-12345678)), '-12.345 678i x 10^6');
        expect(f1.format(new Imaginary(-123456789)), '-123.456 789i x 10^6');
        expect(f1.format(new Imaginary(-1234567890)), '-1.234 567 890i x 10^9');

        expect(f1.format(new Imaginary(0.0)), '0.0i');
        expect(f1.format(new Imaginary(10.01)), '10.01i');
        expect(f1.format(new Imaginary(100.001)), '100.001i');
        expect(f1.format(new Imaginary(1000.0001)), '1.000 000 1i x 10^3');
        expect(f1.format(new Imaginary(10000.00001)), '10.000 000 01i x 10^3');
        expect(f1.format(new Imaginary(9876543210.1234)), '9.876 543 210 123 4i x 10^9');
        expect(f1.format(new Imaginary(1234.9876543219)), '1.234 987 654 321 9i x 10^3');

        expect(f1.format(new Imaginary(-0.0)), '0.0i');
        expect(f1.format(new Imaginary(-10.01)), '-10.01i');
        expect(f1.format(new Imaginary(-100.001)), '-100.001i');
        expect(f1.format(new Imaginary(-1000.0001)), '-1.000 000 1i x 10^3');
        expect(f1.format(new Imaginary(-10000.00001)), '-10.000 000 01i x 10^3');
        expect(f1.format(new Imaginary(-9876543210.1234)), '-9.876 543 210 123 4i x 10^9');
        expect(f1.format(new Imaginary(-1234.9876543219)), '-1.234 987 654 321 9i x 10^3');
      });

      test('complex; regular spaces', () {
        final EngineeringFormatSI f1 = new EngineeringFormatSI(unicode: false);
        expect(f1.format(new Complex.coeff(1, 2)), '1.0 + 2.0i');
        expect(f1.format(new Complex.coeff(1, 0)), '1.0');
        expect(f1.format(new Complex.coeff(0, 2)), '2.0i');
        expect(f1.format(new Complex.coeff(12, 21)), '12.0 + 21.0i');
        expect(f1.format(new Complex.coeff(123, 321)), '123.0 + 321.0i');
        expect(f1.format(new Complex.coeff(1234, 4321)), '1.234 x 10^3 + 4.321i x 10^3');
        expect(f1.format(new Complex.coeff(12345, 54321)), '12.345 x 10^3 + 54.321i x 10^3');
        expect(f1.format(new Complex.coeff(123456, 654321)), '123.456 x 10^3 + 654.321i x 10^3');
        expect(f1.format(new Complex.coeff(1234567, 7654321)), '1.234 567 x 10^6 + 7.654 321i x 10^6');
        expect(f1.format(new Complex.coeff(12345678, 87654321)), '12.345 678 x 10^6 + 87.654 321i x 10^6');
        expect(f1.format(new Complex.coeff(123456789, 987654321)), '123.456 789 x 10^6 + 987.654 321i x 10^6');
        expect(f1.format(new Complex.coeff(1234567898, 8987654321)), '1.234 567 898 x 10^9 + 8.987 654 321i x 10^9');

        expect(f1.format(new Complex.coeff(-1, -2)), '-1.0 - 2.0i');
        expect(f1.format(new Complex.coeff(-1, -0)), '-1.0');
        expect(f1.format(new Complex.coeff(-0, -2)), '-2.0i');
        expect(f1.format(new Complex.coeff(-12, -21)), '-12.0 - 21.0i');
        expect(f1.format(new Complex.coeff(-123, -321)), '-123.0 - 321.0i');
        expect(f1.format(new Complex.coeff(-1234, -4321)), '-1.234 x 10^3 - 4.321i x 10^3');
        expect(f1.format(new Complex.coeff(-12345, -54321)), '-12.345 x 10^3 - 54.321i x 10^3');
        expect(f1.format(new Complex.coeff(-123456, -654321)), '-123.456 x 10^3 - 654.321i x 10^3');
        expect(f1.format(new Complex.coeff(-1234567, -7654321)), '-1.234 567 x 10^6 - 7.654 321i x 10^6');
        expect(f1.format(new Complex.coeff(-12345678, -87654321)), '-12.345 678 x 10^6 - 87.654 321i x 10^6');
        expect(f1.format(new Complex.coeff(-123456789, -987654321)), '-123.456 789 x 10^6 - 987.654 321i x 10^6');
        expect(f1.format(new Complex.coeff(-1234567898, -8987654321)), '-1.234 567 898 x 10^9 - 8.987 654 321i x 10^9');

        expect(f1.format(new Complex.coeff(0, 0)), '0.0');
        expect(f1.format(new Complex.coeff(10.01, 11.22)), '10.01 + 11.22i');
        expect(f1.format(new Complex.coeff(100.001, 111.222)), '100.001 + 111.222i');
        expect(f1.format(new Complex.coeff(1000.0001, 1111.2222)), '1.000 000 1 x 10^3 + 1.111 222 2i x 10^3');
        expect(f1.format(new Complex.coeff(10000.00001, 11111.22222)), '10.000 000 01 x 10^3 + 11.111 222 22i x 10^3');
        expect(f1.format(new Complex.coeff(9876543210.1234, 4321.0123456789)),
            '9.876 543 210 123 4 x 10^9 + 4.321 012 345 678 9i x 10^3');

        expect(f1.format(new Complex.coeff(-0, -0)), '0.0');
        expect(f1.format(new Complex.coeff(-10.01, -11.22)), '-10.01 - 11.22i');
        expect(f1.format(new Complex.coeff(-100.001, -111.222)), '-100.001 - 111.222i');
        expect(f1.format(new Complex.coeff(-1000.0001, -1111.2222)), '-1.000 000 1 x 10^3 - 1.111 222 2i x 10^3');
        expect(f1.format(new Complex.coeff(-10000.00001, -11111.22222)), '-10.000 000 01 x 10^3 - 11.111 222 22i x 10^3');
        expect(f1.format(new Complex.coeff(-9876543210.1234, -4321.0123456789)),
            '-9.876 543 210 123 4 x 10^9 - 4.321 012 345 678 9i x 10^3');
      });
    });

    group('parse', () {
      test('real with regular spaces', () {
        final EngineeringFormatSI f1 = new EngineeringFormatSI(unicode: false);
        expect(f1.parse('12 345'), 12345);
        expect(f1.parse('12 345.678 90'), 12345.67890);
        expect(f1.parse('1\u{2009}234\u{2009}567'), 1234567);
      });
    });
  });
}
