part of number;

/// Provides a common handle for all Real Numbers.
///
abstract class Real extends Number {
  const Real.constant() : super.constant();
  Real();

  /// All Real subclasses must be able to provide their value as a [dart:core] [num].
  num get value;

  int toInt();
  double toDouble();

  bool get isInfinite => value == double.INFINITY || value == double.NEGATIVE_INFINITY;
  bool get isNaN => value == double.NAN;
  bool get isNegative => value < 0;

  Number operator +(addend) {
    if (addend is num) return new Double(value + addend);
    if (addend is Real) return new Double(value + addend.value);
    if (addend is Complex) return new Complex(new Double(addend.real.toDouble() + value), addend.imag);
    if (addend is Imaginary) return new Complex(this, addend);
    return this;
  }

  Number operator -() => new Double(-value);

  Number operator -(subtrahend) {
    if (subtrahend is num) return new Double(value - subtrahend);
    if (subtrahend is Real) return new Double(value - subtrahend.value);
    if (subtrahend is Complex) return new Complex(new Double(value - subtrahend.real.value), -(subtrahend.imag));
    if (subtrahend is Imaginary) return new Complex(this, -subtrahend);

    return this;
  }

  Number operator *(multiplier) {
    if (multiplier is num) {
      num product = multiplier * value;
      if (product == product.truncate()) return new Integer(product.truncate());
      return new Double(product);
    }
    if (multiplier is Real) return this * multiplier.value;
    if (multiplier is Complex) return new Complex(multiplier.real * value, multiplier.imaginary * value);
    if (multiplier is Imaginary) return new Imaginary(multiplier.value * value);

    // Treat multiplier as 0
    return Integer.zero;
  }

  Number operator /(divisor) {
    if (divisor is num) return new Double(value / divisor);
    if (divisor is Real) return new Double(value / divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;

      return new Complex(aOverc2d2 * divisor.real, new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
    } else if (divisor is Imaginary) return new Imaginary((this / divisor.value) * -1);

    // Treat divisor as 0
    return Double.infinity;
  }

  /// The truncating division operator.
  ///
  /// When dividing by an [Imaginary] or [Complex] number, the result will contain an imaginary component.
  /// The imaginary component is *not* truncated; only the real portion of the result is truncated.
  ///
  Number operator ~/(divisor) {
    if (divisor == 0) return Double.infinity;
    if (divisor is num) return new Integer(value ~/ divisor);
    if (divisor is Real) return new Integer(value ~/ divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;
      return new Complex(
          (aOverc2d2 * divisor.real).truncate(), new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
    }
    if (divisor is Imaginary) {
      return new Imaginary(((this / divisor.value) * -1).truncate());
    }

    // Treat divisor as 0
    return Double.infinity;
  }

  /// The modulo operator.
  ///
  /// When dividing by an [Imaginary] or [Complex] number...
  ///
  Number operator %(divisor) {
    if (divisor is num) return new Double(value % divisor);
    if (divisor is Real) return new Double(value % divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;

      //return new Complex(aOverc2d2 * divisor.real, new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
      //TODO
      return null;
    }
    if (divisor is Imaginary) {
      //return new Imaginary((this / divisor.value) * -1);
      //TODO
      return null;
    }

    // Treat divisor as 0
    return Double.NaN;
  }

  /// The power operator (note: NOT bitwise XOR).
  ///
  /// In order to provide a convenient power operator for all [Number]s, the number library
  /// overrides the caret operator.  In Dart the caret operator is ordinarily used
  /// for bitwise XOR operations on [int]s.  The [Integer] class provides the [bitwiseXor] method
  /// as a substitute.
  ///
  Number operator ^(exponent) {
    if (exponent is num) {
      num raised = Math.pow(value, exponent);
      if (raised is int) return new Integer(raised);
      return new Double(raised);
    }
    if (exponent is Real) {
      return new Double(Math.pow(value, exponent.value));
    }
    if (exponent is Complex) {
      // a^(b+ic) = a^b * ( cos(c * ln(a)) + i * sin(c * ln(a)) )
      Number coeff = this ^ exponent.real;
      double clna = (exponent.imaginary.value * Math.log(value)).toDouble();
      return new Complex(coeff * Math.cos(clna) as Real, new Imaginary(coeff * Math.sin(clna)));
    }
    if (exponent is Imaginary) {
      // a^(ic) = cos(c * ln(a)) + i * sin(c * ln(a))
      double clna = (exponent.value * Math.log(value)).toDouble();
      return new Complex(Math.cos(clna) as Real, new Imaginary(Math.sin(clna)));
    }
    return Double.one;
  }

  bool operator >(obj) {
    if (obj is num) return value > obj;
    if (obj is Real) return value > obj.value;
    if (obj is Imaginary) return value > 0;
    if (obj is Complex) return this > obj.real;
    return this > 0;
  }

  bool operator >=(obj) => (this == obj) ? true : this > obj;

  bool operator <(obj) => !(this >= obj);

  bool operator <=(obj) => !(this > obj);

  Number abs() => value >= 0 ? this : value is int ? new Integer(value.abs()) : new Double(value.abs().toDouble());

  Integer ceil() => new Integer(value.ceil());

  Integer truncate() => new Integer(value.truncate());

  Number reciprocal() {
    if (value == 0) return Double.NaN;
    else if (value == 1) return Integer.one;
    else return new Double(1.0 / value);
  }

  String toString() {
    return "${value}";
  }
}
