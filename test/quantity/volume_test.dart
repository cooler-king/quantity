import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Volume', () {
    test('constructors', () {
      var q = Volume();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Volume.volumeDimensions);
      expect(q.preferredUnits, Volume.cubicMeters);
      expect(q.relativeUncertainty, 0);

      q = Volume(m3: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Volume.volumeDimensions);
      expect(q.preferredUnits, Volume.cubicMeters);
      expect(q.relativeUncertainty, 0.001);

      q = Volume(L: 1);
      expect(q.valueSI.toDouble(), 0.001);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Volume.volumeDimensions);
      expect(q.preferredUnits, Volume.liters);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = VolumeUnits.lengthCubed(Length.meters);
      expect(u.name, 'cubic meters');
      expect(u.singular, 'cubic meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "m\u{00b3}");
      expect(u.abbrev2, "m\u{00b3}");

      var km3 = VolumeUnits.lengthCubed(Length.kilometers);
      expect(km3.name, 'cubic kilometers');
      expect(km3.singular, 'cubic kilometer');
      expect(km3.convToMKS.toDouble(), 1.0e9);
      expect(km3.abbrev1, "km\u{00b3}");
      expect(km3.abbrev2, "km\u{00b3}");

      var q1 = Volume(m3: 1.0);
      var q2 = Volume.inUnits(1.0e-9, km3);
      expect(q1 == q2, true);
      expect(q1.toString(), '1 m\u{00b3}');
      expect(q2.toString(), '1e-9 km\u{00b3}');
    });
  });
}
