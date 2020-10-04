import 'dart:math';
import 'double.dart';
import 'imaginary.dart';
import 'integer.dart';
import 'number.dart';
import 'number_exception.dart';
import 'precise.dart';
import 'real.dart';
import 'util/jenkins_hash.dart';

/// Complex numbers have both a real and an imaginary part.
class Complex extends Number {
  /// Constructs a new instance.
  Complex(this.real, this.imaginary);

  /// Constructs a constant Complex number.
  const Complex.constant(this.real, this.imaginary) : super.constant();

  /// Constructs a new instance from real and imaginary coefficients.
  Complex.coeff(num realValue, num imagValue)
      : real = realValue is int ? new Integer(realValue) : new Double.constant(realValue.toDouble()),
        imaginary =
            new Imaginary.constant(imagValue is int ? new Integer(imagValue) : new Double(imagValue.toDouble()));

  /// Constructs a new instance, applying the values in map [m].
  /// See `toJson` for the expected format.
  Complex.fromMap(Map<String, Map<String, dynamic>> m)
      : real = (m?.containsKey('real') ?? false) ? new Real.fromMap(m['real']) : Double.zero,
        imaginary = m?.containsKey('real') ?? false
            ? new Imaginary.constant(new Real.fromMap(m['imag']))
            : const Imaginary.constant(Integer.zero);

  /// The real number component of the complex number.
  final Real real;

  /// The imaginary number component of the complex number.
  final Imaginary imaginary;

  /// [imag] is a convenient getter for the [imaginary] value
  Imaginary get imag => imaginary;

  /// Returns the conjugate of this Complex number (the sign of the imaginary component is flipped).
  Complex get conjugate => new Complex(real, new Imaginary(imaginary.value * -1.0));

  /// Complex modulus represents the magnitude of this complex number in the complex plane.
  /// Synonymous with abs().
  Number get complexModulus {
    final num value = sqrt(real.value * real.value + imaginary.value.value * imaginary.value.value);
    return value.toInt() == value ? new Integer(value.toInt()) : new Double(value.toDouble());
  }

  /// Complex norm is synonymous with complex modulus and abs().
  Number get complexNorm => complexModulus;

  /// Returns the absolute square of this Complex number.
  Number get absoluteSquare => complexModulus ^ 2;

  /// In radians.
  Double get complexArgument => new Double(atan2(imaginary.value.value, real.value));

  /// Phase is synonymous with complex argument.
  Double get phase => complexArgument;

  @override
  bool get isInfinite => real.value == double.infinity || real.value == double.negativeInfinity;

  @override
  bool get isNaN => real.value.isNaN;

  /// Whether the real part of this complex number is negative.
  @override
  bool get isNegative => real.value < 0;

  /// Whether the real part of this complex number is an integer.
  @override
  bool get isInteger => (imaginary == null || imaginary.toDouble() == 0) && real.isInteger;

  /// Returns the real part of this complex number as a double.
  @override
  double toDouble() => real.toDouble();

  /// Returns the real part of this complex number as an integer.
  @override
  int toInt() => real.toInt();

  @override
  int get hashCode {
    if (imaginary == null || imaginary.value.toDouble() == 0) {
      if (real is Precise) return real.hashCode;
      return new Precise.num(real.toDouble()).hashCode;
    } else {
      if (real == null || real.toDouble() == 0) return hashObjects(<Object>[0, imaginary.value]);
      return hashObjects(<Object>[real, imaginary.value]);
    }
  }

  @override
  bool operator ==(dynamic obj) {
    if (obj is num) return real.value == obj && imaginary.value.value == 0.0;
    if (obj is Complex) return real == obj.real && imaginary == obj.imaginary;
    if (obj is Imaginary) return real.value == 0.0 && imaginary == obj;
    if (obj is Real) return obj == real && imaginary.value.value == 0.0;
    return false;
  }

