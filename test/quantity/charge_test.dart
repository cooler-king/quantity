import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Charge', () {
    test('constructors', () {
      var q = Charge();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Charge.electricChargeDimensions);
      expect(q.preferredUnits, Charge.coulombs);
      expect(q.relativeUncertainty, 0);

      q = Charge(C: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Charge.electricChargeDimensions);
      expect(q.preferredUnits, Charge.coulombs);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = ChargeUnits.currentTime(Current.amperes, Time.seconds);
      expect(u.name, 'ampere seconds');
      expect(u.singular, 'ampere second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'Asec');
      expect(u.abbrev2, 'A s');

      var u2 = ChargeUnits.currentTime(Current.milliamperes, Time.hours);
      expect(u2.name, 'milliampere hours');
      expect(u2.singular, 'milliampere hour');
      expect(u2.convToMKS.toDouble(), 0.001 * 3600.0);
      expect(u2.abbrev1, 'mAhrs');
      expect(u2.abbrev2, 'mA h');

      var q1 = Charge(C: 3.6);
      var q2 = Charge.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
