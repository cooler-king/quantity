part of quantity_si;

//TODO other related quantities, such as Currency Rate (time), Exchange Rate (scalar ratio) with live data?

/// Money in any form when in actual use or circulation as a medium of exchange.
///
/// See the [Wikipedia entry for Currency](https://en.wikipedia.org/wiki/Currency)
/// for more information.
///
class Currency extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions currencyDimensions = const Dimensions.constant(const <String, int>{}, qType: Currency);

  /// The unit of currency in the United States
  static final CurrencyUnits dollarsUS = new CurrencyUnits('United States Dollars', '\$', 'USD', null, 1.0, false);

  /// 1 U.S. Cent is equal to 0.01 U.S. Dollar
  static final CurrencyUnits centsUS = new CurrencyUnits('United States Cents', 'cents', null, null, 0.01, false);

  // TODO put other main currencies in here?  EUR, JPY, etc? pound, chinese
  // or in ext because they are data-dependent

  //TODO Bitcoins & other digital currencies

  // For real time feeds
  // See : http://stackoverflow.com/questions/11393173/free-real-time-currency-conversion-exchange-rate-xml-feed-url

  /// Construct a Currency with US dollars ([USD]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.

  // ignore:non_constant_identifier_names
  Currency({dynamic USD, double uncert = 0.0}) : super(USD ?? 0.0, Currency.dollarsUS, uncert);

  Currency._internal(dynamic conv) : super._internal(conv, Currency.currencyDimensions);

  /// Constructs a Currency based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Currency.inUnits(dynamic value, CurrencyUnits units, [double uncert = 0.0])
      : super(value, units ?? Currency.dollarsUS, uncert);

  const Currency.constant(Number valueSI, {CurrencyUnits units, double uncert = 0.0})
      : super.constant(valueSI, Currency.currencyDimensions, units, uncert);
}

/// Units acceptable for use in describing Currency quantities.
///
class CurrencyUnits extends Currency with Units {
  /// Constructs a new instance.
  CurrencyUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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
  Type get quantityType => Currency;

  /// Derive new CurrencyUnits using this CurrencyUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new CurrencyUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);

}
