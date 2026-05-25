import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';
import '../register_si.dart';
import 'length.dart';
import 'pixel.dart';

/// Spatial resolution in pixels per length (1D).
base class Resolution extends Quantity {
  /// Constructs a Resolution with pixels per inch ([ppi]), pixels per centimeter ([dpcm]),
  /// or pixels per meter ([pixelsPerMeter]).
  /// Optionally specify a relative standard uncertainty.
  Resolution(
      {dynamic ppi, dynamic dpcm, dynamic pixelsPerMeter, double uncert = 0.0})
      : super(
            ppi ?? (dpcm ?? (pixelsPerMeter ?? 0.0)),
            ppi != null
                ? Resolution.pixelsPerInch
                : (dpcm != null
                    ? Resolution.pixelsPerCentimeter
                    : Resolution.pixelsPerMeter),
            uncert) {
    var _ = siRegistered;
  }

  /// Constructs an instance without preferred units.
  Resolution.misc(dynamic conv)
      : super.misc(conv, Resolution.resolutionDimensions) {
    var _ = siRegistered;
  }

  /// Constructs a Resolution based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Resolution.inUnits(dynamic value, ResolutionUnits? units,
      [double uncert = 0.0])
      : super(value, units ?? Resolution.pixelsPerMeter, uncert) {
    var _ = siRegistered;
  }

  /// Constructs a constant Resolution.
  const Resolution.constant(Number valueSI,
      {ResolutionUnits? units, double uncert = 0.0})
      : super.constant(valueSI, Resolution.resolutionDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions resolutionDimensions =
      Dimensions.constant(<String, int>{'Length': -1}, qType: Resolution);

  /// Returns the product of this [Resolution] and a [multiplier].
  /// * `Resolution * Length` yields `Pixel`.
  @override
  Quantity operator *(dynamic multiplier) {
    if (multiplier is Length) {
      return Pixel(pixels: valueSI * multiplier.valueSI);
    }
    return super * multiplier;
  }

  // Units.

  /// The standard unit (pixels per meter).
  static final ResolutionUnits pixelsPerMeter = ResolutionUnits(
      'pixels per meter', 'px/m', null, 'pixel per meter', 1.0, true);

  /// Pixels per inch (DPI/PPI).
  static final ResolutionUnits pixelsPerInch = ResolutionUnits(
      'pixels per inch', 'ppi', 'px/in', 'pixel per inch', 1.0 / 0.0254, false);

  /// Pixels per centimeter (DPCM).
  static final ResolutionUnits pixelsPerCentimeter = ResolutionUnits(
      'pixels per centimeter',
      'dpcm',
      'px/cm',
      'pixel per centimeter',
      100.0,
      false);
}

/// Units acceptable for use in describing Resolution quantities.
base class ResolutionUnits extends Resolution with Units {
  /// Constructs an instance.
  ResolutionUnits(String name, String? abbrev1, String? abbrev2,
      String singular, dynamic conv,
      [bool metricBase = false, num offset = 0.0])
      : super.misc(conv) {
    this.name = name;
    this.singular = singular;
    convToMKS = objToNumber(conv);
    this.abbrev1 = abbrev1;
    this.abbrev2 = abbrev2;
    this.metricBase = metricBase;
    this.offset = offset.toDouble();
  }

  /// Returns the Type of the Quantity to which these Units apply.
  @override
  Type get quantityType => Resolution;

  /// Derive ResolutionUnits using this ResolutionUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      ResolutionUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
