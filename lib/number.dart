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

/**
 * Converts an [object] to a Number.  The [object]
 * must be either a [num] or [Number], otherwise
 * and ArgumentError is thrown.
 */
Number objToNumber(Object object) {
  if (object is num) return numToNumber(object);
  else if (object is Number) return object;
  else throw new ArgumentError("num or Number expected");
}

/**
 * Converts a num [value] to associated Number object
 * (Integer for int, Double for Double).
 */
Number numToNumber(num value) {
  if (value is int) return new Integer(value);
  else return new Double(value);
  // JS can't distinguish so just assume Double
  //return new Double(value.toDouble());
}

num numberToNum(Number number) {
  if (number is Double) return number.value;
  else if (number is Integer) return number.value;
  //else if(number is Precise) return (number as Precise).toDouble();
  else if (number is Imaginary) return 0;
  else if (number is Complex) return number.real.toDouble();

  return 0;
}

/**
 *  Approximate solution for the error function of [x].
 *
 * * Fractional error is less than 1.2e7.
 * * There is no standard erf() available in dart:math.
 * * The approximation is based on Chebyshev fitting.
*/
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
