part of quantity_si;

/// A unit is a particular physical quantity, defined and adopted by
/// convention, with which other particular quantities of the same kind
/// (dimensions) are compared to express their value.
///
/// The Units class respresents a unit and includes a name (plural), an optional
/// intermediate abbreviation, an optional symbol and an optional singular form.
/// A Units object stores a conversion value (to convert a value to SI-MKS units)
/// and dimensions.
///
/// ## Abstract Units Mixin
/// This class is designed to be used as a mixin.  In this way typed units
/// wind up being quantities themselves, extending the associated quantity type
/// and mixing in units to represent themselves as units objects (e.g.,
/// `LengthUnits extends Length with Units`).  This is
/// consistent with the definition of units as quantities with specific values
/// and means also that units object _are quantity objects_ and can be used
/// as quantity parameters.
///
/// ## "Units" vs. "Unit"
/// Precisely speaking, quantities are expressed as multiples of a particular
/// unit (singular, not plural).  However, when the quantity's absolute value is
/// greater than 1, the unit is pluralized when spoken.  For example, one says
/// "five meters," not "five of the meter unit" or something along those lines.
/// Therefore, to make units easier to work with and program, this package calls
/// this class Units and not Unit and defines all static
/// unit objects with plural names (e.g., _meters_ vs. _meter_).  This leads to a
/// more natural expression upon Quantity object creation and value manipulation.
///
abstract class Units {
  String name;
  String singular;
  String _abbrev1;
  String _abbrev2;

  /// Multiply by this value to convert a Quantity in these units to SI-MKS units
  Number _convToMKS;

  bool metricBase = false;
  //final String _sh;
  //final String _shDialog;

  double offset = 0.0;

  // Support for Compound Units
  final List<ExponentialUnits> _units = [];
  //bool _temperatureOffset = false;  // temperature units with non-zero offset

  // String-->Units for efficiency
  //static final Map _parseMap = null;

  /// The Type to which the Units apply
  Type get quantityType;

  /**
   * Constructs new units.
   *
   * * the full [name] of the Units (plural form); should not include
   *   any special characters
   * * [_abbrev1] is an alternative name for the Units (for example, a
   *   non-standard representation); may be null or include special characters.
   * * [_abbrev2] is the standard symbol and shortest representation for the
   *   Units; may include special characters; may be null
   * * the alternate [singular] version of the Unit name is required if
   *   the singular form is more complicated than simply removing a trailing
   *   's'; otherwise optional (may be null)
   * * the conversion factor to SI-MKS Units, [_convToMKS], is required
   * * the [dim]ensions of the Units; Units are Quantities and must have
   *   dimensions
   * * indicate whether or not the Units may serve as a [metricBase]
   *   (that is, if prepending the metric prefixes makes sense)
   *
  Units(this.name, this._abbrev1, this._abbrev2, this.singular,
      conv, Dimensions dim, this.metricBase, [this.offset = 0.0]) :
        this._convToMKS = const Double.constant(1.0),
        super.constant(conv, dim, this,  0.0);
        */

  /**
   * Constructs compile-time constant units.
   *
   * * the full [name] of the Units (plural form); should not include
   *   any special characters
   * * [_abbrev1] is an alternative name for the Units (for example, a
   *   non-standard representation); may be null or include special characters.
   * * [_abbrev2] is the standard symbol and shortest representation for the
   *   Units; may include special characters; may be null
   * * the alternate [singular] version of the Unit name is required if
   *   the singular form is more complicated than simply removing a trailing
   *   's'; otherwise optional (may be null)
   * * the conversion factor to SI-MKS Units, [_convToMKS], is required
   * * the [dim]ensions of the Units; Units are Quantities and must have
   *   dimensions
   * * indicate whether or not the Units may serve as a [metricBase]
   *   (that is, if prepending the metric prefixes makes sense)
   *
  const Units.constant(this.name, this._abbrev1, this._abbrev2, this.singular,
      Number conv, Dimensions dim, this.metricBase) :
        super.constant(conv, dim, null,  0.0);
        */

  /*
  const Units(this.name, this._abbrev1, this._abbrev2, this.singular,
      Number conv, Dimensions dim, this.metricBase, [this.offset=null]) :
        _convToMKS = conv,
        super.constant(conv, dim);
  */

  /**
   * This constructor creates compound units having one component
   * (typically with an exponent not equal to 1).
   *
  Units.one(Units units1, Object exp1) :
    this.compound( [new ExponentialUnits(units1, exp1)] );
*/

  /**
   * This constructor creates compound units having two components.
  *
  Units.two(Units units1, num exp1, Units units2, num exp2) :
    this.compound([
      new ExponentialUnits(units1, exp1),
      new ExponentialUnits(units2, exp2)
    ]);
*/

  /**
   * This constructor creates compound units having three components.
   *
   Units.three(Units units1, num exp1, Units units2, num exp2, Units units3,
      num exp3) :
        this.compound([
          new ExponentialUnits(units1, exp1),
          new ExponentialUnits(units2, exp2),
          new ExponentialUnits(units3, exp3)
        ]);
*/

