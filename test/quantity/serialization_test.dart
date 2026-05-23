import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('JSON Serialization', () {
    test('Dimensions serialization', () {
      final d = Dimensions.fromMap({'Length': 1, 'Time': -2});
      final json = d.toJson();
      expect(json, {'Length': 1, 'Time': -2});

      final d2 = Dimensions.fromJson(json);
      expect(d2, d);
    });

    test('Number serialization - Integer', () {
      final num = Integer(42);
      final json = num.toJson();
      expect(json, {'i': 42});

      final num2 = Number.fromJson(json);
      expect(num2, num);
      expect(num2 is Integer, true);
    });

    test('Number serialization - Double', () {
      final num = Double(3.1415);
      final json = num.toJson();
      expect(json, {'d': 3.1415});

      final num2 = Number.fromJson(json);
      expect(num2, num);
      expect(num2 is Double, true);
    });

    test('Number serialization - Precise', () {
      final num = Precise('1234567890.12345678901234567890');
      final json = num.toJson();
      expect(json, {'precise': '1234567890.12345678901234567890'});

      final num2 = Number.fromJson(json);
      expect(num2, num);
      expect(num2 is Precise, true);
    });

    test('Number serialization - Imaginary', () {
      final num = Imaginary(Double(5.5));
      final json = num.toJson();
      expect(json, {
        'imag': {'d': 5.5}
      });

      final num2 = Number.fromJson(json);
      expect(num2, num);
      expect(num2 is Imaginary, true);
    });

    test('Number serialization - Complex', () {
      final num = Complex(Integer(3), Imaginary(Double(4)));
      final json = num.toJson();
      expect(json, {
        'real': {'i': 3},
        'imag': {
          'imag': {'d': 4.0}
        }
      });

      final num2 = Number.fromJson(json);
      expect(num2, num);
      expect(num2 is Complex, true);
    });

    test('Quantity serialization - Typed subclass (Length)', () {
      final q = Length(m: 10, uncert: 0.05);
      final json = q.toJson();
      expect(json['type'], 'Length');
      expect(json['uncertainty'], 0.05);

      final q2 = Quantity.fromJson(json);
      expect(q2, q);
      expect(q2 is Length, true);
    });

    test('Quantity serialization - MiscQuantity', () {
      final q = MiscQuantity(
          Integer(100), Dimensions.fromMap({'Length': 1, 'Time': -1}), 0.01);
      final json = q.toJson();
      expect(json['type'], 'MiscQuantity');

      final q2 = Quantity.fromJson(json);
      expect(q2, q);
      expect(q2 is MiscQuantity, true);
    });
  });
}
