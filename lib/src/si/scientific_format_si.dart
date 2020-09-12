import 'number_format_si.dart';

/// Formats a number as a single integer digit, followed by decimal digits
/// and raised to a power of 10 (e.g., 1.2345 x 10^3).
class ScientificFormatSI extends NumberFormatSI {
  /// Constructs a new instance.
  ScientificFormatSI({bool unicode = false}) : super(unicode: unicode);

  /// Move the decimal point to just after the first integer digit.
  @override
  String adjustForExponent(String str) {
    final int dotIndex = str.indexOf('.');
    int firstNonZeroDigit = -1;
    for (int i = 0; i < str.length; i++) {
      final String s = str[i];
      if (s != '0' && s != '.') {
        firstNonZeroDigit = i;
        break;
      }
    }

    // 7 -> -1... 1 - 1; exp = 0
    // 12 -> -1... 2 - 1; exp = 1; 1.2 x 10^1
    // 12345 -> -1... 5 - 1; exp = 4
    // 5678.1234 -> 4 - 0 - 1; exp = 3; 5.6781234 x 10^3
    // 0.0000678 -> 1 - 6; exp = -5; 6.78 x 10-5
    // 1.001 -> 1 - 0 - 1; exp = 0
    // TODO look for an existing exponent in string??? 4E-7 or 4.2 x 10^4?

    if (firstNonZeroDigit == -1) return '0.0';
    int exp = dotIndex == -1 ? str.length - 1 : dotIndex - firstNonZeroDigit;
    if (dotIndex > firstNonZeroDigit) exp--;

    String sciStr = str.substring(firstNonZeroDigit);
    if (sciStr.length == 1) {
      sciStr = '$sciStr.0';
    } else {
      // Insert the decimal point after the first non zero digit.
      sciStr = sciStr.replaceAll('.', '');
      sciStr = '${sciStr[0]}.${sciStr.substring(1)}';
    }

    // Append the exponent.
    if (exp != 0) {
      sciStr = unicode ? '$sciStr \u{00d7} 10${_unicodeExpStr(exp)}' : '$sciStr x 10^$exp';
    }

    return sciStr;
  }

  String _unicodeExpStr(int exp) {
    final StringBuffer buf = new StringBuffer();
    if (exp < 0) buf.write('\u{207b}');
    final String expStr = exp.abs().toString();
    for (int i = 0; i < expStr.length; i++) {
      final String char = expStr[i];
      buf.write(_expUnicodeMap[char]);
    }
    return buf.toString();
  }

  static const Map<String, String> _expUnicodeMap = const <String, String>{
    '0': '\u{2070}',
    '1': '\u{00b9}',
    '2': '\u{00b2}',
    '3': '\u{00b3}',
    '4': '\u{2074}',
    '5': '\u{2075}',
    '6': '\u{2076}',
    '7': '\u{2077}',
    '8': '\u{2078}',
    '9': '\u{2079}',
  };
}
