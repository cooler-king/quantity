part of number;

/// Represents an imaginary number, defined as a number whose square is negative one.
///
/// An imaginary number is usually displayed as a value followed by small letter 'i'.
/// 'i' squared is defined as -1 (or equivalently, the square root of -1 is defined as 'i').
class Imaginary extends Number {
  final Real value;

  Imaginary(dynamic val)
      : this.value = (val is num)
            ? ((val is int) ? new Integer(val) : new Double(val as double))
            : (val is Real) ? val : Double.zero;

  const Imaginary.constant(this.value) : super.constant();

  factory Imaginary.fromMap(Map<String, Map<String, dynamic>> m) => (m?.containsKey('imag') ?? false)
      ? new Imaginary.fromMap(m['imag'] as Map<String, Map<String, dynamic>>)
      : const Imaginary.constant(Integer.zero);

  @override
  double toDouble() => 0.0;

  @override
  int toInt() => 0;

  Complex toComplex() => new Complex(Double.zero, this);

  @override
  bool get isInfinite => value == Double.infinity || value == Double.negInfinity;

  @override
  bool get isNaN => value == Double.NaN;

  @override
  bool get isNegative => value < 0;

  @override
  bool get isInteger => value.isInteger;

  @override
  bool operator ==(dynamic obj) {
    if (obj is Imaginary) return value == obj.value;
    if (obj is Complex) return obj.real.value == 0.0 && this == obj.imaginary;
    if (obj is Real || obj is num) return value.toDouble() == 0.0 && obj == 0.0;

    return false;
  }

  @override
  int get hashCode {
    if (value.toDouble() == 0) return 0.hashCode;
    return hashObjects(<Object>[0, value]);
  }

  @override
  Number operator +(dynamic addend) {
    if (addend is Imaginary) return new Imaginary((value + addend.value).toDouble());
    if (addend is Complex) return new Complex(addend.real, new Imaginary(value + addend.imag));
    if (addend is Real) return new Complex(addend, this);
    if (addend is num) return new Complex(new Double(addend.toDouble()), this);
    return this;
  }

  @override
  Imaginary operator -() => new Imaginary(-value);

  @override
  Number operator -(dynamic subtrahend) {
    if (subtrahend is num)
      return new Complex(subtrahend is int ? new Integer(-subtrahend) : new Double(-subtrahend as double), this);
    if (subtrahend is Real) return new Complex(-subtrahend, this);
    if (subtrahend is Complex) return new Complex(-subtrahend.real, this - subtrahend.imaginary as Imaginary);
    if (subtrahend is Imaginary) return new Imaginary(value - subtrahend.value);

    return this;
  }

  @override
  Number operator *(dynamic multiplicand) {
    // i * i = -1
    if (multiplicand is Imaginary) return value * multiplicand.value * -1;
    if (multiplicand is Complex)
      return new Complex(value * multiplicand.imag.toDouble() * -1.0 as Real, new Imaginary(value * multiplicand.real));
    if (multiplicand is num) return new Imaginary(value * multiplicand);
    if (multiplicand is Real) return new Imaginary(multiplicand * value);

    return new Imaginary(0);
  }

  @override
  Number operator /(dynamic divisor) {
    if (divisor is num) return new Imaginary(value / divisor);
    if (divisor is Real) return new Imaginary(value / divisor.value);
    if (divisor is Imaginary) return value / divisor.value;
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      // for a = 0 => bi / (c + di) = bd / (c^2 + d^2) + i * bc / (c^2 + d^2)
      final Number bOverc2d2 = value / (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return new Complex(bOverc2d2 * divisor.real as Real, new Imaginary(bOverc2d2 * divisor.imaginary.value * -1.0));
    }

    // Treat divisor as 0
    if (value.isNegative)
      return new Imaginary(Double.negInfinity);
    else
      return new Imaginary(Double.infinity);
  }

  /// The truncating division operator.
  @override
  Number operator ~/(dynamic divisor) {
    if (divisor == 0) return value < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity);
    if (divisor is num) return new Imaginary(value ~/ divisor);
    if (divisor is Imaginary) return value ~/ divisor.value;
    if (divisor is Real) return new Imaginary(value ~/ divisor.value);
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      // for a = 0 => bi / (c + di) = bd / (c^2 + d^2) + i * bc / (c^2 + d^2)
      final Number bOverc2d2 = value / (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return new Complex((bOverc2d2 * divisor.real).truncate() as Real,
          new Imaginary((bOverc2d2 * divisor.imaginary.value * -1.0).truncate()));
    }

