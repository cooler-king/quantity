import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Power', () {
    test('constructors', () {
      Power q = new Power();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.watts);
      expect(q.relativeUncertainty, 0);

      q = new Power(W: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.watts);
      expect(q.relativeUncertainty, 0.001);

      q = new Power(kW: 1);
      expect(q.valueSI?.toDouble(), 1000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.kilowatts);
      expect(q.relativeUncertainty, 0);

      q = new Power(MW: 1);
      expect(q.valueSI?.toDouble(), 1000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Power.powerDimensions);
      expect(q.preferredUnits, Power.megawatts);
      expect(q.relativeUncertainty, 0);
    });
  });
}
