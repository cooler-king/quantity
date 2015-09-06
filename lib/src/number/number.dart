part of number;

/**
   ###Immutable?
 */
abstract class Number implements Comparable {

  //static Map<String, Type> _codeTypeMap;

  const Number.constant();
  Number();

  // Abstract operators

  /// Two Numbers will be equal when the represented values are equal,
  /// even if the Number subtypes are different.
  ///
  bool operator ==(obj);

  /// The hashcodes for two Numbers will be equal when the represnted values are equal,
  /// even if the Number subtypes are different.
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
  int compareTo(Comparable n2) {
    //TODO support nums too
    if (n2 is! Number) throw new ArgumentError();
    return Comparable.compare(this.toDouble(), (n2 as Number).toDouble());
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
