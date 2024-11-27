import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('InformationRate', () {
    test('constructors', () {
      var q = InformationRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.bitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = InformationRate(bps: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.bitsPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = InformationRate(kbps: 1);
      expect(q.valueSI.toDouble(), 1000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.kilobitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = InformationRate(Mbps: 1);
      expect(q.valueSI.toDouble(), 1000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.megabitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = InformationRate(Gbps: 1);
      expect(q.valueSI.toDouble(), 1000000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.gigabitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = InformationRate(Tbps: 1);
      expect(q.valueSI.toDouble(), 1000000000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.terabitsPerSecond);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = InformationRateUnits.informationPerTime(
          Information.bits, Time.seconds);
      expect(u.name, 'bits per second');
      expect(u.singular, 'bit per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'bit / sec');
      expect(u.abbrev2, 'bit s\u{207b}\u{00b9}');

      var u2 = InformationRateUnits.informationPerTime(
          Information.bytes, Time.minutes);
      expect(u2.name, 'bytes per minute');
      expect(u2.singular, 'byte per minute');
      expect(u2.convToMKS.toDouble(), 8.0 / 60.0);
      expect(u2.abbrev1, 'B / min');
      expect(u2.abbrev2, 'B min\u{207b}\u{00b9}');

      var q1 = InformationRate(bps: 8.0 / 60.0);
      var q2 = InformationRate.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
