import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Torque', () {
    test('constructors', () {
      var q = Torque();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Torque.torqueDimensions);
      expect(q.preferredUnits, Torque.newtonMeters);
      expect(q.relativeUncertainty, 0);

      q = Torque(Nm: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Torque.torqueDimensions);
      expect(q.preferredUnits, Torque.newtonMeters);
      expect(q.relativeUncertainty, 0.001);
    });
  });

  test('units', () {
    var u = TorqueUnits.forceLength(Force.newtons, Length.meters);
    expect(u.name, 'newton meters');
    expect(u.singular, 'newton meter');
    expect(u.convToMKS.toDouble(), 1.0);
    expect(u.abbrev1, "N m");
    expect(u.abbrev2, "N m");

    var u2 = TorqueUnits.forceLength(Force.newtons, Length.millimeters);
    expect(u2.name, 'newton millimeters');
    expect(u2.singular, 'newton millimeter');
    expect(u2.convToMKS.toDouble(), 0.001);
    expect(u2.abbrev1, "N mm");
    expect(u2.abbrev2, "N mm");

    var q1 = Torque(Nm: 1.0);
    var q2 = Torque.inUnits(1000.0, u2);
    expect(q1 == q2, true);
    expect(q1.toString(), '1 N m');
    expect(q2.toString(), '1000 N mm');
  });
}
