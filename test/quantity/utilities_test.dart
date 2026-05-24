import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('utilities', () {
    test('unicodeExponent', () {
      expect(unicodeExponent(0), '\u{2070}');
      expect(unicodeExponent(1), '\u{00b9}');
      expect(unicodeExponent(2), '\u{00b2}');
      expect(unicodeExponent(3), '\u{00b3}');
      expect(unicodeExponent(4), '\u{2074}');
      expect(unicodeExponent(5), '\u{2075}');
      expect(unicodeExponent(6), '\u{2076}');
      expect(unicodeExponent(7), '\u{2077}');
      expect(unicodeExponent(8), '\u{2078}');
      expect(unicodeExponent(9), '\u{2079}');

      expect(unicodeExponent(-0), '\u{2070}');
      expect(unicodeExponent(-1), '\u{207b}\u{00b9}');
      expect(unicodeExponent(-2), '\u{207b}\u{00b2}');
      expect(unicodeExponent(-3), '\u{207b}\u{00b3}');
      expect(unicodeExponent(-4), '\u{207b}\u{2074}');
      expect(unicodeExponent(-5), '\u{207b}\u{2075}');
      expect(unicodeExponent(-6), '\u{207b}\u{2076}');
      expect(unicodeExponent(-7), '\u{207b}\u{2077}');
      expect(unicodeExponent(-8), '\u{207b}\u{2078}');
      expect(unicodeExponent(-9), '\u{207b}\u{2079}');

      expect(unicodeExponent(0000), '\u{2070}');
      expect(unicodeExponent(007), '\u{2077}');
      expect(unicodeExponent(00700), '\u{2077}\u{2070}\u{2070}');
      expect(unicodeExponent(1), '\u{00b9}');
      expect(unicodeExponent(23), '\u{00b2}\u{00b3}');
      expect(unicodeExponent(345), '\u{00b3}\u{2074}\u{2075}');
      expect(unicodeExponent(456789),
          '\u{2074}\u{2075}\u{2076}\u{2077}\u{2078}\u{2079}');

      expect(unicodeExponent(-0000), '\u{2070}');
      expect(unicodeExponent(-007), '\u{207b}\u{2077}');
      expect(unicodeExponent(-00700), '\u{207b}\u{2077}\u{2070}\u{2070}');
      expect(unicodeExponent(-1), '\u{207b}\u{00b9}');
      expect(unicodeExponent(-23), '\u{207b}\u{00b2}\u{00b3}');
      expect(unicodeExponent(-345), '\u{207b}\u{00b3}\u{2074}\u{2075}');
      expect(unicodeExponent(-456789),
          '\u{207b}\u{2074}\u{2075}\u{2076}\u{2077}\u{2078}\u{2079}');

      expect(unicodeExponent(1.2), '\u{00b9}\u{02d9}\u{00b2}');
      expect(unicodeExponent(0.98765),
          '\u{2070}\u{02d9}\u{2079}\u{2078}\u{2077}\u{2076}\u{2075}');
    });

    group('condenseUnicodeSequences', () {
      test('null', () {
        expect(condenseUnicodeSequences(null), null);
      });

      test('single positive', () {
        expect(condenseUnicodeSequences('kg\u{2070}'), 'kg\u{2070}');
        expect(condenseUnicodeSequences('kg\u{00b9}'), 'kg\u{00b9}');
        expect(condenseUnicodeSequences('kg\u{00b2}'), 'kg\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{00b3}'), 'kg\u{00b3}');
        expect(condenseUnicodeSequences('kg\u{2074}'), 'kg\u{2074}');
        expect(condenseUnicodeSequences('kg\u{2075}'), 'kg\u{2075}');
        expect(condenseUnicodeSequences('kg\u{2076}'), 'kg\u{2076}');
        expect(condenseUnicodeSequences('kg\u{2077}'), 'kg\u{2077}');
        expect(condenseUnicodeSequences('kg\u{2078}'), 'kg\u{2078}');
        expect(condenseUnicodeSequences('kg\u{2079}'), 'kg\u{2079}');
      });

      test('single negative', () {
        expect(condenseUnicodeSequences('kg\u{207b}\u{2070}'),
            'kg\u{207b}\u{2070}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b9}'),
            'kg\u{207b}\u{00b9}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b3}'),
            'kg\u{207b}\u{00b3}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2074}'),
            'kg\u{207b}\u{2074}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2075}'),
            'kg\u{207b}\u{2075}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2076}'),
            'kg\u{207b}\u{2076}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2077}'),
            'kg\u{207b}\u{2077}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2078}'),
            'kg\u{207b}\u{2078}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2079}'),
            'kg\u{207b}\u{2079}');
      });

      test('positive positive', () {
        expect(condenseUnicodeSequences('kg\u{2070}\u{00b2}'), 'kg\u{2070}');
        expect(condenseUnicodeSequences('kg\u{00b9}\u{00b2}'), 'kg\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{00b2}\u{00b2}'), 'kg\u{2074}');
        expect(condenseUnicodeSequences('kg\u{00b3}\u{00b2}'), 'kg\u{2076}');
        expect(condenseUnicodeSequences('kg\u{2074}\u{00b2}'), 'kg\u{2078}');
        expect(condenseUnicodeSequences('kg\u{2075}\u{00b2}'),
            'kg\u{00b9}\u{2070}');
        expect(condenseUnicodeSequences('kg\u{2076}\u{00b2}'),
            'kg\u{00b9}\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{2077}\u{00b2}'),
            'kg\u{00b9}\u{2074}');
        expect(condenseUnicodeSequences('kg\u{2078}\u{00b2}'),
            'kg\u{00b9}\u{2076}');
        expect(condenseUnicodeSequences('kg\u{2079}\u{00b2}'),
            'kg\u{00b9}\u{2078}');
      });

      test('positive negative', () {
        expect(condenseUnicodeSequences('kg\u{2070}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{2070}');
        expect(condenseUnicodeSequences('kg\u{00b9}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{00b2}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{2074}');
        expect(condenseUnicodeSequences('kg\u{00b3}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{2076}');
        expect(condenseUnicodeSequences('kg\u{2074}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{2078}');
        expect(condenseUnicodeSequences('kg\u{2075}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b9}\u{2070}');
        expect(condenseUnicodeSequences('kg\u{2076}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b9}\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{2077}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b9}\u{2074}');
        expect(condenseUnicodeSequences('kg\u{2078}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b9}\u{2076}');
        expect(condenseUnicodeSequences('kg\u{2079}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{00b9}\u{2078}');
      });

      test('negative negative', () {
        expect(condenseUnicodeSequences('kg\u{207b}\u{2070}\u{207b}\u{00b2}'),
            'kg\u{2070}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b9}\u{207b}\u{00b2}'),
            'kg\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b2}\u{207b}\u{00b2}'),
            'kg\u{2074}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b3}\u{207b}\u{00b2}'),
            'kg\u{2076}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2074}\u{207b}\u{00b2}'),
            'kg\u{2078}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2075}\u{207b}\u{00b2}'),
            'kg\u{00b9}\u{2070}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2076}\u{207b}\u{00b2}'),
            'kg\u{00b9}\u{00b2}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2077}\u{207b}\u{00b2}'),
            'kg\u{00b9}\u{2074}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2078}\u{207b}\u{00b2}'),
            'kg\u{00b9}\u{2076}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{2079}\u{207b}\u{00b2}'),
            'kg\u{00b9}\u{2078}');
      });

      test('multiple terms', () {
        expect(condenseUnicodeSequences('kg\u{00b2}m\u{00b3}'),
            'kg\u{00b2}m\u{00b3}');
        expect(condenseUnicodeSequences('kg\u{207b}\u{00b2}m\u{207b}\u{00b3}'),
            'kg\u{207b}\u{00b2}m\u{207b}\u{00b3}');
        expect(condenseUnicodeSequences('kg\u{00b2}\u{2074}m\u{00b3}\u{00b2}'),
            'kg\u{2078}m\u{2076}');
        expect(
            condenseUnicodeSequences(
                'kg\u{00b2}\u{207b}\u{2074}m\u{00b3}\u{207b}\u{00b2}'),
            'kg\u{207b}\u{2078}m\u{207b}\u{2076}');
        expect(
            condenseUnicodeSequences(
                'kg\u{207b}\u{00b2}\u{207b}\u{2074}m\u{207b}\u{00b3}\u{207b}\u{00b2}'),
            'kg\u{2078}m\u{2076}');
      });
    });
  });

  group('exceptions and converters', () {
    test('NumberException and QuantityException toString', () {
      expect(
          NumberException('test msg').toString(), 'NumberException: test msg');
      expect(QuantityException('test msg').toString(),
          'QuantityException: test msg');
    });

    test('converters edge cases', () {
      expect(() => objToNumber('invalid'), throwsA(anything));
      expect(numberToNum(Imaginary(5)), 0);
      expect(numberToNum(Complex(Double(3.5), Imaginary(2.0))), 3.5);

      final pDec = Precise('10.5');
      expect(numberToNum(pDec), 10.5);

      final pInt = Precise('42');
      expect(numberToNum(pInt), 42);
    });
  });

  group('si utilities methods', () {
    test('dimensionsToTypeMap getter', () {
      // Force initialization of the real registry first
      final _ = Length(m: 5);
      final map = dimensionsToTypeMap;
      expect(map, isNotEmpty);
      expect(map[Length.lengthDimensions], Length);
    });

    test('siRegistryTrigger', () {
      var triggered = false;
      siRegistryTrigger = () {
        triggered = true;
      };
      // Trigger it via a registry-dependent function
      getRegisteredQuantityType(Length.lengthDimensions);
      expect(triggered, true);
    });

    test('siBaseQuantity and siDerivedQuantity', () {
      expect(siBaseQuantity(Length(m: 5)), true);
      expect(siBaseQuantity(Mass(kg: 10)), true);
      expect(siBaseQuantity(Time(s: 2)), true);
      expect(siBaseQuantity(Current(A: 1)), true);
      expect(siBaseQuantity(TemperatureInterval(K: 1)), true);
      expect(siBaseQuantity(Temperature(K: 300)), true);
      expect(siBaseQuantity(AmountOfSubstance(mol: 1)), true);
      expect(siBaseQuantity(LuminousIntensity(cd: 1)), true);

      expect(siBaseQuantity(Speed(metersPerSecond: 10)), false);
      expect(siDerivedQuantity(Speed(metersPerSecond: 10)), true);
      expect(siDerivedQuantity(Length(m: 5)), false);
    });

    test('areWithin', () {
      final l1 = Length(m: 10);
      final l2 = Length(m: 10.1);
      final tolerance1 = Length(m: 0.2);
      final tolerance2 = Length(m: 0.05);

      expect(areWithin(l1, l2, tolerance1), true);
      expect(areWithin(l1, l2, tolerance2), false);

      // Mismatched dimensions must throw DimensionsException
      expect(() => areWithin(l1, Speed(metersPerSecond: 10), tolerance1), throwsA(isA<DimensionsException>()));
    });

    test('logger record listener', () {
      logger.warning('Test warning log', 'MOCK_ERROR', StackTrace.current);
    });
  });
}
