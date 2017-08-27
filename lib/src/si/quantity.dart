part of quantity_si;

/// The abstract base class for all quantities.  The Quantity class represents
/// the value of a physical quantity and its
/// associated dimensions.  It provides methods for constructing and getting the
/// quantity's value in arbitrary units, methods for mathematical manipulation
/// and comparison and optional features such as arbitrary
/// precision and uncertainty.
///
/// ## Definitions
/// _from [NIST's introduction to the International System of Units](http://physics.nist.gov/cuu/Units/introduction.html)_
///
/// * A _quantity in the general sense_ is a property ascribed to phenomena,
/// bodies, or substances that can be quantified for, or assigned to, a
/// particular phenomenon, body, or substance.  Examples are mass and electric
/// charge.
/// * A _quantity in the particular sense_ is a quantifiable or assignable
/// property ascribed to a particular phenomenon, body, or substance.  Examples
/// are the mass of the moon and the electric charge of the proton.
/// * A _physical quantity_ is a quantity that can be used in the mathematical
/// equations of science and technology.
/// * A _unit_ is a particular physical quantity, defined and adopted by
/// convention, with which other particular quantities of the same kind
/// (dimension) are compared to express their value.
/// * The _value of a physical quantity_ is the quantitative expression of a
/// particular physical quantity as the product of a number and a unit, the
/// number being its numerical value.  Thus, the numerical value of a particular
/// physical quantity depends on the unit in which it is expressed.
///
/// ## Immutable
/// Quantity values are immutable; they may not be changed after creation.
/// Use [MutableQuantity] in the quantity_ext library for situations where
/// changing a Quantity object's value or units is required.
///
/// ## Value Representation,  Arbitrary Precision
/// Quantity supports values specified by [num] or [Number] objects.  `Number` subtypes
/// include [Real], [Imaginary] and [Complex].  Various [Real] subtypes are
/// available, including [Precise], which supports arbitrary precision calculations.
///
/// ## Uncertainty
/// A Quantity object optionally includes an uncertainty, as quantities are
/// often determined by measurement and therefore are only accurate within
/// the capabilities of the measuring devices or techniques.  Internally,
/// the uncertainty of a quantity is modeled as a Normal (Gaussian) distribution.
/// The shape of this "bell curve" distribution is captured by a single value:
/// the relative standard uncertainty.  This method of expressing uncertainty is
/// used for all physical constants and is accepted for general use with all
/// quantities (because quantities, as measurable entities, all follow the same
/// logic for representing the uncertainty generated by the combination of
/// values from many different experiments).  The relative standard uncertainty
/// corresponds to an approximately 68% confidence level that the quantity's
/// value is in the stated range.  For different confidence levels, alternative
/// coverage factors may be used (k=2 ~95%; k=3 ~99%).  Uncertainty calculations
/// may be switched on or off as desired.  It is automatically on if the Quantity
/// is constructed with any uncertainty and off otherwise.  The setCalcUncertainty
/// method may be called at any point to enable/disable this capability.
///
abstract class Quantity implements Comparable<dynamic> {
  /// The value of the quantity in the [base units](http://physics.nist.gov/cuu/Units/current.html),
  /// of the International System of Units (SI).
  ///
  /// This is often referred to as the _MKS_ value to highlight that the units reference meters
  /// and kilograms rather than centimeters and grams (_CGS_) as was often done before standardization.
  /// The [mks] getter offers a shorthand way to retrieve this value.
  final Number valueSI;

  // Dimensions
  final Dimensions dimensions;

  /// Sets whether or not uncertainty is to be calculated within mathematical methods.
  // bool calcUncertainty = false;

  final double _ur;

  /// Preferred units for display
  final Units preferredUnits;

  /// This constructor sets the [value] (as expressed in the accompanying [units])
  /// and the relative standard [uncert]ainty.  The value is may be set using any
  /// `num` or `Number` object, including [Precise] for arbitrary precision.
  ///
  /// Both the value and the uncertainty default to zero.
  ///
  /// Quantity dimensions are derived from the [units] and default to scalar
  /// dimensions if units are not provided.
  ///
  /// Relative standard uncertainty is defined as the standard uncertainty
  /// divided by the absolute value of the result.  Standard uncertainty, in turn,
  /// is defined as the uncertainty (of a measurement result) by an estimated
  /// standard deviation, which is equal to the positive square root of the
  /// estimated variance.  One standard deviate in a Normal distribution
  /// corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
  /// 68%.
  ///
  Quantity([dynamic value = Integer.zero, Units units, double uncert = 0.0])
      : this.valueSI = units?.toMks(value ?? 0) ?? (value is Number ? value : numToNumber(value as num)),
        this.preferredUnits = units,
        this.dimensions = (units is Quantity) ? (units as Quantity).dimensions : Scalar.scalarDimensions,
        this._ur = uncert;

