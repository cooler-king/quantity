import 'dart:math' as Math;
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Angle', () {
    test('constructors', () {
      // Default ctor: rad 0
      Angle a = new Angle(rad: 0);
      expect(a, isNotNull);
      expect(a.valueSI, Double.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad +
      a = new Angle(rad: 2.4);
      expect(a, isNotNull);
      expect(a.valueSI?.toDouble() == 2.4, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad -
      a = new Angle(rad: -999.9);
      expect(a, isNotNull);
      expect(a.valueSI.toDouble() == -999.9, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Integer
      a = new Angle(rad: new Integer(4));
      expect(a, isNotNull);
      expect(a.valueSI.toDouble() == 4, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Double
      a = new Angle(rad: new Double(-67.876));
      expect(a, isNotNull);
      expect(a.valueSI.toDouble() == -67.876, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Imaginary
      a = new Angle(rad: new Imaginary(34));
      expect(a, isNotNull);
      expect(a.valueSI == new Imaginary(34), true);
      expect(a.valueSI is Imaginary, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      /*
      // Default ctor: rad Complex
      a = new Angle(rad:new Complex.coeff(12.34, 98.76));
      expect(a, isNotNull);
      expect(a.valueSI == new Complex.coeff(12.34, 98.76), true);
      expect(a.valueSI is Complex, true);
      expect(a.dimensions, Angle.ANGLEdimensions);
      expect(a.preferredUnits, Angle.radians);*/

      // Default ctor: deg 0
      a = new Angle(deg: 0);
      expect(a, isNotNull);
      expect(a.valueSI, Integer.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg +
      a = new Angle(deg: 90.0);
      expect(a, isNotNull);
      expect(a.valueSI is Double, true);
      expect(a.valueSI.toDouble(), closeTo(Math.PI / 2.0, 0.0001));
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg -
      a = new Angle(deg: -270);
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), closeTo(-3 * Math.PI / 2, 0.0001));
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Integer
      a = new Angle(deg: new Integer(4));
      expect(a, isNotNull);
      expect(a.valueSI == Angle.degrees.toMks(4), true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Double
      a = new Angle(deg: new Double(-67.876));
      expect(a, isNotNull);
      expect(a.valueSI == Angle.degrees.toMks(-67.876), true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Imaginary
      a = new Angle(deg: new Imaginary(34));
      expect(a, isNotNull);
      expect(a.valueSI is Imaginary, true);
      expect(a.valueSI == new Imaginary(Angle.degrees.toMks(34)), true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Complex
      a = new Angle(deg: new Complex.coeff(12.34, 98.76));
      expect(a, isNotNull);
      expect(a.valueSI is Complex, true);
      expect(
          a.valueSI == new Complex.coeff(Angle.degrees.toMks(12.34).toDouble(), Angle.degrees.toMks(98.76).toDouble()),
          true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      /*
      // inUnits ctor
      a = new Angle.inUnits(0.0, Angle.degrees);
      expect(a, isNotNull);
      expect(a.valueSI == 4, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.ANGLEdimensions);
      expect(a.preferredUnits, Angle.radians);
      */
    });

    test('angle360', () {
      Angle a = new Angle(rad: 0);
      Angle a360 = a.angle360;
      expect(a360, isNotNull);
      expect(a360.valueSI, Double.zero);

      a = new Angle(deg: 360);
      a360 = a.angle360;
      expect(a360 == new Angle(deg: 360), true);

      a = new Angle(deg: 400);
      a360 = a.angle360;
      expect(a360.valueSI.toDouble(), closeTo(new Angle(deg: 40).valueSI.toDouble(), 0.00001));

      a = new Angle(deg: -25);
      a360 = a.angle360;
      expect(a360.valueSI.toDouble(), closeTo(new Angle(deg: 335).valueSI.toDouble(), 0.00001));
    });
  });
}
