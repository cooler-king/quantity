import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';

/// Represents the _length_ physical quantity (one of the seven base SI quantities).
/// See the [Wikipedia entry for Length](https://en.wikipedia.org/wiki/Length)
/// for more information.
class Length extends Quantity {
  /// Constructs a Length with meters ([m]), kilometers ([km]), millimeters ([mm]), astronomical units ([ua])
  /// or nautical miles ([NM]).
  /// Optionally specify a relative standard uncertainty.
  Length(
      {dynamic m,
      dynamic km,
      dynamic mm,
      dynamic ua,
      // ignore:non_constant_identifier_names
      dynamic NM,
      double uncert = 0.0})
      : super(
            m ?? (km ?? (mm ?? (ua ?? (NM ?? 0.0)))),
            km != null
                ? Length.kilometers
                : (mm != null
                    ? Length.millimeters
                    : (ua != null
                        ? Length.astronomicalUnits
                        : (NM != null ? Length.nauticalMiles : Length.meters))),
            uncert);

  /// Constructs an instance without preferred units.
  Length.misc(dynamic conv) : super.misc(conv, Length.lengthDimensions);

  /// Constructs a Length based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Length.inUnits(dynamic value, LengthUnits? units, [double uncert = 0.0])
      : super(value, units ?? Length.meters, uncert);

  /// Constructs constant Length.
  const Length.constant(Number valueSI,
      {LengthUnits? units, double uncert = 0.0})
      : super.constant(valueSI, Length.lengthDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions lengthDimensions =
      Dimensions.constant(<String, int>{'Length': 1}, qType: Length);

  /// The standard SI unit.
  static final LengthUnits meters =
      LengthUnits('meters', 'm', 'm', 'meter', 1.0, true);

  /// Accepted for use with the SI... the value of the astronomical unit must be
  /// obtained by experiment and is therefore not known exactly... its value is
  /// such that, when used to describe the motion of bodies in the solar system,
  /// the heliocentric gravitation constant is 0.017 202 098 85 squared (in units
  /// of ua+3 d-2, where d is day).
  static final LengthUnits astronomicalUnits = LengthUnits('astronomical units',
      'AU', 'ua', 'astronomical unit', 1.495978707e11, false);

  /// Accepted for use with the SI, subject to further review.
  static final LengthUnits angstroms =
      LengthUnits('angstroms', '\u212b', '\u00c5', 'angstrom', 1.0e-10, true);

  /// Accepted for use with the SI, subject to further review.
  static final LengthUnits nauticalMiles = LengthUnits(
      'nautical miles', 'NM', 'NM', 'nautical mile', 1.852e3, false);

  // Convenience Units.

  /// The metric unit for one thousand meters.
  static final LengthUnits kilometers = Length.meters.kilo() as LengthUnits;

  /// The metric unit for one hundredth of a meter.
  static final LengthUnits centimeters = Length.meters.centi() as LengthUnits;

  /// The metric unit for one thousandth of a meter.
  static final LengthUnits millimeters = Length.meters.milli() as LengthUnits;

  /// The metric unit for one billionth of a meter.
  static final LengthUnits nanometers = Length.meters.nano() as LengthUnits;
}

/// Units acceptable for use in describing Length quantities.
class LengthUnits extends Length with Units {
  /// Constructs an instance.
  LengthUnits(String name, String? abbrev1, String? abbrev2, String singular,
      dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super.misc(conv) {
    this.name = name;
    this.singular = singular;
    convToMKS = objToNumber(conv);
    this.abbrev1 = abbrev1;
    this.abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Length;

  /// Derive LengthUnits using this LengthUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      LengthUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
