part of quantity_si;

/// Whether and how to display a quantity's uncertainty
/// (e.g., compact is 32.324(12), not compact is (32.324 +/- 0.012)).
enum UncertaintyFormat {
  /// Do not display uncertainty.
  none,

  /// Display uncertainty in compact form.
  compact,

  /// Display uncertainty in full plus/minus form.
  plusMinus
}
