import 'dart:math' as Math;
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Quantity Library', () {
    test('createTypedQuantityInstance', () {
      Quantity q = createTypedQuantityInstance(Length, 5.6, Length.meters);
      expect(q is Length, true);
      expect(q.valueSI is Double, true);
      expect(q.valueSI.toDouble(), 5.6);
      expect(q.preferredUnits, Length.meters);
      expect(q.relativeUncertainty, 0.0);

      // non-default units
      q = createTypedQuantityInstance(Length, 12.34567, Length.kilometers);
      expect(q is Length, true);
      expect(q.valueSI is Double, true);
      expect(q.valueSI.toDouble(), 12345.67);
      expect(q.preferredUnits, Length.kilometers);
      expect(q.relativeUncertainty, 0.0);

      // null units
      q = createTypedQuantityInstance(Length, 9.876, null);
      expect(q is Length, true);
      expect(q.valueSI is Double, true);
      expect(q.valueSI.toDouble(), 9.876);
      expect(q.preferredUnits, Length.meters);
      expect(q.relativeUncertainty, 0.0);

      // null value & units
      q = createTypedQuantityInstance(Length, null, null);
      expect(q is Length, true);
      expect(q.valueSI, Double.zero);
      expect(q.preferredUnits, Length.meters);
      expect(q.relativeUncertainty, 0.0);

      // uncertainty
      q = createTypedQuantityInstance(Length, 23.45, Length.meters, 0.015);
      expect(q is Length, true);
      expect(q.valueSI.toDouble(), 23.45);
      expect(q.preferredUnits, Length.meters);
      expect(q.relativeUncertainty, 0.015);

      // types
      expect(createTypedQuantityInstance(Mass, 1.1, null) is Mass, true);
      expect(createTypedQuantityInstance(Time, 1.1, null) is Time, true);
      expect(createTypedQuantityInstance(TemperatureInterval, 1.1, null) is TemperatureInterval, true);
      expect(createTypedQuantityInstance(AmountOfSubstance, 1.1, null) is AmountOfSubstance, true);
      expect(createTypedQuantityInstance(Current, 1.1, null) is Current, true);
      expect(
          createTypedQuantityInstance(LuminousIntensity, 1.1, LuminousIntensity.candelas) is LuminousIntensity, true);

      expect(createTypedQuantityInstance(Scalar, 1.1, null) is Scalar, true);
      expect(createTypedQuantityInstance(Angle, 1.1, Angle.degrees, 13.2) is Angle, true);
      expect(createTypedQuantityInstance(SolidAngle, 1.1, null) is SolidAngle, true);

      Math.Random random = new Math.Random();
      for (Type t in allQuantityTypes) {
        try {
          Quantity q = createTypedQuantityInstance(t, 1.1, null, random.nextDouble() * 10.0);
          expect(q != null, true);
          expect(q.runtimeType == t, true);
        } catch (err) {
          expect(err == null, true);
        }
      }
    });

    test('areWithin', () {
      Scalar s1 = new Scalar(value: 7.11);
      Scalar s2 = new Scalar(value: 9.45);
      expect(areWithin(s1, s2, new Scalar(value: 3)), true);
      expect(areWithin(s1, s2, new Scalar(value: 2)), false);
      expect(areWithin(s1, s2, new Scalar(value: 2.341)), true);
      expect(areWithin(s1, s2, new Scalar(value: 2.339)), false);
      expect(areWithin(s1, s2, new Scalar(value: 2.34)), true);
    });
  });
}
