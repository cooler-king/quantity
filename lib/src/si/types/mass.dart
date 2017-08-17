part of quantity_si;

/// Represents the *mass* physical quantity (one of the seven base SI quantities),
/// that determines the strength of a body's mutual gravitational attraction to other bodies.
///
/// See the [Wikipedia entry for Mass](https://en.wikipedia.org/wiki/Mass)
/// for more information.
///
class Mass extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions massDimensions = const Dimensions.constant(const {"Mass": 1}, type: Mass);

  /// The standard SI unit.
  static final MassUnits kilograms = new MassUnits("kilograms", "kg", null, null, 1.0, false);

  /// Note: kilograms are the standard MKS unit for mass, but grams is used here
  /// to generate the appropriate prefixes.  Gram conversion value is set to 0.001
  /// in order to generate the correct units.
  ///
  static final MassUnits grams = new MassUnits("grams", "g", null, null, 0.001, true);

  /// Accepted for use with the SI.
  static final MassUnits metricTons = grams.mega() as MassUnits;

  /// Accepted for use with the SI.
  static final MassUnits tonnes = metricTons;

  /// Accepted for use with the SI.
  static final MassUnits unifiedAtomicMassUnits =
      new MassUnits("unified atomic mass units", null, "u", null, 1.66053886e-27, false);

  /// Construct a Mass with kilograms ([kg]), grams ([g]) or unified atomic mass units ([u]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Mass({dynamic kg, dynamic g, dynamic u, double uncert: 0.0})
      : super(kg ?? (g ?? (u ?? 0.0)),
            g != null ? Mass.grams : (u != null ? Mass.unifiedAtomicMassUnits : Mass.kilograms), uncert);

  Mass._internal(conv) : super._internal(conv, Mass.massDimensions);

  /// Constructs a Mass based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Mass.inUnits(value, MassUnits units, [double uncert = 0.0]) : super(value, units ?? Mass.kilograms, uncert);

  const Mass.constant(Number valueSI, {MassUnits  units, double uncert: 0.0})
      : super.constant(valueSI, Mass.massDimensions, units, uncert);

  /// Returns the [Energy] equivalent of this Mass using the famous E=mc^2 relationship.
  ///
  Energy toEnergy() {
    if (valueSI is Precise) {
      var c = new Precise("2.99792458e8");
      return new Energy(J: valueSI * c * c, uncert: this._ur);
    } else {
      double c = 2.99792458e8;
      return new Energy(J: valueSI * c * c, uncert: this._ur);
    }
  }
}

/// Units acceptable for use in describing [Mass] quantities.
///
class MassUnits extends Mass with Units {
  MassUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    this._convToMKS = objToNumber(conv);
    this._abbrev1 = abbrev1;
    this._abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Mass;

  /// Derive new MassUnits using this MassUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new MassUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
