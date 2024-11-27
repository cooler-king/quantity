import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

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
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, DynamicViscosity.dynamicViscosityDimensions);
      expect(q.preferredUnits, DynamicViscosity.pascalSeconds);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          DynamicViscosityUnits.pressureTime(Pressure.pascals, Time.seconds);
      expect(u.name, 'pascal seconds');
      expect(u.singular, 'pascal second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'Pa sec');
      expect(u.abbrev2, 'Pa s');

      var u2 =
          DynamicViscosityUnits.pressureTime(Pressure.pascals, Time.minutes);
      expect(u2.name, 'pascal minutes');
      expect(u2.singular, 'pascal minute');
      expect(u2.convToMKS.toDouble(), 60.0);
      expect(u2.abbrev1, 'Pa min');
      expect(u2.abbrev2, 'Pa min');

      var q1 = DynamicViscosity(Pas: 60.0);
      var q2 = DynamicViscosity.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
