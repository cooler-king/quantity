part of quantity_core;

/// This Exception is thrown when an attempt is made to perform an
/// operation on a Quantity having unexpected or illegal dimensions.
///
class DimensionsException extends QuantityException {
  /// Constructs a new DimensionsException with an optional message.
  ///
  DimensionsException([String str = ""]) : super(str);
}
