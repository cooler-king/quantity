part of quantity_si;

/// A measure of a fluid's resistance to gradual deformation by shear stress or
/// tensile stress.
///
/// See the [Wikipedia entry for Viscosity](https://en.wikipedia.org/wiki/Viscosity)
/// for more information.
///
class DynamicViscosity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions dynamicViscosityDimensions =
      const Dimensions.constant(const <String, int>{'Mass': 1, 'Length': -1, 'Time': -1}, qType: DynamicViscosity);

  /// The standard SI unit.
  static final DynamicViscosityUnits pascalSeconds =
      new DynamicViscosityUnits.pressureTime(Pressure.pascals, Time.seconds);

  /// Another name for [pascalSeconds]
  static final DynamicViscosityUnits poiseuille = pascalSeconds;

  /// Construct a DynamicViscosity with pascal seconds ([Pas]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  // ignore: non_constant_identifier_names
  DynamicViscosity({dynamic Pas, double uncert = 0.0}) : super(Pas ?? 0.0, DynamicViscosity.pascalSeconds, uncert);

  DynamicViscosity._internal(dynamic conv) : super._internal(conv, DynamicViscosity.dynamicViscosityDimensions);

  /// Constructs a DynamicViscosity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  DynamicViscosity.inUnits(dynamic value, DynamicViscosityUnits units, [double uncert = 0.0])
      : super(value, units ?? DynamicViscosity.pascalSeconds, uncert);

  const DynamicViscosity.constant(Number valueSI, {DynamicViscosityUnits units, double uncert = 0.0})
      : super.constant(valueSI, DynamicViscosity.dynamicViscosityDimensions, units, uncert);
}

/// Units acceptable for use in describing DynamicViscosity quantities.
///
class DynamicViscosityUnits extends DynamicViscosity with Units {
  /// Constructs a new instance.
  DynamicViscosityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on pressure and time units.
  DynamicViscosityUnits.pressureTime(PressureUnits pu, TimeUnits tu) : super._internal(pu.valueSI * tu.valueSI) {
    name = '${pu.singular} ${tu.name}';
    singular = '${pu.singular} ${tu.singular}';
    _convToMKS = pu.valueSI * tu.valueSI;
    _abbrev1 = pu._abbrev1 != null && tu._abbrev1 != null ? '${pu._abbrev1} ${tu._abbrev1}' : null;
    _abbrev2 = pu._abbrev2 != null && tu._abbrev2 != null ? '${pu._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => DynamicViscosity;

  /// Derive new DynamicViscosityUnits using this DynamicViscosityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new DynamicViscosityUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}
