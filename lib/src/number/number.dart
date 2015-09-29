part of number;

/// The abstract base class for all Number types.
///
abstract class Number implements Comparable {
  const Number.constant();
  Number();

  // Abstract operators

  /// Two Numbers will be equal when the represented values are equal,
  /// even if the Number subtypes are different.
  ///
  bool operator ==(obj);

  /// The hashcodes for two Numbers will be equal when the represented values are equal,
  /// even if the Number subtypes are different.
  ///
  /// Additionally, Numbers having integer values will have the same hashcode as
  /// the corresponding dart:core `int`.
  ///
  int get hashCode;

  Number operator +(addend);
  Number operator -();
  Number operator -(subtrahend);
  Number operator *(multiplicand);
  Number operator /(divisor);
  Number operator ~/(divisor);
  Number operator %(divisor);

  Number operator ^(exponent);

  bool operator >(obj);
  bool operator >=(obj);
  bool operator <(obj);
  bool operator <=(obj);

  // Mirror num's abstract properties
  bool get isInfinite;
  bool get isNaN;
  bool get isNegative;

  // Mirror num's abstract methods

  /// Returns the absolute value of this Number.
  Number abs();

  /// Returns the least Number having integer components no smaller than this Number.
  Number ceil();

  int toInt();
  double toDouble();
  Integer truncate();

  // Add some of our own
  Number reciprocal();

  /// Subclasses must support dart:json for stringify.
  ///
  Map toJson();

  /// True if the Number represents an integer value.
  ///
  /// Note that the Number does not have to be of type
  /// Integer for this to be true.
  ///
  bool get isInteger;

  /// Compares this Number to another Number by comparing values.
  ///
  /// [n2] is expected to be a num or Number.  If it is not it will
  /// be considered to have a value of 0.
  ///
  int compareTo(Comparable n2) {
    if (n2 is Number) return Comparable.compare(this.toDouble(), n2.toDouble());
    if (n2 is num) return Comparable.compare(this.toDouble(), n2);

    // If n2 is not a num or Number, treat it as a zero
    return Comparable.compare(this.toDouble(), 0);
  }

  /// Detect the type of Number by inspecting
  /// map contents and create it.
  ///
  static Number _fromMap(Map m) {
    if (m.containsKey("imag")) return new Imaginary.fromMap(m);
    if (m.containsKey("real")) return new Complex.fromMap(m);
    if (m.containsKey("pd")) return null; //return new Precise()
    return Integer.zero;
  }
}
