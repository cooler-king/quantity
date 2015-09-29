part of number;

/// Represents an imaginary number, defined as a number whose square is negative.
///
/// An imaginary number is usually displayed as a value followed by small letter 'i'.
/// 'i' squared is defined as -1 (or equivalently, the square root of -1 is defined as 'i').
///
class Imaginary extends Number {
  final Real value;

  Imaginary(val)
      : this.value = (val is num)
            ? ((val is int) ? new Integer(val as int) : new Double(val as double))
            : (val is Real) ? val : Double.zero;

  const Imaginary.constant(this.value) : super.constant();

  double toDouble() => 0.0;
  int toInt() => 0;
  Complex toComplex() => new Complex(Double.zero, this);

  bool get isInfinite => value == Double.infinity || value == Double.negInfinity;
  bool get isNaN => value == Double.NaN;
  bool get isNegative => value < 0;

  bool get isInteger => value.isInteger;

  Imaginary.fromMap(Map m) : this.value = (m.containsKey("imag")) ? Number._fromMap(m["imag"]) : Double.zero;

  @override
  bool operator ==(obj) {
    if (obj is Imaginary) return value == obj.value;
    if (obj is Complex) return obj.real == 0.0 && this == obj.imaginary;
    if (obj is Real || obj is num) return value == 0.0 && obj == 0.0;

    return false;
  }

  @override
  int get hashCode {
    if (value == 0) return 0.hashCode;
    return hash2(0.hashCode, value);
  }

  Number operator +(addend) {
    if (addend is Imaginary) return new Imaginary((value + addend.value).toDouble());
    if (addend is Complex) return new Complex(addend.real, value + addend.imag);
    if (addend is Real) return new Complex(addend, this);
    if (addend is num) return new Complex(new Double(addend), this);
    return this;
  }

  Number operator -() => new Imaginary(-value);

  Number operator -(subtrahend) {
    if (subtrahend
        is num) return new Complex(subtrahend is int ? new Integer(-subtrahend) : new Double(-subtrahend), this);
    if (subtrahend is Real) return new Complex(-subtrahend, this);
    if (subtrahend is Complex) return new Complex(-subtrahend.real, this - subtrahend.imaginary);
    if (subtrahend is Imaginary) return new Imaginary(value - subtrahend.value);

    return this;
  }

  Number operator *(multiplier) {
    // i * i = -1
    if (multiplier is Imaginary) return value * multiplier.value * -1;
    if (multiplier is Complex) return new Complex(value * multiplier.imag * -1.0, value * multiplier.real);
    if (multiplier is num) return new Imaginary(value * multiplier);
    if (multiplier is Real) return new Imaginary(multiplier * value);

    return new Imaginary(0);
  }

  Number operator /(divisor) {
    if (divisor is num) return new Imaginary(value / divisor);
    if (divisor is Real) return new Imaginary(value / divisor.value);
    if (divisor is Imaginary) return value / divisor.value;
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      // for a = 0 => bi / (c + di) = bd / (c^2 + d^2) + i * bc / (c^2 + d^2)
      Number bOverc2d2 = value / (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return new Complex(bOverc2d2 * divisor.real, new Imaginary(bOverc2d2 * divisor.imaginary.value * -1.0));
    }

    // Treat divisor as 0
    if (value.isNegative) return new Imaginary(Double.negInfinity);
    else return new Imaginary(Double.infinity);
  }

  ///  The truncating division operator.
  ///
  Number operator ~/(divisor) {
    if (divisor == 0) return value < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity);
    if (divisor is num) return new Imaginary(value ~/ divisor);
    if (divisor is Imaginary) return value ~/ divisor.value;
    if (divisor is Real) return new Imaginary(value ~/ divisor.value);
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      // for a = 0 => bi / (c + di) = bd / (c^2 + d^2) + i * bc / (c^2 + d^2)
      Number bOverc2d2 = value / (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return new Complex((bOverc2d2 * divisor.real).truncate(),
          new Imaginary((bOverc2d2 * divisor.imaginary.value * -1.0).truncate()));
    }

    // Treat divisor as 0
    return value < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity);
  }

  /// The modulo operator.
  ///
  Number operator %(divisor) {
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
  /// for bitwise XOR operations on [int]s.  The Integer class provides the [bitwiseXor] method
  /// as a substitute.
  ///
  /// See http://mathworld.wolfram.com/ComplexNumber.html
  ///
  Number operator ^(exponent) {
    if (exponent is num) return new Double(Math.pow(value.value, exponent));
    if (exponent is Real) return new Double(Math.pow(value.value, exponent.value));
    if (exponent is Complex) {
      // a^(b+ic) = a^b * ( cos(c * ln(a)) + i * sin(c * ln(a)) )
      Number coeff = this ^ exponent.real;
      double clna = (exponent.imaginary.value * Math.log(value.value)).toDouble();
      return new Complex(coeff * Math.cos(clna) as Real, new Imaginary(coeff * Math.sin(clna)));
    }
    if (exponent is Imaginary) {
      // a^(ic) = cos(c * ln(a)) + i * sin(c * ln(a))
      double clna = (exponent.value * Math.log(value.value)).toDouble();
      return new Complex(Math.cos(clna) as Real, new Imaginary(Math.sin(clna)));
    }

    // Treat exponent as zero
    return Double.one;
  }

  Number get complexModulus => value.abs();

  /// The complex argument, or phase, of this imaginary number in radians.
  ///
  num get complexArgument => value < 0 ? -Math.PI / 2.0 : Math.PI / 2.0;

  /// The phase is synonymous with the complex argument.
  ///
  num get phase => complexArgument;

  /// If [obj] is an [Imaginary] number then the comparison is made in the imaginary dimension (for example,
  /// 5i > 3i is true).
  ///
  /// For all other types of numbers the comparison is made in the real dimension, so this [Imaginary] number
  /// is regarded as zero.
  ///
  bool operator >(obj) {
    if (obj is num) return 0 > obj;
    if (obj is Real) return 0 > obj.value;
    if (obj is Imaginary) return value > obj.value;
    if (obj is Complex) return 0 > obj.real.value;

    // treat obj as zero
    return false;
  }

  bool operator >=(obj) {
    if (this == obj) return true;
    return this > obj;
  }

  bool operator <(obj) => !(this >= obj);

  bool operator <=(obj) => !(this < obj);

  /// The real absolute value of a purely imaginary number is always zero.
  ///
  @override
  Number abs() => Integer.zero;

  /// The integer ceiling of a purely imaginary number is always zero.
  ///
  @override
  Number ceil() => Integer.zero;

  @override
  Number clamp(lowerLimit, upperLimit) {
    //TODO what does this mean?
    throw new UnsupportedError("clamping of Imaginary number is undefined");
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
  Number remainder(divisor) {
    new Imaginary(value.remainder(divisor));
  }

  /// Support [dart:convert] JSON.stringify.
  ///
  /// Map Contents:
  ///     "imag" : toJson map of value
  ///
  /// Example:
  ///     {"imag":{"d":456.7}}
  ///
  @override
  Map toJson() {
    return {"imag": value.toJson()};
  }
}
