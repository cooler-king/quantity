import 'package:test/test.dart';
import 'package:quantity/domain/electromagnetic.dart';

void main() {
  group('Electromagnetic', () {
    test('constants', () {
      expect(elementaryCharge is Charge, true);
      expect(elementaryCharge.valueSI.toDouble(), 1.602176634e-19);

      expect(vacuumMagneticPermeability is Permeability, true);
      expect(vacuumMagneticPermeability.valueSI.toDouble(), 1.25663706212e-6);

      expect(conductanceQuantum is Conductance, true);
      expect(conductanceQuantum.valueSI.toDouble(), 7.748091729e-5);

      expect(vonKlitzingConstant is Resistance, true);
      expect(vonKlitzingConstant.valueSI.toDouble(), 25812.80745);

      expect(magneticFluxQuantum is MagneticFlux, true);
      expect(magneticFluxQuantum.valueSI.toDouble(), 2.067833848e-15);

      expect(josephsonConstant is MiscQuantity, true);
      expect(josephsonConstant.valueSI.toDouble(), 483597.8484e9);

      expect(bohrMagneton is MiscQuantity, true);
      expect(bohrMagneton.valueSI.toDouble(), 927.4009994e-26);

      expect(nuclearMagneton is MiscQuantity, true);
      expect(nuclearMagneton.valueSI.toDouble(), 5.050783699e-27);
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
