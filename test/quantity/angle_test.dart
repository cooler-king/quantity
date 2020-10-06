import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Angle', () {
    test('constructors', () {
      // Default ctor: rad 0
      var a = Angle();
      expect(a, isNotNull);
      expect(a.valueSI, Double.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad +
      a = Angle(rad: 2.4);
      expect(a, isNotNull);
      expect(a.valueSI?.toDouble(), 2.4);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad -
      a = Angle(rad: -999.9);
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), -999.9);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Integer
      a = Angle(rad: Integer(4));
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), 4);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Double
      a = Angle(rad: Double(-67.876));
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), -67.876);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Imaginary
      a = Angle(rad: Imaginary(34));
      expect(a, isNotNull);
      expect(a.valueSI == Imaginary(34), true);
      expect(a.valueSI is Imaginary, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: rad Complex
      a = Angle(rad: Complex.coeff(12.34, 98.76));
      expect(a, isNotNull);
      expect(a.valueSI == Complex.coeff(12.34, 98.76), true);
      expect(a.valueSI is Complex, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.radians);

      // Default ctor: deg 0
      a = Angle(deg: 0);
      expect(a, isNotNull);
      expect(a.valueSI, Integer.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg +
      a = Angle(deg: 90.0);
      expect(a, isNotNull);
      expect(a.valueSI is Double, true);
      expect(a.valueSI.toDouble(), closeTo(pi / 2.0, 0.0001));
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg -
      a = Angle(deg: -270);
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), closeTo(-3 * pi / 2, 0.0001));
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Integer
      a = Angle(deg: Integer(4));
      expect(a, isNotNull);
      expect(a.valueSI == Angle.degrees.toMks(4), true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Double
      a = Angle(deg: Double(-67.876));
      expect(a, isNotNull);
      expect(a.valueSI == Angle.degrees.toMks(-67.876), true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Imaginary
      a = Angle(deg: Imaginary(34));
      expect(a, isNotNull);
      expect(a.valueSI is Imaginary, true);
      expect(a.valueSI == Imaginary(Angle.degrees.toMks(34)), true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // Default ctor: deg Complex
      a = Angle(deg: Complex.coeff(12.34, 98.76));
      expect(a, isNotNull);
      expect(a.valueSI is Complex, true);
      expect(a.valueSI == Complex.coeff(Angle.degrees.toMks(12.34).toDouble(), Angle.degrees.toMks(98.76).toDouble()),
          true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);

      // inUnits ctor
      a = Angle.inUnits(2, Angle.degrees);
      expect(a, isNotNull);
      expect(a.valueSI.toDouble(), 0.034906585039886);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Angle.angleDimensions);
      expect(a.preferredUnits, Angle.degrees);
    });

    test('angle360', () {
      var a = Angle(rad: 0);
      var a360 = a.angle360;
      expect(a360, isNotNull);
      expect(a360.valueSI, Double.zero);

      a = Angle(deg: 360);
      a360 = a.angle360;
      expect(a360 == Angle(deg: 360), true);

      a = Angle(deg: 400);
      a360 = a.angle360;
      expect(a360.valueSI.toDouble(), closeTo(Angle(deg: 40).valueSI.toDouble(), 0.00001));

      a = Angle(deg: -25);
      a360 = a.angle360;
      expect(a360.valueSI.toDouble(), closeTo(Angle(deg: 335).valueSI.toDouble(), 0.00001));
    });
  });
}
