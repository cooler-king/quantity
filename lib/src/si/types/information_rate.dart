part of quantity_si;

/// The flow of information, per unit time.
/// See the [Wikipedia entry for Information](https://en.wikipedia.org/wiki/Information)
/// for more information.
class InformationRate extends Quantity {
  /// Construct an InformationRate with bits per second ([bps]), kilobits per second ([kbps]),
  /// megabits per second ([Mbps]), gigibits per second ([Gbps]) or terabits per second ([Tbps]).
  /// Optionally specify a relative standard uncertainty.
  // ignore: non_constant_identifier_names
  InformationRate({dynamic bps, dynamic kbps, dynamic Mbps, dynamic Gbps, dynamic Tbps, double uncert = 0.0})
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

  InformationRate._internal(dynamic conv) : super._internal(conv, InformationRate.informationRateDimensions);

  /// Constructs a InformationRate based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  InformationRate.inUnits(dynamic value, InformationRateUnits units, [double uncert = 0.0])
      : super(value, units ?? InformationRate.bitsPerSecond, uncert);

  /// Constructs a constant InformationRate.
  const InformationRate.constant(Number valueSI, {InformationRateUnits units, double uncert = 0.0})
      : super.constant(valueSI, InformationRate.informationRateDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions informationRateDimensions =
      const Dimensions.constant(const <String, int>{'Time': -1}, qType: InformationRate);

  /// The standard SI unit.
  static final InformationRateUnits bitsPerSecond =
      new InformationRateUnits.informationTime(Information.bits, Time.seconds);

  // Common metric units.

  /// The metric unit for one thousand bits per second.
  static final InformationRateUnits kilobitsPerSecond =
      new InformationRateUnits.informationTime(Information.kilobits, Time.seconds);

  /// The metric unit for one million bits per second.
  static final InformationRateUnits megabitsPerSecond =
      new InformationRateUnits.informationTime(Information.megabits, Time.seconds);

  /// The metric unit for one billion bits per second.
  static final InformationRateUnits gigabitsPerSecond =
      new InformationRateUnits.informationTime(Information.gigabits, Time.seconds);

  /// The metric unit for one trillion bits per second.
  static final InformationRateUnits terabitsPerSecond =
      new InformationRateUnits.informationTime(Information.terabits, Time.seconds);
}

/// Units acceptable for use in describing InformationRate quantities.
class InformationRateUnits extends InformationRate with Units {
  /// Constructs a new instance.
  InformationRateUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Constructs a new instance from information and time units.
  InformationRateUnits.informationTime(InformationUnits iu, TimeUnits tu) : super._internal(iu.valueSI * tu.valueSI) {
    name = '${iu.name} per ${tu.singular}';
    singular = '${iu.singular} per ${tu.singular}';
    _convToMKS = iu.valueSI * tu.valueSI;
    _abbrev1 = iu._abbrev1 != null && tu._abbrev1 != null ? '${iu._abbrev1} / ${tu._abbrev1}' : null;
    _abbrev2 = iu._abbrev2 != null && tu._abbrev2 != null ? '${iu._abbrev2}${tu._abbrev2}' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => InformationRate;

  /// Derive new InformationRateUnits using this InformationRateUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new InformationRateUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
