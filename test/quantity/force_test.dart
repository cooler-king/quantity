import 'dart:math';

import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('Force', () {
    test('constructors', () {
      var q = Force();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Force.forceDimensions);
      expect(q.preferredUnits, Force.newtons);
      expect(q.relativeUncertainty, 0);

      q = Force(N: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Force.forceDimensions);
      expect(q.preferredUnits, Force.newtons);
      expect(q.relativeUncertainty, 0.001);

      // constant constructor
      const fc = Force.constant(Double.constant(5.0));
      expect(fc.valueSI.toDouble(), 5.0);

      // Force.ma constructor
      final fma = Force.ma(Mass(kg: 10, uncert: 0.01),
          Acceleration(metersPerSecondSquared: 9.8, uncert: 0.02));
      expect(fma.valueSI.toDouble(), 98.0);
      expect(fma.relativeUncertainty,
          closeTo(sqrt(0.01 * 0.01 + 0.02 * 0.02), 0.0001));
    });
  });
}
