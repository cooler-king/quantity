import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('MassFlowRate', () {
    test('constructors', () {
      var q = MassFlowRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassFlowRate.massFlowRateDimensions);
      expect(q.preferredUnits, MassFlowRate.kilogramsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = MassFlowRate(kilogramsPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, MassFlowRate.massFlowRateDimensions);
      expect(q.preferredUnits, MassFlowRate.kilogramsPerSecond);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = MassFlowRateUnits.massPerTime(Mass.kilograms, Time.seconds);
      expect(u.name, 'kilograms per second');
      expect(u.singular, 'kilogram per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'kg / sec');
      expect(u.abbrev2, 'kg s\u{207b}\u{00b9}');

      var u2 = MassFlowRateUnits.massPerTime(Mass.grams, Time.minutes);
      expect(u2.name, 'grams per minute');
      expect(u2.singular, 'gram per minute');
      expect(u2.convToMKS.toDouble(), 0.001 / 60.0);
      expect(u2.abbrev1, 'g / min');
      expect(u2.abbrev2, 'g min\u{207b}\u{00b9}');

      var q1 = MassFlowRate(kilogramsPerSecond: 0.001 / 60.0);
      var q2 = MassFlowRate.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
