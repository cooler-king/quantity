part of quantity_si;

/// The number of occurrences of a repeating event per unit time.
///
/// See the [Wikipedia entry for Frequency](https://en.wikipedia.org/wiki/Frequency)
/// for more information.
///
class Frequency extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions frequencyDimensions = const Dimensions.constant(const {"Time": -1}, type: Frequency);

  /// The standard SI unit.
  static final FrequencyUnits hertz = new FrequencyUnits("hertz", "Hz", null, "hertz", 1.0, true);

  // convenience units
  static final FrequencyUnits kilohertz = hertz.kilo();
  static final FrequencyUnits megahertz = hertz.mega();
  static final FrequencyUnits gigahertz = hertz.giga();

  /// Construct a Frequency with hertz ([Hz]), kilohertz ([kHz]), megahertz ([MHz])
  /// or gigahertz ([GHz]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Frequency({dynamic Hz, dynamic kHz, dynamic MHz, dynamic GHz, double uncert: 0.0})
      : super(
            Hz ?? (kHz ?? (MHz ?? (GHz ?? 0.0))),
            kHz != null
                ? Frequency.kilohertz
                : (MHz != null ? Frequency.megahertz : (GHz != null ? Frequency.gigahertz : Frequency.hertz)),
            uncert);

  Frequency._internal(conv) : super._internal(conv, Frequency.frequencyDimensions);

  /// Constructs a Frequency based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Frequency.inUnits(value, FrequencyUnits units, [double uncert = 0.0])
      : super(value, units ?? Frequency.hertz, uncert);

  const Frequency.constant(Number valueSI, {FrequencyUnits units, num uncert: 0.0})
      : super.constant(valueSI, Frequency.frequencyDimensions, units, uncert);
}

/// Units acceptable for use in describing Frequency quantities.
///
class FrequencyUnits extends Frequency with Units {
  FrequencyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Frequency;

  /// Derive new FrequencyUnits using this FrequencyUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new FrequencyUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
