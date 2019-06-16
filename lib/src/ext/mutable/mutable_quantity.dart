part of quantity_ext;

/// Create a [MutableQuantity] with the same value, dimensions and uncertainty as [q].
MutableQuantity toMutable(Quantity q) => new MutableQuantity()..setEqualTo(q);

/// MutableQuantity supports updates to its value, dimensions and uncertainty.
/// Changes are broadcast over the `onChange` stream.
///
/// ## Inversion
/// The Quantity class supports inversion through the `inverse`
/// method, which returns a new Quantity object that is the result of the
/// inversion process.  MiscQuantity adds to this capability with the
/// `invert` method, which inverts the MiscQuantity in place without
/// returning a new object.  This is possible because a MiscQuantity may have
/// any Dimensions, whereas other Quantity subclasses have fixed Dimensions.
// ignore: avoid_implementing_value_types
class MutableQuantity implements Quantity {
  /// Constructs a new instance, with optional SI-MKS value, dimensions and/or relative uncertainty.
  MutableQuantity([this._valueSI = Double.zero, this._dimensions = Scalar.scalarDimensions, this._ur = 0.0]);

  // Value.
  @override
  Number get valueSI => _valueSI;
  Number _valueSI;
  set valueSI(dynamic value) {
    if (value != _valueSI) {
      if (!mutable) throw new ImmutableQuantityException(q: this);
      _valueSI = objToNumber(value);
      _onChange.add(this);
    }
  }

  // Dimensions.
  @override
  Dimensions get dimensions => _dimensions;
  Dimensions _dimensions;
  set dimensions(Dimensions dim) {
    if (dim != _dimensions) {
      if (!mutable) throw new ImmutableQuantityException(q: this);
      _dimensions = dim;
      _onChange.add(this);
    }
  }

  /// Relative uncertainty.
  double _ur = 0;

  @override
  double get relativeUncertainty => _ur;

  /// Sets the relative standard uncertainty in this Quantity object's value.
  ///
  /// - Will throw an ImmutableQuantityException (a RuntimeException) if this
  ///   Quantity is in an immutable state.
  /// - Relative standard uncertainty is defined as the standard uncertainty
  ///   divided by the absolute value of the quantity.  Standard uncertainty, in turn,
  ///   is defined as the uncertainty (of a measurement result) by an estimated
  ///   standard deviation, which is equal to the positive square root of the
  ///   estimated variance.  One standard deviate in a Normal distribution
  ///   corresponds to a coverage factor of 1 (k=1) and a confidence of approximately 68%.
  set relativeUncertainty(double value) {
    if (value != _ur) {
      if (!mutable) throw new ImmutableQuantityException(q: this);
      _ur = value;
      _onChange.add(this);
    }
  }

  /// Preferred units for display.
  @override
  Units preferredUnits;

  /// Mutability can be turned on and off (defaults to true).
  bool mutable = true;

  /// Broadcasts the quantity whenever its value, dimensions or uncertainty changes.
  Stream<MutableQuantity> get onChange => _onChange.stream;
  final StreamController<MutableQuantity> _onChange = new StreamController<MutableQuantity>.broadcast();

  @override
  Number get mks => valueSI;

  /// Sets the [value] of this quantity in standard MKS (meter-kilogram-second) units.
  set mks(Number value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    if (value != valueSI) {
      valueSI = value;

      // Send new value over stream
      _onChange.add(this);
    }
  }

  /// Creates and returns an immutable typed [Quantity] that represents the value and
  /// uncertainty of this MutableQuantity at this moment.
  Quantity get snapshot => //const MiscQuantity.constant(_valueSI, _dimensions, _preferredUnits, _ur);
      dimensions?.toQuantity(preferredUnits?.fromMks(valueSI) ?? valueSI, preferredUnits, _ur) ??
      new Scalar(value: valueSI, uncert: _ur);

  @override
  Number get cgs => snapshot.cgs;

  /// Sets the value of this quantity in alternative CGS (or centimeter-gram-second) units.
  /// MKS (meter-kilogram-second) units are preferred.
  ///
  /// - Although CGS units were once commonly used and contended for the role
  /// of standard units, their use is now discouraged in favor of the adopted
  /// standard MKS (or meter-kilogram-second) units.
  /// - Throws an ImmutableQuantityException if this Quantity has been made immutable.
  ///
  /// See [set mks(double)].
  set cgs(Number value) {
    if (!mutable) throw new ImmutableQuantityException(q: this);

    Number val = value;

    // Adjust for centimeters vs. meters.
    final num lengthExp = dimensions.getComponentExponent(Dimensions.baseLengthKey);
    val /= pow(100.0, lengthExp.toDouble());

    // Adjust for grams vs. kilograms.
    final num massExp = dimensions.getComponentExponent(Dimensions.baseMassKey);
    val /= pow(1000.0, massExp.toDouble());

    mks = new Double(val.toDouble());
  }

  /// Modifies this MutableQuantity to have the value, dimensions, uncertainty and
  /// preferred units of [q2].
  Quantity setEqualTo(Quantity q2) {
    if (!mutable) throw new ImmutableQuantityException(q: this);

    preferredUnits = q2.preferredUnits;

    if (valueSI != q2.valueSI || _dimensions != q2.dimensions || _ur != q2.relativeUncertainty) {
      _valueSI = q2.valueSI;
      _dimensions = q2.dimensions;
      _ur = q2.relativeUncertainty;
      _onChange.add(this);
    }

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
      throw new DimensionsException('The standard uncertainty must have the same dimensions as this Quantity object');
    }

    // Determine ur.
    final Quantity ratio = su / this; // Scalar
    _ur = ratio.mks.toDouble();
    _onChange.add(this);
  }

  /// Sets the this Quantity's [value] in the specified [units]. The [value] is expected to
  /// be a num or Number object.
  void setValueInUnits(dynamic value, Units units) {
    if (!mutable) throw new ImmutableQuantityException(q: this);

    // First check for compatible dimensions
    if (units is Quantity && (units as Quantity).dimensions == dimensions) {
      valueSI = units.toMks(value);
    } else {
      throw new DimensionsException('Cannot set quantity value using units with incompatible dimensions');
    }
  }

  /// Converts the value of this MutableQuantity to its absolute value.  Returns itself.
  @override
  Quantity abs() {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    final Number n = valueSI.abs();
    if (n != _valueSI) {
      valueSI = n;
      _onChange.add(this);
    }
    return this;
  }

  @override
  bool get arbitraryPrecision => valueSI is Precise;

  @override
  Quantity calcExpandedUncertainty(double k) => snapshot.calcExpandedUncertainty(k);

  @override
  int compareTo(dynamic q2) => snapshot.compareTo(q2);

  /// Each MutableQuantity has a unique hashCode that is _not_ value based.
  /// Therefore MutableQuantity instances with the same value and dimensions as
  /// another quantity will not have the same hash code.
  @override
  int get hashCode => hashObjects(<Object>[this]);

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  /// Inverts this MutableQuantity in place and returns itself.
  void invert() {
    if (!mutable) throw new ImmutableQuantityException(q: this);
    _valueSI = valueSI.reciprocal();
    _dimensions = dimensions.inverse();
    _onChange.add(this);
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

  /// Negates the value of this MutableQuantity and returns a reference to itself.
  @override
  Quantity operator -() {
    _valueSI = -_valueSI;
    _onChange.add(this);
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
