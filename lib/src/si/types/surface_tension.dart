part of quantity_si;

class SurfaceTension extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions surfaceTensionDimensions = const Dimensions.constant(const {"Mass": 1, "Time": -2});

  /// The standard SI unit.
  static final SurfaceTensionUnits newtonsPerMeter = new SurfaceTensionUnits.forceLength(Force.newtons, Length.meters);

  SurfaceTension({dynamic N_per_m, double uncert: 0.0})
      : super(N_per_m != null ? N_per_m : 0.0, SurfaceTension.newtonsPerMeter, uncert);

  SurfaceTension._internal(conv) : super._dimensions(conv, SurfaceTension.surfaceTensionDimensions);

  /// Constructs a SurfaceTension based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  SurfaceTension.inUnits(value, SurfaceTensionUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : SurfaceTension.newtonsPerMeter, uncert);

  const SurfaceTension.constant(Number valueSI, {SurfaceTensionUnits units, num uncert: 0.0})
      : super.constant(valueSI, SurfaceTension.surfaceTensionDimensions, units, uncert);
}

/// Units acceptable for use in describing SurfaceTension quantities.
///
class SurfaceTensionUnits extends SurfaceTension with Units {
  SurfaceTensionUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  SurfaceTensionUnits.forceLength(ForceUnits fu, LengthUnits lu) : super._internal(fu.valueSI / lu.valueSI) {
    this.name = "${fu.name} per ${lu.singular}";
    this.singular = "${fu.singular} per ${lu.singular}";
    this._convToMKS = fu.valueSI / lu.valueSI;
    this._abbrev1 = fu._abbrev1 != null && lu._abbrev1 != null ? "${fu._abbrev1} / ${lu._abbrev1}" : null;
    this._abbrev2 = fu._abbrev2 != null && lu._abbrev2 != null ? "${fu._abbrev2}/${lu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => SurfaceTension;

  /// Derive new SurfaceTensionUnits using this SurfaceTensionUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new SurfaceTensionUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
