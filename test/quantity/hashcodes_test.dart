import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('hashcodes', () {
    test('equal', () {
      final Energy a = new Energy(J: 5);
      final Energy b = new Energy(J: 5);
      expect(a.hashCode, b.hashCode);

      final Energy c = new Energy(J: 5.0);
      expect(a.hashCode, c.hashCode);

      final Energy d = new Energy(J: new Integer(5));
      expect(a.hashCode, d.hashCode);

      final Energy e = new Energy(J: new Double(5.0));
      expect(a.hashCode, e.hashCode);

      final Energy f = new Energy(J: new Complex(new Double(5.0), new Imaginary(0)));
      expect(a.hashCode, f.hashCode);

      final Energy g = new Energy(J: new Precise('5.0'));
      expect(a.hashCode, g.hashCode);

      final Energy h = new Energy(J: new Precise.num(5));
      expect(a.hashCode, h.hashCode);

      final Energy i = new Energy(J: new Precise.num(5.0));
      expect(a.hashCode, i.hashCode);
    });

    test('not equal', () {
      final Energy a = new Energy(J: 5.0);
      final Energy b = new Energy(J: 5.000000001);
      expect(a.hashCode == b.hashCode, false);

      final Energy c = new Energy(J: -5.0);
      expect(a.hashCode == c.hashCode, false);

      final Energy d = new Energy(J: new Integer(6));
      expect(a.hashCode == d.hashCode, false);

      final Energy e = new Energy(J: new Double(-5.0));
      expect(a.hashCode == e.hashCode, false);

      final Energy f = new Energy(J: new Complex(new Double(5.01), new Imaginary(0)));
      expect(a.hashCode == f.hashCode, false);

      final Energy g = new Energy(J: new Precise('5.000000000000000000000000000001'));
      expect(a.hashCode == g.hashCode, false);

      final Energy h = new Energy(J: new Precise.num(-5));
      expect(a.hashCode == h.hashCode, false);

      final Energy i = new Energy(J: new Precise.num(5.0000001));
      expect(a.hashCode == i.hashCode, false);

      final Energy j = new Energy(J: new Imaginary(5));
      expect(a.hashCode == j.hashCode, false);
    });

    test('Scalar same as int', () {
      final Scalar a = new Scalar(value: 5.0);
      final Scalar b = new Scalar(value: 5);
      expect(a.hashCode, 5.hashCode);
      expect(b.hashCode, 5.hashCode);

      final Scalar c = new Scalar(value: -5.0);
      expect(c.hashCode, -5.hashCode);

      final Scalar d = new Scalar(value: new Integer(5));
      expect(d.hashCode, 5.hashCode);

      final Scalar e = new Scalar(value: new Double(5.0));
      expect(e.hashCode, 5.hashCode);

      final Scalar f = new Scalar(value: new Complex(new Double(5.0), new Imaginary(0)));
      expect(f.hashCode, 5.hashCode);

      final Scalar g = new Scalar(value: new Precise('5.0000000000000000000'));
      expect(g.hashCode, 5.hashCode);

      final Scalar h = new Scalar(value: new Precise.num(-5));
      expect(h.hashCode, -5.hashCode);

      final Scalar i = new Scalar(value: new Precise.num(5.0));
      expect(i.hashCode, 5.hashCode);

      final Scalar j = new Scalar(value: -5);
      expect(j.hashCode == 5.hashCode, false);
    });

    test('scalar in map', () {
      final Map<int, String> m = <int, String>{0: 'zero', 5: 'five', 10: 'ten'};

      expect(m[0], 'zero');
      expect(m[new Scalar(value: 0)], 'zero');

      expect(m[5], 'five');
      expect(m[new Scalar(value: new Integer(5))], 'five');

      expect(m[10], 'ten');
      expect(m[new Scalar(value: new Double(10.0))], 'ten');

      expect(m[new Scalar(value: new Double(10.000001))], isNull);
    });
  });
}
