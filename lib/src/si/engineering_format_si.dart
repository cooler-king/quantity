import 'number_format_si.dart';

/// A version of scientific notation in which the exponent of ten must be divisible by
/// three (e.g., 123.345 x 10^3).
class EngineeringFormatSI extends NumberFormatSI {
  /// Constructs a new instance.
  EngineeringFormatSI({bool unicode = false}) : super(unicode: unicode);

  /// Move the decimal point.
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

    if (firstNonZeroDigit == -1) return '0.0';
    int exp = dotIndex == -1 ? str.length - 1 : dotIndex - firstNonZeroDigit;
    if (dotIndex > firstNonZeroDigit) exp--;

    final int effExp = (exp ~/ 3) * 3;
    final int adj = exp - effExp;

    String engStr = str.substring(firstNonZeroDigit);
    if (engStr.length == 1) {
      engStr = '$engStr.0';
    } else {
      // Insert the decimal point after the first non zero digit.
      engStr = engStr.replaceAll('.', '');
      engStr = '${engStr[0]}.${engStr.substring(1)}';
    }

    // Append the exponent.
    if (exp != 0) {
      engStr = unicode ? '$engStr \u{00d7} 10${_unicodeExpStr(exp)}' : '$engStr x 10^$exp';
    }

    return engStr;
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