  /**
   * This constructor creates compound units having four components.
   *
  Units.four(Units units1, Number exp1, Units units2, num exp2, Units units3,
       num exp3, Units units4, num exp4) :
         this.compound([
           new ExponentialUnits(units1, exp1),
           new ExponentialUnits(units2, exp2),
           new ExponentialUnits(units3, exp3),
           new ExponentialUnits(units4, exp4)
         ]);
*/

  /**
   * The general constructor used to create compound units.
   *
   * For compound units having 4 components or fewer, it may be simpler
   * to use one of the convenience constructors.
   *
  Units.compound(List<ExponentialUnits> unitList) {
    //_processCompoundUnits(units);
    if(unitList == null || unitList.isEmpty) return;

    String space = " ";
    String caret = "^";
    String plus = "+";
    Dimensions dim = new Dimensions();

    // Make a local copy of the Units list
    this._units.clear();
    this._units.addAll(unitList);

    // Get a flat list of components (each UWE will have non-compound units)
    List<ExponentialUnits> components = getComponents(true,true);

    // Reorder components so that all positive exponents come before all
    // negative exponents (for full names only; for the proper use of "per")
    List fullNameComponents = new List.from(components);
    int posIndex = 0;
    bool first = true;
    for(ExponentialUnits uwe in fullNameComponents) {
      if(uwe._exp > 0) {
         if(!first) {
            fullNameComponents.remove(uwe);
            fullNameComponents.insert(posIndex, uwe);
         }
         posIndex++;
      }
      if(first) first = false;
   }



   // CONSTRUCT THE FULL NAME, DIMENSIONS AND CONVERSION VALUE
   _convToMKS = Double.ONE;
   bool perUsed = false;
   StringBuffer nameBuffer = new StringBuffer();
   first = true;
   for(ExponentialUnits uwe in fullNameComponents) {
      Units u = uwe._units;
      Number exp = uwe._exp;

      // CONVERSION

      // Disallow temperature in composite units (which screws up the whole
      // composite convToMKS approach due to some of its units containing
      // an offset)
      if(u is TemperatureUnits && (posIndex > 1 || exp != 1))  {
         throw new QuantityException(
             "TemperatureUnits are not supported as part of compound units;"
             " use TemperatureIntervalUnits instead.");
      }

      _convToMKS *= u._convToMKS ^ exp;



      // FULL NAME
      double expValue = exp.toDouble();
      String singularName = u.singular;
      if(num == 1 && expValue == 1.0) singularName = u.name;  // use plural if alone and exponent is one
      String prefix = "per ";
      if(first) prefix = "reciprocal ";  // or "inverse "?

      if(expValue < 0.0 && perUsed == false)
      {
         perUsed = true;
         if(first) nameBuffer.write("reciprocal ");
         else nameBuffer.write("per ");
      }

      double absExp = expValue.abs();

      if(absExp == 1.0) nameBuffer.write(singularName);
      else if(absExp == 2.0)
      {
         // SI convention is to use "squared" as a suffix, except for
         // length units, where "square" may be used as a prefix
         // (e.g., seconds squared, square meters)
         if(Dimensions.determineQuantityType(u.dimensions) == Length) nameBuffer.write("square $singularName");
         else nameBuffer.write("$singularName squared");

      } else if(absExp == 3.0) {
         // SI convention is to use "cubed" as a suffix, except for
         // length units, where "cubic" may be used as a prefix
         // (e.g., seconds cubed, cubic meters)
         if(Dimensions.determineQuantityType(u.dimensions) == Length) nameBuffer.write("cubic $singularName");
         else nameBuffer.write("$singularName cubed");

      } else {
         nameBuffer.write(singularName);
         nameBuffer.write(" to the ");
         if(absExp == 4.0) nameBuffer.write("fourth");
         else if(absExp == 5.0) nameBuffer.write("fifth");
         else if(absExp == 6.0) nameBuffer.write("sixth");
         else if(absExp == 7.0) nameBuffer.write("seventh");
         else if(absExp == 8.0) nameBuffer.write("eighth");
         else if(absExp == 9.0) nameBuffer.write("ninth");
         else if(absExp == 10.0) nameBuffer.write("tenth");
         else if(absExp == 11.0) nameBuffer.write("eleventh");
         else if(absExp == 12.0) nameBuffer.write("twelfth");
         else nameBuffer.write(exp);
      }

      // Tack on a space
      nameBuffer.write(space);


      // DETERMINE THE DIMENSIONS AS WE GO
      dim = u.dimensions ^ exp.toDouble();

      first = false;
   }



   // CONSTRUCT SHORT NAME AND SHORT DIALOG NAME
   StringBuffer shortBuffer = new StringBuffer();
   //StringBuffer shortDialogBuffer = new StringBuffer();
   for(ExponentialUnits uwe in components) {
      Units u = uwe._units;
      num exp = uwe._exp;


      String shortName = u.getShortestName(true);
      //String shortDialog = u.getShortestDialogName(true);

      // Append short
      shortBuffer.write(shortName);
      //shortDialogBuffer.write(shortDialog);

      if(exp.toDouble() != 1.0)
      {
         if(exp.toDouble() >= 0)
         {
            shortBuffer.write(plus);
            //shortDialogBuffer.write(plus);
         }

         if((exp.abs() - exp.round()) < 0.001)
         {
            shortBuffer.write(exp.toInt());
            //shortDialogBuffer.write(exp.toInt());
         }
         else
         {
            shortBuffer.write(exp.toDouble());
            //shortDialogBuffer.write(exp.toDouble());
         }
      }

      shortBuffer.write(space);
      //shortDialogBuffer.write(space);


   }


   // BANK THE RESULTS
   name = nameBuffer.toString().trim();
   singular = name;  // singular & name are identical for compound units
   _abbrev1 = null;
   _abbrev2 = shortBuffer.toString().trim();
   //_shDialog = shortDialogBuffer.toString().trim();
   metricBase = false;

   // Set quantity value & dimensions
   mks = toMks(1.0);
   dimensions = dim;
  }
*/

