import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('ElectricFluxDensity', () {
    test('constructors', () {
      var q = ElectricFluxDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ElectricFluxDensity.electricFluxDensityDimensions);
      expect(q.preferredUnits, ElectricFluxDensity.coulombsPerSquareMeter);
      expect(q.relativeUncertainty, 0);

      q = ElectricFluxDensity(coulombsPerSquareMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ElectricFluxDensity.electricFluxDensityDimensions);
      expect(q.preferredUnits, ElectricFluxDensity.coulombsPerSquareMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = ElectricFluxDensityUnits.chargePerArea(
          Charge.coulombs, Area.squareMeters);
      expect(u.name, 'coulombs per square meter');
      expect(u.singular, 'coulomb per square meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'C / m\u{00b2}');
      expect(u.abbrev2, 'C m\u{207b}\u{00b2}');

      var u2 = ElectricFluxDensityUnits.chargePerArea(
          Charge.coulombs, Area.hectares);
      expect(u2.name, 'coulombs per hectare');
      expect(u2.singular, 'coulomb per hectare');
      expect(u2.convToMKS.toDouble(), 0.0001);
      expect(u2.abbrev1, 'C / ha');
      expect(u2.abbrev2, 'C ha\u{207b}\u{00b9}');

      var q1 = ElectricFluxDensity(coulombsPerSquareMeter: 0.0001);
      var q2 = ElectricFluxDensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
