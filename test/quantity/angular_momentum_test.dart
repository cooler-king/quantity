import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('AngularMomentum', () {
    test('constructors', () {
      var q = AngularMomentum();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularMomentum.angularMomentumDimensions);
      expect(q.preferredUnits, AngularMomentum.jouleSecond);
      expect(q.relativeUncertainty, 0);

      q = AngularMomentum(Js: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, AngularMomentum.angularMomentumDimensions);
      expect(q.preferredUnits, AngularMomentum.jouleSecond);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = AngularMomentumUnits.energyTime(Energy.joules, Time.seconds);
      expect(u.name, 'joule seconds');
      expect(u.singular, 'joule second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'J sec');
      expect(u.abbrev2, 'J s');

      var u2 = AngularMomentumUnits.energyTime(Energy.joules, Time.minutes);
      expect(u2.name, 'joule minutes');
      expect(u2.singular, 'joule minute');
      expect(u2.convToMKS.toDouble(), 60.0);
      expect(u2.abbrev1, 'J min');
      expect(u2.abbrev2, 'J min');

      var q1 = AngularMomentum(Js: 60);
      var q2 = AngularMomentum.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
