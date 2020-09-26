import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('SpecificVolume', () {
    test('constructors', () {
      SpecificVolume q = new SpecificVolume();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificVolume.specificVolumeDimensions);
      expect(q.preferredUnits, SpecificVolume.cubicMetersPerKilogram);
      expect(q.relativeUncertainty, 0);

      q = new SpecificVolume(cubicMetersPerKilogram: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificVolume.specificVolumeDimensions);
      expect(q.preferredUnits, SpecificVolume.cubicMetersPerKilogram);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}