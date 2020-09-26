import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('VolumeFlowRate', () {
    test('constructors', () {
      VolumeFlowRate q = new VolumeFlowRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, VolumeFlowRate.volumeFlowRateDimensions);
      expect(q.preferredUnits, VolumeFlowRate.cubicMetersPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new VolumeFlowRate(cubicMetersPerSecond: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, VolumeFlowRate.volumeFlowRateDimensions);
      expect(q.preferredUnits, VolumeFlowRate.cubicMetersPerSecond);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