  const Quantity.constant(this.valueSI, this.dimensions, this.preferredUnits, this._ur);

  /// A private constructor to support MiscQuantity:  dimensions are
  /// known, units are not.
  ///
  Quantity._internal([dynamic value = 0.0, Dimensions dimensions, double uncert = 0.0])
      : this.valueSI = (value is num) ? numToNumber(value) : value is Number ? value : null,
        this.preferredUnits = null,
        this.dimensions = dimensions,
        this._ur = uncert {}

  ///  Whether or not this Quantity is represented using arbitrary precision.
  ///
  /// The values of arbitrarily precise Quantities are stored internally as
  /// [Precise] Number objects.
  ///
  /// Arbitrary precision calculations will generally be
  /// significantly slower than limited precision (double) calculations because
  /// arbitrary precision calculations typically occur in software while
  /// double precision calculations often are accelerated directly in hardware.
  ///
  bool get arbitraryPrecision => valueSI is Precise;

  /// Whether or not this Quantity has scalar dimensions, including having no angle or
  /// solid angle dimensions.
  ///
  /// Use `isScalarSI` to see if these Dimensions are scalar in the strict
  /// International System of Units (SI) sense, which allows non-zero angular and
  /// solid angular dimensions.
  ///
  bool get isScalar => dimensions.isScalar;

  /// Whether or not this Quantity has scalar dimensions in the strict
  /// International System of Units (SI) sense, which allows non-zero angle and
  /// solid angle dimensions.
  ///
  /// Use `isScalarSI` to see if these Dimensions are scalar in the strict
  /// International System of Units sense, which allows non-zero angular and
  /// solid angular dimensions.
  ///
  bool get isScalarSI => dimensions.isScalarSI;

  /// The relative standard uncertainty in this Quantity object's value.
  ///
  /// Relative standard uncertainty is defined as the standard uncertainty
  /// divided by the absolute value of the quantity.  Standard uncertainty, in turn,
  /// is defined as the uncertainty (of a measurement result) by an estimated
  /// standard deviation, which is equal to the positive square root of the
  /// estimated variance.  One standard deviate in a Normal distribution
  /// corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
  /// 68%.
  ///
  double get relativeUncertainty => _ur;

  /// Returns the expanded uncertainty for coverage factor, [k], in this
  /// Quantity's value as a typed Quantity object.
  ///
  /// * The expanded uncertainty is defined as a multiple of the standard
  /// uncertainty and may be used when the 68.27% confidence represented by the
  /// standard uncertainty (k=1) is not adequate.
  /// * Confidence values (i.e., the percentage of the distribution encompassed)
  /// for other values of the coverage factor "k" include:
  ///
  /// 1. 90% for k=1.645,
  /// 2. 95.45% for k=2,
  /// 3. 99% for k=2.576 and
  /// 4. 99.73% for k=3.
  ///
  Quantity calcExpandedUncertainty(double k) => dimensions.toQuantity(valueSI * _ur * k);

  /// Returns the standard uncertainty in this Quantity object's value as a typed
  /// Quantity object.
  ///
  /// Standard uncertainty
  /// is defined as the uncertainty (of a measurement result) by an estimated
  /// standard deviation, which is equal to the positive square root of the
  /// estimated variance.  One standard deviate in a Normal distribution
  /// corresponds to a coverage factor of 1 (k=1) and a confidence of approximately
  /// 68%.
  ///
  Quantity get standardUncertainty => dimensions.toQuantity(valueSI * _ur);

  /// Randomly generates a Quantity from this Quantity's value and uncertainty.
  /// The uncertainty is represented by a Normal (Gaussian) continous
  /// distribution.
  ///
  /// Because the uncertainty is represented by the continuous normal
  /// distribution there are no upper or lower limits on the value that this
  /// method will return.
  ///
  /// If the relative uncertainty is zero, then a copy of this Quantity
  /// will be returned.
  ///
  Quantity randomSample() {
    if (_ur == 0.0) return this;

    // Generate a random number btw 0.0 and 1.0
    double rand = new Math.Random().nextDouble();

    double test = 2.0 * rand - 1.0;

    // Iterate on erf until we get a close enough match
    double delta = 1.0;
    double eps = 0.0001;
    double x = -4.0;
    int count = 0;
    while (count < 10000) {
      double fx = erf(x);
      if ((fx - test).abs() < eps) {
        double z = x * Math.sqrt(2.0);
        return (this + (standardUncertainty * z));
      }

      // Reverse direction and halve it if past it
      if (fx > test) {
        x -= delta; // backtrack... went too far
        delta *= 0.5; // take smaller steps
      } else {
        x += delta;
      }

      count++; // safety valve
    }

    // just in case
    return this;
  }

