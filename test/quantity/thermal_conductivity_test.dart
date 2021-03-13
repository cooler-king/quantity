import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('ThermalConductivity', () {
    test('constructors', () {
      var q = ThermalConductivity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ThermalConductivity.thermalConductivityDimensions);
      expect(q.preferredUnits, ThermalConductivity.wattsPerMeterKelvin);
      expect(q.relativeUncertainty, 0);

      q = ThermalConductivity(wattsPerMeterKelvin: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ThermalConductivity.thermalConductivityDimensions);
      expect(q.preferredUnits, ThermalConductivity.wattsPerMeterKelvin);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
