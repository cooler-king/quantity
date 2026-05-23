import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

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

      const q = MiscQuantity.constant(Double.constant(42.42),
          Dimensions.constant(<String, int>{'Amount': 2}));
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
  });
}
