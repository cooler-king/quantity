part of quantity_core;

class Information extends Quantity {

  /// Dimensions for this type of quantity
  static const Dimensions informationDimensions = Scalar.scalarDimensions;

  // Units

  /** the standard unit of data (ISO, IEC) **/
  static final InformationUnits bits = new InformationUnits("bits", null, "bit", null, 1.0, true);

  /** Equal to 4 bits **/
  static final InformationUnits nibbles = new InformationUnits("nibbles", null, null, null, 4.0, false);

  /** Equal to 8 bits **/
  static final InformationUnits bytes = new InformationUnits("bytes", null, "B", null, 8.0, false);

  // Convenience

  /// 1 000 bits (not 1024 bits)
  static final InformationUnits kilobits = bits.kilo();

  /// 1 000 000 bits (not 1 048 576 bits)
  static final InformationUnits megabits = bits.mega();

  /// 1 billion bits
  static final InformationUnits gigabits = bits.giga();

  /// 1 trillion bits
  static final InformationUnits terabits = bits.tera();

  // Pseudo-Metric Units

  /// 1 kilobyte is equal to 2<sup>10</sup> bytes (1 024 bytes) in typical usage.
  /// This is at odds with the standard use of the "kilo" prefix for
  /// 1 000; use BYTES.kilo() to get the metric value.  Use KILOBYTES for
  /// common usage (e.g., for data storage units).
  static final InformationUnits kilobytes = new InformationUnits("kilobytes", "kB", "KB", null, 8.0 * 1024.0, false);

  /** 1 megabyte is equal to 2<sup>20</sup> bytes (1 048 576 bytes) in typical usage.
       This is at odds with the standard use of the "mega" prefix for
       10<sup>6</sup>; use BYTES.mega() to get the metric value.  Use MEGABYTES for
       common usage (e.g., for data storage units). **/
  static final InformationUnits megabytes =
      new InformationUnits("megabytes", null, "MB", null, 8.0 * 1.048576e6, false);

  /** 1 gigabyte is equal to 2<sup>30</sup> bytes (1 073 741 824 bytes) in typical usage.
       This is at odds with the standard use of the "giga" prefix for
       10<sup>9</sup>; use BYTES.giga() to get the metric value.  Use GIGABYTES for
       common usage (e.g., for data storage units). **/
  static final InformationUnits gigabytes =
      new InformationUnits("gigabytes", null, "GB", null, 8.0 * 1.073741824e9, false);

  /** 1 terabyte is equal to 2<sup>40</sup> bytes (1 099 511 627 776 bytes) in typical usage.
       This is at odds with the standard use of the "tera" prefix for
       10<sup>12</sup>; use BYTES.tera() to get the metric value.  Use TERABYTES for
       common usage (e.g., for data storage units). **/
  static final InformationUnits terabytes =
      new InformationUnits("terabytes", null, "TB", null, 8.0 * 1.099511627776e12, false);

  /** 1 petabyte is equal to 2<sup>50</sup> bytes (1 125 899 906 842 624 bytes) in typical usage.
       This is at odds with the standard use of the "peta" prefix for
       10<sup>15</sup>; use BYTES.peta() to get the metric value.  Use PETABYTES for
       common usage (e.g., for data storage units). **/
  static final InformationUnits petabytes =
      new InformationUnits("petabytes", null, "PB", null, 8.0 * 1.125899906842624e15, false);

  /** 1 exabyte is equal to 2<sup>60</sup> bytes (1 152 921 504 606 846 976 bytes) in typical usage.
       This is at odds with the standard use of the "exa" prefix for
       10<sup>18</sup>; use BYTES.exa() to get the metric value.  Use EXABYTES for
       common usage (e.g., for data storage units). **/
  static final InformationUnits EXABYTES =
      new InformationUnits("exabytes", null, "EB", null, 8.0 * 1.152921504606846976e18, false);

  Information({dynamic Bq, dynamic Ci, double uncert: 0.0})
      : super(Bq != null ? Bq : (Ci != null ? Ci : 0.0), Information.bits, uncert);

  Information._internal(conv) : super._dimensions(conv, Information.informationDimensions);

  /**
   * Constructs a Information based on the [value]
   * and the conversion factor intrinsic to the passed [units].
   */
  Information.inUnits(value, InformationUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Information.bits, uncert);

  const Information.constant(Number valueSI, {InformationUnits units, num uncert: 0.0})
      : super.constant(valueSI, Information.informationDimensions, units, uncert);
}

/**
 * Units acceptable for use in describing Information quantities.
 */
class InformationUnits extends Information with Units {
  InformationUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Information;

  /**
   * Derive new InformationUnits using this InformationUnits object as the base.
   */
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new InformationUnits("${fullPrefix}${name}", _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null, "${fullPrefix}${singular}", valueSI * conv, false,
        this.offset);
  }
}
