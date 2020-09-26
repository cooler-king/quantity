import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('MassFlowRate', () {
    test('constructors', () {
      MassFlowRate q = new MassFlowRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassFlowRate.massFlowRateDimensions);
      expect(q.preferredUnits, MassFlowRate.kilogramsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new MassFlowRate(kilogramsPerSecond: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassFlowRate.massFlowRateDimensions);
      expect(q.preferredUnits, MassFlowRate.kilogramsPerSecond);
      expect(q.relativeUncertainty, 0.001);
    });
  });
}