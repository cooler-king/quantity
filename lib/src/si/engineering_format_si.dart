import '../si/utilities.dart' show unicodeExponent;
import 'number_format_si.dart';

/// A version of scientific notation in which the exponent of ten must be divisible by
/// three (e.g., 123.345 x 10^3).
class EngineeringFormatSI extends NumberFormatSI {
  /// Constructs a new instance.
  EngineeringFormatSI({bool unicode = false}) : super(unicode: unicode);

  /// Move the decimal point.
  @override
  String adjustForExponent(String str) {
    if (str?.isNotEmpty != true) return str;
    final int dotIndex = str.indexOf('.');
    int firstNonZeroDigit = -1;
    for (int i = 0; i < str.length; i++) {
      final String s = str[i];
      if (s != '0' && s != '.' && s != '-' && s != '+') {
        firstNonZeroDigit = i;
        break;
      }
    }

    if (firstNonZeroDigit == -1) return '0.0';
    int exp = dotIndex == -1 ? str.length - 1 : dotIndex - firstNonZeroDigit;
    if (dotIndex > firstNonZeroDigit) exp--;

    final int effExp = exp < 0 ? ((exp + 1) ~/ 3) * 3 - 3 : (exp ~/ 3) * 3;
    final int adj = exp - effExp;

    String engStr = str.substring(firstNonZeroDigit);
    if (engStr.length == 1 && firstNonZeroDigit < dotIndex) {
      engStr = '$engStr.0';
    } else {
      // Insert the decimal point after the first non zero digit.
      engStr = engStr.replaceAll('.', '');
      if (engStr.length < adj + 1) engStr = engStr.padRight(adj + 1, '0');
      engStr = '${engStr.substring(0, adj + 1)}.${engStr.substring(adj + 1)}';
      if (engStr.endsWith('.')) engStr = '${engStr}0';
    }

    // Append the exponent.
    if (effExp != 0) engStr = unicode ? '$engStr \u{00d7} 10${unicodeExponent(effExp)}' : '$engStr x 10^$effExp';

    return engStr;
  }
}