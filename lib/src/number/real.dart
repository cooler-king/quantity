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

  @override
  bool get isInfinite => value == double.INFINITY || value == double.NEGATIVE_INFINITY;

  @override
  bool get isNaN => identical(value, double.NAN);

  @override
  bool get isNegative => value < 0;

  /// Addition operator.
  ///
  /// [addend] is expected to be a `num` or `Number`.  If it is not it
  /// will be assumed to be 0.
  ///
  @override
  Number operator +(addend) {
    if (addend is num) return new Double(value + addend);
    if (addend is Precise) return addend + this;
    if (addend is Real) return new Double(value + addend.value);
    if (addend is Complex) return new Complex(new Double(addend.real.toDouble() + value), addend.imag);
    if (addend is Imaginary) return new Complex(this, addend);
    return this;
  }

  @override
  Number operator -(subtrahend) {
    if (subtrahend is num) return new Double(value - subtrahend);
    if (subtrahend is Precise) return (-subtrahend) + this;
    if (subtrahend is Real) return new Double(value - subtrahend.value);
    if (subtrahend is Complex) return new Complex(new Double(value - subtrahend.real.value), -(subtrahend.imag));
    if (subtrahend is Imaginary) return new Complex(this, -subtrahend);
    return this;
  }

  @override
  Number operator *(multiplier) {
    if (multiplier is num) {
      num product = multiplier * value;
      if (product == product.truncate()) return new Integer(product.truncate());
      return new Double(product);
    }
    if (multiplier is Precise) return multiplier * this;
    if (multiplier is Real) return this * multiplier.value;
    if (multiplier is Complex) return new Complex(multiplier.real * value, multiplier.imaginary * value);
    if (multiplier is Imaginary) return new Imaginary(multiplier.value * value);

    // Treat multiplier as 0
    return Integer.zero;
  }

  @override
  Number operator /(divisor) {
    if (divisor is num) return new Double(value / divisor);
    if (divisor is Precise) return (new Precise.num(this.value)) / divisor;
    if (divisor is Real) return new Double(value / divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;

      return new Complex(aOverc2d2 * divisor.real, new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
    }
    if (divisor is Imaginary) return new Imaginary((this / divisor.value) * -1);

    // Treat divisor as 0
    return Double.infinity;
  }

  /// The truncating division operator.
  ///
  /// When dividing by an [Imaginary] or [Complex] number, the result will contain an imaginary component.
  /// The imaginary component is *not* truncated; only the real portion of the result is truncated.
  ///
  @override
  Number operator ~/(divisor) {
    if (divisor == 0) return Double.infinity;
    if (divisor is num) return new Integer(value ~/ divisor);
    if (divisor is Precise) return (new Precise.num(this.value) / divisor).truncate();
    if (divisor is Real) return new Integer(value ~/ divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;
      return new Complex(
          (aOverc2d2 * divisor.real).truncate(), new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
    }
    if (divisor is Imaginary) return new Imaginary(((this / divisor.value) * -1).truncate());

    // Treat divisor as 0
    return Double.infinity;
  }

  /// The modulo operator.
  ///
  /// When dividing by an [Imaginary] or [Complex] number...
  ///
  @override
  Number operator %(divisor) {
    if (divisor is num) return new Double(value % divisor);
    if (divisor is Real) return new Double(value % divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;

      //TODO Real % operator incomplete

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
  @override
  Number operator ^(exponent) {
    if (exponent is num) {
      num raised = Math.pow(value, exponent);
      if (raised is int) return new Integer(raised);
      return new Double(raised);
    }
    if (exponent is Precise) return (new Precise.num(value)) ^ exponent;
    if (exponent is Real) return new Double(Math.pow(value, exponent.value));
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

  @override
  bool operator >(obj) {
    if (obj is num) return value > obj;
    if (obj is Precise) return new Precise.num(this.value) > obj;
    if (obj is Real) return value > obj.value;
    if (obj is Imaginary) return value > 0;
    if (obj is Complex) return this > obj.real;
    return this > 0;
  }

  @override
  bool operator >=(obj) => (this == obj) ? true : this > obj;

  @override
  bool operator <(obj) => !(this >= obj);

  @override
  bool operator <=(obj) => !(this > obj);

  @override
  Number abs() => value >= 0 ? this : value is int ? new Integer(value.abs()) : new Double(value.abs().toDouble());

  @override
  Number ceil() => new Integer(value.ceil());

  @override
  Number floor() => new Integer(value.floor());

  @override
  Number round() => new Integer(value?.round());

  @override
  Number truncate() => new Integer(value.truncate());

  @override
  Number reciprocal() {
    if (value == 0) return Double.NaN;
    if (value == 1) return Integer.one;
    return new Double(1.0 / value);
  }

  @override
  Number remainder(divisor) {
    num div = divisor is num ? divisor : divisor is Number ? divisor.toDouble() : 0;
    var rem = value.remainder(div);
    if (rem is int) return new Integer(rem);
    return new Double(rem);
  }

  @override
  String toString() {
    return "${value}";
  }
}