  /// Returns the absolute value of this Quantity.
  ///
  /// If the value of this Quantity is not negative it is returned directly.
  ///
  Quantity abs() {
    if (valueSI >= 0) return this;
    return dimensions.toQuantity(valueSI.abs(), preferredUnits, _ur);
  }

  /// Returns the sum of this Quantity and [addend].
  ///
  /// * If an attempt is made to add two Quantity objects having different
  /// dimensions, this method will throw a [DimensionsException].
  /// * If the uncertainty is calculated it will be equal to the combined
  /// standard uncertainty divided by the absolute value of the sum of the
  /// quantities.  The standard uncertainty is the square root of the sum
  /// of the squares of the two quantities' standard uncertainties. See
  /// [NIST Reference on Constants, Units, and Uncertainty: Combining
  /// Uncertainty Components](http://physics.nist.gov/cuu/Uncertainty/combination.html)
  ///
  Quantity operator +(dynamic addend) {
    if (addend == null) throw new QuantityException("Cannot add NULL to Quantity");

    // Scalars allow addition of numbers
    if (this.isScalar && (addend is num || addend is Number)) {
      return dimensions.toQuantity(valueSI + addend, null, _ur);
    }

    // Every other Quantity type can only add another Quantity
    if (addend is! Quantity) throw new QuantityException("Cannot add a ${addend.runtimeType} to a non-Scalar Quantity");

    Quantity q2 = addend as Quantity;
    if (dimensions != q2.dimensions) {
      throw new DimensionsException('''Can't add Quantities having different 
        dimensions:  $dimensions and ${q2.dimensions}''');
    }

    // Calculate the new uncertainty, if necessary
    double sumUr = 0.0;
    if (_ur != 0.0 || q2._ur != 0.0) {
      // Standard uncertainty (derive from relative standard uncertainty)
      //double v1 = valueSI.toDouble();
      double u1 = _ur * valueSI.abs().toDouble();

      // q2's standard uncertainty (derive from relative standard uncertainty)
      double u2 = q2._ur * q2.valueSI.abs().toDouble();

      // Combined standard uncertainty
      double uc = Math.sqrt(u1 * u1 + u2 * u2);

      // Relative combined standard uncertainty
      //TODO should not be mks... should be new value?
      sumUr = uc / mks.abs().toDouble();
    }

    if (dynamicQuantityTyping) {
      return dimensions.toQuantity(valueSI + q2.valueSI, null, sumUr);
    } else {
      return new MiscQuantity(valueSI + q2.valueSI, dimensions, sumUr);
    }
  }

  /// Returns the difference of this Quantity and [subtrahend] or (this - q2).
  ///
  /// Only a Quantity object
  /// having the same dimensions as this Quantity object may be subtracted from it.
  ///
  /// * If an attempt is made to subtract a Quantity object having different
  /// dimensions from this Quantity object, this operator will throw a
  /// [DimensionsException].
  /// * If the uncertainty is calculated it will be equal to the combined
  /// standard uncertainty divided by the absolute value of the difference of the
  /// quantities.  The standard uncertainty is the square root of the sum
  /// of the squares of the two quantities' standard uncertainties.
  ///
  /// See <a href="http://physics.nist.gov/cuu/Uncertainty/combination.html">
  /// NIST Reference on Constants, Units, and Uncertainty: Combining
  /// uncertainty components
  ///
  Quantity operator -(dynamic subtrahend) {
    // Null check
    if (subtrahend == null) throw new QuantityException("Cannot subtract NULL from Quantity");

    // Scalars allow subtraction of numbers.
    if (this.isScalar && (subtrahend is num || subtrahend is Number)) {
      return dimensions.toQuantity(valueSI - subtrahend, null, _ur);
    }

    // Every other Quantity type can only subtract another Quantity.
    if (subtrahend is! Quantity)
      throw new QuantityException("Cannot subtract a ${subtrahend.runtimeType} from a non-Scalar Quantity");

    Quantity q2 = subtrahend as Quantity;
    if (dimensions != q2.dimensions) {
      throw new DimensionsException('''Can't subtract Quantities having different 
        dimensions:  $dimensions and ${q2.dimensions}''');
    }

    Number newValueSI = valueSI - q2.valueSI;
    double diffUr = _calcRelativeCombinedUncertaintySumDiff(this, subtrahend as Quantity, newValueSI);

    if (dynamicQuantityTyping) {
      return dimensions.toQuantity(valueSI - q2.valueSI, null, diffUr);
    } else {
      return new MiscQuantity(valueSI - q2.valueSI, dimensions, diffUr);
    }
  }

