import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Pressure', () {
    test('constructors', () {
      var q = Pressure();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.pascals);
      expect(q.relativeUncertainty, 0);

      q = Pressure(Pa: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.pascals);
      expect(q.relativeUncertainty, 0.001);

      q = Pressure(bars: 1);
      expect(q.valueSI.toDouble(), 100000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Pressure.pressureDimensions);
      expect(q.preferredUnits, Pressure.bars);
      expect(q.relativeUncertainty, 0);
    });

    test('force by area equation', () {
      var area = Area(m2: 1);
      var force = Force(N: 10);

      var q = force / area;
      expect(q.valueSI is Integer, true);
      expect(q.valueSI.toDouble(), 10.0);
      expect(q is Pressure, true);
    });

    test('units', () {
      var u = PressureUnits.forcePerArea(Force.newtons, Area.squareMeters);
      expect(u.name, "newtons per square meter");
      expect(u.singular, "newton per square meter");
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, "N / m\u{00b2}");
      expect(u.abbrev2, "N m\u{207b}\u{00b2}");

      var nPerHa = PressureUnits.forcePerArea(Force.newtons, Area.hectares);
      expect(nPerHa.name, "newtons per hectare");
      expect(nPerHa.singular, "newton per hectare");
      expect(nPerHa.convToMKS.toDouble(), 0.0001);
      expect(nPerHa.abbrev1, "N / ha");
      expect(nPerHa.abbrev2, "N ha\u{207b}\u{00b9}");

      var q1 = Pressure(Pa: 1.0);
      var q2 = Pressure.inUnits(1.0e4, nPerHa);
      expect(q1 == q2, true);
    });
  });
}
