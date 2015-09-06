import 'dart:math' as Math;
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_range.dart';

main() {
  group('AngleRange', () {
    test('constructors', () {
      AngleRange range = new AngleRange(new Angle(deg: 15), new Angle(deg: 70.1));
      expect(range, isNotNull);
    });

    test('endpoint getters', () {
      AngleRange range = new AngleRange(new Angle(rad: 2.4), new Angle(rad: 0.9));
      expect(range.startAngle.valueSI == 2.4, true);
      expect(range.endAngle.valueSI == 0.9, true);

      range = new AngleRange(new Angle(rad: 0.3), new Angle(rad: 0.9));
      expect(range.startAngle.valueSI == 0.3, true);
      expect(range.endAngle.valueSI == 0.9, true);

      range = new AngleRange.degrees(90.0, 180.0);
      expect(range.startAngle.valueSI.toDouble(), closeTo(Math.PI / 2, 0.0001));
      expect(range.endAngle.valueSI.toDouble(), closeTo(Math.PI, 0.0001));

      range = new AngleRange.degrees(180.0, 90.0);
      expect(range.startAngle.valueSI.toDouble(), closeTo(Math.PI, 0.0001));
      expect(range.endAngle.valueSI.toDouble(), closeTo(Math.PI / 2, 0.0001));

      range = new AngleRange.radians(1.72, 1.95);
      expect(range.startAngle.valueSI == 1.72, true);
      expect(range.endAngle.valueSI == 1.95, true);

      range = new AngleRange.radians(1.95, 1.72);
      expect(range.startAngle.valueSI == 1.95, true);
      expect(range.endAngle.valueSI == 1.72, true);
    });

    test('revolutions', () {
      AngleRange range = new AngleRange(new Angle(deg: 15), new Angle(deg: 70.1));
      expect(range.revolutions, 0);

      range = new AngleRange(new Angle(deg: 15), new Angle(deg: 470.1));
      expect(range.revolutions, 1);

      range = new AngleRange(new Angle(deg: 0), new Angle(deg: 3605));
      expect(range.revolutions, 10);

      range = new AngleRange(new Angle(deg: 15), new Angle(deg: -70.1));
      expect(range.revolutions, 0);

      range = new AngleRange(new Angle(deg: 15), new Angle(deg: -470.1));
      expect(range.revolutions, -1);

      range = new AngleRange(new Angle(deg: 0), new Angle(deg: -3605));
      expect(range.revolutions, -10);
    });

    test('clockwise/counterclockwise', () {
      AngleRange range = new AngleRange(new Angle(deg: 15), new Angle(deg: 70.1));
      expect(range.isClockwise, true);
      expect(range.isCounterclockwise, false);
      expect(range.isAnticlockwise, false);

      range = new AngleRange(new Angle(deg: 90), new Angle(deg: -40));
      expect(range.isClockwise, false);
      expect(range.isCounterclockwise, true);
      expect(range.isAnticlockwise, true);
    });

    test('ranges360', () {
      AngleRange range = new AngleRange(new Angle(deg: 15), new Angle(deg: 70.1));
      List<AngleRange> list = range.ranges360;
      expect(list != null, true);
      expect(list.length, 1);
      expect(list[0].startAngle == new Angle(deg: 15), true);
      expect(list[0].endAngle == new Angle(deg: 70.1), true);

      range = new AngleRange(new Angle(deg: 5), new Angle(deg: 370));
      list = range.ranges360;
      expect(list != null, true);
      expect(list.length, 1);
      expect(list[0].startAngle == new Angle(deg: 0), true);
      expect(list[0].endAngle == new Angle(deg: 360), true);

      range = new AngleRange(new Angle(deg: -25), new Angle(deg: 45));
      list = range.ranges360;
      print(list[0]);
      print(list[1]);
      expect(list != null, true);
      expect(list.length, 2);
      expect(list[0].startAngle == new Angle(deg: 0), true);
      expect(list[0].endAngle.valueSI.toDouble(), closeTo(new Angle(deg: 45).valueSI.toDouble(), 0.00001));
      expect(list[1].startAngle.valueSI.toDouble(), closeTo(new Angle(deg: 335).valueSI.toDouble(), 0.00001));
      expect(list[1].endAngle == new Angle(deg: 360), true);
    });

    test('contains/contains360', () {
      AngleRange range = new AngleRange(new Angle(deg: 15), new Angle(deg: 70.1));
      expect(range.contains(new Angle(deg: 55)), true);
      expect(range.contains(new Angle(deg: 155)), false);
      expect(range.contains(new Angle(deg: 15)), true);
      expect(range.contains(new Angle(deg: 70.1)), true);
      expect(range.contains(new Angle(deg: 15), false, 0.0), false);
      expect(range.contains(new Angle(deg: 70.1), false, 0.0), false);
      expect(range.contains(new Angle(deg: 380), false, 0.0), false);
      expect(range.contains(new Angle(deg: -300), false, 0.0), false);

      expect(range.contains360(new Angle(deg: 55)), true);
      expect(range.contains360(new Angle(deg: 155)), false);
      expect(range.contains360(new Angle(deg: 15)), true);
      expect(range.contains360(new Angle(deg: 70.1)), true);
      expect(range.contains360(new Angle(deg: 15), false, 0.0), false);
      expect(range.contains360(new Angle(deg: 70.1), false, 0.0), false);
      expect(range.contains360(new Angle(deg: 380)), true);
      expect(range.contains360(new Angle(deg: -300)), true);
      print("Inclusive angle range********");
      print(range.minValue.mks);
      print(new Angle(deg: 375).mks);
      expect(range.contains360(new Angle(deg: 375), true), true);
      expect(range.contains360(new Angle(deg: 430.1), true), true);
      expect(range.contains360(new Angle(deg: 375), false, 0.0), false);
      //TODO see issue #4 expect(range.contains360(new Angle(deg: 430.1), false, 0.0), false);
      expect(range.contains360(new Angle(deg: 430.1), false, 1.0e-9), true);
      //TODO issue #4 expect(range.contains360(new Angle(deg: -345), false, 0.0), false);
      expect(range.contains360(new Angle(deg: 259.9), false), false);
      expect(range.contains360(new Angle(deg: -345), true, 0.0), true);
      expect(range.contains360(new Angle(deg: -289.9), true), true);
    });
  });
}
