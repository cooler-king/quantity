part of quantity_si;

// Also HeatFlowRate, RadiantFlux

class Power extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions powerDimensions = const Dimensions.constant(const {"Length": 2, "Mass": 1, "Time": -3});

  /// The standard SI unit.
  static final PowerUnits watts = new PowerUnits("watts", null, "W", null, 1.0, true);

  // Convenience
  static final PowerUnits kilowatts = watts.kilo();
  static final PowerUnits megawatts = watts.mega();

  Power({dynamic W, dynamic kW, dynamic MW, double uncert: 0.0})
      : super(W != null ? W : (kW != null ? kW : (MW != null ? MW : 0.0)),
            kW != null ? Power.kilowatts : (MW != null ? Power.megawatts : Power.watts), uncert);

  Power._internal(conv) : super._dimensions(conv, Power.powerDimensions);

  /// Constructs a Power based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Power.inUnits(value, PowerUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Power.watts, uncert);

  const Power.constant(Number valueSI, {PowerUnits units, num uncert: 0.0})
      : super.constant(valueSI, Power.powerDimensions, units, uncert);
}

/// Units acceptable for use in describing Power quantities.
///
class PowerUnits extends Power with Units {
  PowerUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  PowerUnits.energyTime(EnergyUnits eu, TimeUnits tu) : super._internal(eu.valueSI / tu.valueSI) {
    this.name = "${eu.name} per ${tu.singular}";
    this.singular = "${eu.singular} per ${tu.singular}";
    this._convToMKS = eu.valueSI / tu.valueSI;
    this._abbrev1 = eu._abbrev1 != null && tu._abbrev1 != null ? "${eu._abbrev1} / ${tu._abbrev1}" : null;
    this._abbrev2 = eu._abbrev2 != null && tu._abbrev2 != null ? "${eu._abbrev2}${tu._abbrev2}" : null;
    this.metricBase = metricBase;
    this.offset = offset;
  }

  /// Returns the Type of the Quantity to which these Units apply
  Type get quantityType => Power;

  /// Derive new PowerUnits using this PowerUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new PowerUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}

class RadiantFlux extends Power {
  const RadiantFlux.constant(Number valueSI, {PowerUnits units, num uncert: 0.0})
      : super.constant(valueSI, units: units, uncert: uncert);
}
