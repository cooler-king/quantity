part of quantity_core;

//TODO other related quantities, such as Currency Rate (time), Exchange Rate (scalar ratio) with live data?

class Currency extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions currencyDimensions = Scalar.scalarDimensions;

  /// The unit of currency in the United States
  static final CurrencyUnits dollarsUS =
      new CurrencyUnits("United States Dollars", "\$", "USD", null, 1.0, false);

  /// 1 U.S. Cent is equal to 0.01 U.S. Dollar
  static final CurrencyUnits centsUS = new CurrencyUnits(
      "United States Cents", "cents", null, null, 0.01, false);

  // TODO put other main currencies in here?  EUR, JPY, etc? pound, chinese
  // or in ext because they are data-dependent

  //TODO Bitcoins & other digital currencies

  // For real time feeds
  // See : http://stackoverflow.com/questions/11393173/free-real-time-currency-conversion-exchange-rate-xml-feed-url

  Currency({dynamic USD, double uncert: 0.0})
      : super(USD != null ? USD : 0.0, Currency.dollarsUS, uncert);

  Currency._internal(conv)
      : super._dimensions(conv, Currency.currencyDimensions);

  /// Constructs a Currency based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Currency.inUnits(value, CurrencyUnits units, [double uncert = 0.0])
      : super(value, units != null ? units : Currency.dollarsUS, uncert);

  const Currency.constant(Number valueSI,
      {CurrencyUnits units, num uncert: 0.0})
      : super.constant(valueSI, Currency.currencyDimensions, units, uncert);
}

/// Units acceptable for use in describing Currency quantities.
///
class CurrencyUnits extends Currency with Units {
  CurrencyUnits(String name, String abbrev1, String abbrev2, String singular,
      dynamic conv,
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
  Type get quantityType => Currency;

  /// Derive new CurrencyUnits using this CurrencyUnits object as the base.
  ///
  Units derive(String fullPrefix, String abbrevPrefix, double conv) {
    return new CurrencyUnits(
        "${fullPrefix}${name}",
        _abbrev1 != null ? "${abbrevPrefix}${_abbrev1}" : null,
        _abbrev2 != null ? "${abbrevPrefix}${_abbrev2}" : null,
        "${fullPrefix}${singular}",
        valueSI * conv,
        false,
        this.offset);
  }
}
