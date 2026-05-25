import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('Computational Token & TokenRate Quantities', () {
    test('Token & TokenRate constructors and extensions', () {
      final t1 = Token(tokens: 1500);
      expect(t1, isA<Token>());
      expect(t1.inTokens, equals(1500.0));

      final t2 = 2500.tokens;
      expect(t2, isA<Token>());
      expect(t2.inTokens, equals(2500.0));

      final tr1 = TokenRate(tps: 50);
      expect(tr1, isA<TokenRate>());
      expect(tr1.inTps, equals(50.0));
      expect(tr1.inTokensPerSecond, equals(50.0));

      final tr2 = 75.tps;
      expect(tr2, isA<TokenRate>());
      expect(tr2.inTps, equals(75.0));

      final tr3 = 100.tokensPerSecond;
      expect(tr3, isA<TokenRate>());
      expect(tr3.inTps, equals(100.0));
    });

    test('Arithmetic operations (Token / Time and TokenRate * Time)', () {
      final tokenCount = 1000.tokens;
      final duration = 20.seconds;

      final rate = tokenCount / duration;
      expect(rate, isA<TokenRate>());
      expect((rate as TokenRate).inTps, equals(50.0));

      final rate2 = 75.tps;
      final duration2 = 10.seconds;
      final totalTokens = rate2 * duration2;
      expect(totalTokens, isA<Token>());
      expect((totalTokens as Token).inTokens, equals(750.0));

      final divResult = tokenCount / 2;
      expect(divResult, isA<Token>());
      expect(divResult.valueSI.toDouble(), equals(500.0));
    });

    test('Natural Language Unit Parsing (Quantity.parse)', () {
      final q1 = Quantity.parse('5000 tokens');
      expect(q1, isA<Token>());
      expect(q1.valueSI.toDouble(), equals(5000.0));

      final q2 = Quantity.parse('250 tok');
      expect(q2, isA<Token>());
      expect(q2.valueSI.toDouble(), equals(250.0));

      final q3 = Quantity.parse('50 tps');
      expect(q3, isA<TokenRate>());
      expect(q3.valueSI.toDouble(), equals(50.0));

      final q4 = Quantity.parse('75 tok/s');
      expect(q4, isA<TokenRate>());
      expect(q4.valueSI.toDouble(), equals(75.0));
    });

    test('Registry getUnitSymbols', () {
      final tokenSymbols = Quantity.getUnitSymbols(Token);
      expect(tokenSymbols, contains('tok'));
      expect(tokenSymbols, contains('token'));
      expect(tokenSymbols, contains('tokens'));

      final rateSymbols = Quantity.getUnitSymbols(TokenRate);
      expect(rateSymbols, contains('tps'));
      expect(rateSymbols, contains('tok/s'));
      expect(rateSymbols, contains('token/s'));
      expect(rateSymbols, contains('tokens/s'));
    });

    test('Dimensions.describe', () {
      expect(
          Dimensions.describe(Token.tokenDimensions), equals('dimensionless'));
      expect(Dimensions.describe(TokenRate.tokenRateDimensions),
          equals('1 / Time^1'));
    });
  });
}
