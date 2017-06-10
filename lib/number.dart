/// The _quantity package_ accepts both Dart's `num` types and the `Number`s defined by this
/// _number library_ as quantity values and for quantity operations.
///
/// The classes in this library can be used to model quantities having values with arbitrary precision
/// as well as imaginary or complex numbers.  It is independent of the quantity classes and can be
/// used in a purely mathematical context.
///
library number;

import 'dart:math' as Math;
import 'dart:typed_data';

part 'src/number/complex.dart';
part 'src/number/double.dart';
part 'src/number/fraction.dart';
part 'src/number/imaginary.dart';
part 'src/number/integer.dart';
part 'src/number/number.dart';
part 'src/number/precise.dart';
part 'src/number/real.dart';
part 'src/number/util/jenkins_hash.dart';

/// Converts an [object] to a Number.  The [object]
/// must be either a [num] or [Number], otherwise
/// an Exception is thrown.
///
Number objToNumber(Object object) {
  if (object is num) return numToNumber(object);
  if (object is Number) return object;
  throw new Exception("num or Number expected");
}

/// Converts a num [value] to associated [Number] object
/// ([Integer] for `int`s and `double`s that have an integer value,
/// [Double] for other `double`s).
///
Number numToNumber(num value) {
  if (value is int) return new Integer(value);
  if (value.toInt() == value) return new Integer(value.toInt());
  return new Double(value);
}

/// Converts a Number to the equivalent [num].
///
num numberToNum(Number number) {
  if (number is Double) return number.value;
  if (number is Integer) return number.value;
  if (number is Imaginary) return 0;
  if (number is Complex) return number.real?.toDouble() ?? 0.0;
  if (number is Precise) {
    if (number.isInteger) return number.toInt();
    return number.toDouble();
  } else {
    return number?.toDouble() ?? 0;
  }
}

/// Approximate solution for the error function of [x].
///
/// * Fractional error is less than 1.2e7.
/// * There is no standard erf() available in dart:math.
/// * The approximation is based on Chebyshev fitting.
///
double erf(double x) {
  double z = x.abs();
  double t = 1.0 / (1.0 + 0.5 * z);

  // Approximate the complementary error function
  double erfc = t *
      Math.exp(-z * z -
          1.26551223 +
          t *
              (1.00002368 +
                  t *
                      (0.37409196 +
                          t *
                              (0.09678418 +
                                  t *
                                      (-0.18628806 +
                                          t *
                                              (0.27886807 +
                                                  t *
                                                      (-1.13520398 +
                                                          t * (1.48851587 + t * (-0.82215223 + t * 0.17087277)))))))));

  if (x < 0.0) erfc = 2.0 - erfc;
  return 1.0 - erfc;
}
