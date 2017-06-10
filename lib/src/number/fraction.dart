part of number;

/// A convenient way to represent fractional numbers.
///
class Fraction extends Double {
  final int numerator;
  final int denominator;

  Fraction(int numer, int denom)
      : numerator = numer,
        denominator = denom,
        super(numer / denom);

  Fraction.mixed(int whole, int numer, int denom)
      : numerator = numer + (whole * denom),
        denominator = denom,
        super((whole * denom + numer) / denom);
}