  /// Two units are considered equal if their conversions to MKS are equal and
  /// theyhave the same singular name.
  ///
  bool operator ==(obj) {
    if (obj == null) return false;
    if (identical(this, obj)) return true;

    if (obj is Units) return (singular == obj.singular && _convToMKS == obj._convToMKS);
    return false;
  }

  int get hashCode => int.parse("${name.hashCode}54321${_convToMKS.hashCode}");

  /*
     Generates name, shortest name, shortest dialog name, singular name,
     dimensions, and conversion to MKS for the compound units contained by the
     units list.

     * The spelling convention for a compound (i.e., derived) unit is usually
     singular in English.  This method follows that convention by using the
     singular form of each component unit when forming the compound unit's name.
     The compound unit's name and singular name are identical.
     * A QuantityException will be thrown if TemperatureUnits are combined with
     other units (or raised to a power).  Use TemperatureIntervalUnits instead in
     such situations.
  <p>
     * @param list an ArrayList containing ExponentialUnitss objects.
  *
  void _processCompoundUnits(List<ExponentialUnits> list) {
   if(list == null) return;

   String space = " ";
   String caret = "^";
   String plus = "+";
   Dimensions dim = new Dimensions();

   // Make a local copy of the Units list
   this._units.clear();
   this._units.addAll(list);

   // Get a flat list of components (each UWE will have non-compound units)
   List<ExponentialUnits> components = getComponents(true,true);

   // Reorder components so that all positive exponents come before all
   // negative exponents (for full names only; for the proper use of "per")
   List fullNameComponents = new List.from(components);
   int posIndex = 0;
   bool first = true;
   for(ExponentialUnits uwe in fullNameComponents) {
      if(uwe._exp > 0) {
         if(!first)
         {
            fullNameComponents.remove(uwe);
            fullNameComponents.insertRange(posIndex, 1, uwe);
         }
         posIndex++;
      }
      if(first) first = false;
   }



   // CONSTRUCT THE FULL NAME, DIMENSIONS AND CONVERSION VALUE
   _convToMKS = Double.ONE;
   bool perUsed = false;
   StringBuffer nameBuffer = new StringBuffer();
   for(ExponentialUnits uwe in fullNameComponents) {
      Units u = uwe._units;
      Number exp = uwe._exp;

      // CONVERSION

      // Disallow temperature in composite units (which screws up the whole
      // composite convToMKS approach due to some of its units containing
      // an offset)
      if(u is TemperatureUnits && (posIndex > 1 || exp != 1))  {
         throw new QuantityException(
             "TemperatureUnits are not supported as part of compound units;"
             " use TemperatureIntervalUnits instead.");
      }

      _convToMKS *= u._convToMKS ^ exp;



      // FULL NAME
      double expValue = exp.toDouble();
      String singularName = u.singularName;
      if(num == 1 && expValue == 1.0) singularName = u.name;  // use plural if alone and exponent is one
      String prefix = "per ";
      if(i == 0) prefix = "reciprocal ";  // or "inverse "?

      if(expValue < 0.0 && perUsed == false)
      {
         perUsed = true;
         if(i == 0) nameBuffer.write("reciprocal ");
         else nameBuffer.write("per ");
      }

      double absExp = expValue.abs();

      if(absExp == 1.0) nameBuffer.write(singularName);
      else if(absExp == 2.0)
      {
         // SI convention is to use "squared" as a suffix, except for
         // length units, where "square" may be used as a prefix
         // (e.g., seconds squared, square meters)
         if(u.determineQuantityType() == Length) nameBuffer.write("square $singularName");
         else nameBuffer.write("$singularName squared");

      } else if(absExp == 3.0) {
         // SI convention is to use "cubed" as a suffix, except for
         // length units, where "cubic" may be used as a prefix
         // (e.g., seconds cubed, cubic meters)
         if(u.getQuantityType() == Length) nameBuffer.write("cubic $singularName");
         else nameBuffer.write("$singularName cubed");

      } else {
         nameBuffer.write(singularName);
         nameBuffer.write(" to the ");
         if(absExp == 4.0) nameBuffer.write("fourth");
         else if(absExp == 5.0) nameBuffer.write("fifth");
         else if(absExp == 6.0) nameBuffer.write("sixth");
         else if(absExp == 7.0) nameBuffer.write("seventh");
         else if(absExp == 8.0) nameBuffer.write("eighth");
         else if(absExp == 9.0) nameBuffer.write("ninth");
         else if(absExp == 10.0) nameBuffer.write("tenth");
         else if(absExp == 11.0) nameBuffer.write("eleventh");
         else if(absExp == 12.0) nameBuffer.write("twelfth");
         else nameBuffer.write(exp);
      }

      // Tack on a space
      nameBuffer.write(space);


      // DETERMINE THE DIMENSIONS AS WE GO
      dim = u.dimensions ^ exp;
   }



   // CONSTRUCT SHORT NAME AND SHORT DIALOG NAME
   StringBuffer shortBuffer = new StringBuffer();
   StringBuffer shortDialogBuffer = new StringBuffer();
   for(ExponentialUnits uwe in components) {
      Units u = uwe._units;
      Number exp = uwe._exp;


      String shortName = u.getShortestName(true);
      String shortDialog = u.getShortestDialogName(true);

      // Append short
      shortBuffer.write(shortName);
      shortDialogBuffer.write(shortDialog);

      if(exp.toDouble() != 1.0)
      {
         if(exp.toDouble() >= 0)
         {
            shortBuffer.write(plus);
            shortDialogBuffer.write(plus);
         }

         if((exp.abs() - exp.round()) < 0.001)
         {
            shortBuffer.write(exp.toInt());
            shortDialogBuffer.write(exp.toInt());
         }
         else
         {
            shortBuffer.write(exp.toDouble());
            shortDialogBuffer.write(exp.toDouble());
         }
      }

      shortBuffer.write(space);
      shortDialogBuffer.write(space);


   }


   // BANK THE RESULTS
   name = nameBuffer.toString();
   name = name.trim();
   singular = name;  // singular & name are identical for compound units
   _abbrev1 = null;
   _abbrev2 = shortBuffer.toString().trim();
   _shDialog = shortDialogBuffer.toString().trim();
   metricBase = false;

   // Set quantity value & dimensions and make immutable
   mks = toMks(1.0);
   dimensions = dim;
}*/

