part of number;

/// Wraps Dart's core [int] type, so that it can share a common base type with other [Number]s.
class Integer extends Real {
  final int _value;

  static const Integer zero = const Integer.constant(0);
  static const Integer one = const Integer.constant(1);
  static const Integer negOne = const Integer.constant(-1);
  static const Integer ten = const Integer.constant(10);
  static const Integer hundred = const Integer.constant(100);
  static const Integer thousand = const Integer.constant(1000);

  Integer(this._value);

  const Integer.constant(this._value) : super.constant();

  Integer.parse(String str, {int radix: 10}) : _value = int.parse(str, radix: radix);

  /// Construct an Integer from a Map:
  ///     { 'i': integer value }
  ///
  /// If the map contents are not recognized, [Integer.zero] is returned.
  factory Integer.fromMap(Map<String, int> m) {
    if (m?.containsKey('i') ?? false) {
      return new Integer(m['i']);
    }
    return Integer.zero;
  }

  @override
  int get value => _value;

  @override
  bool get isInfinite => false;

  @override
  bool get isNaN => false;

  @override
  bool get isNegative => value < 0;

  @override
  int toInt() => value.toInt();

  @override
  double toDouble() => value.toDouble();

  /// Tests whether this Integer is equal to another Object [obj].
  ///
  /// Only [num] and [Number] objects having the same real
  /// integer value (and no imagainary component) are considered equal.
  @override
  bool operator ==(dynamic obj) {
    if (obj is Number || obj is num) return obj == value;
    if (obj is Complex) return obj.real == value && obj.imaginary == 0.0;
    if (obj is Imaginary) return value == 0.0 && obj == 0.0;

    return false;
  }

  /// Returns the same hash as the [int] with the same value.
  ///
  @override
  int get hashCode => _value?.hashCode;

  @override
  bool get isInteger => true;

  @override
  Number operator +(dynamic addend) {
    if (addend is int) return new Integer(addend + value);
    if (addend is Integer) return new Integer(addend.value + value);
    return super + addend;
  }

  /// Negation operator.
  @override
  Integer operator -() => new Integer(-value);

  @override
  Number operator -(dynamic subtrahend) {
    if (subtrahend is int) return new Integer(value - subtrahend);
    if (subtrahend is Integer) return new Integer(value - subtrahend.value);
    return super - subtrahend;
  }

  @override
  Number operator *(dynamic multiplier) {
    if (multiplier is int) return new Integer(multiplier * value);
    if (multiplier is Integer) return new Integer(multiplier.value * value);
    return super * multiplier;
  }

  /// The modulo operator.
  @override
  Number operator %(dynamic divisor) {
    if (divisor is int) return new Integer(_value % divisor);
    if (divisor is Integer) return new Integer(_value % divisor._value);
    return super % divisor;
  }

  // --- Bitwise and shift operators ---

  /// Bitwise AND.
  Number operator &(dynamic n) {
    if (n is int) return new Integer(_value & n);
    if (n is Integer) return new Integer(_value & n._value);
    throw new UnsupportedError('Bitwise AND operations are only supported for int and Integer objects');
  }

  /// Bitwise OR.
  Number operator |(dynamic n) {
    if (n is int) return new Integer(_value | n);
    if (n is Integer) return new Integer(_value | n._value);
    throw new UnsupportedError('Bitwise OR operations are only supported for int and Integer objects');
  }

  /// A substitute method to perform bitwise XOR operation on integers.
  ///
  /// The caret operator is overridden to provide a power operator for all numbers.
  Integer bitwiseXor(dynamic n) {
    if (n is int) return new Integer(_value ^ n);
    if (n is Integer) return new Integer(_value ^ n._value);
    throw new UnsupportedError('Bitwise XOR operations are only supported for int and Integer objects');
  }

  /// The absolute value, returned as an [Integer].
  ///
  /// Returns itself if its value is greater than or equal to zero.
  @override
  Integer abs() => _value >= 0 ? this : new Integer(value.abs());

  @override
  Number ceil() => this;

  @override
  Number clamp(dynamic lowerLimit, dynamic upperLimit) {
    final num lower = lowerLimit is num ? lowerLimit : lowerLimit is Number ? lowerLimit.toInt() : 0;
    final num upper = upperLimit is num ? upperLimit : upperLimit is Number ? upperLimit.toInt() : 0;
    return new Integer(value?.clamp(lower, upper)?.toInt() ?? lower.toInt());
  }

  @override
  Number floor() => this;

  @override
  Number truncate() => this;

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     'i' : int value
  @override
  Map<String, int> toJson() => <String, int>{'i': value};
}

class Binary extends Integer {
  Binary(String binaryStr) : super.parse(binaryStr, radix: 2);

  @override
  String toString() => _value.toRadixString(2);
}

class Octal extends Integer {
  Octal(String octalStr) : super.parse(octalStr, radix: 8);

  @override
  String toString() => _value.toRadixString(8);
}

class Hexadecimal extends Integer {
  Hexadecimal(String hexStr) : super.parse(hexStr, radix: 16);

  @override
  String toString() => _value.toRadixString(16);
}
