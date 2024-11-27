import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('VolumeFlowRate', () {
    test('constructors', () {
      var q = VolumeFlowRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, VolumeFlowRate.volumeFlowRateDimensions);
      expect(q.preferredUnits, VolumeFlowRate.cubicMetersPerSecond);
      expect(q.relativeUncertainty, 0);

      q = VolumeFlowRate(cubicMetersPerSecond: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, VolumeFlowRate.volumeFlowRateDimensions);
      expect(q.preferredUnits, VolumeFlowRate.cubicMetersPerSecond);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u =
          VolumeFlowRateUnits.volumePerTime(Volume.cubicMeters, Time.seconds);
      expect(u.name, 'cubic meters per second');
      expect(u.singular, 'cubic meter per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'm\u{00b3} / sec');
      expect(u.abbrev2, 'm\u{00b3} s\u{207b}\u{00b9}');

      var litersPerMinute =
          VolumeFlowRateUnits.volumePerTime(Volume.liters, Time.minutes);
      expect(litersPerMinute.name, 'liters per minute');
      expect(litersPerMinute.singular, 'liter per minute');
      expect(litersPerMinute.convToMKS.toDouble(), 0.001 / 60.0);
      expect(litersPerMinute.abbrev1, "L / min");
      expect(litersPerMinute.abbrev2, "L min\u{207b}\u{00b9}");

      var q1 = VolumeFlowRate(cubicMetersPerSecond: 1.0);
      var q2 = VolumeFlowRate.inUnits(60000.0, litersPerMinute);
      expect(q1 == q2, true);
      expect(q1.toString(), '1 m\u{00b3} s\u{207b}\u{00b9}');
      expect(q2.toString(), '60 000 L min\u{207b}\u{00b9}');
    });
  });
}
