import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart';

void main() {
  group('temperature ext', () {
    test('Fahrenheit', () {
      var f = new Temperature.inUnits(1.23, Fahrenheit);
      expect(f.valueSI.toDouble(), closeTo(256.05555555, 0.000001));

      var k = new Temperature(K: 200.4);
      var sum = f + k;
      expect(sum.valueSI.toDouble(), closeTo(456.4555555555555, 0.000001));
    });

    test('Rankine', () {
      var r = new Temperature.inUnits(100, Rankine);
      expect(r.valueSI.toDouble(), closeTo(55.555555555, 0.000001));

      var k = new Temperature(K: 200.4);
      var sum = r + k;
      expect(sum.valueSI.toDouble(), closeTo(255.9555555555, 0.000001));
    });

    test('deg F', () {
      var f = new TemperatureInterval.inUnits(1.23, degF);
      expect(f.valueSI.toDouble(), closeTo(0.6833333333333333, 0.000001));

      var k = new TemperatureInterval(K: 200.4);
      var sum = f + k;
      expect(sum.valueSI.toDouble(), closeTo(201.0833333333333, 0.000001));
    });

    test('Rankine', () {
      var r = new TemperatureInterval.inUnits(100, degR);
      expect(r.valueSI.toDouble(), closeTo(55.555555555, 0.000001));

      var k = new TemperatureInterval(K: 200.4);
      var sum = r + k;
      expect(sum.valueSI.toDouble(), closeTo(255.9555555555, 0.000001));
    });
  });
}