  /// Returns the components of these Units, with options to [fully] decompose
  /// any component Units that are in turn compound Units and [combine]
  /// components having the exact same units.
  ///
  List<ExponentialUnits> getComponents(bool fully, bool combine) {
    if (_units == null) {
      List<ExponentialUnits> list = new List<ExponentialUnits>();

      ExponentialUnits uwe = new ExponentialUnits(this, 1);
      list.add(uwe);

      return list;
    } else {
      List<ExponentialUnits> components = new List<ExponentialUnits>();
      if (fully) {
        for (ExponentialUnits uwe in _units) {
          double exp = uwe._exp;
          List<ExponentialUnits> subComps = uwe._units.getComponents(true, false);
          for (ExponentialUnits uwe2 in subComps) {
            uwe2._exp *= exp;
          }

          components.addAll(subComps);
        }
      } else {
        components = new List<ExponentialUnits>();
        components.addAll(_units);
      }

      if (combine) {
        for (int k = components.length - 1; k > 0; k--) {
          ExponentialUnits uwe = components[k];
          for (int n = 0; n < k; n++) {
            ExponentialUnits uwe2 = components[n];
            if (uwe2._units == uwe._units) {
              uwe2._exp = uwe2._exp + uwe._exp;
              components.remove(k);
              break;
            }
          }
        }

        // Remove any zero exponents
        for (int p = components.length - 1; p > -1; p--) {
          ExponentialUnits uwe = components[p];
          if (uwe._exp == 0.0) components.remove(p);
        }
      }

      return components;
    }
  }

  /// Returns the alternate name for the units.  This may be a non-standard
  /// representation.  If no alternate name exists, then null is returned.
  ///
  String get alternateName => _abbrev1;

  /// Returns the shortest name for the units.  This will be the first non-null name
  /// found when inspecting symbol, alternate name and full name, in that order
  /// (so a non-null symbol will be returned by this method even it is longer than
  /// the alternate name).
  /// @param sing whether (true) or not (false) to return the singular form of
  ///               the full name in the case no suitable symbols/abbreviations are
  ///               available.
  ///
  String getShortestName(bool sing) {
    if (_abbrev2 != null) return _abbrev2;
    if (_abbrev1 != null) return _abbrev1;

    return sing ? singular : name;
  }

  /**
   * Returns the shortest name for the units which will display in Dialog font.
   * This will be the first non-null name found when inspecting symbol, alternate
   * name and full name, in that order (so a non-null symbol will be returned by
   * this method even it is longer than the alternate name).
   *
   * If sing is true, the singular form of the full name will be returned in the
   * case no suitable symbols or abbreviations are available.
   *
  String getShortestDialogName(bool sing) {
    if(sing) {
      String sh = getShortestName(true);
      if(_canDisplayString(sh)) return sh;
      else if(_abbrev1 != null && _canDisplayString(_abbrev1)) return _abbrev1;
      else return singular;
    } else {
      return _shDialog;
    }
  }*/

//TODO UTF-32 values in Dart... plus  maybe these can be displayed now?  MathML?
  bool _canDisplayString(String str) {
    int num = str.length;
    String c;
    for (int i = 0; i < num; i++) {
      c = str[i];

      // Reject ohms, Angstroms and Planck h and hbar symbols
      if ((c == '\u03a9') ||
          (c == '\u2126') ||
          (c == '\u210E') ||
          (c == '\u210F') ||
          (c == '\u00c5') ||
          (c == '\u212b')) {
        return false;
      }
    }

    return true;
  }

