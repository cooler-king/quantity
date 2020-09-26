import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('EnergyDensity', () {
    test('constructors', () {
      EnergyDensity q = new EnergyDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, EnergyDensity.energyDensityDimensions);
      expect(q.preferredUnits, EnergyDensity.joulesPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = new EnergyDensity(joulesPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, EnergyDensity.energyDensityDimensions);
      expect(q.preferredUnits, EnergyDensity.joulesPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
