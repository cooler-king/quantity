import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

main() {
  group('hashcodes', () {
    test('equal', () {
      var a = new Energy(J: 5);
      var b = new Energy(J: 5);
      expect(a.hashCode, b.hashCode);

      var c = new Energy(J: 5.0);
      expect(a.hashCode, c.hashCode);

      var d = new Energy(J: new Integer(5));
      expect(a.hashCode, d.hashCode);

      var e = new Energy(J: new Double(5.0));
      expect(a.hashCode, e.hashCode);

      var f = new Energy(J: new Complex(new Double(5.0), new Imaginary(0)));
      expect(a.hashCode, f.hashCode);

      var g = new Energy(J: new Precise("5.0"));
      expect(a.hashCode, g.hashCode);

      var h = new Energy(J: new Precise.num(5));
      expect(a.hashCode, h.hashCode);

      var i = new Energy(J: new Precise.num(5.0));
      expect(a.hashCode, i.hashCode);
    });

    test('not equal', () {
      var a = new Energy(J: 5.0);
      var b = new Energy(J: 5.000000001);
      expect(a.hashCode == b.hashCode, false);

      var c = new Energy(J: -5.0);
      expect(a.hashCode == c.hashCode, false);

      var d = new Energy(J: new Integer(6));
      expect(a.hashCode == d.hashCode, false);

      var e = new Energy(J: new Double(-5.0));
      expect(a.hashCode == e.hashCode, false);

      var f = new Energy(J: new Complex(new Double(5.01), new Imaginary(0)));
      expect(a.hashCode == f.hashCode, false);

      var g = new Energy(J: new Precise("5.000000000000000000000000000001"));
      expect(a.hashCode == g.hashCode, false);

      var h = new Energy(J: new Precise.num(-5));
      expect(a.hashCode == h.hashCode, false);

      var i = new Energy(J: new Precise.num(5.0000001));
      expect(a.hashCode == i.hashCode, false);

      var j = new Energy(J: new Imaginary(5));
      expect(a.hashCode == j.hashCode, false);
    });

    test('Scalar same as int', () {
      var a = new Scalar(value: 5.0);
      var b = new Scalar(value: 5);
      expect(a.hashCode, 5.hashCode);
      expect(b.hashCode, 5.hashCode);

      var c = new Scalar(value: -5.0);
      expect(c.hashCode, -5.hashCode);

      var d = new Scalar(value: new Integer(5));
      expect(d.hashCode, 5.hashCode);

      var e = new Scalar(value: new Double(5.0));
      expect(e.hashCode, 5.hashCode);

      var f = new Scalar(value: new Complex(new Double(5.0), new Imaginary(0)));
      expect(f.hashCode, 5.hashCode);

      var g = new Scalar(value: new Precise("5.0000000000000000000"));
      expect(g.hashCode, 5.hashCode);

      var h = new Scalar(value: new Precise.num(-5));
      expect(h.hashCode, -5.hashCode);

      var i = new Scalar(value: new Precise.num(5.0));
      expect(i.hashCode, 5.hashCode);

      var j = new Scalar(value: -5);
      expect(j.hashCode == 5.hashCode, false);
    });

    test('scalar in map', () {
      Map<int, String> m = {0: "zero", 5: "five", 10: "ten"};

      expect(m[0], "zero");
      expect(m[new Scalar(value: 0)], "zero");

      expect(m[5], "five");
      expect(m[new Scalar(value: new Integer(5))], "five");

      expect(m[10], "ten");
      expect(m[new Scalar(value: new Double(10.0))], "ten");

      expect(m[new Scalar(value: new Double(10.000001))], isNull);
    });
  });
}
