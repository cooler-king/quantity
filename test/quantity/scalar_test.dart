import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Scalar', () {
    test('constructors', () {
      Scalar s = new Scalar(value: 42);
      expect(s, isNotNull);

      s = new Scalar(value: 0);
      expect(s.valueSI, Integer.zero);
      expect(s.valueSI is Integer, true);
      expect(s.dimensions, Scalar.scalarDimensions);
      expect(s.preferredUnits, Scalar.one);
      expect(s.relativeUncertainty, 0);
    });

    test('operator ==/hashCode', () {
      final Scalar s1 = new Scalar(value: 11);
      final Scalar s2 = new Scalar(value: 0.96);
      final Scalar s3 = new Scalar(value: 11.0);
      final Scalar s4 = new Scalar(percent: 96);
      final Scalar s5 = new Scalar(percent: 0.96);
      final Scalar s6 = new Scalar(value: new Imaginary(11));
      final Scalar s7 = new Scalar(value: new Complex.coeff(0.96, 0));
      final Scalar s8 = new Scalar(value: new Complex.coeff(0, 11));

      expect(s1 == s2, false);
      expect(s1 == s3, true);
      expect(s2 == s4, true);
      expect(s2 == s5, false);
      expect(s4 == s5, false);
      expect(s1 == s6, false);
      expect(s2 == s7, true);
      expect(s6 == s8, true);

      //TODO double hashcodes are NOT unique!!!!  (only do integer part right now)

      expect(s1.hashCode == s2.hashCode, false);
      expect(s1.hashCode == s3.hashCode, true);
      expect(s2.hashCode == s4.hashCode, true);
      expect(s2.hashCode == s5.hashCode, false);
      expect(s4.hashCode == s5.hashCode, false);
      expect(s1.hashCode == s6.hashCode, false);
      expect(s2.hashCode == s7.hashCode, true);
      expect(s6.hashCode == s8.hashCode, true);
    });

    test('operator +', () {
      dynamicQuantityTyping = true;
      final Scalar s1 = new Scalar(value: 11);
      final Scalar s2 = new Scalar(value: 69);

      final dynamic c = s1 + s2;
      expect(c is Scalar, true);
      expect(c.valueSI.toInt(), 80);
      expect(c.valueSI is Integer, true);

      final dynamic d = s1 + s2 + s2 + s1;
      expect(d.valueSI == 160, true);
      expect(d.valueSI is Integer, true);
      expect(d is Scalar, true);

      final Scalar s3 = new Scalar(value: 34.21);

      final dynamic e = s1 + s3;
      expect(e.valueSI == 45.21, true);
      expect(e.valueSI is Double, true);
      expect(e is Scalar, true);

      final dynamic f = s3 + s1 + s2 + s3;
      expect(f.valueSI.toDouble(), closeTo(148.42, 0.000001));
      expect(f.valueSI is Double, true);
      expect(f is Scalar, true);

      // Scalar + num
      dynamic g = s1 + 5;
      expect(g is Scalar, true);
      expect(g.valueSI is Integer, true);
      expect(g.valueSI.toDouble(), 16.0);

      g = s1 + 8.3;
      expect(g is Scalar, true);
      expect(g.valueSI is Double, true);
      expect(g.valueSI.toDouble(), 19.3);

      g = s1 + new Integer(7);
      expect(g is Scalar, true);
      expect(g.valueSI is Integer, true);
      expect(g.valueSI.toDouble(), 18.0);

      g = s1 + new Double(21.1);
      expect(g is Scalar, true);
      expect(g.valueSI is Double, true);
      expect(g.valueSI.toDouble(), 32.1);

      g = s1 + new Imaginary(3.8);
      expect(g is Scalar, true);
      expect(g.valueSI is Complex, true);
      expect((g.valueSI as Complex).real.toDouble(), 11.0);
      expect((g.valueSI as Complex).imag.value.toDouble(), 3.8);

      g = s1 + new Complex(new Double(2.2), new Imaginary(9.3));
      expect(g is Scalar, true);
      expect(g.valueSI is Complex, true);
      expect((g.valueSI as Complex).real.toDouble(), 13.2);
      expect((g.valueSI as Complex).imag.value.toDouble(), 9.3);

      g = s1 + new Precise('4.0032');
      expect(g is Scalar, true);
      expect(g.valueSI is Precise, true);
      expect(g.valueSI, new Precise('15.0032'));
    });

    test('operator -', () {
      dynamicQuantityTyping = true;
      final Scalar s1 = new Scalar(value: 11);
      final Scalar s2 = new Scalar(value: 69);

      dynamic c = s1 - s2;
      expect(c is Scalar, true);
      expect(c.valueSI.toInt(), -58);
      expect(c.valueSI is Integer, true);
      c = s2 - s1;
      expect(c.valueSI.toInt(), 58);

      final Scalar s3 = new Scalar(value: 34.21);

      final dynamic e = s3 - s1;
      expect(e.valueSI == 23.21, true);
      expect(e.valueSI is Double, true);
      expect(e is Scalar, true);

      // Scalar - num
      dynamic g = s1 - 5;
      expect(g is Scalar, true);
      expect(g.valueSI is Integer, true);
      expect(g.valueSI.toDouble(), 6.0);

      g = s1 - 8.3;
      expect(g is Scalar, true);
      expect(g.valueSI is Double, true);
      expect(g.valueSI.toDouble(), closeTo(2.7, 0.000001));

      g = s1 - new Integer(7);
      expect(g is Scalar, true);
      expect(g.valueSI is Integer, true);
      expect(g.valueSI.toDouble(), 4.0);

      g = s1 - new Double(21.1);
      expect(g is Scalar, true);
      expect(g.valueSI is Double, true);
      expect(g.valueSI.toDouble(), closeTo(-10.1, 0.0000001));

      g = s1 - new Imaginary(3.8);
      expect(g is Scalar, true);
      expect(g.valueSI is Complex, true);
      expect((g.valueSI as Complex).real.toDouble(), 11.0);
      expect((g.valueSI as Complex).imag.value.toDouble(), -3.8);

      g = s1 - new Complex(new Double(2.2), new Imaginary(9.3));
      expect(g is Scalar, true);
      expect(g.valueSI is Complex, true);
      expect((g.valueSI as Complex).real.toDouble(), 8.8);
      expect((g.valueSI as Complex).imag.value.toDouble(), -9.3);

      g = s1 - new Precise('4.0032');
      expect(g is Scalar, true);
      expect(g.valueSI is Precise, true);
      expect(g.valueSI, new Precise('6.9968'));
    });

    test('operator *', () {
      dynamicQuantityTyping = true;
      final Scalar s1 = new Scalar(value: 3);
      final Scalar s2 = new Scalar(value: 4);

      dynamic c = s1 * s2;
      expect(c is Scalar, true);
      expect(c.valueSI.toInt(), 12);
      expect(c.valueSI is Integer, true);
      c = s2 * s1;
      expect(c.valueSI.toInt(), 12);

      final Scalar s3 = new Scalar(value: -5);
      c = s3 * s1;
      expect(c.valueSI.toInt(), -15);
      expect(c.valueSI is Integer, true);
      c = s1 * s3;
      expect(c.valueSI.toInt(), -15);
      expect(c.valueSI is Integer, true);

      final Scalar s4 = new Scalar(value: 1.3);
      c = s4 * s1;
      expect(c.valueSI.toDouble(), closeTo(3.9, 0.000001));
      expect(c.valueSI is Double, true);
      c = s1 * s4;
      expect(c.valueSI.toDouble(), closeTo(3.9, 0.000001));
      expect(c.valueSI is Double, true);

      final Scalar s5 = new Scalar(value: -0.5);
      c = s5 * s1;
      expect(c.valueSI.toDouble(), -1.5);
      expect(c.valueSI is Double, true);
      c = s1 * s5;
      expect(c.valueSI.toDouble(), -1.5);
      expect(c.valueSI is Double, true);

      final Scalar s6 = new Scalar(value: new Imaginary(6));
      c = s6 * s1;
      expect(c.valueSI is Imaginary, true);
      expect((c.valueSI as Imaginary).value.toDouble() == 18, true);
    });
  });
}
