part of quantity_si;

/// The spatial frequency of a wave.
///
/// See the [Wikipedia entry for Wavenumber](https://en.wikipedia.org/wiki/Wavenumber)
/// for more information.
///
class WaveNumber extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions waveNumberDimensions = const Dimensions.constant(const {"Length": -1}, type: WaveNumber);

  /// The standard SI unit.
  static final WaveNumberUnits reciprocalMeters = new WaveNumberUnits.length(Length.meters);

  /// Construct a WaveNumber with reciprocal meters ([reciprocal_m]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  WaveNumber({dynamic reciprocal_m, double uncert: 0.0})
      : super(reciprocal_m ?? 0.0, WaveNumber.reciprocalMeters, uncert);

  WaveNumber._internal(conv) : super._internal(conv, WaveNumber.waveNumberDimensions);

  /// Constructs a WaveNumber based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  WaveNumber.inUnits(value, WaveNumberUnits units, [double uncert = 0.0])
      : super(value, units ?? WaveNumber.reciprocalMeters, uncert);

  const WaveNumber.constant(Number valueSI, {WaveNumberUnits units, num uncert: 0.0})
      : super.constant(valueSI, WaveNumber.waveNumberDimensions, units, uncert);
}

/// Units acceptable for use in describing WaveNumber quantities.
///
class WaveNumberUnits extends WaveNumber with Units {
  WaveNumberUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  WaveNumberUnits.length(LengthUnits lu) : super._internal(Integer.one / lu.valueSI) {
    this.name = "reciprocal ${lu.name}";
    this.singular = "reciprocal ${lu.singular}";
    this._convToMKS = Integer.one / lu.valueSI;
    this._abbrev1 = lu._abbrev1 != null ? "1 / ${lu._abbrev1}" : null;
    this._abbrev2 = lu._abbrev2 != null ? "${lu._abbrev2}-1" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => WaveNumber;

  /// Derive new WaveNumberUnits using this WaveNumberUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new WaveNumberUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
