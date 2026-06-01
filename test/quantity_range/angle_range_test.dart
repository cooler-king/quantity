import 'dart:math' show pi;

import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('AngleRange', () {
    // -----------------------------------------------------------------------
    // Constructors
    // -----------------------------------------------------------------------

    test('default constructor stores start and end angles', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));
      expect(range, isNotNull);
      expect(range.startAngle, Angle(deg: 15));
      expect(range.endAngle, Angle(deg: 70.1));
    });

    test('radians constructor stores start and end angles in radians', () {
      final range = AngleRange.radians(1.72, 1.95);
      expect(range.startAngle.valueSI.toDouble(), 1.72);
      expect(range.endAngle.valueSI.toDouble(), 1.95);

      // reversed (end < start)
      final rev = AngleRange.radians(1.95, 1.72);
      expect(rev.startAngle.valueSI.toDouble(), 1.95);
      expect(rev.endAngle.valueSI.toDouble(), 1.72);
    });

    test('degrees constructor converts to radians correctly', () {
      final range = AngleRange.degrees(90, 180);
      expect(range.startAngle.valueSI.toDouble(), closeTo(pi / 2, 0.0001));
      expect(range.endAngle.valueSI.toDouble(), closeTo(pi, 0.0001));

      // reversed (end < start)
      final rev = AngleRange.degrees(180, 90);
      expect(rev.startAngle.valueSI.toDouble(), closeTo(pi, 0.0001));
      expect(rev.endAngle.valueSI.toDouble(), closeTo(pi / 2, 0.0001));
    });

    // -----------------------------------------------------------------------
    // Endpoint getters
    // -----------------------------------------------------------------------

    test('startAngle and endAngle return q1 and q2 respectively', () {
      var range = AngleRange(Angle(rad: 2.4), Angle(rad: 0.9));
      expect(range.startAngle.valueSI.toDouble(), 2.4);
      expect(range.endAngle.valueSI.toDouble(), 0.9);

      range = AngleRange(Angle(rad: 0.3), Angle(rad: 0.9));
      expect(range.startAngle.valueSI.toDouble(), 0.3);
      expect(range.endAngle.valueSI.toDouble(), 0.9);
    });

    // -----------------------------------------------------------------------
    // Direction
    // -----------------------------------------------------------------------

    test('isClockwise is true when end > start', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));
      expect(range.isClockwise, true);
      expect(range.isCounterclockwise, false);
      expect(range.isAnticlockwise, false);
    });

    test('isCounterclockwise and isAnticlockwise are true when start > end',
        () {
      final range = AngleRange(Angle(deg: 90), Angle(deg: -40));
      expect(range.isClockwise, false);
      expect(range.isCounterclockwise, true);
      expect(range.isAnticlockwise, true);
    });

    // -----------------------------------------------------------------------
    // revolutions
    // -----------------------------------------------------------------------

    test('revolutions is 0 for sub-full-circle clockwise ranges', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));
      expect(range.revolutions, 0);
    });

    test('revolutions is 0 for sub-full-circle counterclockwise ranges', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: -70.1));
      expect(range.revolutions, 0);
    });

    test('revolutions counts complete clockwise turns', () {
      expect(AngleRange(Angle(deg: 15), Angle(deg: 470.1)).revolutions, 1);
      expect(AngleRange(Angle(deg: 0), Angle(deg: 3605)).revolutions, 10);
    });

    test('revolutions counts complete counterclockwise turns as negative', () {
      expect(AngleRange(Angle(deg: 15), Angle(deg: -470.1)).revolutions, -1);
      expect(AngleRange(Angle(deg: 0), Angle(deg: -3605)).revolutions, -10);
    });

    // -----------------------------------------------------------------------
    // isTiny
    // -----------------------------------------------------------------------

    test('isTiny returns true when span is at or below default epsilon', () {
      final tiny = AngleRange.degrees(10.0, 10.0005);
      expect(tiny.isTiny(), true);
    });

    test('isTiny returns false when span exceeds default epsilon', () {
      final wide = AngleRange.degrees(10.0, 11.0);
      expect(wide.isTiny(), false);
    });

    test('isTiny respects a custom epsilon', () {
      final range = AngleRange.degrees(10.0, 10.1);
      expect(range.isTiny(epsilon: Angle(deg: 0.2)), true);
      expect(range.isTiny(epsilon: Angle(deg: 0.05)), false);
    });

    // -----------------------------------------------------------------------
    // delta
    // -----------------------------------------------------------------------

    test('delta reflects signed change from start to end', () {
      final cw = AngleRange(Angle(deg: 10), Angle(deg: 50));
      expect(cw.delta.valueSI.toDouble(),
          closeTo(Angle(deg: 40).valueSI.toDouble(), 1e-10));

      final ccw = AngleRange(Angle(deg: 50), Angle(deg: 10));
      expect(ccw.delta.valueSI.toDouble(),
          closeTo(-Angle(deg: 40).valueSI.toDouble(), 1e-10));
    });

    // -----------------------------------------------------------------------
    // ranges360
    // -----------------------------------------------------------------------

    test('ranges360 returns a single range when entirely within 0-360', () {
      var range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));
      var list = range.ranges360;
      expect(list.length, 1);
      expect(list[0].startAngle == Angle(deg: 15), true);
      expect(list[0].endAngle == Angle(deg: 70.1), true);
    });

    test('ranges360 returns full circle when revolutions > 0', () {
      final range = AngleRange(Angle(deg: 5), Angle(deg: 370));
      final list = range.ranges360;
      expect(list.length, 1);
      expect(list[0].startAngle == Angle(deg: 0), true);
      expect(list[0].endAngle == Angle(deg: 360), true);
    });

    test(
        'ranges360 splits into two sub-ranges when clockwise arc crosses 0 degrees',
        () {
      // -25° to 45° clockwise: projects to [335°,360°] ∪ [0°,45°]
      final range = AngleRange(Angle(deg: -25), Angle(deg: 45));
      final list = range.ranges360;
      expect(list.length, 2);
      expect(list[0].startAngle == Angle(deg: 0), true);
      expect(list[0].endAngle.valueSI.toDouble(),
          closeTo(Angle(deg: 45).valueSI.toDouble(), 0.00001));
      expect(list[1].startAngle.valueSI.toDouble(),
          closeTo(Angle(deg: 335).valueSI.toDouble(), 0.00001));
      expect(list[1].endAngle == Angle(deg: 360), true);
    });

    test(
        'ranges360 splits into two sub-ranges when counterclockwise arc crosses 0 degrees',
        () {
      // 20° to -20° counterclockwise
      final range = AngleRange(Angle(deg: 20), Angle(deg: -20));
      final list = range.ranges360;
      expect(list.length, 2);
    });

    // -----------------------------------------------------------------------
    // contains / contains360
    // -----------------------------------------------------------------------

    test('contains uses direct range comparison without wrapping', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));
      expect(range.contains(Angle(deg: 55)), true);
      expect(range.contains(Angle(deg: 155)), false);

      // endpoints inclusive by default
      expect(range.contains(Angle(deg: 15)), true);
      expect(range.contains(Angle(deg: 70.1)), true);

      // endpoints exclusive when inclusive=false and epsilon=0
      expect(range.contains(Angle(deg: 15), false, 0), false);
      expect(range.contains(Angle(deg: 70.1), false, 0), false);

      // angles outside the direct range are not contained
      expect(range.contains(Angle(deg: 380), false, 0), false);
      expect(range.contains(Angle(deg: -300), false, 0), false);
    });

    test('contains360 wraps angles onto the 0-360 circle before testing', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));

      expect(range.contains360(Angle(deg: 55)), true);
      expect(range.contains360(Angle(deg: 155)), false);
      expect(range.contains360(Angle(deg: 15)), true);
      expect(range.contains360(Angle(deg: 70.1)), true);

      // 380° projects to 20°, which is in [15°, 70.1°]
      expect(range.contains360(Angle(deg: 380)), true);
      // -300° projects to 60°, which is in [15°, 70.1°]
      expect(range.contains360(Angle(deg: -300)), true);
    });

    test('contains360 respects inclusive and epsilon parameters', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 70.1));

      expect(range.contains360(Angle(deg: 15), false, 0), false);
      expect(range.contains360(Angle(deg: 70.1), false, 0), false);

      // 375° projects to 15°; inclusive at endpoint
      expect(range.contains360(Angle(deg: 375), true), true);
      // 430.1° projects to 70.1°; inclusive at endpoint
      expect(range.contains360(Angle(deg: 430.1), true), true);
      expect(range.contains360(Angle(deg: 375), false, 0), false);

      // Just inside epsilon tolerance
      expect(range.contains360(Angle(deg: 430.0000009), false, 0.0), true);
      expect(range.contains360(Angle(deg: 430.1), false, 1.0e-15), true);
      // Just outside
      expect(range.contains360(Angle(deg: 430.1000001), false, 0.0), false);

      expect(range.contains360(Angle(deg: -345), true, 0.0), true);
      expect(range.contains360(Angle(deg: -289.9), true), true);
      // 259.9° → projects to 259.9° which is outside [15°, 70.1°]
      expect(range.contains360(Angle(deg: 259.9), false), false);
    });

    test('contains360 returns true for any angle when revolutions > 0', () {
      final fullCircle = AngleRange(Angle(deg: 0), Angle(deg: 720));
      expect(fullCircle.contains360(Angle(deg: 45)), true);
      expect(fullCircle.contains360(Angle(deg: 200)), true);
    });

    // -----------------------------------------------------------------------
    // overlaps360
    // -----------------------------------------------------------------------

    test('overlaps360 detects direct overlap between two non-wrapping ranges',
        () {
      final r1 = AngleRange(Angle(deg: 10), Angle(deg: 40));
      final r2 = AngleRange(Angle(deg: 20), Angle(deg: 60));
      expect(r1.overlaps360(r2), true);
    });

    test('overlaps360 returns false when non-wrapping ranges do not overlap',
        () {
      final r1 = AngleRange(Angle(deg: 10), Angle(deg: 40));
      final r3 = AngleRange(Angle(deg: 100), Angle(deg: 120));
      expect(r1.overlaps360(r3), false);
    });

    test(
        'overlaps360 detects overlap when first range wraps across 0 degrees and second does not',
        () {
      // 350°→20° wraps; 10°→30° is in the wrapped portion
      final wrap = AngleRange(Angle(deg: 350), Angle(deg: 20));
      final plain = AngleRange(Angle(deg: 10), Angle(deg: 30));
      expect(wrap.overlaps360(plain), true);
      expect(plain.overlaps360(wrap), true); // commutative
    });

    test(
        'overlaps360 detects overlap when second range wraps across 0 degrees and first does not',
        () {
      final plain = AngleRange(Angle(deg: 10), Angle(deg: 30));
      final wrapBeyond = AngleRange(Angle(deg: 350), Angle(deg: 380));
      expect(plain.overlaps360(wrapBeyond), true);
    });

    test('overlaps360 detects overlap when both ranges wrap across 0 degrees',
        () {
      final r1 = AngleRange(Angle(deg: 350), Angle(deg: 370));
      final r2 = AngleRange(Angle(deg: 5), Angle(deg: 15));
      expect(r1.overlaps360(r2), true);
    });

    test(
        'overlaps360 returns false when projections are entirely separate on the circle',
        () {
      final r1 = AngleRange(Angle(deg: 350), Angle(deg: 370));
      final r2 = AngleRange(Angle(deg: 20), Angle(deg: 40));
      expect(r1.overlaps360(r2), false);
    });

    // -----------------------------------------------------------------------
    // deriveRange
    // -----------------------------------------------------------------------

    test('deriveRange scales the range about its center', () {
      // [0°, 90°] center=45° scaled by 2 → [-45°, 135°]
      final ar = AngleRange.degrees(0, 90);
      final scaled = ar.deriveRange(scale: 2.0);
      expect(scaled.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(-45.0, 0.0001));
      expect(scaled.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(135.0, 0.0001));
    });

    test('deriveRange rotates the range by the given number of degrees', () {
      // [0°, 90°] center=45° rotated +30° → center=75° → [30°, 120°]
      final ar = AngleRange.degrees(0, 90);
      final rotated = ar.deriveRange(rotate: 30.0);
      expect(rotated.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(30.0, 0.0001));
      expect(rotated.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(120.0, 0.0001));
    });

    test('deriveRange reverses direction by swapping start and end', () {
      final ar = AngleRange.degrees(0, 90);
      final reversed = ar.deriveRange(reverse: true);
      expect(reversed.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(90.0, 0.0001));
      expect(reversed.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(0.0, 0.0001));
    });

    test('deriveRange with reverse=false leaves the range unchanged', () {
      final ar = AngleRange.degrees(10, 80);
      final same = ar.deriveRange(reverse: false);
      expect(same.startAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(10.0, 0.0001));
      expect(same.endAngle.valueInUnits(Angle.degrees).toDouble(),
          closeTo(80.0, 0.0001));
    });

    // -----------------------------------------------------------------------
    // angleClosestTo
    // -----------------------------------------------------------------------

    test('angleClosestTo returns the angle itself when inside the range', () {
      final range = AngleRange(Angle(deg: 15), Angle(deg: 45));
      final inside = Angle(deg: 30);
      expect(range.angleClosestTo(inside), inside);
    });

    test(
        'angleClosestTo returns the nearest endpoint when angle is outside the range',
        () {
      final ang15 = Angle(deg: 15);
      final ang45 = Angle(deg: 45);
      final range = AngleRange(ang15, ang45);

      // 0° is closer to 15° than to 45°
      expect(range.angleClosestTo(angle0), ang15);
      // 90° is closer to 45° than to 15°
      expect(range.angleClosestTo(angle90), ang45);
      expect(range.angleClosestTo(angle180), ang45);
      expect(range.angleClosestTo(angle270), ang15);
    });

    test(
        'angleClosestTo works correctly for a reversed (counterclockwise) range',
        () {
      final ang15 = Angle(deg: 15);
      final ang45 = Angle(deg: 45);
      final rangeFlip = AngleRange(ang45, ang15);
      expect(rangeFlip.angleClosestTo(angle0), ang15);
      expect(rangeFlip.angleClosestTo(angle90), ang45);
      expect(rangeFlip.angleClosestTo(angle180), ang45);
      expect(rangeFlip.angleClosestTo(angle270), ang15);
    });

    test(
        'angleClosestTo in strict mode uses the raw range ignoring 360 wrapping',
        () {
      // [350°, 390°] strict: 10° is outside the raw range
      final arStrict = AngleRange.degrees(350, 390);
      final result = arStrict.angleClosestTo(Angle(deg: 10), true);
      // Closest endpoint in strict mode is 350° (≈5.934 rad)
      expect(result.valueInUnits(Angle.radians).toDouble(),
          closeTo(5.93412, 0.0001));
    });

    test('angleClosestTo in strict mode returns end endpoint when it is closer',
        () {
      final arStrict = AngleRange.degrees(350, 390); // end = 30°
      final result = arStrict.angleClosestTo(Angle(deg: 420), true);
      expect(
          result.valueInUnits(Angle.degrees).toDouble(), closeTo(30.0, 0.0001));
    });

    // -----------------------------------------------------------------------
    // Equality and hashCode
    // -----------------------------------------------------------------------

    test('equality compares start and end angles', () {
      final a1 = Angle(rad: 1.5);
      final a2 = Angle(deg: 234.5);
      final a3 = Angle(rad: 1.5);
      expect(a1 == a2, false);
      expect(a2 == a3, false);
      expect(a1 == a3, true);
      expect(a3 == a1, true);
    });

    test('hashCode is equal for equal angles, different for unequal angles',
        () {
      final a1 = Angle(rad: 1.5);
      final a2 = Angle(deg: 234.5);
      final a3 = Angle(rad: 1.5);
      expect(a1.hashCode == a2.hashCode, false);
      expect(a2.hashCode == a3.hashCode, false);
      expect(a1.hashCode == a3.hashCode, true);
    });
  });
}