  /// Returns the product of this quantity and [multiplier], which is expected
  /// to be either a Quantity, num or Number object.  All other
  /// types will cause a QuantityException to be thrown.
  ///
  /// * This Quantity object is unaffected.
  /// * The uncertainty of the resulting product Quantity
  /// is equal to the relative combined standard uncertainty,
  /// defined as the square root of the sum of the squares of the two
  /// quantities' relative standard uncertainties.  If [multiplier] is numeric
  /// the uncertainty is unchanged.
  ///
  Quantity operator *(dynamic multiplier) {
    // Product uncertainty
    double productUr = _ur;

    // Product value
    Number productValue;

    // Product dimensions
    Dimensions productDimensions = dimensions;

    // Branch on Quantity, num, Number
    if (multiplier is Quantity) {
      Quantity q2 = multiplier;
      productDimensions = dimensions * q2.dimensions;
      productValue = valueSI * q2.valueSI;
      productUr = (_ur != 0.0 || q2._ur != 0.0) ? Math.sqrt(_ur * _ur + q2._ur * q2._ur) : 0.0;
    } else if (multiplier is num || multiplier is Number) {
      productValue = valueSI * multiplier;
    } else {
      throw new QuantityException("Expected a Quantity, num or Number object");
    }

    if (dynamicQuantityTyping) {
      return productDimensions.toQuantity(productValue, null, productUr);
    } else {
      return new MiscQuantity(productValue, productDimensions, productUr);
    }
  }

  /// Returns the quotient of this quantity and [divisor],
  /// including both value and dimensions.
  ///
  /// * This Quantity object is unaffected.
  /// * If the uncertainty of the resulting product Quantity is calculated it
  /// will be equal to the relative combined standard uncertainty, which is
  /// defined as the square root of the sum of the squares of the two quantities'
  /// relative standard uncertainties.
  ///
  Quantity operator /(dynamic divisor) {
    if (divisor is Quantity) {
      return this * divisor.inverse();
    } else if (divisor is num || divisor is Number) {
      var resultValue = valueSI / divisor;
      if (dynamicQuantityTyping) {
        return dimensions.toQuantity(resultValue, null, _ur);
      } else {
        return new MiscQuantity(resultValue, dimensions, _ur);
      }
    } else {
      throw new QuantityException("Expected a Quantity, num or Number object");
    }
  }

  /// Returns this Quantity raised to the power of [exponent].
  ///
  /// * This Quantity object is unaffected.
  /// * If the combined relative standard uncertainty of the resulting product
  ///  Quantity is calculated it will be equal to the exponent times the
  ///  relative standard uncertainty of this Quantity.
  ///
  /// See [NIST Reference on Constants, Units, and Uncertainty: Combining uncertainty components](http://physics.nist.gov/cuu/Uncertainty/combination.html)
  ///
  Quantity operator ^(dynamic exponent) {
    if (exponent == 1) return this;
    if (exponent == 0) {
      if (valueSI == 0) return new Scalar(value: Double.NaN);
      return Scalar.one;
    }

    if (exponent is num) {
      return (dimensions ^ exponent).toQuantity(valueSI ^ exponent, null, _ur * exponent);
    } else if (exponent is Number) {
      return (dimensions ^ exponent.toDouble()).toQuantity(valueSI ^ exponent, null, _ur * exponent.toDouble());
    } else if (exponent is Scalar) {
      return (dimensions ^ exponent.valueSI.toDouble())
          .toQuantity(valueSI ^ exponent, null, _ur * exponent.valueSI.toDouble());
    }

    throw new QuantityException("Cannot raise a quantity to a non-numeric power");
  }

  /// The unary minus operator returns a Quantity whose value
  /// is the negative of this Quantity's value.
  ///
  Quantity operator -() => dimensions.toQuantity(valueSI * -1, preferredUnits, _ur);

  /// Returns a [Quantity] that represents the square root of this Quantity,
  /// in terms of both value and dimensions (for example, if this Quantity were an
  /// Area of 16 square meters, a Length of 4 meters will be returned).
  ///
  Quantity sqrt() => this ^ (0.5);

