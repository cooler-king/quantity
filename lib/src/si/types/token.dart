import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';
import '../register_si.dart';
import 'time.dart';
import 'token_rate.dart';

/// Represents a count of discrete linguistic or computational tokens.
base class Token extends Quantity {
  /// Constructs a Token with tokens.
  /// Optionally specify a relative standard uncertainty.
  Token({dynamic tokens, double uncert = 0.0})
      : super(tokens ?? 0.0, Token.tokens, uncert) {
    var _ = siRegistered;
  }

  /// Constructs an instance without preferred units.
  Token.misc(dynamic conv) : super.misc(conv, Token.tokenDimensions) {
    var _ = siRegistered;
  }

  /// Constructs a Token based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Token.inUnits(dynamic value, TokenUnits? units, [double uncert = 0.0])
      : super(value, units ?? Token.tokens, uncert) {
    var _ = siRegistered;
  }

  /// Constructs a constant Token.
  const Token.constant(Number valueSI, {TokenUnits? units, double uncert = 0.0})
      : super.constant(valueSI, Token.tokenDimensions, units, uncert);

  /// Returns the quotient of this [Token] and a [divisor].
  /// If the divisor is a [Time] object, a [TokenRate] is returned.
  @override
  Quantity operator /(dynamic divisor) {
    if (divisor is Time) {
      return TokenRate(tps: valueSI / divisor.valueSI);
    }
    return super / divisor;
  }

  /// Dimensions for this type of quantity.
  static const Dimensions tokenDimensions =
      Dimensions.constant(<String, int>{}, qType: Token);

  // Units.

  /// The standard unit for tokens.
  static final TokenUnits tokens =
      TokenUnits('tokens', 'tok', 'token', 'token', 1.0, true);
}

/// Units acceptable for use in describing Token quantities.
base class TokenUnits extends Token with Units {
  /// Constructs an instance.
  TokenUnits(String name, String? abbrev1, String? abbrev2, String singular,
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

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => Token;

  /// Derive TokenUnits using this TokenUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      TokenUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
