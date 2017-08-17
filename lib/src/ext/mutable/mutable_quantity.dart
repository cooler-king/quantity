part of quantity_ext;

MutableQuantity toMutable(Quantity q) => new MutableQuantity()..setEqualTo(q);

/// _MutableQuantity is a work in progress._
///
/// ## Inversion
/// The Quantity class supports inversion through the `inverse`
/// method, which returns a new Quantity object that is the result of the
/// inversion process.  MiscQuantity adds to this capability with the
/// `invert` method, which inverts the MiscQuantity in place without
/// returning a new object.  This is possible because a MiscQuantity may have
/// any Dimensions, whereas other Quantity subclasses have fixed Dimensions.
///
class MutableQuantity implements Quantity {
  // Value
  Number _valueSI;
  Number get valueSI => _valueSI;
  void set valueSI(value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    valueSI = objToNumber(value);
    //TODO event
  }

  // Dimensions
  Dimensions _dimensions;
  Dimensions get dimensions => _dimensions;
  void set dimensions(Dimensions dim) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    _dimensions = dim;
    //TODO event
  }

  /// Relative uncertainty
  double _ur = 0.0;

  // Preferred units for display
  Units preferredUnits = null;

  /// Mutability can be turned on and off (defaults to true)
  bool mutable = true;

  Stream<Number> get onChange => _onChange.stream;
  StreamController<Number> _onChange = new StreamController<Number>.broadcast();

  MutableQuantity([dynamic value = 0.0, Dimensions dim = Scalar.scalarDimensions, double uncert = 0.0]) {}

  Number get mks => valueSI;

  /// Sets the [value] of this quantity in standard MKS (meter-kilogram-second) units.
  ///
  set mks(Number value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    if (value != valueSI) {
      valueSI = value;

      // Send new value over stream
      _onChange.add(valueSI);
    }
  }

  /// Creates and returns an immutable typed [Quantity] that represents the value and
  /// uncertainty of this MutableQuantity at this moment.
  ///
  Quantity get snapshot => //const MiscQuantity.constant(_valueSI, _dimensions, _preferredUnits, _ur);
      dimensions?.toQuantity(preferredUnits?.fromMks(valueSI) ?? valueSI, preferredUnits, _ur) ??
      new Scalar(value: valueSI, uncert: _ur);

  Number get cgs => snapshot.cgs;

  /// Sets the value of this quantity in alternative CGS
  /// (or centimeter-gram-second) units.  MKS (meter-kilogram-second) units are
  /// preferred.
  ///
  /// * Although CGS units were once commonly used and contended for the role
  /// of standard units, their use is now discouraged in favor of the adopted
  /// standard MKS (or meter-kilogram-second) units.
  /// * Throws an ImmutableQuantityException (a RuntimeException) if this
  /// Quantity has been made immutable.
  ///
  /// See [set mks(double)].
  ///
  void set cgs(Number value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    // Adjust for centimeters vs. meters
    num lengthExp = dimensions.getComponentExponent(Dimensions.baseLengthKey);
    value /= pow(100.0, lengthExp.toDouble());

    // Adjust for grams vs. kilograms
    num massExp = dimensions.getComponentExponent(Dimensions.baseMassKey);
    value /= pow(1000.0, massExp.toDouble());

    mks = new Double(value.toDouble());
  }

  double get relativeUncertainty => _ur;

  ///   Sets the relative standard uncertainty in this Quantity object's value.
  ///
  ///   * Will throw an ImmutableQuantityException (a RuntimeException) if this
  ///   Quantity is in an immutable state.
  ///   * Relative standard uncertainty is defined as the standard uncertainty
  ///   divided by the absolute value of the quantity.  Standard uncertainty, in turn,
  ///   is defined as the uncertainty (of a measurement result) by an estimated
  ///   standard deviation, which is equal to the positive square root of the
  ///   estimated variance.  One standard deviate in a Normal distribution
  ///   corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
  ///   68%.
  ///
  void set relativeUncertainty(double value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    this._ur = value;
  }

  Quantity setEqualTo(Quantity q2) {
    if (!mutable) throw new ImmutableQuantityException(q: this);

    if (valueSI != q2.valueSI) {
      _valueSI = q2.valueSI;
    }
    dimensions = q2.dimensions;
    preferredUnits = q2.preferredUnits;
    _ur = q2.relativeUncertainty;

    // TODO Send new values over streams
    _onChange.add(valueSI);

    return this;
  }

  Quantity sqrt() => snapshot.sqrt();

  Quantity get standardUncertainty => snapshot.standardUncertainty;

  /// Sets the relative standard uncertainty in this Quantity object's value to [su].
  ///
  /// * Will throw an ImmutableQuantityException (a RuntimeException) if this
  /// Quantity is in an immutable state.
  /// * Relative standard uncertainty is defined as the standard uncertainty
  /// divided by the absolute value of the quantity.  Standard uncertainty, in turn,
  /// is defined as the uncertainty (of a measurement result) by an estimated
  /// standard deviation, which is equal to the positive square root of the
  /// estimated variance.  One standard deviate in a Normal distribution
  /// corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
  /// 68%.
  ///
  void set standardUncertainty(Quantity su) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    if (!(dimensions == su.dimensions)) {
      throw new DimensionsException(
          "The standard uncertainty must have the same " + "dimensions as this Quantity object");
    }

    // Determine ur
    Quantity ratio = su / this; // Scalar
    _ur = ratio.mks.toDouble();
  }

  /// Sets the this Quantity's [value] in the specified [units].  If units
  /// are not provided, MKS units are assumed.  The [value] is expected to
  /// be a num or Number object.
  ///
  void setValue(dynamic value, [Units units]) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    if (units == null) {
      valueSI = value is Number
          ? value
          : value is num ? new Double(value.toDouble()) : throw new QuantityException("Expected a Number or num");
    } else {
      // First check for compatible dimensions
      if (units is Quantity && (units as Quantity).dimensions == dimensions) {
        valueSI = units.toMks(value);
      } else {
        throw new DimensionsException("Cannot set quantity value using units with incompatible dimensions");
      }
    }
  }

  /// Sets the Dimensions of this Quantity.
  ///
  /// ### Notes:
  /// (1) If this Quantity is in an immutable state, an ImmutableQuantityException
  /// will be thrown.
  /// (2) Dimensions are immutable; no copy is made;
  ///
  /// * @param dim the desired Dimensions for this Quantity; if null, Scalar
  ///                dimensions are assumed
  ///
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

  /// Converts the value of this MutableQuantity to its absolute value.
  ///
  /// Returns itself.
  ///

  Quantity abs() {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    valueSI = valueSI.abs();
    return this;
  }

  bool get arbitraryPrecision => valueSI is Precise;

  Quantity calcExpandedUncertainty(double k) => snapshot.calcExpandedUncertainty(k);

  int compareTo(dynamic q2) => snapshot.compareTo(q2);

  /// Each MutableQuantity has a unique hashCode that is _not_ value based.
  ///
  /// Therefore MutableQuantity instances with the
  /// same value and dimensions as another quantity will not have
  /// the same hash code.
  ///

  int get hashCode => super.hashCode;

  /// Inverts this MutableQuantity in place and returns itself.
  ///
  MutableQuantity invert() {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    valueSI = valueSI.reciprocal();
    dimensions = dimensions.inverse();
    return this;
  }

  Quantity inverse() => snapshot.inverse();

  void outputText(StringBuffer buffer, {bool showUncert: false, bool symbols: true, NumberFormat numberFormat}) =>
      snapshot.outputText(buffer, showUncert: showUncert, symbols: symbols, numberFormat: numberFormat);

  Quantity randomSample() => snapshot.randomSample();

  Map toJson() => snapshot.toJson();

  Number valueInUnits(Units units) => snapshot.valueInUnits(units);

  /// Negates the value of this MutableQuantity and returns
  /// a reference to itself.
  ///
  Quantity operator -() {
    valueSI = -valueSI;
    return this;
  }

  Quantity operator +(addend) => snapshot + addend;

  Quantity operator -(subtrahend) => snapshot - subtrahend;

  Quantity operator *(multiplier) => snapshot * multiplier;

  Quantity operator /(divisor) => snapshot / divisor;

  bool operator <(Quantity other) => snapshot.compareTo(other) < 0;

  bool operator <=(Quantity other) => snapshot.compareTo(other) <= 0;

  bool operator >(Quantity other) => snapshot.compareTo(other) > 0;

  bool operator >=(Quantity other) => snapshot.compareTo(other) >= 0;

  Quantity operator ^(exp) => snapshot ^ exp;
}
