import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('RadiantIntensity', () {
    test('constructors', () {
      var q = RadiantIntensity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, RadiantIntensity.radiantIntensityDimensions);
      expect(q.preferredUnits, RadiantIntensity.wattsPerSteradian);
      expect(q.relativeUncertainty, 0);

      q = RadiantIntensity(wattsPerSteradian: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, RadiantIntensity.radiantIntensityDimensions);
      expect(q.preferredUnits, RadiantIntensity.wattsPerSteradian);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = RadiantIntensityUnits.powerPerSolidAngle(
          Power.watts, SolidAngle.steradians);
      expect(u.name, 'watts per steradian');
      expect(u.singular, 'watt per steradian');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'W / sr');
      expect(u.abbrev2, 'W sr\u{207b}\u{00b9}');

      var u2 = RadiantIntensityUnits.powerPerSolidAngle(
          Power.kilowatts, SolidAngleUnits.angleSquared(Angle.degrees));
      expect(u2.name, 'kilowatts per degree squared');
      expect(u2.singular, 'kilowatt per degree squared');
      expect(u2.convToMKS.toDouble(), 1000.0 * 3282.806350011855);

      var q1 = RadiantIntensity(wattsPerSteradian: 3.282806350011855e6);
      var q2 = RadiantIntensity.inUnits(1.0, u2);
      expect(q1 == q2, true);
      expect(q1.toString(), '3 282 806.350 011 855 W sr\u{207b}\u{00b9}');
      expect(q2.toString(), '1 kW deg\u{207b}\u{00b2}');
    });
  });
}
