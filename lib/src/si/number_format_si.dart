part of quantity_si;

/// Whether and how to display a quantity's uncertainty (e.g., compact is 32.324(12),
/// not compact is (7.131 +/- 0.003)).
enum UncertaintyFormat {
  /// Do not display uncertainty.
  none,

  /// Display uncertainty in compact form.
  compact,

  /// Display uncertainty in full plus/minus form.
  plusMinus
}

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
  NumberFormatSI(this.uncertaintyFormat, this.unicode) : super.scientificPattern();

  /// Output in unicode (using unicode thin spaces instead of regular ascii spaces).
  bool unicode = false;

  /// Whether and how to display a quantity's uncertainty.
  UncertaintyFormat uncertaintyFormat = UncertaintyFormat.compact;

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

    final StringBuffer buf = new StringBuffer();
    if (realStr?.isNotEmpty == true) buf.write(insertSpaces(realStr));
    if (imagStr?.isNotEmpty == true) {
      if (buf.isNotEmpty) buf.write(' + ');
      buf..write(insertSpaces(imagStr))..write('i');
    }

    // Add uncertainty.
    if (value is Quantity && uncertaintyFormat == UncertaintyFormat.none && value.relativeUncertainty != 0) {
      buf.write(' +/- ${insertSpaces(value.relativeUncertainty.toString())}');
      // TODO parentheses for standard and non-scalar
      // TODO concise
    }

    return buf.toString();
  }

  /// Returns a new String with spaces added according to SI guidelines.
  String insertSpaces(String str) {
    if (str == null) return null;
    final int decimalIndex = str.indexOf('.');
    final int preCount = decimalIndex != -1 ? decimalIndex : str.length;
    final int postCount = decimalIndex != -1 ? str.length - decimalIndex - 1 : 0;

    final StringBuffer buf = new StringBuffer();

    // Pre-decimal.
    if (preCount > 4) {
      final String preStr = decimalIndex != -1 ? str.substring(0, decimalIndex) : str;
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
        buf.write(str.substring(0, decimalIndex));
      } else {
        buf.write(str);
      }
    }

    // Decimal and post-decimal.
    if (decimalIndex != -1) {
      buf.write('.');
      if (postCount > 4) {
        // Insert a space after each grouping of 3.
        buf.write(str.substring(decimalIndex + 1, decimalIndex + 4));
        int cursor = 3;
        while (cursor < postCount) {
          buf
            ..write(unicode ? '\u{2009}' : ' ')
            ..write(str.substring(decimalIndex + 1 + cursor, math.min(decimalIndex + 4 + cursor, str.length)));
          cursor += 3;
        }
      } else {
        buf.write(str.substring(decimalIndex + 1));
      }
    }

    return buf.toString();
  }
}
