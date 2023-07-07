import 'package:test/test.dart';
import 'package:quantity/domain/electromagnetic.dart';

void main() {
  group('Electromagnetic', () {
    test('constants', () {
      expect(elementaryCharge.valueSI.toDouble(), 1.602176634e-19);
      expect(vacuumMagneticPermeability.valueSI.toDouble(), 1.25663706212e-6);
      expect(conductanceQuantum.valueSI.toDouble(), 7.7480917299999999e-5);
      expect(vonKlitzingConstant.valueSI.toDouble(), 25812.807455555555);
      expect(magneticFluxQuantum.valueSI.toDouble(), 2.0678338488888888e-15);
      expect(josephsonConstant.valueSI.toDouble(), 483597.84844444444e9);
      expect(bohrMagneton.valueSI.toDouble(), 927.40100783e-26);
      expect(nuclearMagneton.valueSI.toDouble(), 5.0507837461e-27);
    });

    test('synonyms', () {
      expect(G0, conductanceQuantum);
      expect(KJ, josephsonConstant);
      expect(RK, vonKlitzingConstant);
      expect(muB, bohrMagneton);
      expect(muN, nuclearMagneton);
      expect(vacuum, vacuumMagneticPermeability);
    });
  });
}
