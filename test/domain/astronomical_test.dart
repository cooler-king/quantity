import 'package:test/test.dart';
import 'package:quantity/domain/astronomical.dart';

void main() {
  group('Astronomical', () {
    test('units', () {
      expect(gees.toMks(1).toDouble(), 9.80665);
      expect(yearsTropical.toMks(1).toDouble(), 3.1556926e7);
      expect(yearsSidereal.toMks(1).toDouble(), 3.1558150e7);
      expect(yearsJulian.toMks(1).toDouble(), 3.15576e7);
      expect(astronomicalUnits.toMks(1).toDouble(), 1.495978707e11);
      expect(parsecs.toMks(1).toDouble(), 3.0857e16);
      expect(lightYears.toMks(1).toDouble(), 9.46055e15);
      expect(xUnits.toMks(1).toDouble(), 1.00208e-13);
      expect(janskys.toMks(1).toDouble(), 1.0e-26);
      expect(microjanskys.toMks(1).toDouble(), 1.0e-32);
    });

    test('constants', () {
      expect(solarLuminosity.valueSI.toDouble(), 3.846e26);
      expect(gravitySolarSurface.valueSI.toDouble(), 274.0);
      expect(hubbleConstant.valueSI.toDouble(), 2.4e-18);
      expect(solarConstant.valueSI.toDouble(), 1370.0);
      expect(solarRadius.valueSI.toDouble(), 6.9599e8);
      expect(earthRadiusEquatorial.valueSI.toDouble(), 6378.164);
      expect(solarMass.valueSI.toDouble(), 1.989e30);
      expect(earthMass.valueSI.toDouble(), 5.972e24);
    });
  });
}
