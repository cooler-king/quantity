import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('MassDensity', () {
    test('constructors', () {
      var q = MassDensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassDensity.massDensityDimensions);
      expect(q.preferredUnits, MassDensity.kilogramsPerCubicMeter);
      expect(q.relativeUncertainty, 0);

      q = MassDensity(kilogramsPerCubicMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassDensity.massDensityDimensions);
      expect(q.preferredUnits, MassDensity.kilogramsPerCubicMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          MassDensityUnits.massPerVolume(Mass.kilograms, Volume.cubicMeters);
      expect(u.name, "kilograms per cubic meter");
      expect(u.singular, "kilogram per cubic meter");
      expect(u.convToMKS is Integer, true);
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "kg / m\u{00b3}");
      expect(u.abbrev2, "kg m\u{207b}\u{00b3}");

      var kgsPerLiter =
          MassDensityUnits.massPerVolume(Mass.kilograms, Volume.liters);
      expect(kgsPerLiter.name, "kilograms per liter");
      expect(kgsPerLiter.singular, "kilogram per liter");
      expect(kgsPerLiter.convToMKS.toDouble(), 1000.0);
      expect(kgsPerLiter.abbrev1, "kg / L");
      expect(kgsPerLiter.abbrev2, "kg L\u{207b}\u{00b9}");

      var md = MassDensity.inUnits(1.0, kgsPerLiter);
      expect(md.valueSI.toDouble(), 1000.0);
      expect(md == MassDensity(kilogramsPerCubicMeter: 1000.0), true);
    });
  });
}
