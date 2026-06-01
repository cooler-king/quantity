import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('AI Readiness & Natural Language Processing', () {
    test('Quantity.parse - Simple Units', () {
      final q1 = Quantity.parse('5 m');
      expect(q1, isA<Length>());
      expect(q1.valueSI.toDouble(), equals(5.0));

      final q2 = Quantity.parse('-2.5 s');
      expect(q2, isA<Time>());
      expect(q2.valueSI.toDouble(), equals(-2.5));

      final q3 = Quantity.parse('42');
      expect(q3, isA<Scalar>());
      expect(q3.valueSI.toDouble(), equals(42.0));
    });

    test('Quantity.parse - Prefixes', () {
      final q1 = Quantity.parse('2.5 km');
      expect(q1, isA<Length>());
      expect(q1.valueSI.toDouble(), equals(2500.0));

      final q2 = Quantity.parse('500 mg');
      expect(q2, isA<Mass>());
      expect(q2.valueSI.toDouble(), equals(0.0005));
    });

    test('Quantity.parse - spacing variations', () {
      // No space between number and unit
      final q1 = Quantity.parse('5m');
      expect(q1, isA<Length>());
      expect(q1.valueSI.toDouble(), equals(5.0));

      // Extra spaces between number and unit
      final q2 = Quantity.parse('5   m');
      expect(q2, isA<Length>());
      expect(q2.valueSI.toDouble(), equals(5.0));

      // Spaces around division slash
      final q3 = Quantity.parse('120 km / h');
      expect(q3, isA<Speed>());
      expect(q3.valueSI.toDouble(), closeTo(33.333333, 0.0001));

      // Spaces around multiplication asterisk
      final q4 = Quantity.parse('10 kg * m / s^2');
      expect(q4, isA<Force>());
      expect(q4.valueSI.toDouble(), equals(10.0));

      // Spaces around carets
      final q5 = Quantity.parse('9.8 m / s ^ 2');
      expect(q5, isA<Acceleration>());
      expect(q5.valueSI.toDouble(), equals(9.8));

      final q6 = Quantity.parse('9.8 m/s ^2');
      expect(q6, isA<Acceleration>());
      expect(q6.valueSI.toDouble(), equals(9.8));
    });

    test('Quantity.parse - Compound Units', () {
      final q1 = Quantity.parse('120 km/h');
      expect(q1, isA<Speed>());
      expect(q1.valueSI.toDouble(), closeTo(33.333333, 0.0001));

      final q2 = Quantity.parse('9.8 m/s^2');
      expect(q2, isA<Acceleration>());
      expect(q2.valueSI.toDouble(), equals(9.8));

      final q3 = Quantity.parse('10 kg*m/s^2');
      expect(q3, isA<Force>());
      expect(q3.valueSI.toDouble(), equals(10.0));

      final q4 = Quantity.parse('15 N*m');
      expect(q4, isA<Torque>());
      expect(q4.valueSI.toDouble(), equals(15.0));

      final q5 = Quantity.parse('15 N·m');
      expect(q5, isA<Torque>());
      expect(q5.valueSI.toDouble(), equals(15.0));

      final q6 = Quantity.parse('5 m^5');
      expect(q6, isA<MiscQuantity>());
      expect(q6.valueSI.toDouble(), equals(5.0));
    });

    test('Quantity.parse - Invalid inputs', () {
      expect(() => Quantity.parse('abc'), throwsFormatException);
      expect(() => Quantity.parse('10 invalidUnit'), throwsFormatException);
      expect(() => Quantity.parse('5 m^abc'), throwsFormatException);
    });

    test('Quantity.getUnitSymbols', () {
      final speedSymbols = Quantity.getUnitSymbols(Speed);
      expect(speedSymbols, contains('m/s'));
      expect(speedSymbols, contains('mph'));
      expect(speedSymbols, contains('km/h'));

      final lengthSymbols = Quantity.getUnitSymbols(Length);
      expect(lengthSymbols, contains('m'));
      expect(lengthSymbols, contains('ft'));
      expect(lengthSymbols, contains('in'));

      final accelSymbols = Quantity.getUnitSymbols(Acceleration);
      expect(accelSymbols, contains('m/s^2'));
    });

    test('Dimensions.describe', () {
      expect(Dimensions.describe(Length.lengthDimensions), equals('Length^1'));
      expect(Dimensions.describe(Speed.speedDimensions),
          equals('Length^1 / Time^1'));
      expect(Dimensions.describe(Acceleration.accelerationDimensions),
          equals('Length^1 / Time^2'));
      expect(Dimensions.describe(Dimensions()), equals('dimensionless'));
    });

    test('Quantity.checkDimensionalConsistency', () {
      final vars = {
        's': Length.lengthDimensions,
        'u': Speed.speedDimensions,
        't': Time.timeDimensions,
        'a': Acceleration.accelerationDimensions,
      };

      // s = u*t + 0.5*a*t^2 (Consistent)
      expect(
          Quantity.checkDimensionalConsistency(
              vars, 's = u * t + 0.5 * a * t^2'),
          isTrue);

      // s = u*t + a (Inconsistent: Length != Length + Acceleration)
      expect(
          Quantity.checkDimensionalConsistency(vars, 's = u * t + a'), isFalse);

      // s = u*t + 5 (Inconsistent: Length != Length + Scalar)
      expect(
          Quantity.checkDimensionalConsistency(vars, 's = u * t + 5'), isFalse);

      // Invalid syntax (Inconsistent/Unparseable)
      expect(
          Quantity.checkDimensionalConsistency(vars, 's = u * * t'), isFalse);

      // single expression evaluation (no '=')
      expect(Quantity.checkDimensionalConsistency(vars, 'u * t'), isTrue);

      // division '/' (e.g. u = s / t)
      expect(Quantity.checkDimensionalConsistency(vars, 'u = s / t'), isTrue);

      // negative exponent '^-1' (e.g. u = s * t^-1)
      expect(
          Quantity.checkDimensionalConsistency(vars, 'u = s * t^-1'), isTrue);

      // negative exponent '^-1' alternative representation
      expect(
          Quantity.checkDimensionalConsistency(vars, 'u = s * t^-1.0'), isTrue);

      // unary minus and plus
      expect(Quantity.checkDimensionalConsistency(vars, 's = -u * +t'), isTrue);

      // parenthesis handling
      expect(Quantity.checkDimensionalConsistency(vars, 's = (u * t)'), isTrue);

      // parenthesis error (unclosed)
      expect(Quantity.checkDimensionalConsistency(vars, 's = (u * t'), isFalse);

      // parenthesis error (extra closed parenthesis / trailing tokens)
      expect(
          Quantity.checkDimensionalConsistency(vars, 's = u * t )'), isFalse);

      // exponent syntax error (missing exponent after ^)
      expect(Quantity.checkDimensionalConsistency(vars, 's = u * t^'), isFalse);

      // empty expression error
      expect(Quantity.checkDimensionalConsistency(vars, ''), isFalse);
    });

    test('Quantity.jsonSchema', () {
      final schema = Quantity.jsonSchema;
      expect(schema['type'], equals('object'));
      expect(schema['properties'], contains('type'));
      expect(schema['properties'], contains('value'));
      expect(schema['properties'], contains('dimensions'));
    });
  });
}
