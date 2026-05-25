import 'dart:math';

import 'package:decimal/decimal.dart';

import 'double.dart';
import 'integer.dart';
import 'number_exception.dart';
import 'precise.dart';
import 'util/jenkins_hash.dart';

part 'complex.dart';
part 'imaginary.dart';
part 'real.dart';

/// The abstract base class for all Number types.
sealed class Number implements Comparable<dynamic> {
  /// The default constructor.
  Number();

  /// Supports const constructors in concrete classes.
  const Number.constant();

  /// Detect the type of Number by inspecting map contents and create it.
  /// Recognized formats are:
  ///     {'i': int value}
  ///     {'d': double value}
  ///     {'pd': arbitrary precision string}
  ///     {'real': {i or d map}, 'imag': {i or d map}}
  ///     {'imag': {i or d map}}
  ///
  /// If the map contents are not recognized [Integer.zero] will be returned.
  factory Number.fromMap(Map<String, dynamic>? m) => switch (m) {
        null => Integer.zero,
        {'d': num _} => Double.fromMap(m.cast<String, num>()),
        {'i': int _} => Integer.fromMap(m.cast<String, int>()),
        {'precise': Object p} when p is String || p is Map<String, String> =>
          Precise.fromMap(m.cast<String, String>()),
        {'real': Map _} => Complex.fromMap(m),
        {'imag': Map _} => Imaginary.fromMap(m),
        _ => Integer.zero,
      };

  /// Converts this Number to a Decimal.
  /// Throws a StateError if the Number has an imaginary or complex component.
  Decimal toDecimal() {
    if (this is Imaginary || this is Complex) {
      throw StateError(
          'Cannot convert Imaginary or Complex numbers to Decimal');
    }
    return Decimal.parse(toString());
  }

  /// Constructs a Number from a Decimal.
  factory Number.fromDecimal(Decimal decimal) => Precise(decimal.toString());

  /// Constructs a Number from a JSON map.
  factory Number.fromJson(Map<String, dynamic> json) => Number.fromMap(json);

  // Abstract operators

  /// Two Numbers will be equal when the represented values are equal,
  /// even if the Number subtypes are different.
  @override
  bool operator ==(Object obj);

  /// The hash codes for two Numbers will be equal when the represented values are equal,
  /// even if the Number subtypes are different.
  ///
  /// Additionally, Numbers having integer values will have the same hashcode as
  /// the corresponding dart:core `int`.
  @override
  int get hashCode;

  /// Returns the sum of this Number and a Number or num.  This Number is unaffected.
  Number operator +(dynamic addend);

  /// Returns the negative of this Number.  This Number is unaffected.
  Number operator -();

  /// Returns the difference of this Number and the [subtrahend] (a Number or num).
  /// This Number is unaffected.
  Number operator -(dynamic subtrahend);

  /// Returns the product of this Number and the [multiplicand] (a Number or num).
  /// This Number is unaffected.
  Number operator *(dynamic multiplicand);

  /// Returns the quotient of this Number divided by the [divisor] (a Number or num).
  /// This Number is unaffected.
  Number operator /(dynamic divisor);

  /// Returns the quotient of this Number divided by the [divisor] (a Number or num)
  /// truncated to an Integer.  This Number is unaffected.
  Number operator ~/(dynamic divisor);

  /// Returns the remainder after division of this Number by [divisor] (a Number or num).
  Number operator %(dynamic divisor);

  /// Returns this Number raised to the power of [exponent] (a Number or num).
  /// This Number is unaffected.
  Number operator ^(dynamic exponent);

  /// Returns whether the value of this Number is greater than the value of obj (a Number or num).
  bool operator >(dynamic obj);

  /// Returns whether the value of this Number is greater than or equal to the value of obj (a Number or num).
  bool operator >=(dynamic obj);

  /// Returns whether the value of this Number is less than the value of obj (a Number or num).
  bool operator <(dynamic obj);

  /// Returns whether the value of this Number is less than or equal to the value of obj (a Number or num).
  bool operator <=(dynamic obj);

  // Mirror num's abstract properties.

  /// Whether this Number represents a finite value.
  bool get isFinite => !isInfinite;

  /// Whether this Number represents infinity.
  bool get isInfinite;

  /// Whether this Number represents a value .
  bool get isNaN;

  /// Whether this number is less than zero.
  bool get isNegative;

