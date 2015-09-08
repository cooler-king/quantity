part of quantity_si;

class Permeability extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions permeabilityDimensions =
      const Dimensions.constant(const {"Length": 1, "Mass": 1, "Time": -2, "Current": -2});

  /// The standard SI unit.
  static final PermeabilityUnits henriesPerMeter =
      new PermeabilityUnits.inductanceLength(Inductance.henries, Length.meters);

  /// The standard SI unit (alternate form).
  static final PermeabilityUnits newtonsPerAmpereSquared =
      new PermeabilityUnits.forceCurrent(Force.newtons, Current.amperes);

  Permeability({dynamic H_per_m, dynamic N_per_A2, double uncert: 0.0})
      : super(H_per_m != null ? H_per_m : (N_per_A2 != null ? N_per_A2 : 0.0),
            N_per_A2 != null ? Permeability.newtonsPerAmpereSquared : Permeability.henriesPerMeter, uncert);

  Permeability._internal(conv) : super._dimensions(conv, Permeability.permeabilityDimensions);

  /// Constructs a Permeability based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Permeability.inUnits(value, PermeabilityUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Permeability.henriesPerMeter, uncert);

  const Permeability.constant(Number valueSI, {PermeabilityUnits units, num uncert: 0.0})
      : super.constant(valueSI, Permeability.permeabilityDimensions, units, uncert);
}

/// Units acceptable for use in describing Permeability quantities.
///
class PermeabilityUnits extends Permeability with Units {
  PermeabilityUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  PermeabilityUnits.inductanceLength(InductanceUnits iu, LengthUnits lu) : super._internal(iu.valueSI / lu.valueSI) {
    this.name = "${iu.name} per ${lu.singular}";
    this.singular = "${iu.singular} per ${lu.singular}";
    this._convToMKS = iu.valueSI / lu.valueSI;
    this._abbrev1 = iu._abbrev1 != null && lu._abbrev1 != null ? "${iu._abbrev1} / ${lu._abbrev1}" : null;
    this._abbrev2 = iu._abbrev2 != null && lu._abbrev2 != null ? "${iu._abbrev2}/${lu._abbrev2}" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  PermeabilityUnits.forceCurrent(ForceUnits fu, CurrentUnits ecu) : super._internal(fu.valueSI / (ecu.valueSI ^ 2)) {
    this.name = "${fu.name} per ${ecu.singular} squared";
    this.singular = "${fu.singular} per ${ecu.singular} squared";
    this._convToMKS = fu.valueSI / (ecu.valueSI ^ 2);
    this._abbrev1 = fu._abbrev1 != null && ecu._abbrev1 != null ? "${fu._abbrev1} / ${ecu._abbrev1}^2" : null;
    this._abbrev2 = fu._abbrev2 != null && ecu._abbrev2 != null ? "${fu._abbrev2}/${ecu._abbrev2}2" : null;
    this.metricBase = false;
    this.offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Permeability;

  /// Derive new PermeabilityUnits using this PermeabilityUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new PermeabilityUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
