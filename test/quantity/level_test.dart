import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('FieldLevel', () {
    test('constructors', () {
      FieldLevel q = new FieldLevel(new Force(N: 10), new Force(N: 10));
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Level.levelDimensions);
      expect(q.preferredUnits, Level.nepers);
      expect(q.relativeUncertainty, 0);

      q = new FieldLevel(new Force(N: 100), new Force(N: 10));
      expect(q.valueSI?.toDouble(), 1.151292546497023);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Level.levelDimensions);
      expect(q.preferredUnits, Level.nepers);
      expect(q.relativeUncertainty, 0);
    });
  });

  group('PowerLevel', () {
    test('constructors', () {
      PowerLevel q = new PowerLevel(new Power(W: 10), new Power(W: 10));
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Level.levelDimensions);
      expect(q.preferredUnits, Level.nepers);
      expect(q.relativeUncertainty, 0);

      q = new PowerLevel(new Power(W: 100), new Power(W: 10));
      expect(q.valueSI?.toDouble(), 1.151292546497023);
      expect(q.valueSI is Double, true);
      expect(q.dimensions, Level.levelDimensions);
      expect(q.preferredUnits, Level.nepers);
      expect(q.relativeUncertainty, 0);
    });
  });
}