  /// Calculates and returns the value in SI-MKS units of the specified [value]
  /// (that is implicitly in these units).
  ///
  /// The method expects [value] to be a num or Number object; any other type will
  /// cause a [QuantityException].
  ///
  Number toMks(value) {
    if (value is num || value is Number) {
      if (offset == 0) return _convToMKS * value;
      return (_convToMKS * value) + objToNumber(offset);
    } else {
      throw new QuantityException("num or Number expected");
    }
  }

  /// Calculates and returns the value in the units represented by this Units
  /// object of [mks] (that is expected to be in SI-MKS units).
  ///
  /// The method accepts a num or Number object; any other type will
  /// cause a [QuantityException].
  ///
  Number fromMks(mks) {
    if (mks is num) {
      if (offset == 0) return (new Double(mks) / _convToMKS);
      return (new Double(mks) / _convToMKS) - objToNumber(offset);
    } else if (mks is Number) {
      if (offset == 0) return (mks / _convToMKS);
      return (mks / _convToMKS) - objToNumber(offset);
    } else {
      throw new QuantityException("num or Number expected");
    }
  }

  /**
   *  Returns a list of units derived from this Units object using metric
   *  prefixes.
   *
   *  1. A copy of this Units object is part of the returned list (1st in list)
   *  2. The overall order is the base unit first followed by the derived
   *  units in order from greatest to least:
   *
   *  * base 10^0
   *  * yotta 10^24,
   *  * zetta 10^21,
   *  * exa 10^18,
   *  * peta 10^15,
   *  * tera 10^12,
   *  * giga 10^9,
   *  * mega 10^6,
   *  * kilo 10^3,
   *  * hecto 10^2,
   *  * deka 10^1,
   *  * deci 10^-1,
   *  * centi 10^-2,
   *  * milli 10^-3,
   *  * micro 10^-6,
   *  * nano 10^-9,
   *  * pico 10^-12,
   *  * femto 10^-15,
   *  * atto 10^-18,
   *  * zepto 10^-21,
   *  * yocto 10^-24.
   *
  List<Units> getAllDerivedUnits() {
    List<Units> list = new List<Units>();

    //if(_sh == null) _sh = getShortestName(false);

    list.add( this.clone() );

    // TimeInstant is special case (no metric prefixes for scale indicators)
    //if(TimeInstant.TimeInstantUnits.class.isAssignableFrom(getClass())) return list;


    list.add(yotta());
    list.add(zetta());
    list.add(exa());
    list.add(peta());
    list.add(tera());
    list.add(giga());
    list.add(mega());
    list.add(kilo());
    list.add(hecto());
    list.add(deka());

    list.add(deci());
    list.add(centi());
    list.add(milli());
    list.add(micro());
    list.add(nano());
    list.add(pico());
    list.add(femto());
    list.add(atto());
    list.add(zepto());
    list.add(yocto());

    return list;
  }
*/

  /// Derive new Units using this Units object as the base.
  Units derive(String fullPrefix, String abbrevPrefix, double conv);

/**
   Returns the Class representing a type of Quantity consistent with these
   Units.  The Quantity type will have Dimensions matching these Units and
   one of its static Units must match these Units.
<p>
   <b>Notes:</b>
   (1) Subclasses should override this method to provide greater efficiency.
   (2) This method will find an appropriate subtype of a Quantity, whereas the
   type returned by the Dimensions.determineQuantityType(Dimensions) method
   will return the first type matching the specified Dimensions.
   (3) Returns MiscQuantity.class if no specific Quantity type containing these
   Units is found.
<p>
   * @return a Class representing a QuantityType that is consistent with these
             Units
*/

/*
    Class
   getQuantityType()

{
   Dimensions dim = getDimensions();
   Class type = Dimensions.determineQuantityType(dim);
   if(type.equals(MiscQuantity.class)) return type;

   List allUnits = Quantity.getAllUnits(type,false);
   int numUnits = allUnits.size();
   int i=0;
   for(i=0; i<numUnits; i++)
   {
      //Units u = (Units) allUnits.get(i);
      //if(this.equals(u)) return type;
      if(this.equals(allUnits.get(i))) return type;
   }

   // Uh oh.  Type returned by Dimensions didn't have our Units in it...
   // look for any other known Quantity type that matches Dimensions of this
   // Units object.  The units might be hiding in a subclass.
   List allTypes = Quantity.getAllQuantityTypes();
   int numTypes = allTypes.size();
   int k=0;
   Quantity q = null;
   for(i=0; i<numTypes; i++)
   {
      Class c = (Class) allTypes.get(i);
      try
      {
         q = (Quantity) c.newInstance();
         //Dimensions qDim = q.getDimensions();
         //if(qDim.equals(dim))
         if(dim.equals(q.getDimensions()))
         {
            allUnits = Quantity.getAllUnits(c,false);
            numUnits = allUnits.size();
            for(k=0; k<numUnits; k++)
            {
               //Units u = (Units) allUnits.get(k);
               //if(this.equals(u)) return c;
               if(this.equals(allUnits.get(k))) return c;
            }
         }
      }
      catch(Exception e)
      {
e.printStackTrace();
         return MiscQuantity.class;
      }
   }

   // OK. Didn't find it specifically anywhere.  But it could still be
   // a match for the first type we found... possibly a derived unit.  Just
   // return that.
   return type;
}
*/

