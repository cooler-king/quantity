part of quantity_si;

// also MomentOfForce

/// The tendency of a force to rotate an object about an axis, fulcrum, or pivot.
///
/// See the [Wikipedia entry for Torque](https://en.wikipedia.org/wiki/Torque)
/// for more information.
///
class Torque extends Quantity {
  /// Construct a Torque with newton meters ([Nm]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  // ignore: non_constant_identifier_names
  Torque({dynamic Nm, double uncert = 0.0}) : super(Nm ?? 0.0, Torque.newtonMeters, uncert);

  Torque._internal(dynamic conv) : super._internal(conv, Torque.torqueDimensions);

  /// Constructs a Torque based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Torque.inUnits(dynamic value, TorqueUnits units, [double uncert = 0.0])
      : super(value, units ?? Torque.newtonMeters, uncert);

  const Torque.constant(Number valueSI, {TorqueUnits units, double uncert = 0.0})
      : super.constant(valueSI, Torque.torqueDimensions, units, uncert);

  /// Dimensions for this type of quantity (energy per angle rather than LengthxForce)
  static const Dimensions torqueDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -2, 'Mass': 1, 'Angle': -1}, qType: Torque);

  /// The standard SI unit.
  static final TorqueUnits newtonMeters = new TorqueUnits.forceLength(Force.newtons, Length.meters);
}

/// Units acceptable for use in describing Torque quantities.
///
class TorqueUnits extends Torque with Units {
  TorqueUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    _convToMKS = objToNumber(conv);
    _abbrev1 = abbrev1;
    _abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  TorqueUnits.forceLength(ForceUnits fu, LengthUnits lu) : super._internal(fu.valueSI * lu.valueSI) {
    name = '${fu.singular} ${lu.name}';
    singular = '${fu.singular} ${lu.singular}';
    _convToMKS = fu.valueSI * lu.valueSI;
    _abbrev1 = fu._abbrev1 != null && lu._abbrev1 != null ? '${fu._abbrev1} ${lu._abbrev1}' : null;
    _abbrev2 = fu._abbrev2 != null && lu._abbrev2 != null ? '${fu._abbrev2}${lu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Torque;

  /// Derive new TorqueUnits using this TorqueUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new TorqueUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
