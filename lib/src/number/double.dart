import 'complex.dart';
import 'imaginary.dart';
import 'integer.dart';
import 'number.dart';
import 'precise.dart';
import 'real.dart';

/// Wraps Dart's core [double] type, so that it can share a common base type with other [Number]s.
class Double extends Real {
  /// Constructs an instance.
  Double(this._value);

  /// Constructs a constant Double.
  const Double.constant(this._value) : super.constant();

  /// Constructs an instance from an integer value.
  Double.fromInt(int val) : _value = val.toDouble();

  /// Construct an Double from a Map:
  ///     { 'd': integer value }
  ///
  /// If the map contents are not recognized, [Double.zero] is returned.
  factory Double.fromMap(Map<String, num>? m) {
    if (m == null) return Double.zero;
    if (m.containsKey('d') == true) return Double(m['d']?.toDouble() ?? 0.0);
    return Double.zero;
  }

  final double _value;

  /// Zero as a Double.
  static const Double zero = Double.constant(0);

  /// One as a Double.
  static const Double one = Double.constant(1);

  /// Ten as a Double.
  static const Double ten = Double.constant(10);

  /// One hundred as a Double.
  static const Double hundred = Double.constant(100);

  /// One thousand as a Double.
  static const Double thousand = Double.constant(1000);

  /// Infinity as a Double.
  static const Double infinity = Double.constant(double.infinity);

  /// Negative infinity as a Double.
  static const Double negInfinity = Double.constant(double.negativeInfinity);

  /// Not a number as a Double.
  // ignore: constant_identifier_names
  static const Double NaN = Double.constant(double.nan);

  @override
  double get value => _value;

  @override
  double toDouble() => _value;

  @override
  int toInt() => _value.toInt();

  /// An integer value returns the same hash as the [int] with the same value.
  /// Otherwise returns the same hash as the [Precise] number representing the value.
  @override
  int get hashCode {
    if (_value.isNaN || _value.isInfinite) return _value.hashCode;
    if (isInteger) return toInt().hashCode;
    return Precise.num(_value).hashCode;
  }

  @override
  bool operator ==(Object obj) {
    if (obj is num && obj.isNaN) return value.isNaN;
    if (obj is Real || obj is num) return obj == value;
    if (obj is Imaginary) return value == 0.0 && obj.value.toDouble() == 0.0;
    if (obj is Complex) {
      return obj.real.toDouble() == value && obj.imaginary.toDouble() == 0.0;
    }

    return false;
  }

  @override
  Double operator -() => Double(-value);

  @override
  Number clamp(dynamic lowerLimit, dynamic upperLimit) {
    final lower = lowerLimit is num
        ? lowerLimit
        : lowerLimit is Number
            ? lowerLimit.toInt()
            : 0;
    final upper = upperLimit is num
        ? upperLimit
        : upperLimit is Number
            ? upperLimit.toInt()
            : 0;
    final clamped = value.clamp(lower, upper);
    return clamped.toInt() == clamped
        ? Integer(clamped.toInt())
        : Double(clamped.toDouble());
  }

  @override
  bool get isInteger =>
      !value.isNaN && value.isFinite && value.toInt() == value;

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     'd' : double value
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{'d': value};
}
