part of number;

/// Complex numbers have both a real and an imaginary part.
///
class Complex extends Number {
  /// The real number component of the complex number.
  final Real real;

  /// The imaginary number component of the complex number.
  final Imaginary imaginary;

  Complex(this.real, this.imaginary);
  const Complex.constant(this.real, this.imaginary) : super.constant();

  Complex.coeff(double realValue, double imagValue)
      : real = new Double.constant(realValue),
        imaginary = new Imaginary.constant(new Double(imagValue));

  Complex.fromMap(Map<String, Map<String, dynamic>> m)
      : real = (m?.containsKey('real') ?? false) ? new Real.fromMap(m['real']) : Double.zero,
        imaginary = m?.containsKey('real') ?? false
            ? new Imaginary.constant(new Real.fromMap(m['imag']))
            : const Imaginary.constant(Integer.zero);

  /// [imag] is a convenient getter for the [imaginary] value
  Imaginary get imag => imaginary;

  Complex get conjugate => new Complex(real, new Imaginary(imaginary.value * -1.0));

  /// Complex modulus represents the magnitude of this complex number in the complex plane.
  ///
  Double get complexModulus =>
      new Double(sqrt(real.value * real.value + imaginary.value.value * imaginary.value.value));

  /// Complex norm is synonymous with complex modulus.
  ///
  Double get complexNorm => complexModulus;

  Double get absoluteSquare => complexModulus ^ 2 as Double;

  /// In radians.
  ///
  Double get complexArgument => new Double(atan2(imaginary.value.value, real.value));

  /// Phase is synonymous with complex argument.
  ///
  Double get phase => complexArgument;

  @override
  bool get isInfinite => real.value == polyfill_core.double.infinity || real.value == polyfill_core.double.negativeInfinity;

  @override
  bool get isNaN => real.value == polyfill_core.double.nan;

  @override
  bool get isNegative => real.value < 0;

  @override
  bool get isInteger => (imaginary == null || imaginary.toDouble() == 0) && real.isInteger;

