part of quantity_core;

class CatalyticActivity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions catalyticActivityDimensions =
      const Dimensions.constant(const {"Amount": 1, "Time": -1});

  /// The standard SI unit **/
  static final CatalyticActivityUnits katals =
      new CatalyticActivityUnits("katals", "kat", null, "katal", 1.0, true);

  CatalyticActivity({dynamic kat, double uncert: 0.0})
      : super(kat != null ? kat : 0.0, CatalyticActivity.katals, uncert);

  CatalyticActivity._internal(conv)
      : super._dimensions(conv, CatalyticActivity.catalyticActivityDimensions);

  /// Constructs a CatalyticActivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  CatalyticActivity.inUnits(value, CatalyticActivityUnits units,
      [double uncert = 0.0])
      : super(value, units != null ? units : CatalyticActivity.katals, uncert);

  const CatalyticActivity.constant(Number valueSI,
      {CatalyticActivityUnits units, num uncert: 0.0})
      : super.constant(valueSI, CatalyticActivity.catalyticActivityDimensions,
            units, uncert);
}

/// Units acceptable for use in describing CatalyticActivity quantities.
///
class CatalyticActivityUnits extends CatalyticActivity with Units {
  CatalyticActivityUnits(String name, String abbrev1, String abbrev2,
      String singular, dynamic conv,
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
  Type get quantityType => CatalyticActivity;

  /// Derive new CatalyticActivityUnits using this CatalyticActivityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new CatalyticActivityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
