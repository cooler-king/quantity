import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

main() {
  group('TemperatureInterval', () {
    test('constructors', () {
      // default ctor, K 0
      var a = new TemperatureInterval();
      expect(a.valueSI, Integer.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.kelvins);
      expect(a.relativeUncertainty, 0);

      // default ctor, K +
      a = new TemperatureInterval(K: 42);
      expect(a.valueSI == 42, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.kelvins);
      expect(a.relativeUncertainty, 0);

      // default ctor, K -
      a = new TemperatureInterval(K: -99.33);
      expect(a.valueSI == -99.33, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.kelvins);
      expect(a.relativeUncertainty, 0);

      // kelvins and degC are equivalent temperature intervals

      // default ctor, degC +
      a = new TemperatureInterval(degC: 100);
      expect(a.valueSI == 100, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.degreesCelsius);
      expect(a.relativeUncertainty, 0);

      // default ctor, degC -
      a = new TemperatureInterval(degC: -53.4);
      expect(a.valueSI == -53.4, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, TemperatureInterval.temperatureIntervalDimensions);
      expect(a.preferredUnits, TemperatureInterval.degreesCelsius);
      expect(a.relativeUncertainty, 0);
    });

    test('operator +', () {
      var a = new TemperatureInterval(K: 12.34);
      var b = new TemperatureInterval(K: 56.78);
      var sum = a + b;
      expect(sum is TemperatureInterval, true);
      expect(sum.valueSI.toDouble(), 69.12);

      var c = new TemperatureInterval(degC: 34);
      sum = a + c;
      expect(sum is TemperatureInterval, true);
      expect(sum.valueSI.toDouble(), closeTo(46.34, 0.000001));

      var d = new Temperature(K: 12.3);
      sum = b + d;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), closeTo(69.08, 0.000001));
    });

    test('operator -', () {
      var a = new TemperatureInterval(K: 56.78);
      var b = new TemperatureInterval(K: 12.34);
      var diff = a - b;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), 44.44);
      diff = b - a;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), -44.44);

      // Subtracting Temperature from TemperatureInterval unsupported
      var c = new Temperature(C: 34);
      var exception;
      try {
        diff = a - c;
      } catch (e) {
        exception = e;
      }
      expect(exception is QuantityException, true);
    });
  });
}
