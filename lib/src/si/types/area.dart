part of quantity_si;

/// The extent of a two-dimensional figure or shape.
///
/// See the [Wikipedia entry for Area](https://en.wikipedia.org/wiki/Area)
/// for more information.
///
class Area extends Quantity {
  /// Construct an Area with either square meters ([m2]), hectares ([ha])
  /// or barns ([b]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  Area({dynamic m2, dynamic ha, dynamic b, double uncert = 0.0})
      : super(m2 ?? (ha ?? (b ?? 0.0)), ha != null ? Area.hectares : (b != null ? Area.barns : Area.squareMeters),
            uncert);

  Area._internal(dynamic conv) : super._internal(conv, Area.areaDimensions);

  /// Constructs a Area based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Area.inUnits(dynamic value, AreaUnits units, [double uncert = 0.0])
      : super(value, units ?? Area.squareMeters, uncert);

  const Area.constant(Number valueSI, {AreaUnits units, double uncert = 0.0})
      : super.constant(valueSI, Area.areaDimensions, units, uncert);

  Area.fromLengths(Length l1, Length l2)
      : super(l1.valueSI * l2.valueSI, Area.squareMeters, math.sqrt(l1._ur * l1._ur + l2._ur * l2._ur));

  /// Dimensions for this type of quantity
  static const Dimensions areaDimensions = const Dimensions.constant(const <String, int>{'Length': 2}, qType: Area);

  /// The standard SI unit
  static final AreaUnits squareMeters = new AreaUnits.lengthSquared(Length.meters);

  /// Accepted for use with the SI,
  /// equals 1 square hectometer, or 10 000 square meters
  static final AreaUnits hectares = new AreaUnits('hectares', 'ha', null, null, 1.0e4, true);

  /// Accepted for use with the SI, subject to further review...
  /// equals one square decameter, or 100 square meters
  static final AreaUnits ares = new AreaUnits('ares', 'a', null, null, 1.0e2, true);

  /// Accepted for use with the SI, subject to further review...
  /// equals 100 square femtometers, or 1.0e-28 square meters
  static final AreaUnits barns = new AreaUnits('barns', 'b', null, null, 1.0e-28, true);
}

/// Units acceptable for use in describing Area quantities.
///
class AreaUnits extends Area with Units {
  /// Constructs a new instance.
  AreaUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super._internal(conv) {
    this.name = name;
    this.singular = singular;
    _convToMKS = objToNumber(conv);
    _abbrev1 = abbrev1;
    _abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Constructs a new instance based on length units.
  AreaUnits.lengthSquared(LengthUnits lu) : super._internal(lu.valueSI * lu.valueSI) {
    name = 'square ${lu.name}';
    singular = 'square ${lu.singular}';
    _convToMKS = lu.valueSI * lu.valueSI;
    _abbrev1 = lu._abbrev1 != null && lu._abbrev1 != null ? '${lu._abbrev1}2' : null;
    _abbrev2 = lu._abbrev2 != null && lu._abbrev2 != null ? '${lu._abbrev2}2' : null;
    metricBase = false;
    offset = 0.0;
  }

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Area;

  /// Derive new AreaUnits using this AreaUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) => new AreaUnits(
      '$fullPrefix$name',
      _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
      _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
      '$fullPrefix$singular',
      valueSI * conv,
      false,
      offset);
}
