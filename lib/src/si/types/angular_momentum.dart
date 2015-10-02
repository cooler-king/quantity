part of quantity_si;

/// A measure of the quantity of rotation of a system of matter, taking into account its mass,
/// rotations, motions and shape.
///
/// See the [Wikipedia entry for Angular momentum](https://en.wikipedia.org/wiki/Angular_momentum)
/// for more information.
///
class AngularMomentum extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions angularMometumDimensions =
      const Dimensions.constant(const {"Angle": 1, "Length": 1, "Time": -1});

  /// The standard SI unit
  static final AngularMomentumUnits jouleSecond = new AngularMomentumUnits.energyTime(Energy.joules, Time.seconds);

  /// Construct an AngularMomentum with joule seconds ([Js]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AngularMomentum({dynamic Js, double uncert: 0.0}) : super(Js ?? 0.0, AngularMomentum.jouleSecond, uncert);

  AngularMomentum._internal(conv) : super._dimensions(conv, AngularMomentum.angularMometumDimensions);

  /// Constructs a AngularMomentum based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  AngularMomentum.inUnits(value, AngularMomentumUnits units, [double uncert = 0.0])
      : super(value, units ?? AngularMomentum.jouleSecond, uncert);

  const AngularMomentum.constant(Number valueSI, {AngularMomentumUnits units, num uncert: 0.0})
      : super.constant(valueSI, AngularMomentum.angularMometumDimensions, units, uncert);
}

/// Units acceptable for use in describing AngularMomentum quantities.
///
class AngularMomentumUnits extends AngularMomentum with Units {
  AngularMomentumUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  AngularMomentumUnits.energyTime(EnergyUnits eu, TimeUnits tu) : super._internal(eu.valueSI * tu.valueSI) {
    this.name = "${eu.singular} ${tu.name}";
    this.singular = "${eu.singular} ${tu.singular}";
    this._convToMKS = eu.valueSI * tu.valueSI;
    this._abbrev1 = eu._abbrev1 != null && tu._abbrev1 != null ? "${eu._abbrev1} ${tu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && tu._abbrev2 != null ? "${eu._abbrev2}${tu._abbrev2}" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => AngularMomentum;

  /// Derive new AngularMomentumUnits using this AngularMomentumUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AngularMomentumUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
