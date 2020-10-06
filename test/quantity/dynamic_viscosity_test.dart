import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('DynamicViscosity', () {
    test('constructors', () {
      var q = DynamicViscosity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, DynamicViscosity.dynamicViscosityDimensions);
      expect(q.preferredUnits, DynamicViscosity.pascalSeconds);
      expect(q.relativeUncertainty, 0);

      q = DynamicViscosity(Pas: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, DynamicViscosity.dynamicViscosityDimensions);
      expect(q.preferredUnits, DynamicViscosity.pascalSeconds);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
