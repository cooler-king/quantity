part of quantity_si;

/// The amount of three-dimensional space enclosed by some closed boundary.
///
/// See the [Wikipedia entry for Volume](https://en.wikipedia.org/wiki/Volume)
/// for more information.
///
class Volume extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions volumeDimensions = const Dimensions.constant(const {"Length": -3});

  /// The standard SI unit
  static final VolumeUnits cubicMeters = new VolumeUnits.length(Length.meters);

  /// Accepted for use with the SI
  /// equal to one thousandth of a cubic meter
  static final VolumeUnits liters = new VolumeUnits("liters", null, "L", null, 1.0e-3, true);

  /// Construct a Volume with cubiic meters ([m3]) or liters ([L]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Volume({dynamic m3, dynamic L, double uncert: 0.0})
      : super(m3 ?? (L ?? 0.0), L != null ? Volume.liters : Volume.cubicMeters, uncert);

  Volume._internal(conv) : super._dimensions(conv, Volume.volumeDimensions);

  /// Constructs a Volume based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Volume.inUnits(value, VolumeUnits units, [double uncert = 0.0]) : super(value, units ?? Volume.cubicMeters, uncert);

  const Volume.constant(Number valueSI, {VolumeUnits units, num uncert: 0.0})
      : super.constant(valueSI, Volume.volumeDimensions, units, uncert);
}

/// Units acceptable for use in describing Volume quantities.
///
class VolumeUnits extends Volume with Units {
  VolumeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  VolumeUnits.length(LengthUnits lu) : super._internal(lu.valueSI ^ 3) {
    this.name = "cubic ${lu.name}";
    this.singular = "cubic ${lu.singular}";
    this._convToMKS = lu.valueSI ^ 3;
    this._abbrev1 = lu._abbrev1 != null ? "${lu._abbrev1}3" : null;
    this._abbrev2 = lu._abbrev2 != null ? "${lu._abbrev2}3" : null;
    ;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Volume;

  /// Derive new VolumeUnits using this VolumeUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new VolumeUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