  /// Determines the inverse of the quantity represented by this object,
  /// creating and returning a new Quantity object (which may have different
  /// dimensions and therefore be of a different type).  This object is not
  /// modified.
  ///
  /// * Inversion occurs when a Quantity is divided into 1 and is
  /// accomplished by simply inverting the dimensions and dividing the SI MKS value
  /// into 1.0.
  /// * The relative standard uncertainty is unchanged by inversion.
  ///
  Quantity inverse() => dimensions.inverse().toQuantity(valueSI.reciprocal(), null, _ur);

  /// Determines whether on not this Quantity is less than a specified Quantity by
  /// comparing their MKS values.  The two Quantities need not be of the same
  /// type or dimensions.
  ///
  bool operator <(Quantity other) => compareTo(other) < 0;

  /// Determines whether on not this Quantity is less than or equal to a
  /// specified Quantity by comparing their MKS values.  The two Quantities
  /// need not be of the same type or dimensions.
  ///
  bool operator <=(Quantity other) => compareTo(other) <= 0;

  /// Determines whether on not this Quantity is greater than a specified Quantity by
  /// comparing their MKS values.  The two Quantities need not be of the same
  /// type or dimensions.
  ///
  bool operator >(Quantity other) => compareTo(other) > 0;

  /// Determines whether on not this Quantity is greater than or equal to a specified
  /// Quantity by comparing their MKS values.  The two Quantities need not be of
  /// the same type or dimensions.
  ///
  bool operator >=(Quantity other) => compareTo(other) >= 0;

  /// Returns true if this Quantity is equal to [obj].  Two Quantity
  /// objects are considered equal if their MKS values and dimensions are equal.
  /// Only values and dimensions are considered; other attributes such as
  /// uncertainty and preferred units are ignored.
  ///
  /// Scalar quantities are also considered equal to num and Number objects
  /// with matching values.
  ///
  @override
  bool operator ==(Object obj) {
    if (obj == null) return false;

    if (this is Scalar && (obj is num || obj is Number)) return valueSI == obj;

    if (obj is! Quantity) return false;
    if (!(dimensions == (obj as Quantity).dimensions)) return false;
    return (compareTo(obj) == 0);
  }

  /// The hash code is based on the value and dimensions.
  ///
  /// Uncertainty and preferred units are not considered.
  ///
  @override
  int get hashCode => hashObjects([valueSI, dimensions]);

  /// Compares this Quantity to [q2] by comparing MKS values.  The
  /// Quantities need not have the same dimensions.
  ///
  /// Returns a negative integer, zero, or a positive integer as this Quantity is
  /// less than, equal to, or greater than [q2].
  ///
  @override
  int compareTo(dynamic q2) {
    if (q2 is! Quantity)
      throw new QuantityException("A Quantity cannot be compared to anything besides another Quantity");
    return valueSI.compareTo((q2 as Quantity).valueSI);
  }

  /// Returns the value of this quantity in standard MKS
  /// (or meter-kilogram-second) units.
  ///
  Number get mks => valueSI;

  /// Returns the value of this quantity in alternative CGS
  /// (or centimeter-gram-second) units.  MKS (meter-kilogram-second) units are
  /// preferred.
  ///
  /// Although CGS units were once commonly used and contended for the role
  /// of standard units, their use is now discouraged in favor of the adopted
  /// standard MKS (or meter-kilogram-second) units.
  ///
  /// See [get mks].
  ///
  Number get cgs {
    Number value = valueSI;

    // Adjust for centimeters vs. meters
    num lengthExp = dimensions.getComponentExponent(Dimensions.baseLengthKey);
    value *= Double.hundred ^ lengthExp;

    // Adjust for grams vs. kilograms
    num massExp = dimensions.getComponentExponent(Dimensions.baseMassKey);
    value *= Double.thousand ^ massExp;

    return value;
  }

  /// Gets the Quantity's value in the specified [units].  If units is null,
  /// the MKS value is returned.  If not null, [units] must have dimensions
  /// compatible with this Quantity or a DimensionsException will be thrown.
  ///
  Number valueInUnits(Units units) {
    if (units == null) {
      return mks;
    } else {
      // First check for compatible dimensions
      if (units is Quantity && (units as Quantity).dimensions == dimensions) {
        return units.fromMks(valueSI);
      } else {
        throw new DimensionsException("Cannot retrieve quantity value using units with incompatible dimensions");
      }
    }
  }

  /// Gets the Quantity's value in the Quantity's current preferred units.

