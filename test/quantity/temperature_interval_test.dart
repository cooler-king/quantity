import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('TemperatureInterval', () {
    test('constructors', () {
      // default ctor, K 0
      TemperatureInterval a = new TemperatureInterval();
      expect(a.valueSI, Integer.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.kelvins);
      expect(a.relativeUncertainty, 0);

      // default ctor, K +
      a = new TemperatureInterval(K: 42);
      expect(a.valueSI?.toDouble() == 42, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.kelvins);
      expect(a.relativeUncertainty, 0);

      // default ctor, K -
      a = new TemperatureInterval(K: -99.33);
      expect(a.valueSI?.toDouble() == -99.33, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.kelvins);
      expect(a.relativeUncertainty, 0);

      // kelvins and degC are equivalent temperature intervals

      // default ctor, degC +
      a = new TemperatureInterval(degC: 100);
      expect(a.valueSI?.toDouble() == 100, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.degreesCelsius);
      expect(a.relativeUncertainty, 0);

      // default ctor, degC -
      a = new TemperatureInterval(degC: -53.4);
      expect(a.valueSI?.toDouble() == -53.4, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.degreesCelsius);
      expect(a.relativeUncertainty, 0);
    });

    test('operator +', () {
      final TemperatureInterval a = new TemperatureInterval(K: 12.34);
      final TemperatureInterval b = new TemperatureInterval(K: 56.78);
      dynamic sum = a + b;
      expect(sum is TemperatureInterval, true);
      expect(sum.valueSI.toDouble(), 69.12);

      final TemperatureInterval c = new TemperatureInterval(degC: 34);
      sum = a + c;
      expect(sum is TemperatureInterval, true);
      expect(sum.valueSI.toDouble(), closeTo(46.34, 0.000001));

      final Temperature d = new Temperature(K: 12.3);
      sum = b + d;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), closeTo(69.08, 0.000001));
    });

    test('operator -', () {
      final TemperatureInterval a = new TemperatureInterval(K: 56.78);
      final TemperatureInterval b = new TemperatureInterval(K: 12.34);
      dynamic diff = a - b;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), 44.44);
      diff = b - a;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), -44.44);

      // Subtracting Temperature from TemperatureInterval unsupported
      final Temperature c = new Temperature(C: 34);
      dynamic exception;
      try {
        diff = a - c;
      } catch (e) {
        exception = e;
      }
      expect(exception is QuantityException, true);
    });
  });
}
