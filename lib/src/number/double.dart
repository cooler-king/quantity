part of number;

class Double extends Real {
  final double _value;

  static const Double zero = const Double.constant(0.0);
  static const Double one = const Double.constant(1.0);
  static const Double ten = const Double.constant(10.0);
  static const Double hundred = const Double.constant(100.0);
  static const Double thousand = const Double.constant(1000.0);
  static const Double infinity = const Double.constant(double.INFINITY);
  static const Double negInfinity = const Double.constant(double.NEGATIVE_INFINITY);
  static const Double NaN = const Double.constant(double.NAN);

  Double(this._value);
  const Double.constant(this._value) : super.constant();
  Double.fromInt(int val) : _value = val.toDouble();

  num get value => _value;

  double toDouble() => _value;

  int toInt() => _value.toInt();

  /// If an integer value returns the same hash as the [int] with the same value.
  ///
  /// Otherwise returns the same hash as the [Precise] number represeting the value.
  ///
  @override
  int get hashCode {
    if (isInteger) return toInt().hashCode;
    return (new Precise.num(_value)).hashCode;
  }

  bool operator ==(obj) {
    if (obj is Real || obj is num) return obj == value;
    if (obj is Imaginary) return value == 0.0 && obj.value == 0.0;
    if (obj is Complex) return obj.real == value && obj.imaginary == 0.0;

    return false;
  }

  Number reciprocal() {
    if (value != 0.0) return new Double(1.0 / value);
    return Double.zero;
  }

  bool get isInteger => value.truncate() == value;

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     "d" : double value
  ///
  Map toJson() {
    return {"d": value};
  }
}