  /// Returns the derived Units having the 10^24 prefix, yotta (Y).
  Units yotta() => derive("yotta", "Y", 1.0e24);

  /// Returns the derived Units having the 10^21 prefix, zetta (Z).
  Units zetta() => derive("zetta", "Z", 1.0e21);

  /// Returns the derived Units having the 10^18 prefix, exa (E).
  Units exa() => derive("exa", "E", 1.0e18);

  /// Returns the derived Units having the 10^15 prefix, peta (P).
  Units peta() => derive("peta", "P", 1.0e15);

  /// Returns the derived Units having the 10^12 prefix, tera (T).
  Units tera() => derive("tera", "T", 1.0e12);

  /// Returns the derived Units having the 10^9 prefix, giga (G).
  Units giga() => derive("giga", "G", 1.0e9);

  /// Returns the derived Units having the 10^6 prefix, mega (M).
  Units mega() => derive("mega", "M", 1.0e6);

  /// Returns the derived Units having the 10^3 (i.e., 1000) prefix, kilo (k).
  Units kilo() => derive("kilo", "k", 1.0e3);

  ///  Returns the derived Units having the 10^2 (i.e., 100) prefix, hecto (h).
  Units hecto() => derive("hecto", "h", 1.0e2);

  /// Returns the derived Units having the 10^1 (i.e. 10) prefix, deka (da).
  Units deka() => derive("deka", "da", 1.0e1);

  /// Returns the derived Units having the 10^-1 (i.e., 0.1) prefix, deci (d).
  Units deci() => derive("deci", "d", 1.0e-1);

  /// Returns the derived Units having the 10^-2 (i.e., 0.01) prefix, centi (c).
  Units centi() => derive("centi", "c", 1.0e-2);

  /// Returns the derived Units having the 10^-3 (i.e., 0.001) prefix, milli (m).
  Units milli() => derive("milli", "m", 1.0e-3);

  /// Returns the derived Units having the 10^-6 prefix, micro (the symbol mu).
  Units micro() => derive("micro", "\u00b5", 1.0e-6);

  /// Returns the derived Units having the 10^-9 prefix, nano (n).
  Units nano() => derive("nano", "n", 1.0e-9);

  /// Returns the derived Units having the 10^-12 prefix, pico (p).
  Units pico() => derive("pico", "p", 1.0e-12);

  /// Returns the derived Units having the 10^-15 prefix, femto (f).
  Units femto() => derive("femto", "f", 1.0e-15);

  /// Returns the derived Units having the 10^-18 prefix, atto (a).
  Units atto() => derive("atto", "a", 1.0e-18);

  /// Returns the derived Units having the 10^-21 prefix, zepto (z).
  Units zepto() => derive("zepto", "z", 1.0e-21);

  /// Returns the derived Units having the 10^-24 prefix, yocto (y).
  Units yocto() => derive("yocto", "y", 1.0e-24);

  /// Returns a String representation of the Units in the following format:
  ///
  ///    full name [MKS value]
  ///
  String toString() {
    //String mksStr = super.toString();
    return name + " [${_convToMKS}]";
  }