  @override
  Number operator +(dynamic addend) {
    if (addend is Complex)
      return Number.simplifyType(new Complex(real + addend.real as Real, imaginary + addend.imaginary as Imaginary));
    if (addend is Imaginary)
      return Number.simplifyType(new Complex(real, new Imaginary(imaginary.value + addend.value)));
    if (addend is Real) return Number.simplifyType(new Complex(real + addend as Real, imaginary));
    if (addend is num) return Number.simplifyType(new Complex(real + addend as Real, imaginary));

    // Treat addend as zero.
    return Number.simplifyType(this);
  }

  @override
  Complex operator -() => new Complex(-real, -imaginary);

  @override
  Number operator -(dynamic subtrahend) {
    if (subtrahend is Complex)
      return Number.simplifyType(
          new Complex(real - subtrahend.real.value as Real, imaginary - subtrahend.imaginary as Imaginary));
    if (subtrahend is Imaginary) return Number.simplifyType(new Complex(real, imaginary - subtrahend as Imaginary));
    if (subtrahend is num) return Number.simplifyType(new Complex(real - subtrahend as Real, imaginary));
    if (subtrahend is Real) return Number.simplifyType(new Complex(real - subtrahend as Real, imaginary));

    return Number.simplifyType(this);
  }

  @override
  Number operator *(dynamic multiplicand) {
    // i * i = -1
    if (multiplicand is num)
      return Number.simplifyType(new Complex(real * multiplicand as Real, imaginary * multiplicand as Imaginary));
    if (multiplicand is Real)
      return Number.simplifyType(
          new Complex(multiplicand * real as Real, new Imaginary(multiplicand * imaginary.value)));
    if (multiplicand is Imaginary)
      // (0+bi)(c+di)=(-bd)+i(bc)
      return Number.simplifyType(
          new Complex(imaginary.value * multiplicand.value * -1 as Real, multiplicand * real as Imaginary));
    if (multiplicand is Complex)
      // (a+bi)(c+di)=(ac-bd)+i(ad+bc)
      return Number.simplifyType(new Complex(
          real * multiplicand.real - imaginary.value * multiplicand.imaginary.value as Real,
          new Imaginary(real * multiplicand.imaginary.value + imaginary.value * multiplicand.real)));

    // Treat multiplier as zero
    return Number.simplifyType(Integer.zero);
  }

  @override
  Number operator /(dynamic divisor) {
    if (divisor is num)
      return Number.simplifyType(new Complex(real / divisor as Real, imaginary / divisor as Imaginary));
    if (divisor is Real)
      return Number.simplifyType(new Complex(real / divisor.value as Real, imaginary / divisor.value as Imaginary));
    if (divisor is Imaginary)
      return Number.simplifyType(
          new Complex(imaginary.value / divisor.value as Real, new Imaginary(-real / divisor.value)));
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      final Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return Number.simplifyType(new Complex(
          (real * divisor.real + imaginary.value * divisor.imaginary.value) / c2d2 as Real,
          (imaginary * divisor.real - real * divisor.imaginary) / c2d2 as Imaginary));
    }

