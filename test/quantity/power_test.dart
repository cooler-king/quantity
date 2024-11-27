import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Power', () {
    test('constructors', () {
      var q = Power();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.watts);
      expect(q.relativeUncertainty, 0);

      q = Power(W: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.watts);
      expect(q.relativeUncertainty, 0.001);

      q = Power(kW: 1);
      expect(q.valueSI.toDouble(), 1000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.kilowatts);
      expect(q.relativeUncertainty, 0);

      q = Power(MW: 1);
      expect(q.valueSI.toDouble(), 1000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.megawatts);
      expect(q.relativeUncertainty, 0);
    });

    test('units', () {
      var u = PowerUnits.energyPerTime(Energy.joules, Time.seconds);
      expect(u.name, 'joules per second');
      expect(u.singular, 'joule per second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'J / sec');
      expect(u.abbrev2, 'J s\u{207b}\u{00b9}');

      var evPerMill =
          PowerUnits.energyPerTime(Energy.electronVolts, Time.milliseconds);
      expect(evPerMill.name, 'electronvolts per millisecond');
      expect(evPerMill.singular, 'electronvolt per millisecond');
      expect(evPerMill.convToMKS.toDouble(), 1.60217653e-19 * 1000.0);
      expect(evPerMill.abbrev1, 'eV / msec');
      expect(evPerMill.abbrev2, 'eV ms\u{207b}\u{00b9}');

      var q1 = Power(W: 1.60217653e-16);
      var q2 = Power.inUnits(1.0, evPerMill);
      expect(q1 == q2, true);
    });
  });
}
