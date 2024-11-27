import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('SpecificVolume', () {
    test('constructors', () {
      var q = SpecificVolume();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificVolume.specificVolumeDimensions);
      expect(q.preferredUnits, SpecificVolume.cubicMetersPerKilogram);
      expect(q.relativeUncertainty, 0);

      q = SpecificVolume(cubicMetersPerKilogram: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpecificVolume.specificVolumeDimensions);
      expect(q.preferredUnits, SpecificVolume.cubicMetersPerKilogram);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          SpecificVolumeUnits.volumePerMass(Volume.cubicMeters, Mass.kilograms);
      expect(u.name, 'cubic meters per kilogram');
      expect(u.singular, 'cubic meter per kilogram');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "m\u{00b3} / kg");
      expect(u.abbrev2, "m\u{00b3} kg\u{207b}\u{00b9}");

      var u2 =
          SpecificVolumeUnits.volumePerMass(Volume.liters, Mass.metricTons);
      expect(u2.name, 'liters per megagram');
      expect(u2.singular, 'liter per megagram');
      expect(u2.convToMKS.toDouble(), 0.001 * 0.001);
      expect(u2.abbrev1, "L / Mg");
      expect(u2.abbrev2, "L Mg\u{207b}\u{00b9}");

      var q1 = SpecificVolume(cubicMetersPerKilogram: 1.0e-6);
      var q2 = SpecificVolume.inUnits(1.0, u2);
      expect(q1 == q2, true);
      expect(q1.toString(), '0.000 001 m\u{00b3} kg\u{207b}\u{00b9}');
      expect(q2.toString(), '1 L Mg\u{207b}\u{00b9}');
    });
  });
}
