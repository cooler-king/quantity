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

    test('decimalPortion', () {
      Precise p = new Precise("123");
      expect(p.decimalPortion, Precise.zero);

      p = new Precise("123.00000");
      expect(p.decimalPortion, Precise.zero);

      p = new Precise("123.4567");
      expect(p.decimalPortion, new Precise("0.4567"));

      p = new Precise("-6.789");
      expect(p.decimalPortion, new Precise("-0.789"));
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
      expect((sum as Precise).digits[0], Digit.nine);
      expect((sum as Precise).digits[1], Digit.five);
      expect((sum as Precise).digits[2], Digit.two);
      expect((sum as Precise).toString(), "-259");
    });

    test('operator -', () {
      Precise p = new Precise("456");
      Precise p2 = new Precise("321");
      Number diff = p - p2;
      expect(diff is Precise, true);
      expect((diff as Precise).digits.length, 3);
      expect((diff as Precise).power, 0);
      expect((diff as Precise).digits[0], Digit.five);
      expect((diff as Precise).digits[1], Digit.three);
      expect((diff as Precise).digits[2], Digit.one);
      expect((diff as Precise).toString(), "135");

      diff = p2 - p; // -135
      expect((diff as Precise).digits.length, 3);
      expect((diff as Precise).power, 0);
      expect((diff as Precise).isNegative, true);
      expect((diff as Precise).digits[0], Digit.five);
      expect((diff as Precise).digits[1], Digit.three);
      expect((diff as Precise).digits[2], Digit.one);
      expect((diff as Precise).toString(), "-135");

      Precise p3 = new Precise("-5");
      Precise p4 = new Precise("-7");
      diff = p3 - p4;
      expect((diff as Precise).digits.length, 1);
      expect((diff as Precise).power, 0);
      expect((diff as Precise).isNegative, false);
      expect((diff as Precise).digits[0], Digit.two);
      expect((diff as Precise).toString(), "2");

      diff = p4 - p3;
      expect((diff as Precise).digits.length, 1);
      expect((diff as Precise).power, 0);
      expect((diff as Precise).isNegative, true);
      expect((diff as Precise).digits[0], Digit.two);
      expect((diff as Precise).toString(), "-2");

      Precise p5 = new Precise("12345.6789");
      diff = p - p5; // -11889.6789
      expect((diff as Precise).digits.length, 9);
      expect((diff as Precise).power, -4);
      expect((diff as Precise).isNegative, true);
      expect((diff as Precise).toString(), "-11889.6789");

      Precise p6 = new Precise("-0.5371057032");
      diff = p5 - p6; // 12345.1417942968
      expect((diff as Precise).digits.length, 15);
      expect((diff as Precise).power, -10);
      expect((diff as Precise).isNegative, false);
      expect((diff as Precise).toString(), "12346.2160057032");
    });

    test('operator *', () {
      Precise p0 = Precise.zero;
      Precise p1 = new Precise("1");
      Precise p2 = new Precise("2");
      Precise p3 = new Precise("3");
      Number prod = p0 * p0;
      expect(prod is Precise, true);
      expect((prod as Precise).digits.length, 1);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).digits[0], Digit.zero);
      expect((prod as Precise).toString(), "0");

      prod = p0 * p1;
      expect((prod as Precise).digits.length, 1);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).digits[0], Digit.zero);
      expect((prod as Precise).toString(), "0");

      prod = p1 * p2;
      expect((prod as Precise).digits.length, 1);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).digits[0], Digit.two);
      expect((prod as Precise).toString(), "2");

      prod = p3 * p3;
      expect((prod as Precise).digits.length, 1);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).digits[0], Digit.nine);
      expect((prod as Precise).toString(), "9");

      Precise p4 = new Precise("4");
      prod = p3 * p4;
      expect((prod as Precise).digits.length, 2);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).digits[0], Digit.two);
      expect((prod as Precise).digits[1], Digit.one);
      expect((prod as Precise).toString(), "12");

      Precise pNeg5 = new Precise("-5");
      prod = p4 * pNeg5;
      expect((prod as Precise).digits.length, 2);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).isNegative, true);
      expect((prod as Precise).digits[0], Digit.zero);
      expect((prod as Precise).digits[1], Digit.two);
      expect((prod as Precise).toString(), "-20");

      Precise p123 = new Precise("123");
      prod = p4 * p123;
      expect((prod as Precise).digits.length, 3);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).digits[0], Digit.two);
      expect((prod as Precise).digits[1], Digit.nine);
      expect((prod as Precise).digits[2], Digit.four);
      expect((prod as Precise).toString(), "492");

      Precise pNeg432 = new Precise("-432");
      prod = p123 * pNeg432;
      expect((prod as Precise).digits.length, 5);
      expect((prod as Precise).power, 0);
      expect((prod as Precise).isNegative, true);
      expect((prod as Precise).digits[0], Digit.six);
      expect((prod as Precise).digits[1], Digit.three);
      expect((prod as Precise).digits[2], Digit.one);
      expect((prod as Precise).digits[3], Digit.three);
      expect((prod as Precise).digits[4], Digit.five);
      expect((prod as Precise).toString(), "-53136");

      Precise p1pt2 = new Precise("1.2");
      prod = p123 * p1pt2;
      expect((prod as Precise).digits.length, 4);
      expect((prod as Precise).power, -1);
      expect((prod as Precise).digits[0], Digit.six);
      expect((prod as Precise).digits[1], Digit.seven);
      expect((prod as Precise).digits[2], Digit.four);
      expect((prod as Precise).digits[3], Digit.one);
      expect((prod as Precise).toString(), "147.6");

      Precise pNeg478pt192 = new Precise("-478.192");
      prod = p1pt2 * pNeg478pt192;
      expect((prod as Precise).digits.length, 7);
      expect((prod as Precise).power, -4);
      expect((prod as Precise).digits[0], Digit.four);
      expect((prod as Precise).digits[1], Digit.zero);
      expect((prod as Precise).digits[2], Digit.three);
      expect((prod as Precise).digits[3], Digit.eight);
      expect((prod as Precise).digits[4], Digit.three);
      expect((prod as Precise).digits[5], Digit.seven);
      expect((prod as Precise).digits[6], Digit.five);
      expect((prod as Precise).toString(), "-573.8304");
    });

    test('operator /', () {
      Precise p0 = Precise.zero;
      Precise p1 = new Precise("1");
      Precise p2 = new Precise("2");
      Precise p10 = new Precise("10");
      Precise pNeg20 = new Precise("-20");
      Number result = p0 / p0;
      expect(result is Precise, true);
      expect((result as Precise).digits.length, 1);
      expect((result as Precise).power, 0);
      expect((result as Precise).digits[0], Digit.one);
      expect((result as Precise).toString(), "1");

      result = p1 / p0;
      expect(result, Double.infinity);

      result = p1 / p1;
      expect(result, Precise.one);

      result = p2 / p1;
      expect(identical(result, p2), true);

      result = p1 / p2;
      expect(result, new Precise("0.5"));

      result = p10 / p2;
      expect(result, new Precise("5"));

      result = p2 / p10;
      expect(result, new Precise("0.2"));

      result = pNeg20 / p2;
      expect(result, new Precise("-10"));

      result = pNeg20 / p10;
      expect(result, new Precise("-2"));

      result = p2 / pNeg20;
      expect(result, new Precise("-0.1"));
    });

    test('operator ^', () {
      Precise p0 = Precise.zero;
      //expect(identical(p0 ^ 0, Double.NaN), true);
      expect(p0 ^ 0, Double.NaN);
      expect(p0 ^ 1, Precise.zero);
      expect(p0 ^ 2, Precise.zero);
      expect(p0 ^ -2, Precise.zero);
      expect(p0 ^ 100, Precise.zero);

      Precise p1 = new Precise.num(1);
      expect(p1 ^ 0, p1);
      expect(p1 ^ 1, p1);
      expect(identical(p1 ^ 1, p1), true);
      expect(p1 ^ 2, p1);
      expect(p1 ^ 10, p1);
      expect(p1 ^ 2, p1);

      var p10 = new Precise.num(10);
      expect(p10 ^ 0, p1);
      expect(p10 ^ 1, p10);
      expect(p10 ^ 2, new Precise.num(100));
      expect(p10 ^ -1, new Precise.num(0.1));
      expect(p10 ^ -2, new Precise.num(0.01));

      var pNeg5 = new Precise.num(-5);
      expect(pNeg5 ^ 0, p1);
      expect(pNeg5 ^ 1, pNeg5);
      expect(pNeg5 ^ 2, new Precise.num(25));
      expect(pNeg5 ^ 3, new Precise.num(-125));
    });

    test('abs', () {
      var p = new Precise("0");
      var abs = p.abs();
      expect(abs is Precise, true);
      expect(abs, Precise.zero);

      p = new Precise("-0.00000001");
      abs = p.abs();
      expect(abs, new Precise("0.00000001"));

      p = new Precise("0.00000001");
      abs = p.abs();
      expect(abs, new Precise("0.00000001"));

      p = new Precise("-99999999999");
      abs = p.abs();
      expect(abs, new Precise("99999999999"));

      p = new Precise("-99999999999.9999999999999");
      abs = p.abs();
      expect(abs, new Precise("99999999999.9999999999999"));
    });

    test('ceil', () {
      var p = new Precise("5.678");
      var ceil = p.ceil();
      expect(ceil is Precise, true);
      expect(ceil.digits.length, 1);
      expect(ceil.isNegative, false);
      expect(ceil.power, 0);
      expect(ceil.digits[0], Digit.six);
      expect(ceil.toString(), "6");

      p = new Precise("-5.678");
      ceil = p.ceil();
      expect(ceil.isNegative, true);
      expect(ceil.toString(), "-5");

      p = new Precise("-9.1");
      ceil = p.ceil();
      expect(ceil.isNegative, true);
      expect(ceil.toString(), "-9");

      p = new Precise("10");
      ceil = p.ceil();
      expect(ceil.toString(), "10");

      p = new Precise("10.000000000001");
      ceil = p.ceil();
      expect(ceil.toString(), "11");
    });

    test('floor', () {
      var p = new Precise("5.678");
      var floor = p.floor();
      expect(floor is Precise, true);
      expect(floor.digits.length, 1);
      expect(floor.isNegative, false);
      expect(floor.power, 0);
      expect(floor.digits[0], Digit.five);
      expect(floor.toString(), "5");

      p = new Precise("-5.678");
      floor = p.floor();
      expect(floor.isNegative, true);
      expect(floor.toString(), "-6");

      p = new Precise("-9.1");
      floor = p.floor();
      expect(floor.isNegative, true);
      expect(floor.toString(), "-10");

      p = new Precise("10");
      floor = p.floor();
      expect(floor.toString(), "10");

      p = new Precise("10.000000000001");
      floor = p.floor();
      expect(floor.toString(), "10");

      p = new Precise("99.9999999999999999999999999");
      floor = p.floor();
      expect(floor.toString(), "99");

      p = new Precise("-999.9999999999999999999999999");
      floor = p.floor();
      expect(floor.toString(), "-1000");
    });

    test('reciprocal', () {
      var p = new Precise("4");
      var recip = p.reciprocal();
      expect(recip is Precise, true);
      expect(recip.digits.length, 3);
      expect(recip.isNegative, false);
      expect(recip.power, -2);
      expect(recip.digits[0], Digit.five);
      expect(recip.digits[1], Digit.two);
      expect(recip.digits[2], Digit.zero);
      expect(recip.toString(), "0.25");
    });

    test('round', () {
      var p = new Precise("5.678");
      var round = p.round();
      expect(round is Precise, true);
      expect(round.digits.length, 1);
      expect(round.isNegative, false);
      expect(round.power, 0);
      expect(round.digits[0], Digit.six);
      expect(round.toString(), "6");

      p = new Precise("-5.678");
      round = p.round();
      expect(round.isNegative, true);
      expect(round.toString(), "-6");

      p = new Precise("1236.5");
      round = p.round();
      expect(round.isNegative, false);
      expect(round.toString(), "1237");

      p = new Precise("-1236.5");
      round = p.round();
      expect(round.isNegative, true);
      expect(round.toString(), "-1237");

      p = new Precise("1236.49999999999999999999999999999999999999");
      round = p.round();
      expect(round.isNegative, false);
      expect(round.isInteger, true);
      expect(round.toString(), "1236");

      p = new Precise("-1236.4999999999999999999999999999999999999");
      round = p.round();
      expect(round.isNegative, true);
      expect(round.isInteger, true);
      expect(round.toString(), "-1236");
    });

    test('truncate', () {
      var p = new Precise("5.678");
      var trunc = p.truncate();
      expect(trunc is Precise, true);
      expect(trunc.digits.length, 1);
      expect(trunc.isNegative, false);
      expect(trunc.power, 0);
      expect(trunc.digits[0], Digit.five);
      expect(trunc.toString(), "5");

      p = new Precise("-1234.5678");
      trunc = p.truncate();
      expect(trunc.isNegative, true);
      expect(trunc.power, 0);
      expect(trunc.toString(), "-1234");

      p = new Precise("123456.78");
      trunc = p.truncate();
      expect(trunc.power, 0);
      expect(trunc.toString(), "123456");

      p = new Precise("0.999999999999999999999999999999999");
      trunc = p.truncate();
      expect(trunc.isNegative, false);
      expect(trunc.power, 0);
      expect(trunc.toString(), "0");

      p = new Precise("-0.000000000000000000000000000001");
      trunc = p.truncate();
      expect(trunc.isNegative, false);
      expect(trunc.power, 0);
      expect(trunc.toString(), "0");

      p = new Precise("10.000000000001");
      trunc = p.truncate();
      expect(trunc.isNegative, false);
      expect(trunc.power, 0);
      expect(trunc.toString(), "10");
    });
  });
}
