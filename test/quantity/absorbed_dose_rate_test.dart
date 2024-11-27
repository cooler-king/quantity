import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('AbsorbedDoseRate', () {
    test('constructors', () {
      var q = AbsorbedDoseRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AbsorbedDoseRate.absorbedDoseRateDimensions);
      expect(q.preferredUnits, AbsorbedDoseRate.graysPerSecond);
      expect(q.relativeUncertainty, 0);

      q = AbsorbedDoseRate(graysPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AbsorbedDoseRate.absorbedDoseRateDimensions);
      expect(q.preferredUnits, AbsorbedDoseRate.graysPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = AbsorbedDoseRate(radsPerSecond: 1);
      expect(q.valueSI.toDouble(), 0.01);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, AbsorbedDoseRate.absorbedDoseRateDimensions);
      expect(q.preferredUnits, AbsorbedDoseRate.radsPerSecond);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = AbsorbedDoseRateUnits.absorbedDosePerTime(
          AbsorbedDose.grays, Time.seconds);
      expect(u.name, 'grays per second');
      expect(u.singular, 'gray per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'Gy / sec');
      expect(u.abbrev2, 'Gy s\u{207b}\u{00b9}');

      var u2 = AbsorbedDoseRateUnits.absorbedDosePerTime(
          AbsorbedDose.rads, Time.minutes);
      expect(u2.name, 'rads per minute');
      expect(u2.singular, 'rads per minute');
      expect(u2.convToMKS.toDouble(), 0.01 / 60.0);
      expect(u2.abbrev1, 'rads / min');
      expect(u2.abbrev2, 'rads min\u{207b}\u{00b9}');

      var q1 = AbsorbedDoseRate(graysPerSecond: 0.01 / 60.0);
      var q2 = AbsorbedDoseRate.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
