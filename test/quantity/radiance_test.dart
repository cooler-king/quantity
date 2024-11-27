import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Radiance', () {
    test('constructors', () {
      var q = Radiance();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Radiance.radianceDimensions);
      expect(q.preferredUnits, Radiance.wattsPerSquareMeterSteradian);
      expect(q.relativeUncertainty, 0);

      q = Radiance(wattsPerSquareMeterSteradian: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Radiance.radianceDimensions);
      expect(q.preferredUnits, Radiance.wattsPerSquareMeterSteradian);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = RadianceUnits.powerPerAreaSolidAngle(
          Power.watts, Area.squareMeters, SolidAngle.steradians);
      expect(u.name, 'watts per square meter steradian');
      expect(u.singular, 'watt per square meter steradian');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'W / m\u{00b2} sr');
      expect(u.abbrev2, 'W m\u{207b}\u{00b2} sr\u{207b}\u{00b9}');

      var u2 = RadianceUnits.powerPerAreaSolidAngle(Power.kilowatts,
          Area.hectares, SolidAngleUnits.angleSquared(Angle.degrees));
      expect(u2.name, 'kilowatts per hectare degree squared');
      expect(u2.singular, 'kilowatt per hectare degree squared');
      expect(u2.convToMKS.toDouble(), 1000.0 * 3282.8063500118554 / 10000.0);

      var q1 = Radiance(wattsPerSquareMeterSteradian: 328.28063500118554);
      var q2 = Radiance.inUnits(1.0, u2);
      expect(q1 == q2, true);
      expect(q1.toString(),
          '328.280 635 001 185 54 W m\u{207b}\u{00b2} sr\u{207b}\u{00b9}');
      expect(q2.toString(), '1 kW ha\u{207b}\u{00b9} deg\u{207b}\u{00b2}');
    });
  });
}