  /**
   *  Parses a String into a Units object.  The parsing rules that this method
   *  follows are:
   *
   *  * Each unit subcomponent must match either the full name (plural or
   *      singular), symbol or alternate abbreviation of one of the Units of
   *      the Quantity types known to the system (as returned by the method
   *      Quantity.getAllQuantityTypes())
   *  * Any number is considered to be an exponent of the preceeding unit
   *      symbol or name
   *  * Whitespace of any kind is used to tokenize the input String; whitespace
   *      between units symbols/names and exponents will be ignored
   *  * Carets are recognized as indicating exponents, but are not necessary;
   *      any number (e.g. -2 or +3 or just 3) will be interpreted as an
   *      exponent of the preceeding units symbol/name
   *  * Metric prefixes are only considered legal for metric base units
   *      (e.g., km or kilometers will work; kilomiles will not)
   *  * Parentheses, brackets, braces and the like are ignored
   *  * "per" and "/" indicate <b>ALL</b> the following unit exponent will be
   *      multiplied by -1; multiple instances of "per" and/or "/" in a line will
   *      result in successive implicit multiplications by -1 of all the exponents
   *      that follow
   *  * "inverse" indicates the following unit exponent will be multiplied by -1
   *  * "reciprocal" indicates the following unit exponent will be multiplied by -1
   *  * "square" indicates the following unit exponent will be multiplied by 2
   *  * "squared" indicates the preceeding unit exponent will be multiplied by 2
   *  * "cubic" indicates the following unit exponent will be multiplied by 3
   *  * "cubed" indicates the preceeding unit exponent will be multiplied by 3
   *  * "to the *" or "to the power of *" where * is either "first", "second",
   *  "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "one",
   *  "two", "three", "four", "five", "six", "seven", "eight", "nine" or a
   *  number indicates the preceeding unit exponent will be multiplied by the
   *  appropriate number.  "to the minus *" and "to the negative *", similarly,
   *  indicate that the preceeding unit exponent will be multipled by the negative
   *  of the number.
   *  * Multiword units are not recognized; use the symbol, if available, instead
   *  * A failure to recognize any portion of the input String will result
   *      in an Exception being thrown
   *  * Note that the non-metric unit "mils" is both an Angle unit and a Length unit;
   *      its use is discouraged; if used, this method's output will be indeterminate
   *  </ul>
   *
   *  Examples of valid entries (all for meters per second squared) are:
   *
   *  * m s-2
   *  * meters per second squared
   *  * meter / square s
   *  * m^+1 s^-2
   */
  //TODO restore parse
  /*
  static Units parse(String unitsStr) {
    // Check to see if it's already been parsed
    if(parseMap != null) {
      Object obj = parseMap.get(unitsStr);
      if(obj is Units) return (obj as Units);
    }

    List uweList = [];

    Units lastUnits = null;
    double exp = 1.0;
    double implicitExp = 1.0;

    // Pre-process:  put spaces around '/', '*' and in front of
    // '-', and any digit (if previous character was not a digit) and replace
    // '^' and "+" with spaces.
    bool lastCharDigit = false;
    StringBuffer buffer = new StringBuffer();
    //int len = unitsStr.length;
    for(int c in unitsStr.runes) {
      //int c = unitsStr.charCodeAt(i);
      if(   (c == '/'.codeUnitAt(0))  ||
            (c == '*')        ) {
        buffer.write(" ");
        buffer.write(c);
        buffer.write(" ");
         lastCharDigit = false;
      } else if(c == '-') {
        buffer.write(" ");
        buffer.write(c);
         lastCharDigit = true;
      } else if( (c == '^')  ||
               (c == '+')  ||
               (c == '.')      ) {
        buffer.write(" ");
         lastCharDigit = false;
      } else if(Character.isDigit(c) && lastCharDigit == false) {
        buffer.write(" ");
        buffer.write(c);
         lastCharDigit = true;
      } else if(Character.isDigit(c) && lastCharDigit == true) {
        buffer.write(c);
         lastCharDigit = true;
      } else {
        buffer.write(c);
         lastCharDigit = false;
      }
    }

    String str = buffer.toString();

    // Preprocess:  eliminate multiple spaces
    int index = 0;
    while(index != -1) {
      index = str.indexOf("  ");
      if(index != -1) preBuffer.replace(index, index+2," ");
      str = str.replaceAll("  ", " ");
    }



    // Preprocess:  replace first, second, third, etc. with number
    str = str.replaceAll(" first", " 1");

    // Since second is a unit name, add extra protection
    str = str.replaceAll(" to the second", " 2");
    str = str.replaceAll(" to the minus second", " -2");

    str = str.replaceAll(" third", " 3");
    str = str.replaceAll(" fourth", " 4");
    str = str.replaceAll(" fifth", " 5");
    str = str.replaceAll(" sixth", " 6");
    str = str.replaceAll(" seventh", " 7");
    str = str.replaceAll(" eighth", " 8");
    str = str.replaceAll(" ninth", " 9");

    // Preprocess:  replace one, two, three, etc. with number
    str = str.replaceAll(" one", " 1");
    str = str.replaceAll(" two", " 2");
    str = str.replaceAll(" three", " 3");
    str = str.replaceAll(" four", " 4");
    str = str.replaceAll(" five", " 5");
    str = str.replaceAll(" six", " 6");
    str = str.replaceAll(" seven", " 7");
    str = str.replaceAll(" eight", " 8");
    str = str.replaceAll(" nine", " 9");



    // Replace "minus " and "negative " with "-" (note deletion
    // of trailing space so that the minus sign will be adjacent to the number)
    str = str.replaceAll("minus ", "-");
    str = str.replaceAll("negative ", "-");
    str = str.replaceAll("neg ", "-");


    // Remove any remaining " to ",  " to the " and " power of "
    str = str.replaceAll(" power of ", " ");
    str = str.replaceAll(" to the ", " ");
    str = str.replaceAll(" to ", " ");





    // USE THE PREPROCESSED STRING
    String origUnitsStr = unitsStr;
    unitsStr = str;


    // TOKENIZE -- create list of tokens (need to check doubles before singles...
    // e.g., degrees Celsius, before degrees)
    //TODO use String.splitMapJoin
    List tokenList = new List();
    StringTokenizer st = new StringTokenizer(unitsStr,"\r\n\t ()[]{}<>,.?!;:'\"\\=|~`@#$%&_");
    while(st.hasMoreTokens()) {
      tokenList.add(st.nextToken());
    }

    String nextToken = null;
    for(String token in tokenList) {
      // See if it's an exponent on its own
      if(token.startsWith("+") || token.startsWith("-") || token.startsWith("^")) {
        if(lastUnits == null) throw new QuantityException("Cannot parse units "
            "string:  exponent must follow a units symbol or name");

        // "+" "-" or "^" separated from number by whitespace
        if(token.length == 1) {
          if(st.hasMoreTokens() == false) throw new QuantityException(
               "Cannot parse units string due to trailing $token");


          String t2 = st.nextToken();
          //TODO isDigit
          if(Character.isDigit(t2[0]) == false) throw new QuantityException(
               "Cannot parse units string:  expected number after $token");

          exp = double.parse(t2);
          if(token.equals("-")) exp *= -1.0;
        } else {
          exp = double.parse(token.substring(1));
          if(token.startsWith("-")) exp *= -1.0;
       }

       ExponentialUnits uwe = uweList[uweList.length-1];
       uwe._exp *= exp;

       // Reinit for next units
       exp = 1.0;
     }


     // Exponent without any +, - or ^ prefix
     else if(Character.isDigit(token.charAt(0))) {
         if(lastUnits == null) throw new QuantityException("Cannot parse units " +
            "string:  exponent must follow a units symbol or name");
         else {
            exp *= double.parse(token);

            ExponentialUnits uwe = uweList[uweList.length-1];
            uwe._exp *=  exp;
         }

         // Reinit for next units
         exp = 1.0;
      }


      // Preceding qualifiers
      //else if(token.equals("per")) exp *= -1.0;
      else if(token == "per") implicitExp *= -1.0;
      else if(token == "/") implicitExp *= -1.0;
      else if(token.equals("*")) exp *= 1.0;
      else if(token.equals("x")) exp *= 1.0;
      else if(token.equals("inverse")) exp *= -1.0;
      else if(token.equals("reciprocal")) exp *= -1.0;
      else if(token.equals("square")) exp *= 2.0;
      else if(token.equals("cubic")) exp *= 3.0;


      // Following qualifiers
      else if(token.equals("squared") || token.equals("cubed"))
      {
         double postFactor = 1.0;
         if(token.equals("squared")) postFactor *= 2.0;
         else if(token.equals("cubed")) postFactor *= 3.0;

         // Adjust the UWE already in the list
         if(uweList.isEmpty)
         {
            throw new QuantityException(
               "Cannot parse units string:  following qualifier (" + token + " without units name");
         }

         ExponentialUnits uwe = uweList[uweList.length-1];
         uwe._exp *= postFactor;
      }


      // Must be a units symbol or name... see if we can find it
      else {
        Units u = null;

        // TRY DOUBLE WORD FIRST (e.g., degrees Celsius)

        // need to know what next token is too (for doubles like degrees Celsius)
        if (i < (tokenList.length - 1)) {
           nextToken = tokenList[i + 1];
        } else {
          nextToken = null;
        }
        if(nextToken != null){
          u = Units.getUnitsByName(null,token + " " + nextToken);

          // make sure the next token is skipped since it was used
          if(u != null) i++;
        }

        // no double found, try just the single token
        if(u == null) {
          u = Units.getUnitsByName(null, token);
        }

        if(u != null) {
          Units u2 = new Units(u,new Double(exp * implicitExp));
          uweList.add(u2.getComponents(false,false)[0]);
          lastUnits = u;
        } else {
          throw new QuantityException(
               "Cannot parse units string:  unknown units name,  " + token);
        }

        // Reinit exp
        exp = 1.0;
      }
    }


    // That's it!  Create the Units from the list of ExponentialUnits and return
    Units newUnits = new Units(uweList);

    // Keep track of what's already been parsed, for efficiency
    if(parseMap == null) parseMap = new HashMap();
    parseMap.put(origUnitsStr,newUnits);

    return newUnits;
  }
*/

