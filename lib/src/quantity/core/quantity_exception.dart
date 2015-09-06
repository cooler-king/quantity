part of quantity_core;

/// The base class for all exceptions thrown in relation to quantities.
///
class QuantityException implements Exception {
  final String message;

  /// Constructs a new QuantityException with an optional message
  ///
  const QuantityException([this.message = ""]);

  String toString() => "QuantityException: $message";
}
