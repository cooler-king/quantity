import 'package:quantity/quantity.dart';

class ConsistencyHelpers {
  static bool checkDimensionalConsistency(
      Map<String, Dimensions> variableDimensions, String expression) {
    try {
      final parts = expression.split(RegExp(r'==?'));
      if (parts.length == 2) {
        final lhs = evaluate(parts[0], variableDimensions);
        final rhs = evaluate(parts[1], variableDimensions);
        return lhs == rhs;
      } else if (parts.length == 1) {
        evaluate(parts[0], variableDimensions);
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  static Dimensions evaluate(String expr, Map<String, Dimensions> variables) {
    final tokens = _tokenize(expr);
    var index = 0;

    late final Dimensions Function() parseExpression;
    late final Dimensions Function() parseTerm;
    late final Dimensions Function() parseFactor;
    late final Dimensions Function() parsePrimary;

    parseExpression = () {
      var result = parseTerm();
      while (index < tokens.length &&
          (tokens[index] == '+' || tokens[index] == '-')) {
        tokens[index++]; // consume op
        final nextTerm = parseTerm();
        if (result != nextTerm) {
          throw DimensionsException(
              'Dimensional mismatch: addition/subtraction of different dimensions');
        }
      }
      return result;
    };

    parseTerm = () {
      var result = parseFactor();
      while (index < tokens.length &&
          (tokens[index] == '*' || tokens[index] == '/')) {
        final op = tokens[index++];
        final nextFactor = parseFactor();
        if (op == '*') {
          result = result * nextFactor;
        } else {
          result = result / nextFactor;
        }
      }
      return result;
    };

    parseFactor = () {
      var result = parsePrimary();
      if (index < tokens.length && tokens[index] == '^') {
        index++; // consume '^'
        var isNegative = false;
        if (index < tokens.length && tokens[index] == '-') {
          isNegative = true;
          index++;
        }
        if (index >= tokens.length) {
          throw FormatException('Expected exponent after ^');
        }
        final exponentStr = tokens[index++];
        var power = double.parse(exponentStr);
        if (isNegative) power = -power;

        if (power == 1.0) {
          // do nothing
        } else if (power == -1.0) {
          result = result.inverse();
        } else {
          final map = <String, num>{};
          for (final key in result.toJson().keys) {
            map[key] = result.getComponentExponent(key) * power;
          }
          result = Dimensions.fromMap(map);
        }
      }
      return result;
    };

    parsePrimary = () {
      if (index >= tokens.length) {
        throw FormatException('Unexpected end of expression');
      }
      final token = tokens[index++];
      if (token == '-') {
        return parsePrimary(); // unary minus does not affect dimensions
      }
      if (token == '+') {
        return parsePrimary(); // unary plus does not affect dimensions
      }
      if (token == '(') {
        final result = parseExpression();
        if (index >= tokens.length || tokens[index] != ')') {
          throw FormatException('Expected matching )');
        }
        index++; // consume ')'
        return result;
      }

      // Check if it's a number
      if (RegExp(r'^[0-9.]+$').hasMatch(token)) {
        return Dimensions(); // Numbers are dimensionless
      }

      // Check if it's a variable
      if (variables.containsKey(token)) {
        return variables[token]!;
      }

      throw FormatException('Unknown token/variable: $token');
    };

    final res = parseExpression();
    if (index < tokens.length) {
      throw FormatException('Unexpected trailing tokens');
    }
    return res;
  }

  static List<String> _tokenize(String expr) {
    final regex =
        RegExp(r'([a-zA-Z_][a-zA-Z0-9_]*|[0-9.]+|\+|-|\*|/|\^|\(|\))');
    return regex.allMatches(expr).map((m) => m.group(0)!).toList();
  }
}
