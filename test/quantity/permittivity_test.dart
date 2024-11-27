import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Permittivity', () {
    test('constructors', () {
      var q = Permittivity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permittivity.permittivityDimensions);
      expect(q.preferredUnits, Permittivity.faradsPerMeter);
      expect(q.relativeUncertainty, 0);

      q = Permittivity(faradsPerMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permittivity.permittivityDimensions);
      expect(q.preferredUnits, Permittivity.faradsPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });

  test('units', () {
    var u = PermittivityUnits.capacitancePerLength(
        Capacitance.farads, Length.meters);
    expect(u.name, 'farads per meter');
    expect(u.singular, 'farad per meter');
    expect(u.convToMKS.toDouble(), 1.0);
    expect(u.abbrev1, 'F / m');
    expect(u.abbrev2, 'F m\u{207b}\u{00b9}');

    var u2 = PermittivityUnits.capacitancePerLength(
        Capacitance.farads, Length.kilometers);
    expect(u2.name, 'farads per kilometer');
    expect(u2.singular, 'farad per kilometer');
    expect(u2.convToMKS.toDouble(), 0.001);
    expect(u2.abbrev1, 'F / km');
    expect(u2.abbrev2, 'F km\u{207b}\u{00b9}');

    var q1 = Permittivity(faradsPerMeter: 1.0);
    var q2 = Permittivity.inUnits(1000.0, u2);
    expect(q1 == q2, true);
  });
}
