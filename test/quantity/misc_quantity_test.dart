import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('MiscQuantity', () {
    test('constructors', () {
      // no-args
      var mq = MiscQuantity();
      expect(mq, isNotNull);
      expect(mq.valueSI, isNotNull);
      expect(mq.valueSI.toDouble(), 0.0);
      expect(mq.dimensions, isNotNull);
      expect(mq.dimensions, Scalar.scalarDimensions);
      expect(mq.relativeUncertainty, 0.0);
      expect(mq.preferredUnits, isNull);

      // int value only
      mq = MiscQuantity(42);
      expect(mq, isNotNull);
      expect(mq.valueSI is Integer, true);
      expect(mq.valueSI.toDouble(), 42.0);
      expect(mq.dimensions, isNotNull);
      expect(mq.dimensions, Scalar.scalarDimensions);
      expect(mq.relativeUncertainty, 0.0);
      expect(mq.preferredUnits, isNull);

      // double value only
      mq = MiscQuantity(42.42);
      expect(mq, isNotNull);
      expect(mq.valueSI is Double, true);
      expect(mq.valueSI.toDouble(), 42.42);
      expect(mq.dimensions, isNotNull);
      expect(mq.dimensions, Scalar.scalarDimensions);
      expect(mq.relativeUncertainty, 0.0);
      expect(mq.preferredUnits, isNull);

      // Number (Integer) value only
      mq = MiscQuantity(Integer(56));
      expect(mq, isNotNull);
      expect(mq.valueSI is Integer, true);
      expect(mq.valueSI.toDouble(), 56.0);
      expect(mq.dimensions, isNotNull);
      expect(mq.dimensions, Scalar.scalarDimensions);
      expect(mq.relativeUncertainty, 0.0);
      expect(mq.preferredUnits, isNull);

      // Number (Double) value only
      mq = MiscQuantity(Double(67.89));
      expect(mq, isNotNull);
      expect(mq.valueSI is Double, true);
      expect(mq.valueSI.toDouble(), 67.89);
      expect(mq.dimensions, isNotNull);
      expect(mq.dimensions, Scalar.scalarDimensions);
      expect(mq.relativeUncertainty, 0.0);
      expect(mq.preferredUnits, isNull);

      // with Dimensions
      mq = MiscQuantity(42.42, Angle.angleDimensions);
      expect(mq, isNotNull);
      expect(mq.dimensions, isNotNull);
      expect(mq.dimensions, Angle.angleDimensions);

      final q = MiscQuantity.constant(
          Double(42.42), Dimensions.constant(<String, int>{'Amount': 2}));
      expect(q, isNotNull);
    });

    test('getValue', () {
      final mq = MiscQuantity(5.0, Length.lengthDimensions);
      expect(mq.getValue(Length.meters).toDouble(), 5.0);

      expect(
          () => mq.getValue(Time.seconds), throwsA(isA<DimensionsException>()));
    });

    test('toTypedQuantity', () {
      final mq = MiscQuantity(10.0, Length.lengthDimensions);
      final typed = mq.toTypedQuantity();
      expect(typed is Length, true);
      expect(typed.valueSI.toDouble(), 10.0);
    });

    test('Quantity base class methods and exceptions', () {
      final l = Length(m: 10, uncert: 0.01);
      final t = Time(s: 5);

      // Subtraction exception: mismatched dimensions
      expect(() => l - t, throwsA(isA<DimensionsException>()));

      // Subtraction exception: subtracting num/Number from non-scalar
      expect(() => l - 5, throwsA(isA<QuantityException>()));

      // arbitraryPrecision getter
      final lPrecise = Length(m: Precise('10.5'));
      expect(lPrecise.arbitraryPrecision, true);
      expect(l.arbitraryPrecision, false);

      // isScalarSI getter
      expect(Scalar(value: 5).isScalarSI, true);
      expect(l.isScalarSI, false);

      // Exponent raising: Number and Scalar
      final lSquared = l ^ Integer(2);
      expect(lSquared.dimensions, Area.areaDimensions);

      final lCubed = l ^ Scalar(value: 3);
      expect(Dimensions.describe(lCubed.dimensions), contains('Length^3'));

      // outputText formatting on MiscQuantity (null preferredUnits) with uncertainty
      final mq = MiscQuantity(10.0, Length.lengthDimensions, 0.02);
      final mqString = mq.toString();
      expect(mqString, contains('MKS'));

      // Formatting without symbols (singular vs plural names)
      final buffer1 = StringBuffer();
      Length(m: 1.0).outputText(buffer1, symbols: false);
      expect(buffer1.toString(), '1 meter');

      final buffer2 = StringBuffer();
      Length(m: 5.0).outputText(buffer2, symbols: false);
      expect(buffer2.toString(), '5 meters');

      // valueInUnits tests
      expect(l.valueInUnits(null), l.mks);
      expect(() => l.valueInUnits(Time.seconds),
          throwsA(isA<DimensionsException>()));

      // dynamicQuantityTyping = false math operations
      dynamicQuantityTyping = false;
      final sum = l + l;
      expect(sum is MiscQuantity, true);
      expect(sum.valueSI.toDouble(), 20.0);

      final diff = l - l;
      expect(diff is MiscQuantity, true);
      expect(diff.valueSI.toDouble(), 0.0);

      final prod = l * 2.0;
      expect(prod is MiscQuantity, true);
      expect(prod.valueSI.toDouble(), 20.0);
      dynamicQuantityTyping = true; // reset

      // fromJson fallback
      final mqFallback = Quantity.fromJson({
        'type': 'NonExistentQuantityType',
        'value': {'d': 42.0},
        'dimensions': {'Length': 1},
        'uncertainty': 0.0
      });
      expect(mqFallback is MiscQuantity, true);
      expect(mqFallback.valueSI.toDouble(), 42.0);
    });
  });
}
