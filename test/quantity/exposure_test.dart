import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Exposure', () {
    test('constructors', () {
      var q = Exposure();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Exposure.exposureDimensions);
      expect(q.preferredUnits, Exposure.coulombsPerKilogram);
      expect(q.relativeUncertainty, 0);

      q = Exposure(coulombsPerKilogram: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Exposure.exposureDimensions);
      expect(q.preferredUnits, Exposure.coulombsPerKilogram);
      expect(q.relativeUncertainty, 0.001);

      q = Exposure(R: 1);
      expect(q.valueSI.toDouble(), 0.000258);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Exposure.exposureDimensions);
      expect(q.preferredUnits, Exposure.roentgens);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = ExposureUnits.chargePerMass(Charge.coulombs, Mass.kilograms);
      expect(u.name, 'coulombs per kilogram');
      expect(u.singular, 'coulomb per kilogram');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'C / kg');
      expect(u.abbrev2, 'C kg\u{207b}\u{00b9}');

      var u2 = ExposureUnits.chargePerMass(Charge.coulombs, Mass.grams);
      expect(u2.name, 'coulombs per gram');
      expect(u2.singular, 'coulomb per gram');
      expect(u2.convToMKS.toDouble(), 1000.0);
      expect(u2.abbrev1, 'C / g');
      expect(u2.abbrev2, 'C g\u{207b}\u{00b9}');

      var q1 = Exposure(coulombsPerKilogram: 1000.0);
      var q2 = Exposure.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
