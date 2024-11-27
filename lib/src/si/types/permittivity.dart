import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';
import 'capacitance.dart';
import 'length.dart';

/// The resistance that is encountered when forming an electric field in a medium.
/// See the [Wikipedia entry for Permittivity](https://en.wikipedia.org/wiki/Permittivity)
/// for more information.
class Permittivity extends Quantity {
  /// Constructs a Permittivity with farads per meter.
  /// Optionally specify a relative standard uncertainty.
  Permittivity({dynamic faradsPerMeter, double uncert = 0.0})
      : super(faradsPerMeter ?? 0.0, Permittivity.faradsPerMeter, uncert);

  /// Constructs an instance without preferred units.
  Permittivity.misc(dynamic conv)
      : super.misc(conv, Permittivity.permittivityDimensions);

  /// Constructs a Permittivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Permittivity.inUnits(dynamic value, PermittivityUnits? units,
      [double uncert = 0.0])
      : super(value, units ?? Permittivity.faradsPerMeter, uncert);

  /// Constructs a constant Permittivity.
  const Permittivity.constant(Number valueSI,
      {PermittivityUnits? units, double uncert = 0.0})
      : super.constant(
            valueSI, Permittivity.permittivityDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions permittivityDimensions = Dimensions.constant(
      <String, int>{'Length': -3, 'Time': 4, 'Current': 2, 'Mass': -1},
      qType: Permittivity);

  /// The standard SI unit.
  static final PermittivityUnits faradsPerMeter =
      PermittivityUnits.capacitancePerLength(Capacitance.farads, Length.meters);
}

/// Units acceptable for use in describing Permittivity quantities.
class PermittivityUnits extends Permittivity with Units {
  /// Constructs an instance.
  PermittivityUnits(String name, String? abbrev1, String? abbrev2,
      String singular, dynamic conv,
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

  /// Constructs an instance based on capacitance and length units.
  PermittivityUnits.capacitancePerLength(CapacitanceUnits cu, LengthUnits lu)
      : super.misc(cu.valueSI / lu.valueSI) {
    name = '${cu.name} per ${lu.singular}';
    singular = '${cu.singular} per ${lu.singular}';
    convToMKS = cu.valueSI / lu.valueSI;
    abbrev1 = cu.abbrev1 != null && lu.abbrev1 != null
        ? '${cu.abbrev1} / ${lu.abbrev1}'
        : null;
    abbrev2 = cu.abbrev2 != null && lu.abbrev2 != null
        ? '${cu.abbrev2} ${lu.abbrev2}\u{207b}\u{00b9}'
        : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Permittivity;

  /// Derive PermittivityUnits using this PermittivityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      PermittivityUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
