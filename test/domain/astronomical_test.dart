import 'package:test/test.dart';
import 'package:quantity/domain/astronomical.dart';

main() {
  group('Astronomical', () {
    test('units', () {
      expect(gees is AccelerationUnits, true);
      expect(gees.toMks(1).toDouble(), 9.80665);

      expect(yearsTropical is TimeUnits, true);
      expect(yearsTropical.toMks(1).toDouble(), 3.1556926e7);

      expect(yearsSidereal is TimeUnits, true);
      expect(yearsSidereal.toMks(1).toDouble(), 3.1558150e7);

      expect(yearsJulian is TimeUnits, true);
      expect(yearsJulian.toMks(1).toDouble(), 3.15576e7);

      expect(astronomicalUnits is LengthUnits, true);
      expect(astronomicalUnits.toMks(1).toDouble(), 1.495978707e11);

      expect(parsecs is LengthUnits, true);
      expect(parsecs.toMks(1).toDouble(), 3.0857e16);

      expect(lightYears is LengthUnits, true);
      expect(lightYears.toMks(1).toDouble(), 9.46055e15);

      expect(xUnits is LengthUnits, true);
      expect(xUnits.toMks(1).toDouble(), 1.00208e-13);

      expect(janskys is SpectralIrradianceUnits, true);
      expect(janskys.toMks(1).toDouble(), 1.0e-26);

      expect(microjanskys is SpectralIrradianceUnits, true);
      expect(microjanskys.toMks(1).toDouble(), 1.0e-32);
    });

    test('constants', () {
      expect(solarLuminosity is Power, true);
      expect(solarLuminosity.valueSI.toDouble(), 3.846e26);
      expect(solarLuminosity.relativeUncertainty, 0.0);

      expect(gravitySolarSurface is Acceleration, true);
      expect(gravitySolarSurface.valueSI.toDouble(), 274.0);
      expect(gravitySolarSurface.relativeUncertainty, 0.0);

      expect(hubbleConstant is Frequency, true);
      expect(hubbleConstant.valueSI.toDouble(), 2.4e-18);
      expect(hubbleConstant.relativeUncertainty, 0.3333333333);

      expect(solarConstant is EnergyFlux, true);
      expect(solarConstant.valueSI.toDouble(), 1370.0);
      expect(solarConstant.relativeUncertainty, 0.0);

      expect(solarRadius is Length, true);
      expect(solarRadius.valueSI.toDouble(), 6.9599e8);
      expect(solarRadius.relativeUncertainty, 0.0);

      expect(earthRadiusEquatorial is Length, true);
      expect(earthRadiusEquatorial.valueSI.toDouble(), 6378.164);
      expect(earthRadiusEquatorial.relativeUncertainty, 0.0);

      expect(solarMass is Mass, true);
      expect(solarMass.valueSI.toDouble(), 1.989e30);
      expect(solarMass.relativeUncertainty, 0.0);

      expect(earthMass is Mass, true);
      expect(earthMass.valueSI.toDouble(), 5.972e24);
      expect(earthMass.relativeUncertainty, 0.0);
    });
  });
}
