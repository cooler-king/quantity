import '../register_si.dart';
import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';
import 'token.dart';
import 'time.dart';

/// The flow of tokens, per unit time.
base class TokenRate extends Quantity {
  /// Construct a TokenRate with tokens per second ([tps]).
  /// Optionally specify a relative standard uncertainty.
  TokenRate({dynamic tps, double uncert = 0.0})
      : super(tps ?? 0.0, TokenRate.tokensPerSecond, uncert) {
    var _ = siRegistered;
  }

  /// Constructs an instance without preferred units.
  TokenRate.misc(dynamic conv)
      : super.misc(conv, TokenRate.tokenRateDimensions) {
    var _ = siRegistered;
  }

  /// Constructs a TokenRate based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  TokenRate.inUnits(dynamic value, TokenRateUnits? units, [double uncert = 0.0])
      : super(value, units ?? TokenRate.tokensPerSecond, uncert) {
    var _ = siRegistered;
  }

  /// Constructs a constant TokenRate.
  const TokenRate.constant(Number valueSI,
      {TokenRateUnits? units, double uncert = 0.0})
      : super.constant(valueSI, TokenRate.tokenRateDimensions, units, uncert);

  /// Returns the product of this [TokenRate] and a [multiplier].
  /// If the multiplier is a [Time] object, a [Token] is returned.
  @override
  Quantity operator *(dynamic multiplier) {
    if (multiplier is Time) {
      return Token(tokens: valueSI * multiplier.valueSI);
    }
    return super * multiplier;
  }

  /// Dimensions for this type of quantity.
  static const Dimensions tokenRateDimensions =
      Dimensions.constant(<String, int>{'Time': -1}, qType: TokenRate);

  /// The standard unit of token rate.
  static final TokenRateUnits tokensPerSecond =
      TokenRateUnits.tokenPerTime(Token.tokens, Time.seconds);
}

/// Units acceptable for use in describing TokenRate quantities.
base class TokenRateUnits extends TokenRate with Units {
  /// Constructs an instance.
  TokenRateUnits(String name, String? abbrev1, String? abbrev2, String singular,
      dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super.misc(conv) {
    this.name = name;
    this.singular = singular;
    convToMKS = objToNumber(conv);
    this.abbrev1 = abbrev1;
    this.abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Constructs an instance from token and time units.
  TokenRateUnits.tokenPerTime(TokenUnits tu, TimeUnits tmu)
      : super.misc(tu.valueSI / tmu.valueSI) {
    name = '${tu.name} per ${tmu.singular}';
    singular = '${tu.singular} per ${tmu.singular}';
    convToMKS = tu.valueSI / tmu.valueSI;
    abbrev1 = tu.abbrev1 != null && tmu.abbrev1 != null
        ? '${tu.abbrev1} / ${tmu.abbrev1}'
        : null;
    abbrev2 = tu.abbrev2 != null && tmu.abbrev2 != null
        ? '${tu.abbrev2} ${tmu.abbrev2}\u{207b}\u{00b9}'
        : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => TokenRate;

  /// Derive TokenRateUnits using this TokenRateUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      TokenRateUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
