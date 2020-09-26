import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Force', () {
    test('constructors', () {
      Force q = new Force();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Force.forceDimensions);
      expect(q.preferredUnits, Force.newtons);
      expect(q.relativeUncertainty, 0);

      q = new Force(N: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Force.forceDimensions);
      expect(q.preferredUnits, Force.newtons);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}
