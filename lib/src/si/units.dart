part of quantity_si;

/// A unit is a particular physical quantity, defined and adopted by
/// convention, with which other particular quantities of the same kind
/// (dimensions) are compared to express their value.
///
/// The Units class represents a unit and includes a name (plural), an optional
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
/// and means also that units objects _are quantity objects_ and can be used
/// as quantity parameters.
///
/// ## 'Units' vs. 'Unit'
/// Precisely speaking, quantities are expressed as multiples of a particular
/// unit (singular, not plural).  However, when the quantity's absolute value is
/// greater than 1, the unit is pluralized when spoken.  For example, one says
/// 'five meters,' not 'five of the meter unit' or something along those lines.
/// Therefore, to make units easier to work with and program, this package calls
/// this class Units and not Unit and defines all static
/// unit objects with plural names (e.g., _meters_ vs. _meter_).  This leads to a
/// more natural expression upon Quantity object creation and value manipulation.
mixin Units {
  /// The name of the units (plural).
  String name;

  /// The name of the units in singular form.
  String singular;

  /// The primary abbreviation for the units.
  String _abbrev1;

  /// A secondary abbreviation for the units.
  String _abbrev2;

  /// Multiply by this value to convert a Quantity in these units to SI-MKS units
  Number _convToMKS;

  /// Whether these units are considered a base metric unit.
  bool metricBase = false;

  //final String _sh;
  //final String _shDialog;

  /// The offset of this unit from zero in the metric unit scale.
  double offset = 0;

  /// The Type to which the Units apply
  Type get quantityType;

  /// Two units are considered equal if their conversions to MKS are equal and
  /// they have the same singular name.
  @override
  bool operator ==(dynamic obj) {
    if (identical(this, obj)) return true;

    if (obj is Units) return singular == obj.singular && _convToMKS == obj._convToMKS;
    return false;
  }

  @override
  int get hashCode => int.parse('${name.hashCode}54321${_convToMKS.hashCode}');

  /// Returns the alternate name for the units.  This may be a non-standard
  /// representation.  If no alternate name exists, then null is returned.
  String get alternateName => _abbrev1;

  /// Returns the shortest name for the units.  This will be the first non-null name
  /// found when inspecting secondary abbreviation, primary abbreviation and full name,
  /// in that order.  If [sing] is true and no symbol or alternate name are available
  /// then the singular version of the name will be returned.
  String getShortestName(bool sing) => _abbrev2 ?? _abbrev1 ?? (sing ? singular : name);

  /// Returns the shortest name for the units which will display in Dialog font.
  /// This will be the first non-null name found when inspecting symbol, alternate
  /// name and full name, in that order (so a non-null symbol will be returned by
  /// this method even it is longer than the alternate name).
  ///
  /// If sing is true, the singular form of the full name will be returned in the
  /// case no suitable symbols or abbreviations are available.
  /*
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
    final int num = str.length;
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
  /// The method expects [value] to be a num or Number object; any other type will
  /// cause a [QuantityException].
  Number toMks(dynamic value) {
    if (value is num || value is Number) {
      if (offset == 0) return _convToMKS * value;
      return (_convToMKS * value) + objToNumber(offset);
    } else {
      throw const QuantityException('num or Number expected');
    }
  }

  /// Calculates and returns the value in the units represented by this Units
  /// object of [mks] (that is expected to be in SI-MKS units).
  /// The method accepts a num or Number object; any other type will
  /// cause a [QuantityException].
  Number fromMks(dynamic mks) {
    if (mks is num) {
      if (offset == 0) return new Double(mks.toDouble()) / _convToMKS;
      return (new Double(mks.toDouble()) / _convToMKS) - objToNumber(offset);
    } else if (mks is Number) {
      if (offset == 0) return mks / _convToMKS;
      return (mks / _convToMKS) - objToNumber(offset);
    } else {
      throw const QuantityException('num or Number expected');
    }
  }

  /// Derive new Units using this Units object as the base.
  Units derive(String fullPrefix, String abbrevPrefix, double conv);

  /// Returns the derived Units having the 10^24 prefix, yotta (Y).
  Units yotta() => derive('yotta', 'Y', 1.0e24);

  /// Returns the derived Units having the 10^21 prefix, zetta (Z).
  Units zetta() => derive('zetta', 'Z', 1.0e21);

  /// Returns the derived Units having the 10^18 prefix, exa (E).
  // ignore: prefer_int_literals
  Units exa() => derive('exa', 'E', 1.0e18);

  /// Returns the derived Units having the 10^15 prefix, peta (P).
  // ignore: prefer_int_literals
  Units peta() => derive('peta', 'P', 1.0e15);

  /// Returns the derived Units having the 10^12 prefix, tera (T).
  // ignore: prefer_int_literals
  Units tera() => derive('tera', 'T', 1.0e12);

  /// Returns the derived Units having the 10^9 prefix, giga (G).
  // ignore: prefer_int_literals
  Units giga() => derive('giga', 'G', 1.0e9);

  /// Returns the derived Units having the 10^6 prefix, mega (M).
  // ignore: prefer_int_literals
  Units mega() => derive('mega', 'M', 1.0e6);

  /// Returns the derived Units having the 10^3 (i.e., 1000) prefix, kilo (k).
  Units kilo() => derive('kilo', 'k', 1000);

  ///  Returns the derived Units having the 10^2 (i.e., 100) prefix, hecto (h).
  Units hecto() => derive('hecto', 'h', 100);

  /// Returns the derived Units having the 10^1 (i.e. 10) prefix, deka (da).
  Units deka() => derive('deka', 'da', 10);

  /// Returns the derived Units having the 10^-1 (i.e., 0.1) prefix, deci (d).
  Units deci() => derive('deci', 'd', 0.1);

  /// Returns the derived Units having the 10^-2 (i.e., 0.01) prefix, centi (c).
  Units centi() => derive('centi', 'c', 0.01);

  /// Returns the derived Units having the 10^-3 (i.e., 0.001) prefix, milli (m).
  Units milli() => derive('milli', 'm', 0.001);

  /// Returns the derived Units having the 10^-6 prefix, micro (the symbol mu).
  Units micro() => derive('micro', '\u00b5', 1.0e-6);

  /// Returns the derived Units having the 10^-9 prefix, nano (n).
  Units nano() => derive('nano', 'n', 1.0e-9);

  /// Returns the derived Units having the 10^-12 prefix, pico (p).
  Units pico() => derive('pico', 'p', 1.0e-12);

  /// Returns the derived Units having the 10^-15 prefix, femto (f).
  Units femto() => derive('femto', 'f', 1.0e-15);

  /// Returns the derived Units having the 10^-18 prefix, atto (a).
  Units atto() => derive('atto', 'a', 1.0e-18);

  /// Returns the derived Units having the 10^-21 prefix, zepto (z).
  Units zepto() => derive('zepto', 'z', 1.0e-21);

  /// Returns the derived Units having the 10^-24 prefix, yocto (y).
  Units yocto() => derive('yocto', 'y', 1.0e-24);

  /// Returns a String representation of the Units in the following format:
  ///
  ///    full name [MKS value]
  @override
  String toString() => '$name [$_convToMKS]';

  //TODO bug, should be .abs()???
  String unicodeExponent(int exp) {
    final String neg = exp < 0 ? '\u{207b}' : '';
    if (exp == 2) {
      return '$neg\u{00b2}';
    } else if (exp == 3) {
      return '$neg\u{00b3}';
    }
    //else if(exp.abs() < 10) return '${neg}\u{00b3}';

    //TODO create a static array that holds unicode characters

    //TODO handle 10+, 100+ , 1000+, etc.

    // failed to find appropriate unicode characters
    return exp < 0 ? '-$exp' : '$exp';
  }
}
