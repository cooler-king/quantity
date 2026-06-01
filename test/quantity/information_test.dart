import 'dart:math';

import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('Information', () {
    test('constructors', () {
      // default ctor, bits 0
      var info = Information(bits: 0);
      expect(info.valueSI, Double.zero);
      expect(info.valueSI is Integer, true);
      expect(info.dimensions, Information.informationDimensions);
      expect(info.preferredUnits, Information.bits);
      expect(info.relativeUncertainty, 0);

      // default ctor, bits +
      info = Information(bits: 42);
      expect(info.valueSI.toDouble(), 42);
      expect(info.valueSI is Integer, true);
      expect(info.dimensions, Information.informationDimensions);
      expect(info.preferredUnits, Information.bits);
      expect(info.relativeUncertainty, 0);

      // default ctor, bits -
      info = Information(bits: -99.33);
      expect(info.valueSI.toDouble(), -99.33);
      expect(info.valueSI is Double, true);
      expect(info.dimensions, Information.informationDimensions);
      expect(info.preferredUnits, Information.bits);
      expect(info.relativeUncertainty, 0);

      // default ctor, bytes
      info = Information(B: 12.1);
      expect(info.valueSI.toDouble(), 96.8);
      expect(info.preferredUnits, Information.bytes);
      expect(info.relativeUncertainty, 0);

      // default ctor, kibibytes
      info = Information(KiB: 1);
      expect(info.valueSI.toDouble(), 8 * 1024);
      expect(info.preferredUnits, Information.kibibytes);

      // default ctor, mebibytes
      info = Information(MiB: 1);
      expect(info.valueSI.toDouble(), 8 * pow(2, 20));
      expect(info.preferredUnits, Information.mebibytes);

      // default ctor, gibibytes
      info = Information(GiB: 1);
      expect(info.valueSI.toDouble(), 8 * pow(2, 30));
      expect(info.preferredUnits, Information.gibibytes);

      // default ctor, tebibytes
      info = Information(TiB: 1);
      expect(info.valueSI.toDouble(), 8 * pow(2, 40));
      expect(info.preferredUnits, Information.tebibytes);
    });

    test('misc, inUnits, and constant constructors plus binary unit values and derive', () {
      // misc ctor
      final infMisc = Information.misc(1024.0);
      expect(infMisc.valueSI.toDouble(), 1024.0);

      // inUnits ctor
      final infUnits = Information.inUnits(4.0, Information.nibbles);
      expect(infUnits.valueSI.toDouble(), 16.0);

      // constant ctor
      const infConst =
          Information.constant(Double.constant(128.0), units: null);
      expect(infConst.valueSI.toDouble(), 128.0);

      // Convenience units
      expect(Information.nibbles.valueSI.toDouble(), 4.0);
      expect(Information.kilobits.valueSI.toDouble(), 1000.0);
      expect(Information.megabits.valueSI.toDouble(), 1e6);
      expect(Information.gigabits.valueSI.toDouble(), 1e9);
      expect(Information.terabits.valueSI.toDouble(), 1e12);

      // Binary units
      expect(Information.pebibytes.valueSI.toDouble(), 8.0 * pow(2, 50));
      expect(Information.exbibytes.valueSI.toDouble(), 8.0 * pow(2, 60));
      expect(Information.zebibytes.valueSI.toDouble(), 8.0 * pow(2, 70));
      expect(Information.yobibytes.valueSI.toDouble(), 8.0 * pow(2, 80));

      // derive units
      final derived =
          Information.bits.derive('kilo', 'k', 1000.0) as InformationUnits;
      expect(derived.name, 'kilobits');
      expect(derived.abbrev1, 'kbit');
      expect(derived.quantityType, Information);
    });
  });
}
