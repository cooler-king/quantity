import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Current', () {
    test('constructors', () {
      Current q = new Current();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Current.electricCurrentDimensions);
      expect(q.preferredUnits, Current.amperes);
      expect(q.relativeUncertainty, 0);

      q = new Current(A: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Current.electricCurrentDimensions);
      expect(q.preferredUnits, Current.amperes);
      expect(q.relativeUncertainty, 0.001);

      q = new Current(mA: 1);
      expect(q.valueSI?.toDouble(), 0.001);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Current.electricCurrentDimensions);
      expect(q.preferredUnits, Current.milliamperes);
      expect(q.relativeUncertainty, 0);
    });
  });
}
