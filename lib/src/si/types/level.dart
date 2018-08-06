part of quantity_si;

/// Represents _logarithmic_ physical quantities and has
/// dimensions of 1 (Scalar).  Level of a field quantity and level of a power
/// quantity are two common logarithmic quantities.
///
/// Level of a field quantity is defined as ln(F/F0), where F/F0 is the ratio
/// of two amplitudes of the same kind and F0 is a reference amplitude.
///
/// Level of a power quantity is defined as 0.5*ln(P/P0), where P/P0 is the ratio
/// of two powers and P0 is a reference power.
///
/// ## Adding and Subtracting Levels
/// When levels are to be combined or separated, use the 'add' and
/// 'subtract' methods of this class rather than the 'plus,' 'plusEquals,'
/// 'minus,' or 'minusEquals' methods that are inherited from the Quantity
/// superclass.  This is necessary in order to properly handle the
/// logarithmic nature of Level quantities.  For example, use the 'add' method
/// to properly determine that the resulting sound intensity level from two
/// sources--62.0 dB and 73.0 dB--is 73.3 dB (not 135 dB!).
///
/// See the [Wikipedia entry for Level (logarithmic_quantity)](https://en.wikipedia.org/wiki/Level_%28logarithmic_quantity%29)
/// for more information.
///
abstract class Level extends Quantity {
  /// Dimensions for this type of quantity
  static const Dimensions levelDimensions = const Dimensions.constant(const <String, int>{}, qType: Level);

  /// Accepted for use with the SI...
  /// the level of a field quantity when F/F0 = e and P/P0 = e squared.
  static final LevelUnits nepers = new LevelUnits('nepers', null, 'Np', null, 1.0, true);

  /// Accepted for use with the SI...
  /// the level of a field quantity when F/F0 = square root of 10 and P/P0 = 10.
  /// 1 B = (ln 10) / 2 Np exactly.
  static final LevelUnits bels = new LevelUnits('bels', null, 'B', null, 0.5 * math.log(10.0), true);

  // Convenience

  /// Accepted for use with the SI.
  static final LevelUnits decibels = bels.deci() as LevelUnits;

  /// Construct a Level with nepers ([Np]).
  ///
  /// Optionally specify a relative standard [uncert]ainty.
  ///
  // ignore: non_constant_identifier_names
  Level({dynamic Np, double uncert = 0.0}) : super(Np ?? 0.0, Level.nepers, uncert);

  Level._internal(dynamic conv) : super._internal(conv, Level.levelDimensions);

  /// Constructs a Level based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  ///
  Level.inUnits(dynamic value, LevelUnits units, [double uncert = 0.0]) : super(value, units ?? Level.nepers, uncert);

  const Level.constant(Number valueSI, {LevelUnits units, double uncert = 0.0})
      : super.constant(valueSI, Level.levelDimensions, units, uncert);
}

/// Units acceptable for use in describing Level quantities.
///
class LevelUnits extends Level with Units {
  /// Constructs a new instance.
  LevelUnits(String name, String abbrev1, String abbrev2, String singular, dynamic conv,
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

  /// Returns the Type of the Quantity to which these Units apply
  @override
  Type get quantityType => Level;

  /// Derive new LevelUnits using this LevelUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
     new LevelUnits(
        '$fullPrefix$name',
        _abbrev1 != null ? '$abbrevPrefix$_abbrev1' : null,
        _abbrev2 != null ? '$abbrevPrefix$_abbrev2' : null,
        '$fullPrefix$singular',
        valueSI * conv,
        false,
        offset);
  
}

// Also SoundIntensityLevel

/// Represents a level of a power quantity,  a _logarithmic_ quantity.
///
/// Level of a power quantity is defined as 0.5*ln(P/P0), where P/P0 is the ratio
/// of two powers and P0 is a reference power.
///
class PowerLevel extends Level {
  PowerLevel(Power p, Power refP) : super(Np: 0.5 * math.log((p.mks / refP.mks).toDouble()));

  PowerLevel.inUnits(dynamic value, LevelUnits units, [double uncert = 0.0]) : super.inUnits(value, units, uncert);

  double get ratio => math.exp(2.0 * valueSI.toDouble());

  @override
  Quantity operator +(dynamic addend) {
    if (addend is PowerLevel) {
      return new PowerLevel.inUnits(0.5 * math.log(ratio + addend.ratio), Level.nepers);
    } else {
      return super + addend;
    }
  }

  @override
  Quantity operator -(dynamic subtrahend) {
    if (subtrahend is PowerLevel) {
      return new PowerLevel.inUnits(0.5 * math.log(ratio - subtrahend.ratio), Level.nepers);
    } else {
      return super - subtrahend;
    }
  }
}

// Also SoundPressureLevel

/// Represents a level of a field quantity,  a _logarithmic_ quantity.
///
/// Level of a field quantity is defined as ln(F/F0), where F/F0 is the ratio
/// of two field quantities and F0 is a reference amplitude of the appropriate
/// type.
class FieldLevel extends Level {
  FieldLevel(Quantity q1, Quantity refQ) : super(Np: 0.5 * math.log((q1.mks / refQ.mks).toDouble()));

  FieldLevel.inUnits(dynamic value, LevelUnits units, [double uncert = 0.0]) : super.inUnits(value, units, uncert);

  double get ratio => math.exp(valueSI.toDouble());

  @override
  Quantity operator +(dynamic addend) {
    if (addend is FieldLevel) {
      return new FieldLevel.inUnits(math.log(ratio + addend.ratio), Level.nepers);
    } else {
      return super + addend;
    }
  }

  @override
  Quantity operator -(dynamic subtrahend) {
    if (subtrahend is FieldLevel) {
      return new FieldLevel.inUnits(math.log(ratio - subtrahend.ratio), Level.nepers);
    } else {
      return super - subtrahend;
    }
  }
}
