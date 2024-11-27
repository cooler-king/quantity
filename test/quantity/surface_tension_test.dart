import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('SurfaceTension', () {
    test('constructors', () {
      var q = SurfaceTension();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SurfaceTension.surfaceTensionDimensions);
      expect(q.preferredUnits, SurfaceTension.newtonsPerMeter);
      expect(q.relativeUncertainty, 0);

      q = SurfaceTension(newtonsPerMeter: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SurfaceTension.surfaceTensionDimensions);
      expect(q.preferredUnits, SurfaceTension.newtonsPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = SurfaceTensionUnits.forcePerLength(Force.newtons, Length.meters);
      expect(u.name, 'newtons per meter');
      expect(u.singular, 'newton per meter');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "N / m");
      expect(u.abbrev2, "N m\u{207b}\u{00b9}");

      var u2 =
          SurfaceTensionUnits.forcePerLength(Force.newtons, Length.millimeters);
      expect(u2.name, 'newtons per millimeter');
      expect(u2.singular, 'newton per millimeter');
      expect(u2.convToMKS.toDouble(), 1.0e3);
      expect(u2.abbrev1, "N / mm");
      expect(u2.abbrev2, "N mm\u{207b}\u{00b9}");

      var q1 = SurfaceTension(newtonsPerMeter: 1.0);
      var q2 = SurfaceTension.inUnits(1.0e-3, u2);
      expect(q1 == q2, true);
      expect(q1.toString(), '1 N m\u{207b}\u{00b9}');
      expect(q2.toString(), '0.001 N mm\u{207b}\u{00b9}');
    });
  });
}
