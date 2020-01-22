part of quantity_si;

/// NumberFormatSI implements the International System of Units (SI) style
/// conventions for displaying values of quantities.  Specifically:
///
/// - Three-digit groups of numbers with more than four digits are separated
/// by spaces instead of commas (for example, 299 792 458, not
/// 299,792,458) to avoid confusion with the decimal marker in European
/// literature.  This spacing is also used to the right of the decimal
/// marker (for example, 12 345.678 90).
/// - Uncertainty in the quantity's value may be optionally displayed...
/// e.g., 1.234(11) or 1.234 +/- 0.011.
///
/// The value will be displayed in "computer scientific notation" (e.g., 1.3E9)
/// if its exponent is less than -3 or greater than 6.  These thresholds are
/// arbitrary, but track with typical usage.  If the exponent does not pass one
/// of these thresholds then the number is simply displayed as a normal
/// decimal number (e.g., 1 234.567 89).
///
/// The standard DecimalFormat class is unable to apply grouping to digits
/// after the decimal.  Therefore, this class directly extends NumberFormat
/// and provides implementations for format and parse.
class NumberFormatSI extends NumberFormat {
  /// Constructs a new instance.
  NumberFormatSI({this.unicode = false}) : super.scientificPattern();

  /// Output in unicode (using unicode thin spaces instead of regular ascii spaces).
  bool unicode;

  /// [value] is expected to be a Quantity, Number or num object.
  @override
  String format(dynamic value) {
    String realStr;
    String imagStr;
    if (value is num) {
      realStr = value.toString();
    } else {
      final Number number = value is Number ? value : value is Quantity ? value.valueSI : null;
      if (number is Integer) {
        realStr = number.toInt().toString();
      } else if (value is Double) {
        realStr = number.toDouble().toString();
      } else if (number is Imaginary) {
        imagStr = number.value.toString();
      } else if (number is Complex) {
        if (number.real != null && number.real.value.toDouble() != 0)
          realStr = number.real?.isInteger == true ? '${number.real.toInt()}' : number.real?.toString();

        if (number.imag != null && number.imag.value.toDouble() != 0)
          imagStr =
              number.imag?.value?.isInteger == true ? '${number.imag.value.toInt()}' : number.imag?.value?.toString();

        if (realStr == null && imagStr == null) realStr = '0';
      } else if (number is Precise) {
        realStr = number.toString();
      }
    }

    if (realStr?.isNotEmpty == true) realStr = adjustForExponent(realStr);
    if (imagStr?.isNotEmpty == true) imagStr = adjustForExponent(imagStr);

    final StringBuffer buf = new StringBuffer();
    if (realStr?.isNotEmpty == true) buf.write(insertSpaces(realStr));
    if (imagStr?.isNotEmpty == true) {
      if (buf.isNotEmpty) buf.write(' + ');
      final String s = insertSpaces(imagStr);
      final int expIndex = _exponentIndex(s);
      if (expIndex == -1) {
        buf..write(s)..write('i');
      } else {
        buf..write(s.substring(0, expIndex))..write('i')..write(s.substring(expIndex));
      }
    }

    return buf.toString();
  }

  /// Subclasses should override if they wish to modify the number string to
  /// include an exponent and move the decimal point.
  String adjustForExponent(String str) => str;

  /// Looks for the start of an exponent section.
  int _exponentIndex(String str) {
    int expIndex = str.indexOf(' x 10');
    if (expIndex == -1) expIndex = str.indexOf(' \u{00d7} 10');
    if (expIndex == -1) expIndex = str.indexOf('E');
    return expIndex;
  }

  /// Returns a new String with spaces added according to SI guidelines.
  String insertSpaces(String str) {
    if (str == null) return null;

    // Remove any exponent piece and add it back in after spaces have been added.
    final int expIndex = _exponentIndex(str);
    final String numStr = expIndex != -1 ? str.substring(0, expIndex) : str;

    final int decimalIndex = numStr.indexOf('.');
    final int preCount = decimalIndex != -1 ? decimalIndex : numStr.length;
    final int postCount = decimalIndex != -1 ? numStr.length - decimalIndex - 1 : 0;

    final StringBuffer buf = new StringBuffer();

    // Pre-decimal.
    if (preCount > 4) {
      final String preStr = decimalIndex != -1 ? numStr.substring(0, decimalIndex) : numStr;
      final int fullGroups = preStr.length ~/ 3;
      int cursor = preStr.length - fullGroups * 3;
      if (cursor != 0) buf.write(preStr.substring(0, cursor));
      while (cursor + 3 <= preStr.length) {
        if (cursor != 0) buf.write(unicode ? '\u{2009}' : ' ');
        buf.write(preStr.substring(cursor, cursor + 3));
        cursor += 3;
      }
    } else {
      if (decimalIndex != -1) {
        buf.write(numStr.substring(0, decimalIndex));
      } else {
        buf.write(numStr);
      }
    }

    // Decimal and post-decimal.
    if (decimalIndex != -1) {
      buf.write('.');
      if (postCount > 4) {
        // Insert a space after each grouping of 3.
        buf.write(numStr.substring(decimalIndex + 1, decimalIndex + 4));
        int cursor = 3;
        while (cursor < postCount) {
          buf
            ..write(unicode ? '\u{2009}' : ' ')
            ..write(numStr.substring(decimalIndex + 1 + cursor, math.min(decimalIndex + 4 + cursor, numStr.length)));
          cursor += 3;
        }
      } else {
        buf.write(numStr.substring(decimalIndex + 1));
      }
    }

    if (expIndex != -1) buf.write(str.substring(expIndex));

    return buf.toString();
  }

  @override
  num parse(String text) {
    // Strip spaces and unicode thin spaces before parsing.
    final String stripped = text.replaceAll(' ', '').replaceAll('\u{2009}', '');
    return super.parse(stripped);
  }
}
