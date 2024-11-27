import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Permeability', () {
    test('constructors', () {
      var q = Permeability();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permeability.permeabilityDimensions);
      expect(q.preferredUnits, Permeability.henriesPerMeter);
      expect(q.relativeUncertainty, 0);

      q = Permeability(henriesPerMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permeability.permeabilityDimensions);
      expect(q.preferredUnits, Permeability.henriesPerMeter);
      expect(q.relativeUncertainty, 0.001);

      q = Permeability(newtonsPerAmpereSquared: 1);
      expect(q.valueSI.toDouble(), 1);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permeability.permeabilityDimensions);
      expect(q.preferredUnits, Permeability.newtonsPerAmpereSquared);
      expect(q.relativeUncertainty, 0);
    });

    group('units', () {
      test('inductanceLength constructor', () {
        var u = PermeabilityUnits.inductancePerLength(
            Inductance.henries, Length.meters);
        expect(u.name, 'henries per meter');
        expect(u.singular, 'henry per meter');
        expect(u.convToMKS.toDouble(), 1.0);
        expect(u.abbrev1, 'H / m');
        expect(u.abbrev2, 'H m\u{207b}\u{00b9}');

        var u2 = PermeabilityUnits.inductancePerLength(
            Inductance.henries, Length.kilometers);
        expect(u2.name, 'henries per kilometer');
        expect(u2.singular, 'henry per kilometer');
        expect(u2.convToMKS.toDouble(), 0.001);
        expect(u2.abbrev1, 'H / km');
        expect(u2.abbrev2, 'H km\u{207b}\u{00b9}');

        var q1 = Permeability(henriesPerMeter: 1.0);
        var q2 = Permeability.inUnits(1000.0, u2);
        expect(q1 == q2, true);
      });

      test('forceCurrent constructor', () {
        var u = PermeabilityUnits.forcePerCurrentSquared(
            Force.newtons, Current.amperes);
        expect(u.name, 'newtons per ampere squared');
        expect(u.singular, 'newton per ampere squared');
        expect(u.convToMKS.toDouble(), 1.0);
        expect(u.abbrev1, 'N / A\u{00b2}');
        expect(u.abbrev2, 'N A\u{207b}\u{00b2}');

        var u2 = PermeabilityUnits.forcePerCurrentSquared(
            Force.newtons, Current.milliamperes);
        expect(u2.name, 'newtons per milliampere squared');
        expect(u2.singular, 'newton per milliampere squared');
        expect(u2.convToMKS.toDouble(), 1000000.0);
        expect(u2.abbrev1, 'N / mA\u{00b2}');
        expect(u2.abbrev2, 'N mA\u{207b}\u{00b2}');

        var q1 = Permeability(newtonsPerAmpereSquared: 1000000.0);
        var q2 = Permeability.inUnits(1.0, u2);
        expect(q1 == q2, true);
      });
    });
  });
}
