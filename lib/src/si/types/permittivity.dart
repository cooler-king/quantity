part of quantity_si;

class Permittivity extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions permittivityDimensions =
      const Dimensions.constant(const {"Length": -3, "Time": 4, "Current": 2, "Mass": -1});

  /// The standard SI unit.
  static final PermittivityUnits faradsPerMeter =
      new PermittivityUnits.capacitanceLength(Capacitance.farads, Length.meters);

  /// Construct a Permittivity with farads per meter ([F_per_m]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Permittivity({dynamic F_per_m, double uncert: 0.0}) : super(F_per_m ?? 0.0, Permittivity.faradsPerMeter, uncert);

  Permittivity._internal(conv) : super._dimensions(conv, Permittivity.permittivityDimensions);

  /// Constructs a Permittivity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Permittivity.inUnits(value, PermittivityUnits units, [double uncert = 0.0])
      : super(value, units ?? Permittivity.faradsPerMeter, uncert);

  const Permittivity.constant(Number valueSI, {PermittivityUnits units, num uncert: 0.0})
      : super.constant(valueSI, Permittivity.permittivityDimensions, units, uncert);
}

/// Units acceptable for use in describing Permittivity quantities.
///
class PermittivityUnits extends Permittivity with Units {
  PermittivityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  PermittivityUnits.capacitanceLength(CapacitanceUnits ecu, LengthUnits lu)
      : super._internal(ecu.valueSI / lu.valueSI) {
    this.name = "${ecu.name} per ${lu.singular}";
    this.singular = "${ecu.singular} per ${lu.singular}";
    this._convToMKS = ecu.valueSI / lu.valueSI;
    this._abbrev1 = ecu._abbrev1 != null && lu._abbrev1 != null ? "${ecu._abbrev1} / ${lu._abbrev1}" : null;
    this._abbrev2 = ecu._abbrev2 != null && lu._abbrev2 != null ? "${ecu._abbrev2}/${lu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Permittivity;

  /// Derive new PermittivityUnits using this PermittivityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new PermittivityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
