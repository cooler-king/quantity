import 'package:quantity/domain/radiometry.dart';
import 'package:test/test.dart';

void main() {
  group('Radiometry Domain', () {
    test('quantity types and units', () {
      expect(watts, isA<PowerUnits>());
      expect(lux, isA<IlluminanceUnits>());
      expect(candelas, isA<LuminousIntensityUnits>());
      expect(janskys, isA<SpectralIrradianceUnits>());
    });

    test('constants', () {
      expect(stefanBoltzmann.valueSI.toDouble(), 5.670374419e-8);
      expect(wienDisplacement.valueSI.toDouble(), 0.002897771955);
      expect(firstRadiationConstant.valueSI.toDouble(), 3.741771852e-16);
      expect(secondRadiationConstant.valueSI.toDouble(), 0.01438776877);
      expect(solarConstant.valueSI.toDouble(), 1370.0);
      expect(solarLuminosity.valueSI.toDouble(), 3.846e26);
    });
  });
}
