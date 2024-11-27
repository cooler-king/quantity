import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('MassFluxDensity', () {
    test('constructors', () {
      var q = MassFluxDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassFluxDensity.massFluxDensityDimensions);
      expect(
          q.preferredUnits, MassFluxDensity.kilogramsPerSecondPerSquareMeter);
      expect(q.relativeUncertainty, 0);

      q = MassFluxDensity(kilogramsPerSecondPerSquareMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassFluxDensity.massFluxDensityDimensions);
      expect(
          q.preferredUnits, MassFluxDensity.kilogramsPerSecondPerSquareMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = MassFluxDensityUnits.massPerTimeArea(
          Mass.kilograms, Time.seconds, Area.squareMeters);
      expect(u.name, 'kilograms per second per square meter');
      expect(u.singular, 'kilogram per second per square meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'kg / sec m\u{00b2}');
      expect(u.abbrev2, 'kg s\u{207b}\u{00b9} m\u{207b}\u{00b2}');

      var u2 = MassFluxDensityUnits.massPerTimeArea(Mass.grams, Time.minutes,
          AreaUnits.lengthSquared(Length.centimeters));
      expect(u2.name, 'grams per minute per square centimeter');
      expect(u2.singular, 'gram per minute per square centimeter');
      expect(u2.convToMKS.toDouble(), 10000.0 * 0.001 / 60.0);
      expect(u2.abbrev1, 'g / min cm\u{00b2}');
      expect(u2.abbrev2, 'g min\u{207b}\u{00b9} cm\u{207b}\u{00b2}');

      var q1 = MassFluxDensity(
          kilogramsPerSecondPerSquareMeter: 10000.0 * 0.001 / 60.0);
      var q2 = MassFluxDensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
