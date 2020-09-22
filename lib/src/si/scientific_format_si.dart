import '../si/utilities.dart' show unicodeExponent;
import 'number_format_si.dart';

/// Formats a number as a single integer digit, followed by decimal digits
/// and raised to a power of 10 (e.g., 1.2345 x 10^3).
class ScientificFormatSI extends NumberFormatSI {
  /// Constructs a new instance.
  ScientificFormatSI({bool unicode = false}) : super(unicode: unicode);

  /// Move the decimal point to just after the first integer digit.
  @override
  String adjustForExponent(String str) {
    if (str?.isNotEmpty != true) return str;
    String trimmed = str.trim();
    String sign = '';
    if (trimmed.startsWith('-')) {
      sign = '-';
      trimmed = trimmed.substring(1);
    } else if (trimmed.startsWith('+')) {
      trimmed = trimmed.substring(1);
    }

    final int dotIndex = trimmed.indexOf('.');
    final int eIndex = trimmed.toLowerCase().indexOf('e');

    int firstNonZeroDigit = -1;
    for (int i = 0; i < trimmed.length; i++) {
      final String s = trimmed[i];
      if (s != '0' && s != '.') {
        firstNonZeroDigit = i;
        break;
      }
    }

    if (firstNonZeroDigit == -1) return '0.0';

    final num includedExponent = eIndex != -1 ? num.parse(trimmed.substring(eIndex + 1)) : 0;

    final int length = eIndex != -1 ? eIndex : trimmed.length;
    num exp = (dotIndex == -1 ? length - 1 : dotIndex - firstNonZeroDigit) + includedExponent;
    if (dotIndex > firstNonZeroDigit) exp--;

    String sciStr = eIndex != -1 ? trimmed.substring(firstNonZeroDigit, eIndex) : trimmed.substring(firstNonZeroDigit);
    if (sciStr.length == 1) {
      sciStr = '$sciStr.0';
    } else {
      // Insert the decimal point after the first non zero digit.
      sciStr = sciStr.replaceAll('.', '');
      sciStr = '${sciStr[0]}.${sciStr.substring(1)}';
    }

    sciStr = NumberFormatSI.removeInsignificantZeros(sciStr);

    // Prepend the sign.
    sciStr = '$sign$sciStr';

    // Append the exponent.
    if (exp != 0) sciStr = unicode ? '$sciStr \u{00d7} 10${unicodeExponent(exp)}' : '$sciStr x 10^$exp';

    return sciStr;
  }
}
