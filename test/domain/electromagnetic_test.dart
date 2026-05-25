import 'package:quantity/domain/electromagnetic.dart';
import 'package:test/test.dart';

void main() {
  group('Electromagnetic', () {
    test('constants', () {
      expect(elementaryCharge.valueSI.toDouble(), 1.602176634e-19);
      expect(
          vacuumMagneticPermeability.valueSI.toDouble(), 0.00000125663706127);
      expect(conductanceQuantum.valueSI.toDouble(), 0.00007748091729);
      expect(vonKlitzingConstant.valueSI.toDouble(), 25812.80745);
      expect(magneticFluxQuantum.valueSI.toDouble(), 2.067833848e-15);
      expect(josephsonConstant.valueSI.toDouble(), 483597848400000.0);
      expect(bohrMagneton.valueSI.toDouble(), 9.2740100657e-24);
      expect(nuclearMagneton.valueSI.toDouble(), 5.0507837393e-27);
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
