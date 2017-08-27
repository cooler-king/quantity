part of quantity_si;

/// Whether and how to display a quantity's uncertainty (e.g., compact is 32.324(12),
/// not compact is (7.131 +/- 0.003)).
enum UncertaintyFormat { none, compact, plusMinus }

/// NumberFormatSI implements the International System of Units (SI) style
/// conventions for displaying values of quantities.  Specifically:
///
/// - Three-digit groups of numbers with more than four digits are separated
/// by spaces instead of commas (for example, 299 792 458, not
/// 299,792,458) to avoid confusion with the decimal marker in European
/// literature.  This spacing is also used to the right of the decimal
/// marker (for example, 12 345.678 90).
/// - Uncertainty in the quantity's value may be optionally displayed...
/// e.g., 1.234(11) or (1.234 +/- 0.011).
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
///
class NumberFormatSI extends NumberFormat {
  /// Output in unicode (using unicode thin spaces instead of regular ascii spaces).
  bool unicode = false;

  /// Whether and how to display a quantity's
  UncertaintyFormat uncertaintyFormat = UncertaintyFormat.compact;

  //TODO placeholder for formatting

  NumberFormatSI(this.uncertaintyFormat, this.unicode) : super.scientificPattern();

  /// [number] is expected to be a Quantity, Number or num object.
  @override
  String format(dynamic number) {
    //TODO format
/*    if (number is num) {
      String format1 = super.format(number);
    } else if (number is Real) {
      number.
    } */
    return super.format(number);
  }
}
