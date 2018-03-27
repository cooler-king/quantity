part of quantity_si;

/// The resistance to flow of a fluid, equal to its absolute viscosity divided by its density.
///
/// See the [Wikipedia entry for Viscosity](https://en.wikipedia.org/wiki/Viscosity)
/// for more information.
///
class KinematicViscosity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions kinematicViscosityDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -1}, qType: KinematicViscosity);

  /// The standard SI unit.
  static final KinematicViscosityUnits metersSquaredPerSecond =
      new KinematicViscosityUnits.areaTime(Area.squareMeters, Time.seconds);

  /// Construct a KinematicViscosity with meters squared per second.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  KinematicViscosity({dynamic metersSquaredPerSecond, double uncert: 0.0}) : super(metersSquaredPerSecond ?? 0.0, Illuminance.lux, uncert);

  KinematicViscosity._internal(dynamic conv) : super._internal(conv, KinematicViscosity.kinematicViscosityDimensions);

  /// Constructs a KinematicViscosity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  KinematicViscosity.inUnits(dynamic value, KinematicViscosityUnits units, [double uncert = 0.0])
      : super(value, units ?? KinematicViscosity.metersSquaredPerSecond, uncert);

  const KinematicViscosity.constant(Number valueSI, {KinematicViscosityUnits units, double uncert: 0.0})
      : super.constant(valueSI, KinematicViscosity.kinematicViscosityDimensions, units, uncert);
}

/// Units acceptable for use in describing KinematicViscosity quantities.
///
class KinematicViscosityUnits extends KinematicViscosity with Units {
  /// Constructs a new instance.
  KinematicViscosityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on area and time units.
  KinematicViscosityUnits.areaTime(AreaUnits au, TimeUnits tu) : super._internal(au.valueSI * tu.valueSI) {
    name = '${au.name} per ${tu.singular}';
    singular = '${au.singular} per ${tu.singular}';
    _convToMKS = au.valueSI * tu.valueSI;
    _abbrev1 = au._abbrev1 != null && tu._abbrev1 != null ? '${au._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = au._abbrev2 != null && tu._abbrev2 != null ? '${au._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => KinematicViscosity;

  /// Derive new KinematicViscosityUnits using this KinematicViscosityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new KinematicViscosityUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
