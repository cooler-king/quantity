import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('HeatFluxDensity', () {
    test('constructors', () {
      var q = HeatFluxDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, HeatFluxDensity.heatFluxDensityDimensions);
      expect(q.preferredUnits, HeatFluxDensity.wattsPerSquareMeter);
      expect(q.relativeUncertainty, 0);

      q = HeatFluxDensity(wattsPerSquareMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, HeatFluxDensity.heatFluxDensityDimensions);
      expect(q.preferredUnits, HeatFluxDensity.wattsPerSquareMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = HeatFluxDensityUnits.powerPerArea(Power.watts, Area.squareMeters);
      expect(u.name, 'watts per square meter');
      expect(u.singular, 'watt per square meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'W / m\u{00b2}');
      expect(u.abbrev2, 'W m\u{207b}\u{00b2}');

      var u2 =
          HeatFluxDensityUnits.powerPerArea(Power.kilowatts, Area.hectares);
      expect(u2.name, 'kilowatts per hectare');
      expect(u2.singular, 'kilowatt per hectare');
      expect(u2.convToMKS.toDouble(), 0.0001 * 1000.0);
      expect(u2.abbrev1, 'kW / ha');
      expect(u2.abbrev2, 'kW ha\u{207b}\u{00b9}');

      var q1 = HeatFluxDensity(wattsPerSquareMeter: 0.1);
      var q2 = HeatFluxDensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