    // Treat divisor as 0
    return value < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity);
  }

  /// The modulo operator.
  @override
  Number operator %(dynamic divisor) {
    if (divisor == 0) return Double.NaN;

    if (divisor is num) return new Imaginary(value % divisor);
    if (divisor is Imaginary) return new Imaginary((this / divisor.value) * -1);
    if (divisor is Real) return new Imaginary(value % divisor.value);
    if (divisor is Complex) return Double.zero;

    // Treat divisor as 0
    return Double.NaN;
  }

  /// The power operator (note: NOT bitwise XOR).
  ///
  /// In order to provide a convenient power operator for all [Number]s, the number library
  /// overrides the caret operator.  In Dart the caret operator is ordinarily used
  /// for bitwise XOR operations on [int]s.  The Integer class provides the `bitwiseXor` method
  /// as a substitute.
  ///
  /// See http://mathworld.wolfram.com/ComplexNumber.html
  @override
  Number operator ^(dynamic exponent) {
    if (exponent is num) return new Double(pow(value.value, exponent).toDouble());
    if (exponent is Real) return new Double(pow(value.value, exponent.value).toDouble());
    if (exponent is Complex) {
      // a^(b+ic) = a^b * ( cos(c * ln(a)) + i * sin(c * ln(a)) )
      final Number coeff = this ^ exponent.real;
      final double clna = (exponent.imaginary.value * log(value.value)).toDouble();
      return new Complex(coeff * cos(clna) as Real, new Imaginary(coeff * sin(clna)));
    }
    if (exponent is Imaginary) {
      // a^(ic) = cos(c * ln(a)) + i * sin(c * ln(a))
      final double clna = (exponent.value * log(value.value)).toDouble();
      return new Complex(cos(clna) as Real, new Imaginary(sin(clna)));
    }

    // Treat exponent as zero
    return Double.one;
  }

  Number get complexModulus => value.abs();

  /// The complex argument, or phase, of this imaginary number in radians.
  ///
  num get complexArgument => value < 0 ? -polyfill_math.pi / 2.0 : polyfill_math.pi / 2.0;

  /// The phase is synonymous with the complex argument.
  ///
  num get phase => complexArgument;

  /// If [obj] is an [Imaginary] number then the comparison is made in the imaginary dimension (for example,
  /// 5i > 3i is true).
  ///
  /// For all other types of numbers the comparison is made in the real dimension, so this [Imaginary] number
  /// is regarded as zero.
  @override
  bool operator >(dynamic obj) {
    if (obj is num) return 0 > obj;
    if (obj is Real) return 0 > obj.value;
    if (obj is Imaginary) return value > obj.value;
    if (obj is Complex) return 0 > obj.real.value;

    // treat obj as zero
    return false;
  }

  @override
  bool operator >=(dynamic obj) {
    if (this == obj) return true;
    return this > obj;
  }

  @override
  bool operator <(dynamic obj) => !(this >= obj);

  @override
  bool operator <=(dynamic obj) => !(this < obj);

  /// The real absolute value of a purely imaginary number is always zero.
  ///
  @override
  Number abs() => Integer.zero;

  /// The integer ceiling of a purely imaginary number is always zero.
  ///
  @override
  Number ceil() => Integer.zero;

  @override
  Number clamp(dynamic lowerLimit, dynamic upperLimit) {
    //TODO what does this mean?
    throw new UnsupportedError('clamping of Imaginary number is undefined');
  }

  /// The integer floor of a purely imaginary number is always zero.
  ///
  @override
  Number floor() => Integer.zero;

  /// The nearest integer of a purely imaginary number is always zero.
  ///
  @override
  Number round() => Integer.zero;

  /// The integer resulting from truncation of a purely imaginary number is always zero.
  ///
  @override
  Number truncate() => Integer.zero;

  @override
  Number reciprocal() => Integer.one / this;

  @override
  Number remainder(dynamic divisor) => new Imaginary(value.remainder(divisor));

  /// Support [dart:convert] JSON.stringify.
  ///
  /// Map Contents:
  ///     'imag' : toJson map of value
  ///
  /// Example:
  ///     {'imag':{'d':456.7}}
  ///
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'imag': value.toJson()};

  @override
  String toString() => '${value}i';
}