    // Treat divisor as 0
    return Number.simplifyType(new Complex(real < 0 ? Double.negInfinity : Double.infinity,
        imaginary < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity)));
  }

  ///  The truncating division operator.
  @override
  Number operator ~/(dynamic divisor) {
    if (divisor != 0) {
      if (divisor is num) return new Complex(real ~/ divisor as Real, imaginary ~/ divisor as Imaginary);
      if (divisor is Imaginary)
        return new Complex(imaginary.value ~/ divisor.value as Real, new Imaginary(-real ~/ divisor.value));
      if (divisor is Real) return new Complex(real ~/ divisor as Real, imaginary ~/ divisor as Imaginary);
      if (divisor is Complex) {
        // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
        final Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
        return new Complex(((real * divisor.real + imaginary * divisor.imaginary) / c2d2).truncate() as Real,
            new Imaginary(((imaginary * divisor.real - real * divisor.imaginary) / c2d2).truncate()));
      }
    }

    // Treat divisor as 0
    return new Complex(real < 0 ? Double.negInfinity : Double.infinity,
        imaginary < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity));
  }

  /// The modulo operator.
  @override
  Number operator %(dynamic divisor) {
    throw const NumberException('The number library does not support the modulo operator for complex numbers');
  }

  /// The power operator (note: NOT bitwise XOR).
  /// In order to provide a convenient power operator for all [Number]s, the number library
  /// overrides the caret operator.  In Dart the caret operator is ordinarily used
  /// for bitwise XOR operations on [int]s.
  @override
  Number operator ^(dynamic exponent) {
    if (exponent is num) {
      final double scaledPhase = exponent.toDouble() * phase.value;
      final Number expModulus = complexModulus ^ exponent;
      return Number.simplifyType(
          new Complex(expModulus * cos(scaledPhase) as Real, new Imaginary(expModulus * sin(scaledPhase))));
    } else if (exponent is Real) {
      final double scaledPhase = (exponent * phase.value).toDouble();
      final Number expModulus = complexModulus ^ exponent.value;
      return Number.simplifyType(
          new Complex(expModulus * cos(scaledPhase) as Real, new Imaginary(expModulus * sin(scaledPhase))));
    } else if (exponent is Complex) {
      throw const NumberException('The number library does not support raising a complex number to a complex power');
    } else if (exponent is Imaginary) {
      throw const NumberException('The number library does not support raising a complex number to an imaginary power');
    }

    return Double.one;
  }

  /// Returns true if the real component of this Complex number is greater than [obj].
  /// The imaginary part of this complex number is ignored.
  @override
  bool operator >(dynamic obj) => real > obj;

  /// Returns true if the real component of this Complex number is greater
  /// than or equal to [obj].
  /// The imaginary part of this complex number is ignored.
  @override
  bool operator >=(dynamic obj) => real >= obj;

  /// Returns true if the real component of this Complex number is
  /// less than [obj].
  /// The imaginary part of this complex number is ignored.
  @override
  bool operator <(dynamic obj) => real < obj;

  /// Returns true if the real component of this Complex number is
  /// less than or equal to [obj].
  /// The imaginary part of this complex number is ignored.
  @override
  bool operator <=(dynamic obj) => real <= obj;

  /// The absolute value of a Complex number is its distance from zero in the
  /// Complex number space (e.g., the absolute value of 3 + 4i = 5).  The absolute
  /// value is always a real number.  Synonymous with [complexModulus].
  @override
  Number abs() => complexModulus;

  /// Returns the ceiling of the real portion of this complex number.
  @override
  Number ceil() => real.ceil();

  /// Returns a new Complex number whose real portion has been clamped to within [lowerLimit] and
  /// [upperLimit] and whose imaginary portion is the same as the imaginary value in this Complex number.
  @override
  Number clamp(dynamic lowerLimit, dynamic upperLimit) {
    final Real clampedReal = real.clamp(lowerLimit, upperLimit) as Real;
    if (clampedReal.toDouble() == 0) return imaginary.value.toDouble() == 0 ? Integer.zero : imaginary;
    return new Complex(clampedReal, imaginary);
  }

  /// Returns the floor of the real portion of this complex number.
  @override
  Number floor() => real.floor();

  /// Returns the integer closest to the real portion of this complex number.
  @override
  Number round() => real.round();

  /// Returns the real portion of this complex number, truncated to an Integer.
  @override
  Number truncate() => real.truncate();

  /// The remainder method operates on the real portion of this Complex number only.
  @override
  Number remainder(dynamic divisor) => real.remainder(divisor);

  @override
  Number reciprocal() {
    // (a - bi) / (a^2 + b^2)
    final num a2b2 = pow(real.value, 2) + pow(imaginary.value.value, 2);
    return new Complex(real / a2b2 as Real, new Imaginary(imaginary.value / -a2b2));
  }

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     'real' : toJson map of real number
  ///     'imag' : toJson map of imaginary number
  ///
  /// Example:
  ///     {'real':{'i':5},'imag':{'d':3.3}}
  ///
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'real': real.toJson(), 'imag': imaginary.toJson()};

  @override
  String toString() => imag.value < 0 ? '$real - ${imag.value.abs()}i' : '$real + ${imag.value.abs()}i';
}
