import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('InformationRate', () {
    test('constructors', () {
      InformationRate q = new InformationRate();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.bitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new InformationRate(bps: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.bitsPerSecond);
      expect(q.relativeUncertainty, 0.001);

      q = new InformationRate(kbps: 1);
      expect(q.valueSI?.toDouble(), 1000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.kilobitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new InformationRate(Mbps: 1);
      expect(q.valueSI?.toDouble(), 1000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.megabitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new InformationRate(Gbps: 1);
      expect(q.valueSI?.toDouble(), 1000000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.gigabitsPerSecond);
      expect(q.relativeUncertainty, 0);

      q = new InformationRate(Tbps: 1);
      expect(q.valueSI?.toDouble(), 1000000000000);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, InformationRate.informationRateDimensions);
      expect(q.preferredUnits, InformationRate.terabitsPerSecond);
      expect(q.relativeUncertainty, 0);
    });
  });
}
