part of number;

/// Provides a common handle for all Real Numbers.
abstract class Real extends Number {
  /// The default constructor.
  Real();

  /// Creates a constant real number.
  const Real.constant() : super.constant();

  /// Constructs a new instance using the value for property `d` (decimal) or `i` (integer) in Map [m].
  factory Real.fromMap(Map<String, dynamic> m) =>
      m?.containsKey('d') == true || m?.containsKey('i') == true ? new Number.fromMap(m) as Real : Integer.zero;

  /// All Real subclasses must be able to provide their value as a [dart:core] [num].
  num get value;

  @override
  int toInt();

  @override
  double toDouble();

  @override
  bool get isInfinite => value == double.infinity || value == double.negativeInfinity;

  @override
  bool get isNaN => identical(value, double.nan);

  @override
  bool get isNegative => value < 0;

  /// Negation operator.
  @override
  Real operator -();

  /// Addition operator.
  ///
  /// [addend] is expected to be a `num` or `Number`.  If it is not it is assumed to be 0.
  ///
  @override
  Number operator +(dynamic addend) {
    if (addend is num) return new Double((value + addend).toDouble());
    if (addend is Precise) return addend + this;
    if (addend is Real) return new Double((value + addend.value).toDouble());
    if (addend is Complex) return new Complex(new Double(addend.real.toDouble() + value), addend.imag);
    if (addend is Imaginary) return new Complex(this, addend);
    return this;
  }

  @override
  Number operator -(dynamic subtrahend) {
    if (subtrahend is num) return new Double((value - subtrahend).toDouble());
    if (subtrahend is Precise) return (-subtrahend) + this;
    if (subtrahend is Real) return new Double((value - subtrahend.value).toDouble());
    if (subtrahend is Complex)
      return new Complex(new Double((value - subtrahend.real.value).toDouble()), -subtrahend.imag);
    if (subtrahend is Imaginary) return new Complex(this, -subtrahend);
    return this;
  }

  @override
  Number operator *(dynamic multiplicand) {
    if (multiplicand is num) {
      final num product = multiplicand * value;
      if (product == product.truncate()) return new Integer(product.truncate());
      return new Double(product.toDouble());
    }
    if (multiplicand is Precise) return multiplicand * this;
    if (multiplicand is Real) return this * multiplicand.value;
    if (multiplicand is Complex)
      return new Complex(multiplicand.real * value as Real, multiplicand.imaginary * value as Imaginary);
    if (multiplicand is Imaginary) return new Imaginary(multiplicand.value * value);

    // Treat multiplier as 0
    return Integer.zero;
  }

  @override
  Number operator /(dynamic divisor) {
    if (divisor is num) return new Double(value / divisor);
    if (divisor is Precise) return (new Precise.num(value)) / divisor;
    if (divisor is Real) return new Double(value / divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      final Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      final Number aOverc2d2 = this / c2d2;
      return new Complex(aOverc2d2 * divisor.real as Real, new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
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
  Number operator ~/(dynamic divisor) {
    if (divisor == 0) return Double.infinity;
    if (divisor is num) return new Integer(value ~/ divisor);
    if (divisor is Precise) return (new Precise.num(value) / divisor).truncate();
    if (divisor is Real) return new Integer(value ~/ divisor.value);
    if (divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      final Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      final Number aOverc2d2 = this / c2d2;
      return new Complex(
          (aOverc2d2 * divisor.real).truncate() as Real, new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
    }
    if (divisor is Imaginary) return new Imaginary(((this / divisor.value) * -1).truncate());

    // Treat divisor as 0
    return Double.infinity;
  }

  /// The modulo operator.
  /// [Imaginary] and [Complex] divisors are nor supported and will throw an Exception.
  @override
  Number operator %(dynamic divisor) {
    if (divisor is num) return new Double((value % divisor).toDouble());
    if (divisor is Real) return new Double((value % divisor.value).toDouble());
    if (divisor is Complex || divisor is Imaginary)
      throw new Exception('Unsupported operation (% with imaginary or complex divisor)');

    // Treat divisor as 0
    return Double.NaN;
  }

  /// The power operator (note: NOT bitwise XOR).
  ///
  /// In order to provide a convenient power operator for all [Number]s, the number library
  /// overrides the caret operator.  In Dart the caret operator is ordinarily used
  /// for bitwise XOR operations on [int]s.  The [Integer] class provides the `bitwiseXor` method
  /// as a substitute.
  @override
  Number operator ^(dynamic exponent) {
    if (exponent is num) {
      final num raised = pow(value, exponent);
      if (raised is int) return new Integer(raised);
      return new Double(raised as double);
    }
    if (exponent is Precise) return (new Precise.num(value)) ^ exponent;
    if (exponent is Real) return new Double(pow(value, exponent.value).toDouble());
    if (exponent is Complex) {
      // a^(b+ic) = a^b * ( cos(c * ln(a)) + i * sin(c * ln(a)) )
      final Number coeff = this ^ exponent.real;
      final double clna = (exponent.imaginary.value * log(value)).toDouble();
      return new Complex(coeff * cos(clna) as Real, new Imaginary(coeff * sin(clna)));
    }
    if (exponent is Imaginary) {
      // a^(ic) = cos(c * ln(a)) + i * sin(c * ln(a))
      final double clna = (exponent.value * log(value)).toDouble();
      return new Complex(cos(clna) as Real, new Imaginary(sin(clna)));
    }
    return Double.one;
  }

  @override
  bool operator >(dynamic obj) {
    if (obj is num) return value > obj;
    if (obj is Precise) return new Precise.num(value) > obj;
    if (obj is Real) return value > obj.value;
    if (obj is Imaginary) return value > 0;
    if (obj is Complex) return this > obj.real;
    return this > 0;
  }

  @override
  bool operator >=(dynamic obj) => this == obj || this > obj;

  @override
  bool operator <(dynamic obj) => !(this >= obj);

  @override
  bool operator <=(dynamic obj) => !(this > obj);

  @override
  Number abs() =>
      value >= 0 ? this : value is int ? new Integer(value.abs().toInt()) : new Double(value.abs().toDouble());

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
  Number remainder(dynamic divisor) {
    final num div = divisor is num ? divisor : divisor is Number ? divisor.toDouble() : 0;
    final num rem = value.remainder(div);
    if (rem is int) return new Integer(rem);
    return new Double(rem.toDouble());
  }

  @override
  String toString() => '$value';
}
