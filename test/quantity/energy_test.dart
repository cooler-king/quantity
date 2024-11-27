import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Energy', () {
    test('constructors', () {
      var q = Energy();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Energy.energyDimensions);
      expect(q.preferredUnits, Energy.joules);
      expect(q.relativeUncertainty, 0);

      q = Energy(J: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Energy.energyDimensions);
      expect(q.preferredUnits, Energy.joules);
      expect(q.relativeUncertainty, 0.001);

      q = Energy(eV: 1);
      expect(q.valueSI.toDouble(), 1.60217653e-19);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Energy.energyDimensions);
      expect(q.preferredUnits, Energy.electronVolts);
      expect(q.relativeUncertainty, 0);
    });

    test('toMass', () {
      var e = Energy(J: 1);
      var m = e.toMass();

      expect(m.valueSI.toDouble(), 1.1126500560536185e-17);

      e = Energy(J: 2.2);
      m = e.toMass();
      expect(m.valueSI.toDouble(), 2.447830123317961e-17);
    });

    test('units', () {
      var u = EnergyUnits.powerTime(Power.watts, Time.seconds);
      expect(u.name, 'watt seconds');
      expect(u.singular, 'watt second');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'W sec');
      expect(u.abbrev2, 'W s');

      var u2 = EnergyUnits.powerTime(Power.kilowatts, Time.hours);
      expect(u2.name, 'kilowatt hours');
      expect(u2.singular, 'kilowatt hour');
      expect(u2.convToMKS.toDouble(), 1000.0 * 3600.0);
      expect(u2.abbrev1, 'kW hrs');
      expect(u2.abbrev2, 'kW h');

      var q1 = Energy(J: 3600000.0);
      var q2 = Energy.inUnits(1.0, u2);
      expect(q1 == q2, true);
    });
  });
}
