import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('KinematicViscosity', () {
    test('constructors', () {
      var q = KinematicViscosity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, KinematicViscosity.kinematicViscosityDimensions);
      expect(q.preferredUnits, KinematicViscosity.metersSquaredPerSecond);
      expect(q.relativeUncertainty, 0);

      q = KinematicViscosity(metersSquaredPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, KinematicViscosity.kinematicViscosityDimensions);
      expect(q.preferredUnits, KinematicViscosity.metersSquaredPerSecond);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