  @override
  double toDouble() => real.toDouble();

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
    if (obj is Imaginary) return real.value == 0.0 && imaginary.value == obj;
    if (obj is Real) return real == obj && imaginary.value.value == 0.0;
    return false;
  }

  @override
  Number operator +(dynamic addend) {
    if (addend is Complex) return new Complex(real + addend.real as Real, imaginary + addend.imaginary as Imaginary);
    if (addend is Imaginary) return new Complex(real, new Imaginary(imaginary.value + addend.value));
    if (addend is Real) return new Complex(real + addend as Real, imaginary);
    if (addend is num) return new Complex(real + addend as Real, imaginary);

    // Treat addend as zero
    return this;
  }

  @override
  Complex operator -() => new Complex(-real, -imaginary);

  @override
  Number operator -(dynamic subtrahend) {
    if (subtrahend is Complex)
      return new Complex(real - subtrahend.real.value as Real, imaginary - subtrahend.imaginary as Imaginary);
    if (subtrahend is Imaginary) return new Complex(real, imaginary - subtrahend as Imaginary);
    if (subtrahend is num) return new Complex(real - subtrahend as Real, imaginary);
    if (subtrahend is Real) return new Complex(real - subtrahend.value as Real, imaginary);

    return this;
  }

  @override
  Number operator *(dynamic multiplicand) {
    // i * i = -1
    if (multiplicand is num) return new Complex(real * multiplicand as Real, imaginary * multiplicand as Imaginary);
    if (multiplicand is Real)
      return new Complex(multiplicand * real as Real, new Imaginary(multiplicand.value * imaginary.value.toDouble()));
    if (multiplicand is Imaginary)
      // (0+bi)(c+di)=(-bd)+i(bc)
      return new Complex(imaginary * multiplicand.value * -1 as Real, real * multiplicand.value as Imaginary);
    if (multiplicand is Complex)
      // (a+bi)(c+di)=(ac-bd)+i(ad+bc)
      return new Complex(real * multiplicand.real - imaginary * multiplicand.imaginary as Real,
          real * multiplicand.imaginary + imaginary * multiplicand.real as Imaginary);

    // Treat multiplier as zero
    return Double.zero;
  }

  @override
  Number operator /(dynamic divisor) {
    if (divisor is num) return new Complex(real / divisor as Real, imaginary / divisor as Imaginary);
    if (divisor is Real) return new Complex(real / divisor.value as Real, imaginary / divisor.value as Imaginary);
    if (divisor is Imaginary) return new Complex(imaginary / divisor.value as Real, -real / divisor.value as Imaginary);
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      final Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return new Complex((real * divisor.real + imaginary * divisor.imaginary) / c2d2 as Real,
          (imaginary * divisor.real - real * divisor.imaginary) / c2d2 as Imaginary);
    }

    // Treat divisor as 0
    return new Complex(real < 0 ? Double.negInfinity : Double.infinity,
        imaginary < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity));
  }

  ///  The truncating division operator.
  ///
  @override
  Number operator ~/(dynamic divisor) {
    if (divisor == 0) {
      // Treat divisor as 0
      return new Complex(real < 0 ? Double.negInfinity : Double.infinity,
          imaginary < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity));
    }

    if (divisor is num) new Complex(real ~/ divisor as Real, imaginary ~/ divisor as Imaginary);
    if (divisor is Imaginary) new Complex(imaginary ~/ divisor.value as Real, new Imaginary(-real ~/ divisor.value));
    if (divisor is Real) new Complex(real ~/ divisor as Real, imaginary ~/ divisor as Imaginary);
    if (divisor is Complex) {
      // (a + bi) / (c + di) = (ac + bd) / (c^2 + d^2) + i * (bc - ad) / (c^2 + d^2)
      final Number c2d2 = (divisor.real ^ 2.0) + (divisor.imaginary.value ^ 2.0);
      return new Complex(((real * divisor.real + imaginary * divisor.imaginary) / c2d2).truncate() as Real,
          new Imaginary(((imaginary * divisor.real - real * divisor.imaginary) / c2d2).truncate()));
    }

    // Treat divisor as 0
    return new Complex(real < 0 ? Double.negInfinity : Double.infinity,
        imaginary < 0 ? new Imaginary(Double.negInfinity) : new Imaginary(Double.infinity));
  }

  /// The modulo operator.
  /// See http://math.stackexchange.com/questions/274694/modulo-complex-number
  @override
  Number operator %(dynamic divisor) {
    //TODO complex modulo operator
    /*
    if(divisor is num) return new Double(value % divisor);
    else if(divisor is Real) return new Double(value % divisor.value);
    else if(divisor is Complex) {
      // (a + 0i) / (c + di) = (ac - adi) / (c^2 + d^2)
      Number c2d2 = (divisor.real ^ 2.0)  + (divisor.imaginary.value ^ 2.0);
      Number aOverc2d2 = this / c2d2;

      //return new Complex(aOverc2d2 * divisor.real, new Imaginary(aOverc2d2 * divisor.imaginary.value * -1.0));
      //TODO
      return null;
    } else if(divisor is Imaginary) {//return new Imaginary((this / divisor.value) * -1);
      //TODO
      return null;

    }
    */
    // Treat divisor as 0
    return Double.zero;
  }

  /// The power operator (note: NOT bitwise XOR).
  ///
  /// In order to provide a convenient power operator for all [Number]s, the number library
  /// overrides the caret operator.  In Dart the caret operator is ordinarily used
  /// for bitwise XOR operations on [int]s.
  ///
  @override
  Number operator ^(dynamic exponent) {
    if (exponent is num) {
      final double scaledPhase = exponent.toDouble() * phase.value;
      final Number expModulus = complexModulus ^ exponent;
      return new Complex(expModulus * cos(scaledPhase) as Real, new Imaginary(expModulus * sin(scaledPhase)));
    } else if (exponent is Real) {
      final double scaledPhase = (exponent * phase.value).toDouble();
      final Number expModulus = complexModulus ^ exponent.value;
      return new Complex(expModulus * cos(scaledPhase) as Real, new Imaginary(expModulus * sin(scaledPhase)));
    } else if (exponent is Complex) {
      //TODO see http://mathworld.wolfram.com/ComplexNumber.html
    } else if (exponent is Imaginary) {
      //TODO
    }

    return Double.one;
  }

  /// Returns true if the real component of this Complex number is greater than [obj].
  ///
  /// The imaginary part of this complex number is ignored.
  ///
  @override
  bool operator >(dynamic obj) => real > obj;

  /// Returns true if the real component of this Complex number is greater
  /// than or equal to [obj].
  ///
  /// The imaginary part of this complex number is ignored.
  ///
  @override
  bool operator >=(dynamic obj) => real >= obj;

  /// Returns true if the real component of this Complex number is
  /// less than [obj].
  ///
  /// The imaginary part of this complex number is ignored.
  ///
  @override
  bool operator <(dynamic obj) => real < obj;

  /// Returns true if the real component of this Complex number is
  /// less than or equal to [obj].
  ///
  /// The imaginary part of this complex number is ignored.
  ///
  @override
  bool operator <=(dynamic obj) => real <= obj;

  /// The absolute value of a Complex number is its distance from zero in the
  /// Complex number space (e.g. the absolute value of 3 + 4i = 5).  The absolute
  /// value is always a real number.
  ///
  @override
  Number abs() => ((real * real) + (imaginary.value * imaginary.value)) ^ 0.5;

  /// Returns the ceiling
  @override
  Number ceil() => real.ceil();

  @override
  Number clamp(dynamic lowerLimit, dynamic upperLimit) => real.clamp(lowerLimit, upperLimit);

  @override
  Number floor() => real.floor();

  @override
  Number round() => real.round();

  @override
  Number truncate() => real.truncate();

  /// The remainder method operates on the real portion of
  /// this Complex number only.
  ///
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
}
