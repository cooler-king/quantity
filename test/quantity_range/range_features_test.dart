import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('QuantityRange', () {
    test('basic properties and constructors', () {
      final r = QuantityRange<Length>(Length(m: 10.0), Length(m: 20.0));
      expect(r.q1.valueSI.toDouble(), 10.0);
      expect(r.q2.valueSI.toDouble(), 20.0);
      expect(r.minValue.valueSI.toDouble(), 10.0);
      expect(r.maxValue.valueSI.toDouble(), 20.0);
      expect(r.centerValue.valueSI.toDouble(), 15.0);
      expect(r.span.valueSI.toDouble(), 10.0);
      expect(r.delta.valueSI.toDouble(), 10.0);
      expect(r.toString(), '10 m to 20 m');

      // reverse range
      final r2 = QuantityRange<Length>(Length(m: 25.0), Length(m: 15.0));
      expect(r2.minValue.valueSI.toDouble(), 15.0);
      expect(r2.maxValue.valueSI.toDouble(), 25.0);
      expect(r2.span.valueSI.toDouble(), 10.0);
      expect(r2.delta.valueSI.toDouble(), -10.0);
    });

    test('uncertaintyRangeForQuantity', () {
      final len = Length(m: 100.0, uncert: 0.05); // standard uncertainty = 5.0

      final r1 = uncertaintyRangeForQuantity(len);
      expect(r1.q1.valueSI.toDouble(), 95.0);
      expect(r1.q2.valueSI.toDouble(), 105.0);

      final r2 = uncertaintyRangeForQuantity(len, k: 2.0);
      expect(r2.q1.valueSI.toDouble(), 90.0);
      expect(r2.q2.valueSI.toDouble(), 110.0);
    });

    test('overlaps and encompasses', () {
      final rBase = QuantityRange<Length>(Length(m: 10.0), Length(m: 20.0));
      final rOverlap = QuantityRange<Length>(Length(m: 15.0), Length(m: 25.0));
      final rNoOverlap =
          QuantityRange<Length>(Length(m: 21.0), Length(m: 30.0));
      final rEncompassed =
          QuantityRange<Length>(Length(m: 12.0), Length(m: 18.0));

      expect(rBase.overlaps(rOverlap), true);
      expect(rOverlap.overlaps(rBase), true);
      expect(rBase.overlaps(rNoOverlap), false);
      expect(rBase.overlaps(rEncompassed), true);

      expect(rBase.encompasses(rEncompassed), true);
      expect(rBase.encompasses(rOverlap), false);
    });

    test('contains', () {
      final r = QuantityRange<Length>(Length(m: 10.0), Length(m: 20.0));
      expect(r.contains(Length(m: 15.0)), true);
      expect(r.contains(Length(m: 10.0)), true);
      expect(r.contains(Length(m: 20.0)), true);

      // non-inclusive
      expect(r.contains(Length(m: 10.0), false),
          true); // because of epsilon tolerance
      expect(r.contains(Length(m: 10.0), false, 0.0), false);
      expect(r.contains(Length(m: 15.0), false, 0.0), true);

      // out of bounds
      expect(r.contains(Length(m: 5.0)), false);
      expect(r.contains(Length(m: 25.0)), false);

      // reversed range contains
      final rRev = QuantityRange<Length>(Length(m: 20.0), Length(m: 10.0));
      expect(rRev.contains(Length(m: 15.0)), true);
      expect(rRev.contains(Length(m: 10.0), false, 0.0), false);
      expect(rRev.contains(Length(m: 15.0), false, 0.1), true);
    });

    test('equality and hashcode', () {
      final r1 = QuantityRange<Length>(Length(m: 10.0), Length(m: 20.0));
      final r2 = QuantityRange<Length>(Length(m: 10.0), Length(m: 20.0));
      final r3 = QuantityRange<Length>(Length(m: 10.0), Length(m: 21.0));

      expect(r1 == r2, true);
      expect(r1 == r3, false);
      expect(r1 == Object(), false);
      expect(r1.hashCode, r2.hashCode);
    });
  });

  group('AngleRange', () {
    test('constructors and basic getters', () {
      final ar1 = AngleRange.radians(0.5, 1.5);
      expect(ar1.startAngle.valueSI.toDouble(), 0.5);
      expect(ar1.endAngle.valueSI.toDouble(), 1.5);
      expect(ar1.isClockwise, true);
      expect(ar1.isCounterclockwise, false);

      final ar2 = AngleRange.degrees(90.0, 45.0);
      expect(ar2.startAngle.valueSI.toDouble(), closeTo(1.570796, 0.0001));
      expect(ar2.isClockwise, false);
      expect(ar2.isCounterclockwise, true);
      expect(ar2.isAnticlockwise, true);
    });

    test('isTiny', () {
      final arNormal = AngleRange.degrees(10.0, 10.0005);
      expect(arNormal.isTiny(), true);

      final arWide = AngleRange.degrees(10.0, 11.0);
      expect(arWide.isTiny(), false);

      final arCustom = AngleRange.degrees(10.0, 10.1);
      expect(arCustom.isTiny(epsilon: Angle(deg: 0.2)), true);
    });

    test('revolutions and delta', () {
      final ar1 = AngleRange.radians(0.0, 7.0); // 7.0 rad is > 2*pi
      expect(ar1.revolutions, 1);
      expect(ar1.delta.valueSI.toDouble(), 7.0);

      final ar2 = AngleRange.radians(7.0, 0.0);
      expect(ar2.revolutions, -1);
    });

    test('overlaps360', () {
      final ar1 = AngleRange.degrees(0, 90);
      final ar2 = AngleRange.degrees(45, 135);
      expect(ar1.overlaps360(ar2), true);

      // cross 0 projection overlap
      final ar3 = AngleRange.degrees(350, 20); // starts at 350, ends at 20
      final ar4 = AngleRange.degrees(10, 30);
      expect(ar3.overlaps360(ar4), true);
      expect(ar4.overlaps360(ar3), true);

      // cross 0 projection where direct overlaps is false but list2 splits
      final ar9 = AngleRange.degrees(10, 30);
      final ar10 = AngleRange.degrees(350, 380);
      expect(ar9.overlaps360(ar10), true);

      // test where direct overlap is false but projection overlap is true
      final ar5 = AngleRange.degrees(350, 370);
      final ar6 = AngleRange.degrees(5, 15);
      expect(ar5.overlaps360(ar6), true);

      // test where they do not overlap at all (neither direct nor projection)
      final ar7 = AngleRange.degrees(350, 370);
      final ar8 = AngleRange.degrees(20, 40);
      expect(ar7.overlaps360(ar8), false);
    });

    test('deriveRange', () {
      final ar = AngleRange.degrees(0, 90); // center is 45

      // scale by 2.0 (span 90 becomes 180, centered on 45 => -45 to 135)
      final scaled = ar.deriveRange(scale: 2.0);
      expect(scaled.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(-45.0, 0.0001));
      expect(scaled.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(135.0, 0.0001));

      // rotate by 30 degrees (center becomes 75 => 30 to 120)
      final rotated = ar.deriveRange(rotate: 30.0);
      expect(rotated.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(30.0, 0.0001));
      expect(rotated.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(120.0, 0.0001));

      // reverse
      final reversed = ar.deriveRange(reverse: true);
      expect(reversed.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(90.0, 0.0001));
      expect(reversed.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(0.0, 0.0001));
    });

    test('ranges360', () {
      // revolutions > 0
      final ar1 = AngleRange.degrees(0, 720);
      expect(ar1.ranges360.length, 1);
      expect(ar1.ranges360.first.startAngle.valueSI.toDouble(), 0.0);

      // normal clockwise cross 360
      final ar2 = AngleRange.degrees(340, 380); // end is > 360
      final list2 = ar2.ranges360;
      expect(list2.length, 2);

      // counterclockwise
      final ar3 = AngleRange.degrees(20, -20);
      final list3 = ar3.ranges360;
      expect(list3.length, 2);
    });

    test('contains360', () {
      final ar = AngleRange.degrees(350, 410); // spans 350 to 50
      expect(ar.contains360(Angle(deg: 355)), true);
      expect(ar.contains360(Angle(deg: 10)), true);
      expect(ar.contains360(Angle(deg: 180)), false);
    });

    test('angleClosestTo', () {
      final ar = AngleRange.degrees(10, 50);

      // inside
      expect(
          ar
              .angleClosestTo(Angle(deg: 30))
              .valueInUnits(Angle.degrees)
              .toDouble(),
          closeTo(30.0, 0.0001));

      // outside, closest to 10
      expect(
          ar
              .angleClosestTo(Angle(deg: 5))
              .valueInUnits(Angle.degrees)
              .toDouble(),
          closeTo(10.0, 0.0001));

      // outside, closest to 50
      expect(
          ar
              .angleClosestTo(Angle(deg: 60))
              .valueInUnits(Angle.degrees)
              .toDouble(),
          closeTo(50.0, 0.0001));

      // strict
      final arStrict = AngleRange.degrees(350, 390); // 350 to 30
      // 10 degrees is inside nominal 360 range, but outside strict range 350-390
      expect(
          arStrict
              .angleClosestTo(Angle(deg: 10), true)
              .valueInUnits(Angle.radians)
              .toDouble(),
          closeTo(5.93412, 0.0001));

      // test where deltaEndRad is closer than deltaStartRad (strict = true)
      expect(
          arStrict
              .angleClosestTo(Angle(deg: 420), true)
              .valueInUnits(Angle.degrees)
              .toDouble(),
          closeTo(30.0, 0.0001));
    });
  });
}
