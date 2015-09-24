import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/domain/electromagnetic.dart';

main() {
  group('Electromagnetic', () {
    test('constants', () {
      expect(elementaryCharge is Charge, true);
      expect(elementaryCharge.valueSI.toDouble(), 1.6021766208e-19);
      expect(elementaryCharge.relativeUncertainty, 6.1e-9);

      expect(magneticConstant is Permeability, true);
      expect(magneticConstant.valueSI.toDouble(), 4.0e-7 * PI);
      expect(magneticConstant.relativeUncertainty, 0.0);

      expect(conductanceQuantum is Conductance, true);
      expect(conductanceQuantum.valueSI.toDouble(), 7.7480917310e-5);
      expect(conductanceQuantum.relativeUncertainty, 2.3e-10);

      expect(vonKlitzingConstant is Resistance, true);
      expect(vonKlitzingConstant.valueSI.toDouble(), 25812.8074555);
      expect(vonKlitzingConstant.relativeUncertainty, 2.3e-10);

      expect(magneticFluxQuantum is MagneticFlux, true);
      expect(magneticFluxQuantum.valueSI.toDouble(), 2.067833831e-15);
      expect(magneticFluxQuantum.relativeUncertainty, 6.1e-9);

      expect(josephsonConstant is MiscQuantity, true);
      expect(josephsonConstant.valueSI.toDouble(), 483597.8525e9);
      expect(josephsonConstant.relativeUncertainty, 6.1e-9);

      expect(bohrMagneton is MiscQuantity, true);
      expect(bohrMagneton.valueSI.toDouble(), 927.4009994e-26);
      expect(bohrMagneton.relativeUncertainty, 6.2e-9);

      expect(nuclearMagneton is MiscQuantity, true);
      expect(nuclearMagneton.valueSI.toDouble(), 5.050783699e-27);
      expect(nuclearMagneton.relativeUncertainty, 6.2e-9);
    });

    test('synonyms', () {
      expect(G0, conductanceQuantum);
      expect(KJ, josephsonConstant);
      expect(RK, vonKlitzingConstant);
      expect(muB, bohrMagneton);
      expect(muN, nuclearMagneton);
      expect(vacuum, magneticConstant);
    });
  });
}
