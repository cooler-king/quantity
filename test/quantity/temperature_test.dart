import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Temperature', () {
    test('constructors', () {
      // default ctor, K 0
      Temperature a = new Temperature();
      expect(a.valueSI, Integer.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Temperature.temperatureDimensions);
      expect(a.preferredUnits, Temperature.kelvins);
      expect(a.relativeUncertainty, 0);

      // default ctor, K +
      a = new Temperature(K: 42);
      expect(a.valueSI?.toDouble() == 42, true);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, Temperature.temperatureDimensions);
      expect(a.preferredUnits, Temperature.kelvins);
      expect(a.relativeUncertainty, 0);

      // default ctor, K -
      a = new Temperature(K: -99.33);
      expect(a.valueSI?.toDouble() == -99.33, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Temperature.temperatureDimensions);
      expect(a.preferredUnits, Temperature.kelvins);
      expect(a.relativeUncertainty, 0);

      // K = C + 273.15

      // default ctor, degC +
      a = new Temperature(C: 100);
      expect(a.valueSI?.toDouble() == 373.15, true);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Temperature.temperatureDimensions);
      expect(a.preferredUnits, Temperature.degreesCelsius);
      expect(a.relativeUncertainty, 0);

      // default ctor, degC -
      a = new Temperature(C: -53.4);
      expect(a.valueSI.toDouble(), closeTo(219.75, 0.000001));
      expect(a.valueSI is Double, true);
      expect(a.dimensions, Temperature.temperatureDimensions);
      expect(a.preferredUnits, Temperature.degreesCelsius);
      expect(a.relativeUncertainty, 0);
    });

    test('operator +', () {
      final Temperature a = new Temperature(K: 12.34);
      final Temperature b = new Temperature(K: 56.78);
      dynamic sum = a + b;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), 69.12);

      final Temperature c = new Temperature(C: 34);
      sum = a + c;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), closeTo(319.49, 0.000001));

      final TemperatureInterval d = new TemperatureInterval(K: 12.3);
      sum = b + d;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), closeTo(69.08, 0.000001));
    });

    test('operator -', () {
      final Temperature a = new Temperature(K: 56.78);
      final Temperature b = new Temperature(K: 12.34);
      dynamic diff = a - b;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), 44.44);
      diff = b - a;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), -44.44);

      final Temperature c = new Temperature(C: 34);
      diff = a - c;
      expect(diff is TemperatureInterval, true);
      expect(diff.valueSI.toDouble(), closeTo(-250.37, 0.000001));

      final TemperatureInterval d = new TemperatureInterval(K: 12.3);
      diff = b - d;
      expect(diff is Temperature, true);
      expect(diff.valueSI.toDouble(), closeTo(0.04, 0.000001));
    });
  });
}
