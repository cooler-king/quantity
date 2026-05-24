import 'dart:math';
import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Dimensions Property-Based Tests', () {
    final rand = Random(42); // Seeded for reproducibility

    // The 9 base dimensions tracked by Dimensions class
    final dimensionKeys = [
      Dimensions.baseLengthKey,
      Dimensions.baseMassKey,
      Dimensions.baseTimeKey,
      Dimensions.baseTemperatureKey,
      Dimensions.baseCurrentKey,
      Dimensions.baseIntensityKey,
      Dimensions.baseAmountKey,
      Dimensions.baseAngleKey,
      Dimensions.baseSolidAngleKey,
    ];

    // Allowed exponents that are integers or half-integers (which are represented exactly in binary float)
    final allowedExponents = <num>[
      -3,
      -2.5,
      -2,
      -1.5,
      -1,
      -0.5,
      0,
      0.5,
      1,
      1.5,
      2,
      2.5,
      3
    ];

    // Generates a random Dimensions object
    Dimensions nextRandomDimensions() {
      final map = <String, num>{};
      // Randomly decide how many dimensions will have non-zero exponents
      final numNonZero = rand.nextInt(dimensionKeys.length + 1);
      final keys = List<String>.from(dimensionKeys)..shuffle(rand);

      for (var i = 0; i < numNonZero; i++) {
        final key = keys[i];
        final exponent =
            allowedExponents[rand.nextInt(allowedExponents.length)];
        if (exponent != 0) {
          map[key] = exponent;
        }
      }
      return Dimensions.fromMap(map);
    }

    test('Algebraic Properties', () {
      final scalar =
          Dimensions(); // No-arg constructor makes scalar (empty map)

      for (var i = 0; i < 1000; i++) {
        final a = nextRandomDimensions();
        final b = nextRandomDimensions();
        final c = nextRandomDimensions();

        // 1. Multiplicative Identity: A * Scalar == A
        expect(a * scalar, equals(a));
        expect(scalar * a, equals(a));

        // 2. Multiplicative Commutativity: A * B == B * A
        expect(a * b, equals(b * a));

        // 3. Multiplicative Associativity: (A * B) * C == A * (B * C)
        expect((a * b) * c, equals(a * (b * c)));

        // 4. Division Identity: A / Scalar == A, Scalar / A == A.inverse()
        expect(a / scalar, equals(a));
        expect(scalar / a, equals(a.inverse()));

        // 5. Division Invariant: A / B == A * B.inverse()
        expect(a / b, equals(a * b.inverse()));

        // 6. Self Division: A / a == Scalar
        expect(a / a, equals(scalar));

        // 7. Inverse Invariant: A * A.inverse() == Scalar
        expect(a * a.inverse(), equals(scalar));

        // 8. Double Inversion: A.inverse().inverse() == A
        expect(a.inverse().inverse(), equals(a));
      }
    });
  });
}
