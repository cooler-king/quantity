part of quantity_si;

class AmountOfSubstance extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions amountOfSubstanceDimensions = const Dimensions.constant(const {"Amount": 1});

  /// The standard SI unit.
  static final AmountOfSubstanceUnits moles = new AmountOfSubstanceUnits("moles", null, "mol", null, 1.0, true);

  /// A common metric derivative of the standard SI unit.
  static final AmountOfSubstanceUnits kilomoles = moles.kilo();

  /// Construct an AmountOfSubstance with moles ([mol])
  /// or kilomoles ([kmol]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  AmountOfSubstance({dynamic mol, dynamic kmol, double uncert: 0.0})
      : super(mol ?? (kmol ?? 0.0), kmol != null ? AmountOfSubstance.kilomoles : AmountOfSubstance.moles, uncert);

  AmountOfSubstance._internal(conv) : super._dimensions(conv, AmountOfSubstance.amountOfSubstanceDimensions);

  /// Constructs a AmountOfSubstance based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  AmountOfSubstance.inUnits(value, AmountOfSubstanceUnits units, [double uncert = 0.0])
      : super(value, units ?? AmountOfSubstance.moles, uncert);

  const AmountOfSubstance.constant(Number valueSI, {AmountOfSubstanceUnits units, num uncert: 0.0})
      : super.constant(valueSI, AmountOfSubstance.amountOfSubstanceDimensions, units, uncert);
}

/// Units acceptable for use in describing [AmountOfSubstance] quantities.
///
class AmountOfSubstanceUnits extends AmountOfSubstance with Units {
  AmountOfSubstanceUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => AmountOfSubstance;

  /// Derive new AmountOfSubstanceUnits using this AmountOfSubstanceUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new AmountOfSubstanceUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
