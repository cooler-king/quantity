import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('SpectralIrradiance', () {
    test('constructors', () {
      SpectralIrradiance q = new SpectralIrradiance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpectralIrradiance.spectralIrradianceDimensions);
      expect(q.preferredUnits, SpectralIrradiance.wattsPerSquareMeterPerHertz);
      expect(q.relativeUncertainty, 0);

      q = new SpectralIrradiance(wattsPerSquareMeterPerHertz: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, SpectralIrradiance.spectralIrradianceDimensions);
      expect(q.preferredUnits, SpectralIrradiance.wattsPerSquareMeterPerHertz);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}