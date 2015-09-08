import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

main() {
  group('Length', () {
    test('constructors -default', () {
      // default ctor, meters 0
      Length a = new Length(m: 0);
      expect(a.valueSI, Double.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Length.lengthDimensions);
      expect(a.preferredUnits, Length.meters);
      expect(a.relativeUncertainty, 0);

      // default ctor, meters +
      a = new Length(m: 42);
      expect(a.valueSI == 42, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Length.lengthDimensions);
      expect(a.preferredUnits, Length.meters);
      expect(a.relativeUncertainty, 0);

      // default ctor, meters -
      a = new Length(m: -99.33);
      expect(a.valueSI == -99.33, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Length.lengthDimensions);
      expect(a.preferredUnits, Length.meters);
      expect(a.relativeUncertainty, 0);

      // default ctor, kilometers
      a = new Length(km: 76.54321);
      expect(a.valueSI == 76543.21, true);
      expect(a.preferredUnits, Length.kilometers);
      expect(a.relativeUncertainty, 0);

      // default ctor, millimeters
      a = new Length(mm: 12345.6789);
      expect(a.valueSI.toDouble(), closeTo(12.3456789, 0.00001));
      expect(a.preferredUnits, Length.millimeters);
      expect(a.relativeUncertainty, 0);

      // default ctor, astronomical units
      a = new Length(AU: 0.001);
      expect(a.valueSI.toDouble(), closeTo(1.495978707e8, 0.00001));
      expect(a.preferredUnits, Length.astronomicalUnits);
      expect(a.relativeUncertainty, 0);

      // default ctor, nautical miles
      a = new Length(NM: 200.0);
      expect(a.valueSI.toDouble(), closeTo(3.704e5, 0.00001));
      expect(a.preferredUnits, Length.nauticalMiles);
      expect(a.relativeUncertainty, 0);
    });

    test('constructors - default (uncertainty)', () {
      Length a = new Length(m: 0, uncert: 0.01);
      expect(a.relativeUncertainty, 0.01);

      a = new Length(km: 0, uncert: 0.0001);
      expect(a.relativeUncertainty, 0.0001);
    });

    test('operator - unary negation', () {
      dynamicQuantityTyping = true;
      Length a = new Length(m: 5);
      Length b = new Length(m: -7);
      Length c = new Length(m: 5.4);
      Length d = new Length(m: -83.521);

      var a2 = -a;
      expect(a2.valueSI == -5, true);
      expect(a2.valueSI is Integer, true);
      expect(a2 is Length, true);

      var b2 = -b;
      expect(b2.valueSI == 7, true);
      expect(b2.valueSI is Integer, true);
      expect(b2 is Length, true);

      var c2 = -c;
      expect(c2.valueSI == -5.4, true);
      expect(c2.valueSI is Double, true);
      expect(c2 is Length, true);

      var d2 = -d;
      expect(d2.valueSI == 83.521, true);
      expect(d2.valueSI is Double, true);
      expect(d2 is Length, true);
    });

    test('operator - addition', () {
      dynamicQuantityTyping = true;
      Length a = new Length(m: 5.4);
      Length b = new Length(m: 83.521);

      var c = a + b;
      expect(c.valueSI == 88.921, true);
      expect(c.valueSI is Double, true);
      expect(c is Length, true);

      var d = a + b + b + a;
      expect(d.valueSI == 177.842, true);
      expect(d.valueSI is Double, true);
      expect(d is Length, true);
    });

    test('operator - subtraction', () {
      dynamicQuantityTyping = true;
      Length a = new Length(m: 75.3);
      Length b = new Length(m: 17.11);
      Length c = new Length(m: -4.2);

      var aa = a - b;
      expect(aa.valueSI == 58.19, true);
      expect(aa.valueSI is Double, true);
      expect(aa is Length, true);

      var bb = a - c;
      expect(bb.valueSI == 79.5, true);
      expect(bb.valueSI is Double, true);
      expect(bb is Length, true);
    });

    test('operator - multiplication', () {
      dynamicQuantityTyping = true;
      Length a = new Length(m: 0.3);
      Length b = new Length(m: 42.0);
      Length c = new Length(m: -4.5);

      var aa = a * b;
      expect(aa.valueSI == 12.6, true);
      expect(aa.valueSI is Double, true);
      expect(aa.dimensions.equalsSI(Area.areaDimensions), true);
      expect(aa is Area, true);

      var bb = a * c;
      expect(bb.valueSI.toDouble(), closeTo(-1.35, 0.000001));
      expect(bb.valueSI is Double, true);
      expect(bb.dimensions.equalsSI(Area.areaDimensions), true);
      expect(bb is Area, true);
    });

    test('operator - division', () {
      dynamicQuantityTyping = true;
      Length a = new Length(m: 0.3);
      Length b = new Length(m: 42.0);
      Length c = new Length(m: -4.5);

      var aa = b / a;
      expect(aa.valueSI == 140.0, true);
      expect(aa.valueSI is Integer, true);
      expect(aa.dimensions.equalsSI(Scalar.scalarDimensions), true);
      expect(aa is Scalar, true);

      var bb = a / c;
      expect(bb.valueSI.toDouble(), closeTo(0.3 / -4.5, 0.000001));
      expect(bb.valueSI is Double, true);
      expect(bb.dimensions.equalsSI(Scalar.scalarDimensions), true);
      expect(bb is Scalar, true);

      var cc = b / 14;
      expect(cc.valueSI == 3, true);
      expect(cc.valueSI is Integer, true);
      expect(cc.dimensions.equalsSI(Length.lengthDimensions), true);
      expect(cc is Length, true);

      var dd = b / new Scalar(value: 21);
      expect(dd.valueSI == 2, true);
      expect(dd.valueSI is Integer, true);
      expect(dd.dimensions.equalsSI(Length.lengthDimensions), true);
      expect(dd is Length, true);

      var ee = b / new Time(s: 4);
      expect(ee.valueSI == 10.5, true);
      expect(ee.valueSI is Double, true);
      expect(ee.dimensions.equalsSI(Speed.speedDimensions), true);
      expect(ee is Speed, true);

      var ff = b / new Speed(m_per_s: 10.5);
      expect(ff.valueSI == 4, true);
      expect(ff.valueSI is Integer, true);
      expect(ff.dimensions.equalsSI(Time.timeDimensions), true);
      expect(ff is Time, true);
    });

    test('operator - power', () {
      dynamicQuantityTyping = true;
      Length a = new Length(m: 2);

      var aa = a ^ 2;
      expect(aa.valueSI == 4, true);
      expect(aa.valueSI is Integer, true);
      expect(aa.dimensions.equalsSI(Area.areaDimensions), true);
      expect(aa is Area, true);

      var bb = a ^ 3;
      expect(bb.valueSI == 8, true);
      expect(bb.valueSI is Integer, true);
      expect(bb.dimensions.equalsSI(Volume.volumeDimensions), true);
      expect(bb is Volume, true);

      var cc = a ^ 2.5;
      expect(cc.valueSI is Double, true);
      expect(cc.dimensions.getComponentExponent("Length"), 2.5);
      expect(cc is MiscQuantity, true);

      var dd = a ^ 1;
      expect(identical(a, dd), true);

      var ee = a ^ 0;
      expect(identical(ee, Scalar.one), true);
    });

    test('operator - less than', () {
      Length a = new Length(m: 75.3);
      Length b = new Length(m: 17.11);
      Length c = new Length(m: -4.2);
      Length d = new Length(m: -4003.2);

      expect(a < a, false);
      expect(a < b, false);
      expect(a < c, false);
      expect(a < d, false);

      expect(b < a, true);
      expect(b < b, false);
      expect(b < c, false);
      expect(b < d, false);

      expect(c < a, true);
      expect(c < b, true);
      expect(c < c, false);
      expect(c < d, false);

      expect(d < a, true);
      expect(d < b, true);
      expect(d < c, true);
      expect(d < d, false);
    });

    test('operator - less than equals', () {
      Length a = new Length(m: 75.3);
      Length b = new Length(m: 17.11);
      Length c = new Length(m: -4.2);
      Length d = new Length(m: 75.3);
      Length e = new Length(m: 2317.11);

      expect(a <= a, true);
      expect(a <= b, false);
      expect(a <= c, false);
      expect(a <= d, true);
      expect(a <= e, true);
    });

    test('operator - greater than', () {
      Length a = new Length(m: 75.3);
      Length b = new Length(m: 17.11);
      Length c = new Length(m: -4.2);
      Length d = new Length(m: -4003.2);

      expect(a > a, false);
      expect(a > b, true);
      expect(a > c, true);
      expect(a > d, true);

      expect(b > a, false);
      expect(b > b, false);
      expect(b > c, true);
      expect(b > d, true);

      expect(c > a, false);
      expect(c > b, false);
      expect(c > c, false);
      expect(c > d, true);

      expect(d > a, false);
      expect(d > b, false);
      expect(d > c, false);
      expect(d > d, false);
    });

    test('operator - greater than equals', () {
      Length a = new Length(m: 75.3);
      Length b = new Length(m: 17.11);
      Length c = new Length(m: -4.2);
      Length d = new Length(m: 75.3);
      Length e = new Length(m: 2317.11);

      expect(a >= a, true);
      expect(a >= b, true);
      expect(a >= c, true);
      expect(a >= d, true);
      expect(a >= e, false);
    });

    test('units - metric', () {
      expect(Length.meters.valueSI == 1, true);

      expect((Length.meters.yotta() as Length).valueSI == 1e24, true);
      expect((Length.meters.zetta() as Length).valueSI == 1e21, true);
      expect((Length.meters.exa() as Length).valueSI == 1e18, true);
      expect((Length.meters.peta() as Length).valueSI == 1e15, true);
      expect((Length.meters.tera() as Length).valueSI == 1e12, true);
      expect((Length.meters.giga() as Length).valueSI == 1e9, true);
      expect((Length.meters.mega() as Length).valueSI == 1e6, true);
      expect(Length.kilometers.valueSI == 1000, true);
      expect((Length.meters.hecto() as Length).valueSI == 100, true);
      expect((Length.meters.deka() as Length).valueSI == 10, true);
      expect((Length.meters.deci() as Length).valueSI == 0.1, true);
      expect(Length.centimeters.valueSI == 0.01, true);
      expect(Length.millimeters.valueSI == 0.001, true);
      expect((Length.meters.micro() as Length).valueSI == 1e-6, true);
      expect(Length.nanometers.valueSI == 1e-9, true);
      expect((Length.meters.pico() as Length).valueSI == 1e-12, true);
      expect((Length.meters.femto() as Length).valueSI == 1e-15, true);
      expect((Length.meters.atto() as Length).valueSI == 1e-18, true);
      expect((Length.meters.zepto() as Length).valueSI == 1e-21, true);
      expect((Length.meters.yocto() as Length).valueSI == 1e-24, true);
    });
  });
}