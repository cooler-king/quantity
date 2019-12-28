import 'package:quantity/quantity_si.dart';
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart';

void main() {
  group('mutable quantity', () {
    test('construct', () {
      final MutableQuantity mq = new MutableQuantity();
      expect(mq.mks.toDouble(), 0);
      expect(mq.dimensions, Scalar.scalarDimensions);
      expect(mq.relativeUncertainty, 0.0);

      final MutableQuantity mq2 = new MutableQuantity(new Double(177.32), Mass.massDimensions, 0.001);
      expect(mq2.mks.toDouble(), 177.32);
      expect(mq2.dimensions, Mass.massDimensions);
      expect(mq2.relativeUncertainty, 0.001);

      final Mass m = new Mass(g: 27.2, uncert: 0.002);
      final MutableQuantity mq3 = new MutableQuantity.from(m);
      expect(mq3.mks.toDouble(), 0.0272);
      expect(mq3.dimensions, Mass.massDimensions);
      expect(mq3.relativeUncertainty, 0.002);
      expect(mq3.preferredUnits, Mass.grams);
    });

    test('dynamic value, dimsension and uncertainty', () {
      final MutableQuantity mq = new MutableQuantity(new Double(21.45), Length.lengthDimensions, 0.0004);
      expect(mq.mks.toDouble(), 21.45);
      expect(mq.dimensions, Length.lengthDimensions);
      expect(mq.relativeUncertainty, 0.0004);

      mq.mks = new Double(1234.5);
      expect(mq.mks.toDouble(), 1234.5);
      expect(mq.dimensions, Length.lengthDimensions);
      expect(mq.relativeUncertainty, 0.0004);

      mq.dimensions = Luminance.luminanceDimensions;
      expect(mq.mks.toDouble(), 1234.5);
      expect(mq.dimensions, Luminance.luminanceDimensions);
      expect(mq.relativeUncertainty, 0.0004);

      mq.relativeUncertainty = 0.0908;
      expect(mq.mks.toDouble(), 1234.5);
      expect(mq.dimensions, Luminance.luminanceDimensions);
      expect(mq.relativeUncertainty, 0.0908);

      mq.setEqualTo(new TemperatureInterval(K: 1055.66, uncert: 0.00432));
      expect(mq.mks.toDouble(), 1055.66);
      expect(mq.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(mq.relativeUncertainty, 0.00432);

      mq.setValueInUnits(82.39, Temperature.degreesCelsius);
      expect(mq.mks.toDouble(), closeTo(355.54, 0.000000001));
      expect(mq.dimensions, Temperature.temperatureDimensions);
      expect(mq.relativeUncertainty, 0.00432);
    });

    test('change events', () async {
      // setEqualTo.
      final MutableQuantity mq1 = new MutableQuantity(new Double(21.45), Length.lengthDimensions, 0.0004);
      mq1.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 88.54);
        expect(q.dimensions, Luminance.luminanceDimensions);
        expect(q.relativeUncertainty, 0.0101);
      }));
      mq1.setEqualTo(new Luminance(candelasPerSquareMeter: 88.54, uncert: 0.0101));

      // Set mks.
      final MutableQuantity mq2 = new MutableQuantity(new Double(15.3), Mass.massDimensions, 0.007);
      mq2.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 65.43);
        expect(q.dimensions, Mass.massDimensions);
        expect(q.relativeUncertainty, 0.007);
      }));
      mq2.mks = new Double(65.43);

      // Set relative uncertainty.
      final MutableQuantity mq3 = new MutableQuantity(new Double(1.3), Mass.massDimensions, 0.004);
      mq3.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 1.3);
        expect(q.dimensions, Mass.massDimensions);
        expect(q.relativeUncertainty, 0.01010101);
      }));
      mq3.relativeUncertainty = .01010101;

      // Set standard uncertainty.
      final MutableQuantity mq3b = new MutableQuantity(new Double(1.4), Mass.massDimensions, 0.005);
      mq3b.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 1.4);
        expect(q.dimensions, Mass.massDimensions);
        expect(q.standardUncertainty.mks.toDouble(), 0.000001);
      }));
      mq3b.standardUncertainty = new Mass(kg: 0.000001);

      // setValueInUnits.
      final MutableQuantity mq4 = new MutableQuantity(new Double(1.3), Time.timeDimensions, 0.876);
      mq4.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), closeTo(0.07799, 0.0000000001));
        expect(q.dimensions, Time.timeDimensions);
        expect(q.relativeUncertainty, 0.876);
      }));
      mq4.setValueInUnits(77.99, Time.milliseconds);

      // set valueSI.
      final MutableQuantity mq5 = new MutableQuantity(new Double(12.3), Luminance.luminanceDimensions, 0.212);
      mq5.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 17.76);
        expect(q.dimensions, Luminance.luminanceDimensions);
        expect(q.relativeUncertainty, 0.212);
      }));
      mq5.valueSI = new Double(17.76);

      // abs().
      final MutableQuantity mq6 = new MutableQuantity(new Double(-99.876), Energy.energyDimensions);
      mq6.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 99.876);
        expect(q.dimensions, Energy.energyDimensions);
        expect(q.relativeUncertainty, 0.0);
      }));
      mq6.abs();

      // set cgs.
      final MutableQuantity mq7 = new MutableQuantity(new Double(42.24), Length.lengthDimensions);
      mq7.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 10.001);
        expect(q.dimensions, Length.lengthDimensions);
        expect(q.relativeUncertainty, 0.0);
      }));
      mq7.cgs = new Double(1000.1);

      // invert().
      final MutableQuantity mq8 = new MutableQuantity(new Double(1000), Frequency.frequencyDimensions);
      mq8.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 0.001);
        expect(q.dimensions, Time.timeDimensions);
        expect(q.relativeUncertainty, 0.0);
      }));
      mq8.invert();

      // set dimensions.
      final MutableQuantity mq9 = new MutableQuantity(new Double(8.76), Frequency.frequencyDimensions);
      mq9.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), 8.76);
        expect(q.dimensions, Acceleration.accelerationDimensions);
        expect(q.relativeUncertainty, 0.0);
      }));
      mq9.dimensions = Acceleration.accelerationDimensions;

      // negate.
      final MutableQuantity mq10 = new MutableQuantity(new Double(79.26), Mass.massDimensions);
      mq10.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), -79.26);
        expect(q.dimensions, Mass.massDimensions);
        expect(q.relativeUncertainty, 0.0);
      }));
      // ignore: unnecessary_statements
      -mq10;

      // Multiple events.
      final MutableQuantity mq11 = new MutableQuantity(new Double(8.76), Frequency.frequencyDimensions);
      mq11.onChange.listen(expectAsync1((Quantity q) {
        expect(q.mks.toDouble(), lessThan(10));
      }, count: 4));
      mq11
        ..mks = new Integer(2)
        ..mks = new Integer(4)
        ..mks = new Integer(6)
        ..mks = new Integer(8);
    });

    test('snapshot', () {
      final MutableQuantity mq = new MutableQuantity(new Double(21.45), Length.lengthDimensions, 0.0004);
      final Quantity q = mq.snapshot;
      expect(q is Length, true);
      expect(q.mks.toDouble(), 21.45);
      expect(q.dimensions, Length.lengthDimensions);
      expect(q.relativeUncertainty, 0.0004);

      final MutableQuantity mq2 = new MutableQuantity(
          new Double(11.32),
          new Dimensions.fromMap(<String, int>{
            'Length': 7,
            'Time': -12,
          }),
          0.005);
      final Quantity q2 = mq2.snapshot;
      expect(q2 is MiscQuantity, true);
      expect(q2.mks.toDouble(), 11.32);
      expect(q2.dimensions.getComponentExponent('Length'), 7);
      expect(q2.dimensions.getComponentExponent('Time'), -12);
      expect(q2.relativeUncertainty, 0.005);

      final MutableQuantity mq3 = new MutableQuantity(new Double(123.321));
      final Quantity q3 = mq3.snapshot;
      expect(q3 is Scalar, true);
      expect(q3.mks.toDouble(), 123.321);
      expect(q3.dimensions, Scalar.scalarDimensions);
      expect(q3.relativeUncertainty, 0.0);
    });

    test('inverse', () {
      final MutableQuantity mq = new MutableQuantity(new Double(1000), Frequency.frequencyDimensions);
      final Quantity q = mq.inverse();
      expect(q is Time, true);
      expect(q.mks.toDouble(), 0.001);
      expect(q.dimensions, Time.timeDimensions);
    });

    test('dynamic mutability', () {
      final MutableQuantity mq = new MutableQuantity(new Double(1.1), Mass.massDimensions)..mks = new Integer(77);
      expect(mq.mks.toDouble(), 77.0);

      mq.mutable = false;
      expect(() => mq.mks = new Integer(99), throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.cgs = new Integer(98), throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.valueSI = new Integer(97), throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.setValueInUnits(1, Mass.grams), throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.setEqualTo(new Mass(u: 12.0)), throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.relativeUncertainty = 0.000004, throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.standardUncertainty = new Mass(g: 0.1), throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => mq.dimensions = Time.timeDimensions, throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(mq.invert, throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(mq.abs, throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(() => -mq, throwsA(const TypeMatcher<ImmutableQuantityException>()));
      expect(mq.inverse, returnsNormally);

      mq.mutable = true;
      expect(() => mq.mks = new Integer(99), returnsNormally);
      expect(() => mq.cgs = new Integer(98), returnsNormally);
      expect(() => mq.valueSI = new Integer(97), returnsNormally);
      expect(() => mq.setValueInUnits(1, Mass.grams), returnsNormally);
      expect(() => mq.setEqualTo(new Mass(u: 12.0)), returnsNormally);
      expect(() => mq.relativeUncertainty = 0.000004, returnsNormally);
      expect(() => mq.standardUncertainty = new Mass(g: 0.1), returnsNormally);
      expect(() => mq.dimensions = Time.timeDimensions, returnsNormally);
      expect(mq.invert, returnsNormally);
      expect(mq.abs, returnsNormally);
      expect(() => -mq, returnsNormally);
      expect(mq.inverse, returnsNormally);
    });

    test('dimension exceptions', () {
      final MutableQuantity mq = new MutableQuantity(new Double(1.1), Length.lengthDimensions)..mks = new Integer(77);
      expect(() => mq.standardUncertainty = new Mass(g: 0.1), throwsA(const TypeMatcher<DimensionsException>()));
      expect(() => mq.setValueInUnits(34, Time.days), throwsA(const TypeMatcher<DimensionsException>()));
    });
  });
}
