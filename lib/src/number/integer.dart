part of number;

/// Wraps Dart's core [int] type, so that it can share a common base
/// type with other [Number]s.
///
class Integer extends Real {
  final int _value;

  static const zero = const Integer.constant(0);
  static const one = const Integer.constant(1);
  static const negOne = const Integer.constant(-1);
  static const ten = const Integer.constant(10);
  static const hundred = const Integer.constant(100);
  static const thousand = const Integer.constant(1000);

  Integer(this._value);
  const Integer.constant(this._value) : super.constant();
  Integer.parse(String str, {int radix: 10})
      : _value = int.parse(str, radix: radix);

  num get value => _value;

  bool get isInfinite => false;
  bool get isNaN => false;
  bool get isNegative => value < 0;

  int toInt() => value.toInt();
  double toDouble() => value.toDouble();

  /// Tests whether this Integer is equal to another Object [obj].
  ///
  /// Only [num] and [Number] objects having the same real
  /// integer value (and no imagainary component) are considered
  /// equal.
  ///
  bool operator ==(obj) {
    if (obj is Number || obj is num) return obj == value;
    if (obj is Complex) return obj.real == value && obj.imaginary == 0.0;
    if (obj is Imaginary) return value == 0.0 && obj == 0.0;

    return false;
  }

  int get hashCode => _value.toDouble().hashCode;

  bool get isInteger => true;

  @override
  Number operator +(addend) {
    if (addend is int) return new Integer(addend + value);
    else if (addend is Integer) return new Integer(addend.value + value);
    return super + addend;
  }

  /// Negation operator.
  ///
  @override
  Number operator -() => new Integer(-value);

  @override
  Number operator -(subtrahend) {
    if (subtrahend is int) return new Integer(value - subtrahend);
    if (subtrahend is Integer) return new Integer(value - subtrahend.value);
    return super - subtrahend;
  }

  @override
  Number operator *(multiplier) {
    if (multiplier is int) return new Integer(multiplier * value);
    if (multiplier is Integer) return new Integer(multiplier.value * value);
    return super * multiplier;
  }

  /// The modulo operator.
  ///
  Number operator %(divisor) {
    if (divisor is int) return new Integer(_value % divisor);
    if (divisor is Integer) return new Integer(_value % divisor._value);
    return super % divisor;
  }

  // --- Bitwise and shift operators ---

  /// Bitwise AND.
  ///
  Number operator &(n) {
    if (n is int) return new Integer(_value & n);
    if (n is Integer) return new Integer(_value & n._value);
    throw new UnsupportedError(
        "Bitwise AND operations are only supported for int and Integer objects");
  }

  /// Bitwise OR.
  ///
  Number operator |(n) {
    if (n is int) return new Integer(_value | n);
    if (n is Integer) return new Integer(_value | n._value);
    throw new UnsupportedError(
        "Bitwise OR operations are only supported for int and Integer objects");
  }

  /// A substitute method to perform bitwise XOR operation on integers.
  ///
  /// The caret operator is overridden to provide a power operator for all numbers.
  ///
  Integer bitwiseXor(n) {
    if (n is int) return new Integer(_value ^ n);
    if (n is Integer) return new Integer(_value ^ n._value);
    throw new UnsupportedError(
        "Bitwise XOR operations are only supported for int and Integer objects");
  }

  /// The absolute value, returned as an [Integer].
  ///
  /// Returns itself if its value is greater than or equal to zero.
  ///
  @override
  Integer abs() => _value >= 0 ? this : new Integer(value.abs());

  @override
  Integer ceil() => this;

  @override
  Integer truncate() => this;

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     "i" : int value
  ///
  Map toJson() {
    return {"i": value};
  }
}

class Binary extends Integer {
  Binary(String binaryStr) : super.parse(binaryStr, radix: 2);

  String toString() => _value.toRadixString(2);
}

class Octal extends Integer {
  Octal(String octalStr) : super.parse(octalStr, radix: 8);

  String toString() => _value.toRadixString(8);
}

class Hexadecimal extends Integer {
  Hexadecimal(String hexStr) : super.parse(hexStr, radix: 16);

  String toString() => _value.toRadixString(16);
}
