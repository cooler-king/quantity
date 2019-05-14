part of quantity_si;

/// Represents the stochastic health effects (probability of cancer induction and genetic damage)
/// of ionizing radiation on the human body.
///
/// See the [Wikipedia entry for Equivalent dose](https://en.wikipedia.org/wiki/Equivalent_dose)
/// for more information.
///
class DoseEquivalent extends Quantity {
  /// Construct a DoseEquivalent with seiverts ([Sv]) or [rems].
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  // ignore: non_constant_identifier_names
  DoseEquivalent({dynamic Sv, dynamic rems, double uncert = 0.0})
      : super(Sv != null ? Sv : (rems != null ? rems : 0.0),
            rems != null ? DoseEquivalent.rems : DoseEquivalent.seiverts, uncert);

  DoseEquivalent._internal(dynamic conv) : super._internal(conv, DoseEquivalent.doseEquivalentDimensions);

  /// Constructs a DoseEquivalent based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  DoseEquivalent.inUnits(dynamic value, DoseEquivalentUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : DoseEquivalent.seiverts, uncert);

  const DoseEquivalent.constant(Number valueSI, {DoseEquivalentUnits units, double uncert = 0.0})
      : super.constant(valueSI, DoseEquivalent.doseEquivalentDimensions, units, uncert);

  /// Dimensions for this type of quantity
  static const Dimensions doseEquivalentDimensions =
      const Dimensions.constant(const <String, int>{'Length': 2, 'Time': -2}, qType: DoseEquivalent);

  /// The standard SI unit.
  static final DoseEquivalentUnits seiverts = new DoseEquivalentUnits('seiverts', null, 'Sv', null, 1.0, true);

  /// Accepted for use with the SI, subject to further review.
  static final DoseEquivalentUnits rems = new DoseEquivalentUnits('rems', null, null, null, 1.0e-2, true);
}

/// Units acceptable for use in describing DoseEquivalent quantities.
///
class DoseEquivalentUnits extends DoseEquivalent with Units {
  /// Constructs a new instance.
  DoseEquivalentUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => DoseEquivalent;

  /// Derive new DoseEquivalentUnits using this DoseEquivalentUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new DoseEquivalentUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
