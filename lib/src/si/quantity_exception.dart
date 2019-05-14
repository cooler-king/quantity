part of quantity_si;

/// The base class for all exceptions thrown in relation to quantities.
class QuantityException implements Exception {
  /// Constructs a new QuantityException with an optional message
  const QuantityException([this.message = '']);

  final String message;

  @override
  String toString() => 'QuantityException: $message';
}
