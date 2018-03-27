import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart';

void main() {
  group('temperature ext', () {
    test('Fahrenheit', () {
      final Temperature f = new Temperature.inUnits(1.23, Fahrenheit);
      expect(f.valueSI.toDouble(), closeTo(256.05555555, 0.000001));

      final Temperature k = new Temperature(K: 200.4);
      final dynamic sum = f + k;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), closeTo(456.4555555555555, 0.000001));
    });

    test('Rankine', () {
      final Temperature r = new Temperature.inUnits(100, Rankine);
      expect(r.valueSI.toDouble(), closeTo(55.555555555, 0.000001));

      final Temperature k = new Temperature(K: 200.4);
      final dynamic sum = r + k;
      expect(sum is Temperature, true);
      expect(sum.valueSI.toDouble(), closeTo(255.9555555555, 0.000001));
    });

    test('deg F', () {
      final TemperatureInterval f = new TemperatureInterval.inUnits(1.23, degF);
      expect(f.valueSI.toDouble(), closeTo(0.6833333333333333, 0.000001));

      final TemperatureInterval k = new TemperatureInterval(K: 200.4);
      final dynamic sum = f + k;
      expect(sum is TemperatureInterval, true);
      expect(sum.valueSI.toDouble(), closeTo(201.0833333333333, 0.000001));
    });

    test('Rankine', () {
      final TemperatureInterval r = new TemperatureInterval.inUnits(100, degR);
      expect(r.valueSI.toDouble(), closeTo(55.555555555, 0.000001));

      final TemperatureInterval k = new TemperatureInterval(K: 200.4);
      final dynamic  sum = r + k;
      expect(sum is TemperatureInterval, true);
      expect(sum.valueSI.toDouble(), closeTo(255.9555555555, 0.000001));
    });
  });
}
