import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('AngularSpeed', () {
    test('constructors', () {
      AngularSpeed q = new AngularSpeed();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularSpeed.angularSpeedDimensions);
      expect(q.preferredUnits, AngularSpeed.radiansPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new AngularSpeed(radiansPerSecond: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularSpeed.angularSpeedDimensions);
      expect(q.preferredUnits, AngularSpeed.radiansPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = new AngularSpeed(degreesPerSecond: 1);
      expect(q.valueSI?.toDouble(), 0.017453292519943);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, AngularSpeed.angularSpeedDimensions);
      expect(q.preferredUnits, AngularSpeed.degreesPerSecond);
      expect(q.relativeUncertainty, 0);
    });
  });
}
