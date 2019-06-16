part of quantity_si;

/// The amount of three-dimensional space enclosed by some closed boundary.
/// See the [Wikipedia entry for Volume](https://en.wikipedia.org/wiki/Volume)
/// for more information.
class Volume extends Quantity {
  /// Constructs a Volume with cubiic meters ([m3]) or liters ([L]).
  /// Optionally specify a relative standard uncertainty.
  Volume({dynamic m3, dynamic L, double uncert = 0.0})
      : super(m3 ?? (L ?? 0.0), L != null ? Volume.liters : Volume.cubicMeters, uncert);

  Volume._internal(dynamic conv) : super._internal(conv, Volume.volumeDimensions);

  /// Constructs a Volume based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Volume.inUnits(dynamic value, VolumeUnits units, [double uncert = 0.0])
      : super(value, units ?? Volume.cubicMeters, uncert);

  /// Constructs a constant Volume.
  const Volume.constant(Number valueSI, {VolumeUnits units, double uncert = 0.0})
      : super.constant(valueSI, Volume.volumeDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions volumeDimensions =
      const Dimensions.constant(const <String, int>{'Length': -3}, qType: Volume);

  /// The standard SI unit.
  static final VolumeUnits cubicMeters = new VolumeUnits.lengthCubed(Length.meters);

  /// Accepted for use with the SI
  /// equal to one thousandth of a cubic meter
  static final VolumeUnits liters = new VolumeUnits('liters', null, 'L', null, 1.0e-3, true);
}

/// Units acceptable for use in describing Volume quantities.
class VolumeUnits extends Volume with Units {
  /// Constructs a new instance.
  VolumeUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance based on length units.
  VolumeUnits.lengthCubed(LengthUnits lu) : super._internal(lu.valueSI ^ 3) {
    name = 'cubic ${lu.name}';
    singular = 'cubic ${lu.singular}';
    _convToMKS = lu.valueSI ^ 3;
    _abbrev1 = lu._abbrev1 != null ? '${lu._abbrev1}3' : null;
    _abbrev2 = lu._abbrev2 != null ? '${lu._abbrev2}3' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => Volume;

  /// Derive new VolumeUnits using this VolumeUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new VolumeUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
