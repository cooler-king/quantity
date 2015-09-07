part of number;

class Fraction extends Double {
  final int _numerator;
  final int _denominator;

  Fraction(int numer, int denom)
      : _numerator = numer,
        _denominator = denom,
        super(numer / denom);
  Fraction.mixed(int whole, int numer, int denom)
      : _numerator = numer + (whole * denom),
        _denominator = denom,
        super((whole * denom + numer) / denom);

  // num get real => this.value;

  /*
  bool isInteger() {
    if(imaginary == null) {}
  }*/

  Number operator +(addend) {
    if (addend is Fraction) {} else {
      return super + addend;
    }

    double val = (_denominator != 0)
        ? (_numerator.toDouble() / _denominator.toDouble())
        : double.INFINITY;

    if (addend is Imaginary) {
      return new Complex(new Double(val), addend);
    } else if (addend is Complex) {
      return new Complex(addend.real + val, addend.imaginary);
    } else if (addend is Real) {
      return new Double(val + addend);
    } else if (addend is num) {
      return new Double(val + addend);
    }

    // treat addend as zero
    return this;
  }
}
