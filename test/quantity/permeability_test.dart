import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Permeability', () {
    test('constructors', () {
      Permeability q = new Permeability();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permeability.permeabilityDimensions);
      expect(q.preferredUnits, Permeability.henriesPerMeter);
      expect(q.relativeUncertainty, 0);

      q = new Permeability(henriesPerMeter: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permeability.permeabilityDimensions);
      expect(q.preferredUnits, Permeability.henriesPerMeter);
      expect(q.relativeUncertainty, 0.001);

      q = new Permeability(newtonsPerAmpereSquared: 1);
      expect(q.valueSI?.toDouble(), 1);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Permeability.permeabilityDimensions);
      expect(q.preferredUnits, Permeability.newtonsPerAmpereSquared);
      expect(q.relativeUncertainty, 0);
    });
  });
}
