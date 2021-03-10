import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('LuminousFlux', () {
    test('constructors', () {
      var q = LuminousFlux();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, LuminousFlux.luminousFluxDimensions);
      expect(q.preferredUnits, LuminousFlux.lumens);
      expect(q.relativeUncertainty, 0);

      q = LuminousFlux(lm: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, LuminousFlux.luminousFluxDimensions);
      expect(q.preferredUnits, LuminousFlux.lumens);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
