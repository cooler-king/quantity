part of quantity_si;

/// The increase in rate of a chemical reaction caused by the presence of a catalyst.
///
/// See the [Wikipedia entry for Catalysis](https://en.wikipedia.org/wiki/Catalysis)
/// for more information.
///
class CatalyticActivity extends Quantity {
  /// Construct a CatalyticActivity with katals ([kat]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  CatalyticActivity({dynamic kat, double uncert = 0.0}) : super(kat ?? 0.0, CatalyticActivity.katals, uncert);

  CatalyticActivity._internal(dynamic conv) : super._internal(conv, CatalyticActivity.catalyticActivityDimensions);

  /// Constructs a CatalyticActivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  CatalyticActivity.inUnits(dynamic value, CatalyticActivityUnits units, [double uncert = 0.0])
      : super(value, units ?? CatalyticActivity.katals, uncert);

  const CatalyticActivity.constant(Number valueSI, {CatalyticActivityUnits units, double uncert = 0.0})
      : super.constant(valueSI, CatalyticActivity.catalyticActivityDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions catalyticActivityDimensions =
      const Dimensions.constant(const <String, int>{'Amount': 1, 'Time': -1}, qType: CatalyticActivity);

  /// The standard SI unit **/
  static final CatalyticActivityUnits katals = new CatalyticActivityUnits('katals', 'kat', null, 'katal', 1.0, true);
}

/// Units acceptable for use in describing CatalyticActivity quantities.
///
class CatalyticActivityUnits extends CatalyticActivity with Units {
  CatalyticActivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => CatalyticActivity;

  /// Derive new CatalyticActivityUnits using this CatalyticActivityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new CatalyticActivityUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