  /// ### Notes:
  ///  (1) The value is returned as a Number object, which will be either a
  /// BigDecimal (if the Quantity's value is stored internally in arbitrary
  /// precision) or a Double object.
/*
    Number
   getValueInPreferredUnits()

{
   Units prefUnits = getPreferredUnits();
   if(altValueSI == null) { return new Double(prefUnits.fromMKS(valueSI));
   } else { return prefUnits.fromMKS(altValueSI);
   }
}
*/

/**
   Sets the Quantity's value in the preferred units.

   ### Notes:
   (1) If the Quantity object is currently in an immutable state then an
   ImmutableQuantityException (a RuntimeException) is thrown.
   (2) If the passed value is of type BigDecimal, a local copy is made to
   prevent any accidental adjustment of the Quantity's value.
   (3) If the passed value is a BigInteger, a new BigDecimal is created that
   represents the same value and used internally for all further calculations.
   (4) If the passed value is some other Number object besides BigDecimal or
   BigInteger, its double value is extracted and used internally for all
   further calculations.

   * @param value the desired value
*/

/*
    void
   setValueInPreferredUnits(Number value)

{
   Units prefUnits = getPreferredUnits();

   if(immutable) throw new ImmutableQuantityException("In Quantity.setValueInPreferredUnits",this);

   if(value instanceof BigDecimal)
   {
      altValueSI = prefUnits.toMKS((BigDecimal) value);
   }
   else if(value instanceof BigInteger)
   {
      BigDecimal bd = new BigDecimal((BigInteger) value);
      altValueSI = prefUnits.toMKS(bd);
   }
   else
   {
      valueSI = prefUnits.toMKS(value.doubleValue());
      altValueSI = null;
   }

   if(_listeners != null) _fireValueChanged();
}
*/

/**
   Returns a list of available units (Units objects) for a specific
   quantity type.

   ### Notes:
   (1) MKS units should always be the first entry

   * @return List of Units objects appropriate for specific Quantity type
*/
/*


    abstract List
   getAllUnits();

*/

  /**
   * The preferred units for display.
   *
  Units get preferredUnits {

    if(preferredUnits != null) {
      return preferredUnits;
    } else {
      // Get all of the SI units for this Quantity
      List<Units> allUnits = getAllUnits(this.runtimeType,false);

      // Just take the first one in the list
      if(allUnits.length > 0) return allUnits[0];
    }

    // If there are no units (e.g., for a MiscQuantity) construct from
    // Dimensions.
    List units = new List();
    List exps = new List();

    if(dimensions != null) {
      Number aosDim = dimensions.getComponentExponent(Dimensions.AMOUNT);
      Number angleDim = dimensions.getComponentExponent(Dimensions.ANGLE);
      Number currentDim = dimensions.getComponentExponent(Dimensions.CURRENT);
      Number intensityDim = dimensions.getComponentExponent(Dimensions.INTENSITY);
      Number lengthDim = dimensions.getComponentExponent(Dimensions.LENGTH);
      Number massDim = dimensions.getComponentExponent(Dimensions.MASS);
      Number solidAngleDim = dimensions.getComponentExponent(Dimensions.SOLID_ANGLE);
      Number tempDim = dimensions.getComponentExponent(Dimensions.TEMPERATURE);
      Number timeDim = dimensions.getComponentExponent (Dimensions.TIME);

      if(aosDim != 0.0)
      {
         units.add(AmountOfSubstance.MOLES);
         exps.add(aosDim);
      }

      if(angleDim != 0.0)
      {
         units.add(Angle.RADIANS);
         exps.add(angleDim);
      }

      if(currentDim != 0.0)
      {
         units.add(ElectricCurrent.AMPERES);
         exps.add(currentDim);
      }

      if(intensityDim != 0.0)
      {
         units.add(LuminousIntensity.CANDELAS);
         exps.add(intensityDim);
      }

      if(lengthDim != 0.0)
      {
         units.add(Length.METERS);
         exps.add(lengthDim);
      }

      if(massDim != 0.0)
      {
         units.add(Mass.KILOGRAMS);
         exps.add(massDim);
      }

      if(solidAngleDim != 0.0)
      {
         units.add(SolidAngle.STERADIANS);
         exps.add(solidAngleDim);
      }

      if(tempDim != 0.0)
      {
         units.add(TemperatureInterval.KELVINS);
         exps.add(tempDim);
      }

      if(timeDim != 0.0)
      {
         units.add(Time.SECONDS);
         exps.add(timeDim);
      }
    }


    return new Units.one(units, exps);
  }*/

  /**
   * Sets the preferred units for display to [units]. If the units do not
   * have dimensions compatible with this [Quantity] a [DimensionsException]
   * will be thrown; if null the current preferred units will be cleared.
  *
  set preferredUnits(Units units) {
    if(units == null) {
      preferredUnits = null;
      return;
    }

    // Check for appropriate units, if necessary
    if(!(dimensions == units.dimensions)) {
      throw new DimensionsException("Units do not have proper dimension for "
         "this Quantity:  $dimensions vs. ${units.dimensions}");
    }

    preferredUnits = units;
  }
*/

/**
   Subclasses that wish to have their superclass's units disregarded, should
   override this method and return true.  This method is called by getAllUnits().

   * @return ignore superclass units (true) or include them (false)
*/

