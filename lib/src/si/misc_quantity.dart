part of quantity_si;

///   A MiscQuantity is a general Quantity having arbitrary dimensions (including
///   possibly the same dimensions as a named Quantity subclass).  MiscQuantity
///   objects may be used, for example, in less common domains or as intermediate
///   results in equations.
///
///   ## Units Dimension Checking
///   Other subclasses of Quantity have implicit type safety in their get/setValue
///   methods, as they accept only sublasses of Units having the appropriate type
///   (for example, the Mass class' get/setValue methods only accept MassUnits as
///   arguments).  Because MiscQuantity may have any Dimensions at all, any Units
///   are possible.  Therefore, in order to ensure that the Units passed to
///   get/setValue in this class are valid, runtime dimensions checking is
///   performed.  The Dimensions of the specified Units are compared to the
///   Dimensions of the MiscQuantity object and, if not equal, a
///   DimensionsException (a RuntimeException) is thrown.<p>

///   ## Construction
///   MiscQuantity objects are harder to construct than other subclasses of
///   Quantity.  Both the SI-MKS value and the Dimensions must be provided at
///   object creation.  Other subclasses allow construction with any appropriate
///   Units (and its implicit conversion factor to SI-MKS) and automatically
///   initialize the Dimensions.

///   ## Externalization (Serialization)
///   It is somewhat less efficient to write out and read in MiscQuantity objects
///   as compared to specific Quantity subclasses.  This is due to MiscQuantity's
///   requirement that Dimensions information be written to the object stream,
///   whereas other Quantity subclasses implicitly initialize their Dimensions
///   when constructed.
///
class MiscQuantity extends Quantity {
  /// This constructor sets the [value], [dim]ensions and relative
  /// [uncert]ainty.
  ///
  ///  [value] may be a num or Number object.
  ///
  MiscQuantity([Object value = 0.0, Dimensions dim = Scalar.scalarDimensions, double uncert = 0.0])
      : super._dimensions(value, dim, uncert);

  const MiscQuantity.constant(Number valueSI, Dimensions dim, {Units units, num uncert: 0.0})
      : super.constant(valueSI, dim, units, uncert);

  /*
  const MiscQuantity.constant(
      Number value, Dimensions dim, Units units, double uncert) :
        super.constant(value, dim, units, uncert);
  */

  ///  Gets this quantity's value in [units].
  ///
  /// * The Dimensions of the specified units are checked for validity.
  ///  This method throws a DimensionsException (a RuntimeException) if the
  ///  units' Dimensions are not equal to this MiscQuantity object's Dimensions.
  ///  * The value is returned in double precision even if the quantity's
  ///  value is stored internally in arbitrary precision.
  ///
  Number getValue(Units units) {
    if (dimensions != (units as Quantity).dimensions) {
      throw new DimensionsException("The units provided do not have proper dimensions for this Quantity.");
    }
    return super.valueInUnits(units);
  }
}
