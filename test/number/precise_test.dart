import 'package:test/test.dart';
import 'package:quantity/number.dart';

main() {
  group('Digit', () {
    test('constructors', () {
      Digit d1 = new Digit(0);
      Digit d2 = new Digit(1);
      Digit d3 = new Digit(2);
      Digit d4 = new Digit(3);
      expect(d1.value.getUint8(0), 0);
      expect(d2.value.getUint8(0), 1);
      expect(d3.value.getUint8(0), 2);
      expect(d4.value.getUint8(0), 3);

      Digit d5 = new Digit.char("5");
      Digit d6 = new Digit.char("6");
      Digit d7 = new Digit.char("7");
      Digit d8 = new Digit.char("8");
      expect(d5.value.getUint8(0), 5);
      expect(d6.value.getUint8(0), 6);
      expect(d7.value.getUint8(0), 7);
      expect(d8.value.getUint8(0), 8);

      // Bad values
      try {
        new Digit(10);
        fail("Should not be allowed to contruct a Digit with a value greater then 9");
      } catch (e) {
        expect(e is String, true);
      }
      try {
        new Digit(-1);
        fail("Should not be allowed to contruct a Digit with a value less than 0");
      } catch (e) {
        expect(e is String, true);
      }
      try {
        new Digit(null);
        fail("Should not be allowed to contruct a Digit with null");
      } catch (e) {
        expect(e is String, true);
      }
      try {
        new Digit.char("12");
        fail("Should not be allowed to contruct a Digit with a string having more than one character");
      } catch (e) {
        expect(e is String, true);
      }
      try {
        new Digit.char("");
        fail("Should not be allowed to contruct a Digit with an empty string");
      } catch (e) {
        expect(e is String, true);
      }
      try {
        new Digit.char(null);
        fail("Should not be allowed to contruct a Digit with a null string");
      } catch (e) {
        expect(e is String, true);
      }
    });

    test('toInt()', () {
      Digit d1 = new Digit(0);
      Digit d2 = new Digit(1);
      Digit d3 = new Digit(2);
      Digit d4 = new Digit(3);
      expect(d1.toInt(), 0);
      expect(d2.toInt(), 1);
      expect(d3.toInt(), 2);
      expect(d4.toInt(), 3);
    });

    test('operator <', () {
      Digit d1 = new Digit(0);
      Digit d2 = new Digit(1);
      Digit d3 = new Digit(2);
      Digit d4 = new Digit(3);
      expect(d1 < d2, true);
      expect(d2 < d3, true);
      expect(d3 < d2, false);
      expect(d3 < Digit.two, false);
      expect(d3 < Digit.three, true);
    });
  });

  group('Precise', () {
    test('constructors', () {
      Precise p = new Precise("0");
      expect(p.digits.length, 1);
      expect(p.digits[0].toInt(), 0);
      expect(p.power, 0);

      p = new Precise("0.0");
      expect(p.digits.length, 2);
      expect(p.digits[0].toInt(), 0);
      expect(p.digits[1].toInt(), 0);
      expect(p.power, -1);

      p = new Precise("12345.6789");
      expect(p.digits.length, 9);
      expect(p.digits[0].toInt(), 9);
      expect(p.digits[1].toInt(), 8);
      expect(p.digits[2].toInt(), 7);
      expect(p.digits[3].toInt(), 6);
      expect(p.digits[4].toInt(), 5);
      expect(p.digits[5].toInt(), 4);
      expect(p.digits[6].toInt(), 3);
      expect(p.digits[7].toInt(), 2);
      expect(p.digits[8].toInt(), 1);
      expect(p.power, -4);

      p = new Precise("543.91e7");
      expect(p.digits.length, 5);
      expect(p.digits[0].toInt(), 1);
      expect(p.digits[1].toInt(), 9);
      expect(p.digits[2].toInt(), 3);
      expect(p.digits[3].toInt(), 4);
      expect(p.digits[4].toInt(), 5);
      expect(p.power, 5);
    });

    test('operator ==', () {
      Precise p = new Precise("123");
      Precise p2 = new Precise("456");
      Precise p3 = new Precise("456");
      Precise p4 = new Precise("456.000");
      Precise p5 = new Precise("-456");
      expect(p == p, true);
      expect(p == p2, false);
      expect(p2 == p3, true);
      expect(p2 == p4, true);
      expect(p3 == p5, false);
      expect(p4 == p5, false);
    });

    test('operator <', () {
      Precise p = new Precise("123");
      Precise p2 = new Precise("456");
      Precise p3 = new Precise("456");
      Precise p4 = new Precise("456.000");
      Precise p5 = new Precise("-456");
      expect(p < p, false);
      expect(p < p2, true);
      expect(p2 < p, false);
      expect(p2 < p3, false);
      expect(p2 < p4, false);
      expect(p5 < p3, true);
      expect(p5 < p4, true);
      expect(p3 < p5, false);
      expect(p4 < p5, false);
    });

    test('operator >', () {
      Precise p = new Precise("123");
      Precise p2 = new Precise("456");
      Precise p3 = new Precise("456");
      Precise p4 = new Precise("456.000");
      Precise p5 = new Precise("-456");
      expect(p > p, false);
      expect(p > p2, false);
      expect(p2 > p, true);
      expect(p2 > p3, false);
      expect(p2 > p4, false);
      expect(p5 > p3, false);
      expect(p5 > p4, false);
      expect(p3 > p5, true);
      expect(p4 > p5, true);
    });

    test('operator <=', () {
      Precise p = new Precise("123");
      Precise p2 = new Precise("456");
      Precise p3 = new Precise("456");
      Precise p4 = new Precise("456.000");
      Precise p5 = new Precise("-456");
      expect(p <= p, true);
      expect(p <= p2, true);
      expect(p2 <= p, false);
      expect(p2 <= p3, true);
      expect(p2 <= p4, true);
      expect(p5 <= p3, true);
      expect(p5 <= p4, true);
      expect(p3 <= p5, false);
      expect(p4 <= p5, false);
    });

    test('operator >=', () {
      Precise p = new Precise("123");
      Precise p2 = new Precise("456");
      Precise p3 = new Precise("456");
      Precise p4 = new Precise("456.000");
      Precise p5 = new Precise("-456");
      expect(p >= p, true);
      expect(p >= p2, false);
      expect(p2 >= p, true);
      expect(p2 >= p3, true);
      expect(p2 >= p4, true);
      expect(p5 >= p3, false);
      expect(p5 >= p4, false);
      expect(p3 >= p5, true);
      expect(p4 >= p5, true);
    });

    test('operator +', () {
      Precise p = new Precise("123");
      Precise p2 = new Precise("456");
      Number sum = p + p2;
      expect(sum is Precise, true);
      expect((sum as Precise).digits.length, 3);
      expect((sum as Precise).power, 0);
      expect((sum as Precise).digits[0], Digit.nine);
      expect((sum as Precise).digits[1], Digit.seven);
      expect((sum as Precise).digits[2], Digit.five);
      expect((sum as Precise).toString(), "579");

      Precise p3 = new Precise("9999");
      sum = p + p3;
      expect(sum is Precise, true);
      expect((sum as Precise).digits.length, 5);
      expect((sum as Precise).power, 0);
      expect((sum as Precise).digits[0], Digit.two);
      expect((sum as Precise).digits[1], Digit.two);
      expect((sum as Precise).digits[2], Digit.one);
      expect((sum as Precise).digits[3], Digit.zero);
      expect((sum as Precise).digits[4], Digit.one);
      expect((sum as Precise).toString(), "10122");

      Precise p4 = new Precise("123.456");
      Precise p5 = new Precise("987.654");
      sum = p4 + p5; // 1111.110
      expect(sum is Precise, true);
      expect((sum as Precise).digits.length, 7);
      expect((sum as Precise).power, -3);
      expect((sum as Precise).digits[0], Digit.zero);
      expect((sum as Precise).digits[1], Digit.one);
      expect((sum as Precise).digits[2], Digit.one);
      expect((sum as Precise).digits[3], Digit.one);
      expect((sum as Precise).digits[4], Digit.one);
      expect((sum as Precise).digits[5], Digit.one);
      expect((sum as Precise).digits[6], Digit.one);
      expect((sum as Precise).toString(), "1111.110");

      Precise p6 = new Precise("-382");
      sum = p + p6; // -259
      expect(sum is Precise, true);
      expect((sum as Precise).digits.length, 3);
      expect((sum as Precise).power, 0);
      expect((sum as Precise).isNegative, true);
      expect((sum as Precise).digits[0], Digit.zero);
      expect((sum as Precise).digits[1], Digit.two);
      expect((sum as Precise).digits[2], Digit.five);
      expect((sum as Precise).digits[3], Digit.nine);
      expect((sum as Precise).toString(), "-259");
    });
  });
}
