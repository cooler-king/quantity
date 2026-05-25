import 'dart:math';

import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('angle ext', () {
    test('common angles', () {
      expect(angle0.valueInUnits(Angle.degrees).toDouble(), 0.0);
      expect(angle30.valueInUnits(Angle.degrees).toDouble(), 30.0);
      expect(angle45.valueInUnits(Angle.degrees).toDouble(), 45.0);
      expect(angle60.valueInUnits(Angle.degrees).toDouble(), 60.0);
      expect(angle90.valueInUnits(Angle.degrees).toDouble(), 90.0);
      expect(angle180.valueInUnits(Angle.degrees).toDouble(), 180.0);
      expect(angle270.valueInUnits(Angle.degrees).toDouble(), 270.0);
      expect(angle360.valueInUnits(Angle.degrees).toDouble(), 360.0);
      expect(anglePi, angle180);
      expect(angleTau, angle360);
    });

    test('trig functions and conversions', () {
      final a45 = Angle(deg: 45.0);
      expect(cosecant(a45), closeTo(1.41421356, 0.0001));
      expect(secant(a45), closeTo(1.41421356, 0.0001));
      expect(cotangent(a45), closeTo(1.0, 0.0001));

      expect(degToRad(180), closeTo(pi, 0.0001));
      expect(radToDeg(pi), closeTo(180.0, 0.0001));
    });

    test('trig constants', () {
      expect(sin0, 0.0);
      expect(sin30, 0.5);
      expect(sin45, closeTo(0.70710678, 0.0001));
      expect(sin60, closeTo(0.8660254, 0.0001));
      expect(sin90, 1.0);

      expect(cos0, 1.0);
      expect(cos30, closeTo(0.8660254, 0.0001));
      expect(cos45, closeTo(0.70710678, 0.0001));
      expect(cos60, 0.5);
      expect(cos90, 0.0);

      expect(tan0, 0.0);
      expect(tan30, closeTo(0.577350269, 0.0001));
      expect(tan45, 1.0);
      expect(tan60, closeTo(1.7320508, 0.0001));
    });

    test('alternative units', () {
      expect(milliradian, isA<AngleUnits>());
      expect(rad, radians);
      expect(deg, degrees);
      expect(grads, isA<AngleUnits>());
      expect(grades, grads);
      expect(gons, grads);
      expect(angularMils, isA<AngleUnits>());
      expect(revolutions, isA<AngleUnits>());
      expect(cycles, revolutions);
      expect(circles, revolutions);
      expect(semicircles, isA<AngleUnits>());
      expect(quadrants, isA<AngleUnits>());
      expect(signs, isA<AngleUnits>());
      expect(hoursTime, isA<AngleUnits>());
      expect(minutesTime, isA<AngleUnits>());
      expect(secondsTime, isA<AngleUnits>());
      expect(tau, twoPi);
    });

    test('alternative construction', () {
      final a = angleFromHourMinSec(12, 0, 0);
      expect(a.valueInUnits(Angle.degrees).toDouble(), closeTo(180.0, 0.0001));
    });
  });
}
