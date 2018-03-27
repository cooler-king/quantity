part of quantity_si;

/// Represents specific units raised to some power.
///
class ExponentialUnits {
  Units _units;

  /// Exponent associated with the units.  An int or double.
  num _exp;

  /// Associates [units] with an [exp]onent.
  ///
  /// The [exp]onent must be either a [num] or [Number], otherwise
  /// a [QuantityException] will be thrown.
  ///
  ExponentialUnits(Units units, dynamic exp) {
    _units = units;

    if (exp is num) {
      _exp = exp;
    } else if (exp is Number) {
      _exp = exp.toDouble();
    } else {
      throw const QuantityException('exp must be a num or Number');
    }
  }

  /// Create new ExponentialUnits with the same values as [expUnits2].
  ExponentialUnits.copy(ExponentialUnits expUnits2) : this(expUnits2._units, expUnits2._exp);

  ExponentialUnits get reciprocal => new ExponentialUnits(_units, (_exp * -1.0));

  /**
   * Creates and returns a new ExponentialUnits object in which the
   * exponent has been propagated to the unit components (and so the
   * top level exponent will then be exactly 1).
   *
  ExponentialUnits get normalized {
    Units modUnits = null;
    List<ExponentialUnits> comps = _units.getComponents(true,true);
    List<ExponentialUnits> modComps = new List<ExponentialUnits>();
    int numComps = comps.length;
    for(ExponentialUnits uwe in comps) {
      modComps.add(new ExponentialUnits(uwe._units, uwe._exp * _exp));
    }

    modUnits = new Units.compound(modComps);

    return new ExponentialUnits(modUnits, 1);
  }
  */

/*
  Units asUnits() {
    return new Units.one(_units,_exp);
  }*/

}
