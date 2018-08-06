part of number;

/// Wraps Dart's core [double] type, so that it can share a common base type with other [Number]s.
class Double extends Real {
  final double _value;

  static const Double zero = const Double.constant(0.0);
  static const Double one = const Double.constant(1.0);
  static const Double ten = const Double.constant(10.0);
  static const Double hundred = const Double.constant(100.0);
  static const Double thousand = const Double.constant(1000.0);
  static const Double infinity = const Double.constant(polyfill_core.double.infinity);
  static const Double negInfinity = const Double.constant(polyfill_core.double.negativeInfinity);

  // ignore: constant_identifier_names
  static const Double NaN = const Double.constant(polyfill_core.double.nan);

  Double(this._value);

  const Double.constant(this._value) : super.constant();

  Double.fromInt(int val) : _value = val.toDouble();

  /// Construct an Double from a Map:
  ///     { 'd': integer value }
  ///
  /// If the map contents are not recognized, [Double.zero] is returned.
  factory Double.fromMap(Map<String, num> m) {
    if (m?.containsKey('d') == true) {
      return new Double(m['d']?.toDouble() ?? 0.0);
    }
    return Double.zero;
  }

  @override
  double get value => _value;

  @override
  double toDouble() => _value;

  @override
  int toInt() => _value.toInt();

  /// If an integer value returns the same hash as the [int] with the same value.
  /// Otherwise returns the same hash as the [Precise] number representing the value.
  @override
  int get hashCode {
    if (_value.isNaN || _value.isInfinite) return _value.hashCode;
    if (isInteger) return toInt().hashCode;
    return new Precise.num(_value).hashCode;
  }

  @override
  bool operator ==(dynamic obj) {
    if (obj == polyfill_core.double.nan) return value == polyfill_core.double.nan;
    if (obj is Real || obj is num) return obj == value;
    if (obj is Imaginary) return value == 0.0 && obj.value?.toDouble() == 0.0;
    if (obj is Complex) return obj.real?.toDouble() == value && obj.imaginary?.toDouble() == 0.0;

    return false;
  }

  @override
  Double operator -() => new Double(-value);

  @override
  Number clamp(dynamic lowerLimit, dynamic upperLimit) {
    final num lower = lowerLimit is num ? lowerLimit : lowerLimit is Number ? lowerLimit.toInt() : 0;
    final num upper = upperLimit is num ? upperLimit : upperLimit is Number ? upperLimit.toInt() : 0;
    return new Double(value?.clamp(lower, upper)?.toDouble() ?? 0.0);
  }

  @override
  Number reciprocal() {
    if (value != 0.0) return new Double(1.0 / value);
    return Double.zero;
  }

  @override
  bool get isInteger => value.truncate() == value;

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     'd' : double value
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'d': value};
}