  /// Returns minus one, zero or plus one depending on the sign and numerical value of the number.
  /// Returns minus one if the number is less than zero, plus one if the number is greater than zero,
  /// and zero if the number is equal to zero. Returns NaN if the number is NaN.
  /// Returns an `int` if this Number's value is an integer, a `double` otherwise.
  num get sign {
    if (isNaN) return double.nan;
    if (isNegative) return isInteger ? -1 : -1.0;
    if (toDouble() == 0) return isInteger ? 0 : 0.0;
    return isInteger ? 1 : 1.0;
  }

  /// Returns the Number equivalent to [n] having the simplest type that can
  /// represent the value (in order):  Integer, Double, Imaginary, or Complex.
  /// If [n] is already the most simple type possible, then it will be returned directly.
  /// Precise Numbers always remain Precise.
  static Number simplifyType(Number n) {
    if (n is Integer || n is Precise) return n;
    if (n is Double) {
      if (n.isInteger) {
        final val = n.toInt();
        if (val == 0) return Integer.zero;
        if (val == 1) return Integer.one;
        if (val == -1) return Integer.negOne;
        return Integer(val);
      }
      return n;
    }
    if (n is Imaginary) {
      if (n.value is Precise) return n;
      if (n.value.toDouble() == 0) return Integer.zero;
      if (n.value.isInteger && n.value is Double) {
        final val = n.value.toInt();
        if (val == 0) return Integer.zero;
        if (val == 1) return Imaginary(Integer.one);
        if (val == -1) return Imaginary(Integer.negOne);
        return Imaginary(Integer(val));
      }
      return n;
    }
    if (n is Complex) {
      final realZero =
          n.real.value == 0 && (n.real is! Precise || n.real == Precise.zero);
      final imagZero = n.imag.value.value.toDouble() == 0 &&
          (n.imag.value is! Precise || n.imag.value == Precise.zero);
      if (realZero) {
        if (imagZero) return simplifyType(n.real);
        return Imaginary(simplifyType(n.imag.value));
      } else if (imagZero) {
        return simplifyType(n.real);
      } else {
        final simpleReal = simplifyType(n.real) as Real;
        final simpleImag = simplifyType(n.imag.value);
        if (identical(simpleReal, n.real) &&
            identical(simpleImag, n.imag.value)) {
          return n;
        }
        return Complex(simpleReal, Imaginary(simpleImag));
      }
    }

    return n;
  }

  // Mirror num's abstract methods.

  /// Returns the absolute value of this Number.
  Number abs();

  /// Returns the least Number having integer components no smaller than this Number.
  Number ceil();

  /// Returns this num clamped to be in the range lowerLimit-upperLimit.
  /// The comparison is done using compareTo and therefore takes -0.0 into account.
  /// This also implies that double.NAN is treated as the maximal double value.
  /// `lowerLimit` and `upperLimit` are expected to be `num` or `Number' objects.
  Number clamp(dynamic lowerLimit, dynamic upperLimit);

  /// Returns the greatest Number with an integer value no greater than this Number.
  /// If this is not finite (NaN or infinity), throws an UnsupportedError.
  Number floor();

  /// Returns the remainder of the truncating division of this Number by `divisor`.
  /// The result r of this operation satisfies: this == (this ~/ other) * other + r.
  /// As a consequence the remainder r has the same sign as the [operator /(divisor)].
  Number remainder(dynamic divisor);

  /// Returns the integer Number closest to this Number.
  /// Rounds away from zero when there is no closest integer:
  /// (3.5).round() == 4 and (-3.5).round() == -4.
  /// If this is not finite (NaN or infinity), throws an UnsupportedError.
  Number round();

  /// Converts this Number to a `dart:core int`.
  int toInt();

  /// Converts this Number to a `dart:core double`.
  double toDouble();

  /// Returns a truncated value.
  Number truncate();

  // Add some of our own.

  /// Returns the Number that is the reciprocal of this Number.
  /// This Number is unaffected.
  Number reciprocal();

  /// Subclasses must support dart:json for stringify.
  Map<String, dynamic> toJson();

  /// True if the Number represents an integer value.
  /// Note that the Number does not have to be of type
  /// Integer for this to be true.
  bool get isInteger;

  /// Compares this Number to another Number by comparing values.
  /// [n2] is expected to be a num or Number.  If it is not it will
  /// be considered to have a value of 0.
  @override
  int compareTo(dynamic n2) {
    if (n2 is Number) return Comparable.compare(toDouble(), n2.toDouble());
    if (n2 is num) return Comparable.compare(toDouble(), n2);

    // If n2 is not a num or Number, treat it as a zero
    return Comparable.compare(toDouble(), 0);
  }
}