  /**
     Returns a list of all units available for a particular quantity type.
     The specified type is searched for any Units objects.

     ### Notes:
     (1) The list will be ordered as follows:

     <ul>
     <li>units that have a conversion value of 1.0 (i.e., base units)
     <li>other units found in the main class
     <li>if siOnly is false, other units found in a sister class (defined as
     having the same package prefix as the specified class plus ".constant."
     plus the same name, only capitalized; for example, the sister class of
     com.nanotitan.nvisualizer.quantity.Mass is com.nanotitan.nvisualizer.quantity.constant.MASS).
     </ul>

     (2) The units are discovered using Java's class reflection methods.

     * @param c the class to search for available Units; the class should
                be derived from Quantity and implement QuantityType, although this
                is not strictly necessary
     * @param siOnly whether (true) or not (false) to include only units that
                     are part of the SI (International System of Units) and those
                     considered acceptable for use with the SI; true will return
                     only units found directly in the specified class (assumed
                     to be SI or SI-acceptable units); false will
                     cause units stored in the class's sister constant class to be
                     included as well (e.g., if class is Length then the
                     com.nanotitan.nvisualizer.quantity.constant.LENGTH class will to be examined for
                     additional units)
  *
  static List<Units> getAllUnits(Type c, bool siOnly, bool ignoreSuperUnits) {
    List<Units> list = new List<Units>();

    reflect()

   Field[] fields = c.getDeclaredFields();
   Units baseMetricUnits = null;

   // Declared fields go first
   for(int i=0; i<fields.length; i++)
   {
      try
      {
         if(Units.isAssignableFrom(fields[i].getType()))
         {
            Units u = (Units) fields[i].get(null);

            double conv = u.toMKS(1.0);
            if(conv == 1.0) { list.add(0,u);
            } else { list.add(u);
            }
            if(u.isMetricBase()) baseMetricUnits = u;
         }
      }
      catch(e)
      {
         // ?
      }
   }


   // Inherited fields follow
   if(ignoreSuperUnits() == false)
   {
      Class superClass = c.getSuperclass();
      if(superClass != null && (superClass.equals(Quantity) == false))
      {
         Field[] inheritedFields = superClass.getFields();
         for(int i=0; i<inheritedFields.length; i++)
         {
            try
            {
               if(Units.isAssignableFrom(inheritedFields[i].getType()))
               {
                  Units u = (Units) inheritedFields[i].get(null);

                  double conv = u.toMKS(1.0);
                  if(conv == 1.0)
                  {
                     // Put at index 0 or 1 slot
                     if(list.size() == 0) { list.add(u);
                     } else
                     {
                        Units u0 = (Units) list.get(0);
                        if(u.toMKS(1.0) == 1.0) { list.add(1,u);  // second place
                        } else { list.add(0,u);
                        }  // first place
                     }
                  }
                  else { list.add(u);
                  }
               }
            }
            catch(e)
            {
               // ?
            }
         }
      }
   }


   // DONE, if siOnly
   if(siOnly)
   {
      // add derived metric units
      if(baseMetricUnits != null)
      {
         List<Units> allDerived = baseMetricUnits.getAllDerivedUnits();
         allDerived.remove(0);  // lop off duplicate metric base
         //list.addAll(allDerived);

         // Add all... but disallow doubles (some common metric units may be
         // defined explicitly for a specific Quantity type, e.g., KILOMETERS)
         int numDerived = allDerived.length;
         for(int n=0; n<numDerived; n++) {
            if(list.contains(allDerived.[n]) == false) list.add(allDerived[n]);
         }
      }

      return list;
   }


   // See if there is a CONSTANTS sister class (same name, ALL CAPS, with
   // underscores inserted between words)
   String className = c.getName();
   int lastDot = className.lastIndexOf('.');
   String prefix = className.substring(0,lastDot+1);
   StringBuffer shortClassBuffer = new StringBuffer(className.substring(lastDot+1));

   int scbLength = shortClassBuffer.length();
   for(int n=scbLength-1; n>0; n--)
   {
      char ch = shortClassBuffer.charAt(n);
      if(Character.isUpperCase(ch))
      {
         // insert an underscore
         shortClassBuffer.insert(n,'_');
      }
   }


   String sisterClassName = "$prefix constant." + shortClassBuffer.toString().toUpperCase();

   try
   {
      Class sisterClass = Class.forName(sisterClassName);

      Field[] fields2 = sisterClass.getFields();
      Units u2 = null;
      for(int j=0; j<fields2.length; j++)
      {

         if(Units.isAssignableFrom(fields2[j].getType()))
         {
            u2 = (Units) fields2[j].get(null);
            if(list.contains(u2) == false) list.add(u2);

            if(u2.metricBase) {
               List<Units> derivedList = u2.getAllDerivedUnits();
               int numDerived = derivedList.size();
               Units u3 = null;
               for(int k=0; k<numDerived; k++) {
                  u3 = derivedList[k];
                  if(list.contains(u3) == false) list.add(u3);
               }
            }
         }
      }
   } on Exception {
      // No sister class found.  That's OK... move on
   }


   // add derived metric units
   if(baseMetricUnits != null) {
      List<Units> allDerived = baseMetricUnits.getAllDerivedUnits();
      allDerived.remove(0);  // lop off duplicate metric base
      //list.addAll(allDerived);

      // Add all... but disallow doubles (some common metric units may be
      // defined explicitly for a specific Quantity type, e.g., KILOMETERS)
      int numDerived = allDerived.length;
      for(Units derivedUnits in allDerived) {
         if(!list.contains(derivedUnits)) list.add(derivedUnits);
      }
   }

   return list;
}





  List<String> getAllUnitNames(Type c, bool siOnly) {
    List<Units> unitsList = Quantity.getAllUnits(c,siOnly);
    if(unitsList != null) {
       List<String> strArray = [];
       for(Units units in unitsList) {
        strArray.add(units.name);
       }

       return strArray;
    }

    return new List<String>();
  }


*/

