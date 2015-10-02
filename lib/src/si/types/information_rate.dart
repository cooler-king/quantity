part of quantity_si;

/// The flow of information, per unit time.
///
/// See the [Wikipedia entry for Information](https://en.wikipedia.org/wiki/Information)
/// for more information.
///
class InformationRate extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions informationRateDimensions = Frequency.frequencyDimensions;

  /// The standard SI unit
  static final InformationRateUnits bitsPerSecond = new InformationRateUnits.massTime(Information.bits, Time.seconds);

  // Common metric units
  static final InformationRateUnits kilobitsPerSecond =
      new InformationRateUnits.massTime(Information.kilobits, Time.seconds);

  static final InformationRateUnits megabitsPerSecond =
      new InformationRateUnits.massTime(Information.megabits, Time.seconds);

  static final InformationRateUnits gigabitsPerSecond =
      new InformationRateUnits.massTime(Information.gigabits, Time.seconds);

  static final InformationRateUnits terabitsPerSecond =
      new InformationRateUnits.massTime(Information.terabits, Time.seconds);

  /// Construct an InformationRate with bits per second ([bps]), kilobits per second ([kbps]),
  /// megabits per second ([Mbps]), gigibits per second ([Gbps]) or terabits per second ([Tbps]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  InformationRate({dynamic bps, dynamic kbps, dynamic Mbps, dynamic Gbps, dynamic Tbps, uncert: 0.0})
      : super(
            bps ?? (kbps ?? (Mbps ?? (Gbps ?? (Tbps ?? 0.0)))),
            kbps != null
                ? InformationRate.kilobitsPerSecond
                : (Mbps != null
                    ? InformationRate.megabitsPerSecond
                    : (Gbps != null
                        ? InformationRate.gigabitsPerSecond
                        : (Tbps != null ? InformationRate.terabitsPerSecond : InformationRate.bitsPerSecond))),
            uncert);

  InformationRate._internal(conv) : super._dimensions(conv, InformationRate.informationRateDimensions);

  /// Constructs a InformationRate based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  InformationRate.inUnits(value, InformationRateUnits units, [double uncert = 0.0])
      : super(value, units ?? InformationRate.bitsPerSecond, uncert);

  const InformationRate.constant(Number valueSI, {InformationRateUnits units, num uncert: 0.0})
      : super.constant(valueSI, InformationRate.informationRateDimensions, units, uncert);
}

/// Units acceptable for use in describing InformationRate quantities.
///
class InformationRateUnits extends InformationRate with Units {
  InformationRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  InformationRateUnits.massTime(InformationUnits iu, TimeUnits tu) : super._internal(iu.valueSI * tu.valueSI) {
    this.name = "${iu.name} per ${tu.singular}";
    this.singular = "${iu.singular} per ${tu.singular}";
    this._convToMKS = iu.valueSI * tu.valueSI;
    this._abbrev1 = iu._abbrev1 != null && tu._abbrev1 != null ? "${iu._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = iu._abbrev2 != null && tu._abbrev2 != null ? "${iu._abbrev2}${tu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => InformationRate;

  /// Derive new InformationRateUnits using this InformationRateUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new InformationRateUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
