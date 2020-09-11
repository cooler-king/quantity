import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Information', () {
    test('constructors', () {
      // Default ctor: bits 0
      Information i = new Information(bits: 0);
      expect(i, isNotNull);
      expect(i.valueSI, Double.zero);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.bits);

      // Default ctor: bits +
      i = new Information(bits: 8);
      expect(i, isNotNull);
      expect(i.valueSI.toInt(), 8);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.bits);

      // Default ctor: bits -
      i = new Information(bits: -999);
      expect(i, isNotNull);
      expect(i.valueSI.toInt(), -999);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.bits);

      // Default ctor: B
      i = new Information(B: 1);
      expect(i, isNotNull);
      expect(i.valueSI.toInt(), 8);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.bytes);

      // Default ctor: kB
      i = new Information(kB: 1);
      expect(i, isNotNull);
      expect(i.valueSI.toInt(), 8 * 1024);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.kilobytes);

      // Default ctor: MB
      i = new Information(MB: 1);
      expect(i, isNotNull);
      expect(i.valueSI.toDouble(), 8 * 1024 * 1024);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.megabytes);

      // Default ctor: GB
      i = new Information(GB: 1);
      expect(i, isNotNull);
      expect(i.valueSI.toDouble(), 8 * 1024 * 1024 * 1024);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.gigabytes);

      // // Default ctor: TB
      i = new Information(TB: 1);
      expect(i, isNotNull);
      expect(i.valueSI.toDouble(), 8 * 1024 * 1024 * 1024 * 1024);
      expect(i.valueSI is Integer, true);
      expect(i.dimensions, Information.informationDimensions);
      expect(i.preferredUnits, Information.terabytes);
    });

    test('operator - addition', () {
      dynamicQuantityTyping = true;
      final Information a = new Information(bits: 5);
      final Information b = new Information(bits: 64);

      final dynamic c = a + b;
      expect(c.valueSI.toInt(), 69);
      expect(c.valueSI is Integer, true);
      expect(c is Information, true);

      final dynamic d = a + b + b + a;
      expect(d.valueSI.toInt(), 138);
      expect(d.valueSI is Integer, true);
      expect(d is Information, true);
    });

    test('operator - subtraction', () {
      dynamicQuantityTyping = true;
      final Information a = new Information(bits: 64);
      final Information b = new Information(bits: 5);
      final Information c = new Information(bits: 13);

      final dynamic aa = a - b;
      expect(aa.valueSI.toInt(), 59);
      expect(aa.valueSI is Integer, true);
      expect(aa is Information, true);

      final dynamic bb = a - c;
      expect(bb.valueSI.toInt(), 51);
      expect(bb.valueSI is Integer, true);
      expect(bb is Information, true);
    });

    test('operator - multiplication', () {
      dynamicQuantityTyping = true;
      final Information a = new Information(bits: 2);
      final Information b = new Information(bits: 6);

      final dynamic aa = a * 6;
      expect(aa.valueSI.toInt(), 12);
      expect(aa.valueSI is Integer, true);
      expect(aa.dimensions, Information.informationDimensions);

      try {
        final dynamic bb = a * b;
        fail('Multiplication should have thrown an exception.');
      } catch (e) {
        expect(e is QuantityException, true);
      }
    });
  });
}