  /**
   *   Searches for units that match either the full name or shortest name (symbol)
   *  of unitStr.  If the type is not specified all known quantity types are searched.
   *  Case is ignored in the full name search (but is important in the symbol search).
   *     * @param type the Class of a Quantity type to search for the units; may be null
   *  * @param unitStr the name of the Units (either full name or symbol) to
   *                   search for; if null, will return null immediately
   */
  //TODO restore getUnitsByName
  /*
  static Units getUnitsByName(String unitStr, [Type type]) {
    if(unitStr == null) return null;

    List<Type> listToCheck;

    if(?type && type != null) {
      //TODO any way to check it's a Quantity type with mirrors?  if(Quantity.class.isAssignableFrom(type)) listToCheck.add(type);
      listToCheck.add(type);
    } else {
      listToCheck.addAll(getAllQuantityTypes());
    }

    List list = null;
    for(Type t in listToCheck) {
      list = Quantity.getAllUnits(t, false);
      for(Units u in list) {
         if(u.name.equalsIgnoreCase(unitStr)) return u;
         if(u.singularName.equalsIgnoreCase(unitStr)) return u;
         if(u.getShortestName(false) == unitStr) return u;  // case is important in symbols
      }
    }

    return null;
  }
*/

  //TODO bug, should be .abs()???
  String unicodeExponent(int exp) {
    String neg = exp < 0 ? "\u{207b}" : "";
    if (exp == 2) {
      return "${neg}\u{00b2}";
    } else if (exp == 3) {
      return "${neg}\u{00b3}";
    }
    //else if(exp.abs() < 10) return "${neg}\u{00b3}";

    //TODO create a static array that holds unicode characters

    //TODO handle 10+, 100+ , 1000+, etc.

    // failed to find appropriate unicode characters
    return exp < 0 ? "-${exp}" : "${exp}";
  }
}
