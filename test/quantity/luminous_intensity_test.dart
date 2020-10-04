import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('LuminousIntensity', () {
    test('constructors', () {
      LuminousIntensity a = new LuminousIntensity();
      expect(a, isNotNull);
      expect(a.valueSI, Double.zero);
      expect(a.valueSI is Integer, true);
      expect(a.dimensions, LuminousIntensity.luminousIntensityDimensions);
      expect(a.preferredUnits, LuminousIntensity.candelas);

      a = new LuminousIntensity(cd: 2.4);
      expect(a, isNotNull);
      expect(a.valueSI?.toDouble(), 2.4);
      expect(a.valueSI is Double, true);
      expect(a.dimensions, LuminousIntensity.luminousIntensityDimensions);
      expect(a.preferredUnits, LuminousIntensity.candelas);
    });
  });
}
