import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('SurfaceTension', () {
    test('constructors', () {
      SurfaceTension q = new SurfaceTension();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SurfaceTension.surfaceTensionDimensions);
      expect(q.preferredUnits, SurfaceTension.newtonsPerMeter);
      expect(q.relativeUncertainty, 0);

      q = new SurfaceTension(newtonsPerMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SurfaceTension.surfaceTensionDimensions);
      expect(q.preferredUnits, SurfaceTension.newtonsPerMeter);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}