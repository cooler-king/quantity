import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('MolarEnergy', () {
    test('constructors', () {
      MolarEnergy a = new MolarEnergy();
      expect(a, isNotNull);
      expect(a.valueSI, Double.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, MolarEnergy.molarEnergyDimensions);
      expect(a.preferredUnits, MolarEnergy.joulesPerMole);

      a = new MolarEnergy(joulesPerMole: 2.4);
      expect(a, isNotNull);
      expect(a.valueSI?.toDouble(), 2.4);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, MolarEnergy.molarEnergyDimensions);
      expect(a.preferredUnits, MolarEnergy.joulesPerMole);
    });
  });
}