  /// Appends a String representation of this [Quantity] to the [buffer]
  /// using the preferred units and number format.  If no preferred units have
  /// been specified, then MKS units are used.  Uncertainty in the value of the
  /// Quantity is optionally shown as a plus/minus value in the same units.
  ///
  void outputText(StringBuffer buffer, {bool showUncert: false, bool symbols: true, NumberFormat numberFormat}) {
    if (preferredUnits != null) {
      Number val = preferredUnits.fromMks(mks);

      // Format the number
      //NumberFormat format = numberFormat;
      //if (numberFormat == null) format = new NumberFormatSI();
      //if (numberFormat == null) format = new NumberFormat.decimalPattern();
      var valStr = numberFormat?.format(val) ?? "$val";

      // Get the units string (singular or plural, as appropriate)
      String unitStr = null;
      if (symbols) {
        unitStr = preferredUnits.getShortestName(val.abs() <= 1.0);
        //unitStr = preferredUnits.getShortestDialogName(true);
      } else {
        if (val.abs() <= 1.0) {
          unitStr = preferredUnits.singular;
        } else {
          unitStr = preferredUnits.name;
        }
      }

      buffer.write(valStr);

      if (unitStr != null && !(unitStr == "1")) {
        buffer.write(" ");
        buffer.write(unitStr);
      }
    } else {
      // couldn't find any preferred units
      buffer.write(mks);
      buffer.write(" [MKS]");
    }
  }

  /// Returns a String representation of this [Quantity] using the
  /// [preferredUnits].
  ///
  /// If no preferred units have been specified, then MKS units are used.
  ///
  String toString() {
    var buffer = new StringBuffer();
    outputText(buffer);
    return buffer.toString();
  }

  /// Support [dart:json] stringify.
  ///
  Map<String, dynamic> toJson() {
    Map<String, dynamic> m = <String, dynamic>{};

    // Use value in preferred units, if available, for
    // better readability

    if ((preferredUnits != null)) {
      m["value"] = valueInUnits(preferredUnits).toJson();
      m["prefUnits"] = preferredUnits.name;
    }

    // Only include non-zero relative uncertainty
    if (_ur != 0.0) m["ur"] = _ur;

    return m;
  }
}

// --------------------------------------------------------------------
// Top level functions
// --------------------------------------------------------------------

double _calcRelativeCombinedUncertaintySumDiff(Quantity q1, Quantity q2, Number valueSI) {
  if (q1._ur != 0.0 || q2._ur != 0.0) {
    // Standard uncertainty (derive from relative standard uncertainty)
    double u1 = q1._ur * q1.valueSI.abs().toDouble();

    // q2's standard uncertainty (derive from relative standard uncertainty)
    double u2 = q2._ur * q2.valueSI.abs().toDouble();

    // Combined standard uncertainty
    double uc = Math.sqrt(u1 * u1 + u2 * u2);

    // Relative combined standard uncertainty
    return uc / valueSI.abs().toDouble();
  }

  return 0.0;
}
