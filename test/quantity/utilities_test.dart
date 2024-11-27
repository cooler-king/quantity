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
}
