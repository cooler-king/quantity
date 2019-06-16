part of quantity_si;

/// A measure of the quantity of rotation of a system of matter, taking into account its mass,
/// rotations, motions and shape.
/// See the [Wikipedia entry for Angular momentum](https://en.wikipedia.org/wiki/Angular_momentum)
/// for more information.
class AngularMomentum extends Quantity {
  /// Construct an AngularMomentum with joule seconds ([Js]).
  /// Optionally specify a relative standard uncertainty.
  // ignore: non_constant_identifier_names
  AngularMomentum({dynamic Js, double uncert = 0.0}) : super(Js ?? 0.0, AngularMomentum.jouleSecond, uncert);

  AngularMomentum._internal(dynamic conv) : super._internal(conv, AngularMomentum.angularMometumDimensions);

  /// Constructs a AngularMomentum based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  AngularMomentum.inUnits(dynamic value, AngularMomentumUnits units, [double uncert = 0.0])
      : super(value, units ?? AngularMomentum.jouleSecond, uncert);

  /// Constructs a constant AngularMomentum.
  const AngularMomentum.constant(Number valueSI, {AngularMomentumUnits units, double uncert = 0.0})
      : super.constant(valueSI, AngularMomentum.angularMometumDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions angularMometumDimensions =
      const Dimensions.constant(const <String, int>{'Angle': 1, 'Length': 1, 'Time': -1}, qType: AngularMomentum);

  /// The standard SI unit.
  static final AngularMomentumUnits jouleSecond = new AngularMomentumUnits.energyTime(Energy.joules, Time.seconds);
}

/// Units acceptable for use in describing AngularMomentum quantities.
class AngularMomentumUnits extends AngularMomentum with Units {
  /// Constructs a new instance.
  AngularMomentumUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on energy and time units.
  AngularMomentumUnits.energyTime(EnergyUnits eu, TimeUnits tu) : super._internal(eu.valueSI * tu.valueSI) {
    name = '${eu.singular} ${tu.name}';
    singular = '${eu.singular} ${tu.singular}';
    _convToMKS = eu.valueSI * tu.valueSI;
    _abbrev1 = eu._abbrev1 != null && tu._abbrev1 != null ? '${eu._abbrev1} ${tu._abbrev1}' : null;
    _abbrev2 = eu._abbrev2 != null && tu._abbrev2 != null ? '${eu._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => AngularMomentum;

  /// Derive new AngularMomentumUnits using this AngularMomentumUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new AngularMomentumUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
