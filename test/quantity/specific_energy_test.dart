import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('SpecificEnergy', () {
    test('constructors', () {
      var q = SpecificEnergy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificEnergy.specificEnergyDimensions);
      expect(q.preferredUnits, SpecificEnergy.joulesPerKilogram);
      expect(q.relativeUncertainty, 0);

      q = SpecificEnergy(joulesPerKilogram: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificEnergy.specificEnergyDimensions);
      expect(q.preferredUnits, SpecificEnergy.joulesPerKilogram);
      expect(q.relativeUncertainty, 0.001);
    });

    group('units', () {
      test('energyMass constructor', () {
        var u =
            SpecificEnergyUnits.energyPerMass(Energy.joules, Mass.kilograms);
        expect(u.name, 'joules per kilogram');
        expect(u.singular, 'joule per kilogram');
        expect(u.convToMKS.toDouble(), 1.0);
        expect(u.abbrev1, 'J / kg');
        expect(u.abbrev2, 'J kg\u{207b}\u{00b9}');

        var u2 =
            SpecificEnergyUnits.energyPerMass(Energy.electronVolts, Mass.grams);
        expect(u2.name, 'electronvolts per gram');
        expect(u2.singular, 'electronvolt per gram');
        expect(u2.convToMKS.toDouble(), 1.60217653e-19 * 1000.0);
        expect(u2.abbrev1, 'eV / g');
        expect(u2.abbrev2, 'eV g\u{207b}\u{00b9}');

        var q1 = SpecificEnergy(joulesPerKilogram: 1.60217653e-16);
        var q2 = SpecificEnergy.inUnits(1.0, u2);
        expect(q1 == q2, true);
        expect(q1.toString(), '1.602 176 53e-16 J kg\u{207b}\u{00b9}');
        expect(q2.toString(), '1 eV g\u{207b}\u{00b9}');
      });

      test('lengthTime constructor', () {
        var u = SpecificEnergyUnits.lengthTime(Length.meters, Time.seconds);
        expect(u.name, 'meters squared per second squared');
        expect(u.singular, 'meter squared per second squared');
        expect(u.convToMKS.toDouble(), 1.0);
        expect(u.abbrev1, 'm\u{00b2} / sec\u{00b2}');
        expect(u.abbrev2, 'm\u{00b2} s\u{207b}\u{00b2}');

        var u2 =
            SpecificEnergyUnits.lengthTime(Length.kilometers, Time.minutes);
        expect(u2.name, 'kilometers squared per minute squared');
        expect(u2.singular, 'kilometer squared per minute squared');
        expect(u2.convToMKS.toDouble(), (1000.0 * 1000.0) / (60.0 * 60.0));
        expect(u2.abbrev1, 'km\u{00b2} / min\u{00b2}');
        expect(u2.abbrev2, 'km\u{00b2} min\u{207b}\u{00b2}');

        var q1 = SpecificEnergy(joulesPerKilogram: 277.777777777777777777);
        var q2 = SpecificEnergy.inUnits(1.0, u2);
        expect(q1 == q2, true);
        expect(q1.toString(), '277.777 777 777 777 77 J kg\u{207b}\u{00b9}');
        expect(q2.toString(), '1 km\u{00b2} min\u{207b}\u{00b2}');
      });

      test('speed constructor', () {
        var u = SpecificEnergyUnits.speed(Speed.metersPerSecond);
        expect(u.name, '(meters per second) squared');
        expect(u.singular, '(meter per second) squared');
        expect(u.convToMKS.toDouble(), 1.0);
        expect(u.abbrev1, '(m / sec) sq.');
        expect(u.abbrev2, '(m s\u{207b}\u{00b9})\u{00b2}');

        var u2 = SpecificEnergyUnits.speed(Speed.knots);
        expect(u2.name, 'knots squared');
        expect(u2.singular, 'knot squared');
        expect(u2.convToMKS.toDouble(), (5.144444444e-1 * 5.144444444e-1));

        var q1 =
            SpecificEnergy(joulesPerKilogram: 5.144444444e-1 * 5.144444444e-1);
        var q2 = SpecificEnergy.inUnits(1.0, u2);
        expect(q1 == q2, true);
        expect(q1.toString(), '0.264 653 086 374 024 74 J kg\u{207b}\u{00b9}');
        expect(q2.toString(), '1 knot\u{00b2}');
      });
    });
  });
}
