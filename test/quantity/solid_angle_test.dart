import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('SolidAngle', () {
    test('constructors', () {
      var q = SolidAngle();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SolidAngle.solidAngleDimensions);
      expect(q.preferredUnits, SolidAngle.steradians);
      expect(q.relativeUncertainty, 0);

      q = SolidAngle(sr: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SolidAngle.solidAngleDimensions);
      expect(q.preferredUnits, SolidAngle.steradians);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
