part of quantity_ext;

/// Create a [MutableQuantity] with the same value, dimensions and uncertainty as [q].
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
class MutableQuantity implements Quantity {
  MutableQuantity([dynamic value = 0.0, Dimensions dim = Scalar.scalarDimensions, double uncert = 0.0]);

  // Value
  Number _valueSI;
  @override
  Number get valueSI => _valueSI;
  set valueSI(dynamic value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    _valueSI = objToNumber(value);
    //TODO event
  }

  // Dimensions
  Dimensions _dimensions;
  @override
  Dimensions get dimensions => _dimensions;
  set dimensions(Dimensions dim) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    _dimensions = dim;
    //TODO event
  }

  /// Relative uncertainty.
  double _ur = 0.0;

  /// Preferred units for display.
  @override
  Units preferredUnits;

  /// Mutability can be turned on and off (defaults to true).
  bool mutable = true;

  Stream<Number> get onChange => _onChange.stream;
  final StreamController<Number> _onChange = new StreamController<Number>.broadcast();


  @override
  Number get mks => valueSI;

  /// Sets the [value] of this quantity in standard MKS (meter-kilogram-second) units.
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
  Quantity get snapshot => //const MiscQuantity.constant(_valueSI, _dimensions, _preferredUnits, _ur);
      dimensions?.toQuantity(preferredUnits?.fromMks(valueSI) ?? valueSI, preferredUnits, _ur) ??
      new Scalar(value: valueSI, uncert: _ur);

  @override
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
  set cgs(Number value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);

    Number val = value;

    // Adjust for centimeters vs. meters
    final num lengthExp = dimensions.getComponentExponent(Dimensions.baseLengthKey);
    val /= pow(100.0, lengthExp.toDouble());

    // Adjust for grams vs. kilograms
    final num massExp = dimensions.getComponentExponent(Dimensions.baseMassKey);
    val /= pow(1000.0, massExp.toDouble());

    mks = new Double(val.toDouble());
  }

  @override
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
  ///   corresponds to a coverage factor of 1 (k=1) and a confidence of approximately 68%.
  set relativeUncertainty(double value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    _ur = value;
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

  @override
  Quantity sqrt() => snapshot.sqrt();

  @override
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
  /// corresponds to a coverage factor of 1 (k=1) and a confidence of approximately 68%.
  set standardUncertainty(Quantity su) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    if (!(dimensions == su.dimensions)) {
      throw new DimensionsException(
          'The standard uncertainty must have the same dimensions as this Quantity object');
    }

    // Determine ur.
    final Quantity ratio = su / this; // Scalar
    _ur = ratio.mks.toDouble();
  }

  /// Sets the this Quantity's [value] in the specified [units].  If units
  /// are not provided, MKS units are assumed.  The [value] is expected to
  /// be a num or Number object.
  void setValue(dynamic value, [Units units]) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    if (units == null) {
      valueSI = value is Number
          ? value
          : value is num ? new Double(value.toDouble()) : throw const QuantityException('Expected a Number or num');
    } else {
      // First check for compatible dimensions
      if (units is Quantity && (units as Quantity).dimensions == dimensions) {
        valueSI = units.toMks(value);
      } else {
        throw new DimensionsException('Cannot set quantity value using units with incompatible dimensions');
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
    if(immutable) throw new ImmutableQuantityException('In Quantity.setDimensions',this);

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
  @override
  Quantity abs() {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    valueSI = valueSI.abs();
    return this;
  }

  @override
  bool get arbitraryPrecision => valueSI is Precise;

  @override
  Quantity calcExpandedUncertainty(double k) => snapshot.calcExpandedUncertainty(k);

  @override
  int compareTo(dynamic q2) => snapshot.compareTo(q2);

  /// Each MutableQuantity has a unique hashCode that is _not_ value based.
  ///
  /// Therefore MutableQuantity instances with the
  /// same value and dimensions as another quantity will not have
  /// the same hash code.
  @override
  int get hashCode => hashObjects(<Object>[this]);

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  /// Inverts this MutableQuantity in place and returns itself.
  void invert() {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    valueSI = valueSI.reciprocal();
    dimensions = dimensions.inverse();
  }

  @override
  Quantity inverse() => snapshot.inverse();

  @override
  void outputText(StringBuffer buffer, {bool showUncert = false, bool symbols = true, NumberFormat numberFormat}) =>
      snapshot.outputText(buffer, showUncert: showUncert, symbols: symbols, numberFormat: numberFormat);

  @override
  Quantity randomSample() => snapshot.randomSample();

  @override
  Map<String, dynamic> toJson() => snapshot.toJson();

  @override
  Number valueInUnits(Units units) => snapshot.valueInUnits(units);

  /// Negates the value of this MutableQuantity and returns
  /// a reference to itself.
  @override
  Quantity operator -() {
    valueSI = -valueSI;
    return this;
  }

  @override
  Quantity operator +(dynamic addend) => snapshot + addend;

  @override
  Quantity operator -(dynamic subtrahend) => snapshot - subtrahend;

  @override
  Quantity operator *(dynamic multiplier) => snapshot * multiplier;

  @override
  Quantity operator /(dynamic divisor) => snapshot / divisor;

  @override
  bool operator <(Quantity other) => snapshot.compareTo(other) < 0;

  @override
  bool operator <=(Quantity other) => snapshot.compareTo(other) <= 0;

  @override
  bool operator >(Quantity other) => snapshot.compareTo(other) > 0;

  @override
  bool operator >=(Quantity other) => snapshot.compareTo(other) >= 0;

  @override
  Quantity operator ^(dynamic exp) => snapshot ^ exp;

  /// Whether or not this Quantity has scalar dimensions, including having no angle or
  /// solid angle dimensions.
  ///
  /// Use `isScalarSI` to see if these Dimensions are scalar in the strict
  /// International System of Units (SI) sense, which allows non-zero angular and
  /// solid angular dimensions.
  @override
  bool get isScalar => dimensions.isScalar;

  /// Whether or not this Quantity has scalar dimensions in the strict
  /// International System of Units (SI) sense, which allows non-zero angle and
  /// solid angle dimensions.
  ///
  /// Use `isScalarSI` to see if these Dimensions are scalar in the strict
  /// International System of Units sense, which allows non-zero angular and
  /// solid angular dimensions.
  @override
  bool get isScalarSI => dimensions.isScalarSI;
}
