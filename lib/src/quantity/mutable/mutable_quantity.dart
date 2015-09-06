part of quantity_mutable;

/**
 *    ## Inversion
   The Quantity class supports inversion through the <code>inverse</code>
   method, which returns a new Quantity object that is the result of the
   inversion process.  MiscQuantity adds to this capability with the
   <code>invert</code> method, which inverts the MiscQuantity in place without
   returning a new object.  This is possible because a MiscQuantity may have
   any Dimensions, whereas other Quantity subclasses have fixed Dimensions.
 */
//class MutableQuantity<Q extends Quantity> extends MiscQuantity {
class MutableQuantity implements Quantity {

  // Value
  Number valueSI;

  // Dimensions
  Dimensions dimensions;

  /// Relative uncertainty
  double _ur = 0.0;

  // Preferred units for display
  Units preferredUnits = null;

  /// TODO Mutability can be turned on and off
  bool mutable = true;

  StreamController _valueController;
  Stream onValueChange;
  Stream onDimensionsChange;
  Stream onUncertaintyChange;

  /**
   * Sets the [value] of this quantity in standard MKS (meter-kilogram-second) units.
   */
  set mks(Number value) {
    if (value != valueSI) {
      valueSI = value;

      // Send new value over stream
      _valueController.add(valueSI);
    }
  }

  //TODO toTypedQuantity

  /**
     Sets the value of this quantity in alternative CGS
     (or centimeter-gram-second) units.  MKS (meter-kilogram-second) units are
     preferred.
  
     ### Notes:
     (1) Although CGS units were once commonly used and contended for the role
     of standard units, their use is now discouraged in favor of the adopted
     standard MKS (or meter-kilogram-second) units.<br>
     (2) Throws an ImmutableQuantityException (a RuntimeException) if this
     Quantity has been made immutable.
  
     @see #setMKS(double)
  */
  set cgs(Number value) {
    // Adjust for centimeters vs. meters
    num lengthExp = dimensions.getComponentExponent(Dimensions.BASE_LENGTH);
    value /= Math.pow(100.0, lengthExp.toDouble());

    // Adjust for grams vs. kilograms
    num massExp = dimensions.getComponentExponent(Dimensions.BASE_MASS);
    value /= Math.pow(1000.0, massExp.toDouble());

    mks = new Double(value.toDouble());
  }

  /**
     Sets the relative standard uncertainty in this Quantity object's value.
  
     ### Notes:
     (1) Will throw an ImmutableQuantityException (a RuntimeException) if this
     Quantity is in an immutable state.<br>
     (2) Relative standard uncertainty is defined as the standard uncertainty
     divided by the absolute value of the quantity.  Standard uncertainty, in turn,
     is defined as the uncertainty (of a measurement result) by an estimated
     standard deviation, which is equal to the positive square root of the
     estimated variance.  One standard deviate in a Normal distribution
     corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
     68%.
  
     * @param ur the relative uncertainty
  */
  set relativeUncertainty(double value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    this._ur = value;
  }

  Quantity setEqualTo(Quantity q2) {
    if (!mutable) throw new ImmutableQuantityException(q: this);

    if (valueSI != q2.valueSI) {
      valueSI = q2.valueSI;
      _valueController.add(valueSI);
    }
    dimensions = q2.dimensions;
    preferredUnits = q2.preferredUnits;
    _ur = q2._ur;

    // Send new values over streams

    return this;
  }

  /**
     Sets the relative standard uncertainty in this Quantity object's value.
  
     ### Notes:
     (1) Will throw an ImmutableQuantityException (a RuntimeException) if this
     Quantity is in an immutable state.<br>
     (2) Relative standard uncertainty is defined as the standard uncertainty
     divided by the absolute value of the quantity.  Standard uncertainty, in turn,
     is defined as the uncertainty (of a measurement result) by an estimated
     standard deviation, which is equal to the positive square root of the
     estimated variance.  One standard deviate in a Normal distribution
     corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
     68%.
  
     * @param su the new standard uncertainty
  */
  set standardUncertainty(Quantity su) {
    if (!(dimensions == su.dimensions)) {
      throw new DimensionsException(
          "The standard uncertainty must have the same " + "dimensions as this Quantity object");
    }

    // Determine ur
    Quantity ratio = su / this; // Scalar
    _ur = ratio.mks.toDouble();
  }

  /**
   * Sets the this Quantity's [value] in the specified [units].  If units 
   * are not provided, MKS units are assumed.  The [value] is expected to 
   * be a num or Number object; anything else will cause an [ArgumentError].
   */
  void setValue(Object value, [Units units]) {
    if (units == null) {
      valueSI = value;
    } else {
      // First check for compatible dimensions
      if (units is Quantity && (units as Quantity).dimensions == dimensions) {
        valueSI = units.toMks(value);
      } else {
        throw new DimensionsException("Cannot set quantity value using units with incompatible dimensions");
      }
    }
  }

  /**
     Sets the Dimensions of this Quantity.
  
     ### Notes:
     (1) If this Quantity is in an immutable state, an ImmutableQuantityException
     will be thrown.<br>
     (2) Dimensions are immutable; no copy is made;
  
     * @param dim the desired Dimensions for this Quantity; if null, Scalar
                  dimensions are assumed
  */
  /* dimension cannot be changed
  set dimensions(Dimensions dim) {
    if(immutable) throw new ImmutableQuantityException("In Quantity.setDimensions",this);

    if(dim == null) { 
      _dimensions = Scalar.SCALAR_DIMENSIONS;
    } else {       
      _dimensions = dim;
    }

   if(_listeners != null) _fireValueChanged();
  }
  */

}
