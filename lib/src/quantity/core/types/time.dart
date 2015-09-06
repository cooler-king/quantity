part of quantity_core;

/**
 * Represents the _time interval_ physical quantity (one of the seven
 * base SI quantities).
 *
 * The class is named Time, rather than Duration, to avoid conflict with
 * the [dart:core] [Duration] class.
 *
 * Use the [TimeInstant] class to specify a specific moment in time.
 */
class Time extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions timeDimensions = const Dimensions.constant(const {"Time": 1});

  // units

  /// the standard SI unit
  static final TimeUnits seconds = new TimeUnits("seconds", "sec", "s", null, Double.one, true);

  /// accepted for use with the SI
  static final TimeUnits daysMeanSolar = new TimeUnits("days", "days", "d", null, const Double.constant(8.64e4), false);

  /// accepted for use with the SI
  static final TimeUnits hoursMeanSolar =
      new TimeUnits("hours", "hrs", "h", null, const Double.constant(3.60e3), false);

  /// accepted for use with the SI
  static final TimeUnits minutesMeanSolar =
      new TimeUnits("minutes", "minutes", "min", null, const Double.constant(6.0e1), false);

  // common metric derivations

  /// one thousandth of a second
  static final TimeUnits milliseconds = Time.seconds.milli();

  /// one millionth of a second
  static final TimeUnits microseconds = Time.seconds.micro();

  /// one billionth of a second
  static final TimeUnits nanoseconds = Time.seconds.nano();

  // convenience units

  /// accepted for use with the SI
  static final TimeUnits minutes = minutesMeanSolar;

  /// accepted for use with the SI
  static final TimeUnits hours = hoursMeanSolar;

  /// accepted for use with the SI
  static final TimeUnits days = daysMeanSolar;

  Time(
      {dynamic s,
      dynamic ms,
      dynamic ns,
      dynamic d,
      dynamic h,
      dynamic min,
      double uncert: 0.0})
      : super(
          s !=
                  null
              ? s
              : (ms != null
                  ? ms
                  : (ns != null ? ns : (d != null ? d : (h != null ? h : (min != null ? min : 0.0))))),
          ms !=
                  null
              ? Time.milliseconds
              : (ns != null
                  ? Time.nanoseconds
                  : (d != null
                      ? Time.daysMeanSolar
                      : (h != null ? Time.hoursMeanSolar : (min != null ? Time.minutesMeanSolar : Time.seconds)))),
          uncert);

  Time._internal(conv) : super._dimensions(conv, Time.timeDimensions);

  /**
   * Constructs a Time based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Time.inUnits(value, TimeUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Time.seconds, uncert);

  const Time.constant(Number valueSI, {TimeUnits units, num uncert: 0.0})
      : super.constant(valueSI, Time.timeDimensions, units, uncert);

  /**
   * Construct a Time object from an existin dart:core Duration object.
   */
  Time.fromDuration(Duration d) : super((d != null) ? d.inMicroseconds.toDouble() / 1.0e6 : 0.0, Time.seconds);

  /**
   * Create a dart:core Duration object with the same time interval as this
   * Time object, to microsecond precision (the maximum precision of the
   * Duration object).
   */
  Duration toDuration() => new Duration(microseconds: (valueSI.toDouble() * 1000000.0).round());
}

/**
 * Units acceptable for use in describing [Time] quantities.
 */
class TimeUnits extends Time with Units {
  TimeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    this._convToMKS = objToNumber(conv);
    this._abbrev1 = abbrev1;
    this._abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Time;

  /**
   * Derive new TimeUnits using this TimeUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new TimeUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
