import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Information', () {
    test('constructors -default', () {
      // default ctor, bits 0
      Information info = new Information(bits: 0);
      expect(info.valueSI, Double.zero);
      expect(info.valueSI is Integer, true);
      expect(info.dimensions, Information.informationDimensions);
      expect(info.preferredUnits, Information.bits);
      expect(info.relativeUncertainty, 0);

      // default ctor, bits +
      info = new Information(bits: 42);
      expect(info.valueSI?.toDouble() == 42, true);
      expect(info.valueSI is Integer, true);
      expect(info.dimensions, Information.informationDimensions);
      expect(info.preferredUnits, Information.bits);
      expect(info.relativeUncertainty, 0);

      // default ctor, bits -
      info = new Information(bits: -99.33);
      expect(info.valueSI?.toDouble() == -99.33, true);
      expect(info.valueSI is Double, true);
      expect(info.dimensions, Information.informationDimensions);
      expect(info.preferredUnits, Information.bits);
      expect(info.relativeUncertainty, 0);

      // default ctor, bytes
      info = new Information(B: 12.1);
      expect(info.valueSI?.toDouble(), 96.8);
      expect(info.preferredUnits, Information.bytes);
      expect(info.relativeUncertainty, 0);

      // default ctor, kibibytes
      info = new Information(KiB: 1);
      expect(info.valueSI?.toDouble(), 8 * 1024);
      expect(info.preferredUnits, Information.kibibytes);

      // default ctor, mebibytes
      info = new Information(MiB: 1);
      expect(info.valueSI?.toDouble(), 8 * pow(2, 20));
      expect(info.preferredUnits, Information.mebibytes);

      // default ctor, gibibytes
      info = new Information(GiB: 1);
      expect(info.valueSI?.toDouble(), 8 * pow(2, 30));
      expect(info.preferredUnits, Information.gibibytes);

      // default ctor, tebibytes
      info = new Information(TiB: 1);
      expect(info.valueSI?.toDouble(), 8 * pow(2, 40));
      expect(info.preferredUnits, Information.tebibytes);
    });
  });
}
