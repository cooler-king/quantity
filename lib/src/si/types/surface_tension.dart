part of quantity_si;

/// The elastic tendency of liquids which makes them acquire the least surface area possible.
///
/// See the [Wikipedia entry for Surface tension](https://en.wikipedia.org/wiki/Surface_tension)
/// for more information.
///
class SurfaceTension extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions surfaceTensionDimensions =
      const Dimensions.constant(const <String, int>{'Mass': 1, 'Time': -2}, qType: SurfaceTension);

  /// The standard SI unit.
  static final SurfaceTensionUnits newtonsPerMeter =
      new SurfaceTensionUnits.forcePerLength(Force.newtons, Length.meters);

  /// Construct a SurfaceTension with newtons per meter.
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  SurfaceTension({dynamic newtonsPerMeter, double uncert: 0.0})
      : super(newtonsPerMeter ?? 0.0, SurfaceTension.newtonsPerMeter, uncert);

  SurfaceTension._internal(dynamic conv) : super._internal(conv, SurfaceTension.surfaceTensionDimensions);

  /// Constructs a SurfaceTension based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SurfaceTension.inUnits(dynamic value, SurfaceTensionUnits units, [double uncert = 0.0])
      : super(value, units ?? SurfaceTension.newtonsPerMeter, uncert);

  const SurfaceTension.constant(Number valueSI, {SurfaceTensionUnits units, double uncert: 0.0})
      : super.constant(valueSI, SurfaceTension.surfaceTensionDimensions, units, uncert);
}

/// Units acceptable for use in describing SurfaceTension quantities.
///
class SurfaceTensionUnits extends SurfaceTension with Units {
  /// Constructs a new instance.
  SurfaceTensionUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on force and length units.
  SurfaceTensionUnits.forcePerLength(ForceUnits fu, LengthUnits lu) : super._internal(fu.valueSI / lu.valueSI) {
    name = '${fu.name} per ${lu.singular}';
    singular = '${fu.singular} per ${lu.singular}';
    _convToMKS = fu.valueSI / lu.valueSI;
    _abbrev1 = fu._abbrev1 != null && lu._abbrev1 != null ? '${fu._abbrev1} / ${lu._abbrev1}' : null;
    _abbrev2 = fu._abbrev2 != null && lu._abbrev2 != null ? '${fu._abbrev2}/${lu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => SurfaceTension;

  /// Derive new SurfaceTensionUnits using this SurfaceTensionUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new SurfaceTensionUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
