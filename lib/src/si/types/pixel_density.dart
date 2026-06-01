import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';
import '../register_si.dart';
import 'area.dart';
import 'pixel.dart';

/// 2D pixel density in pixels per area.
base class PixelDensity extends Quantity {
  /// Constructs a PixelDensity with pixels per square inch ([pixelsPerSquareInch]) or pixels per
  /// square meter ([pixelsPerSquareMeter]).
  /// Optionally specify a relative standard uncertainty.
  PixelDensity(
      {dynamic pixelsPerSquareInch,
      dynamic pixelsPerSquareMeter,
      double uncert = 0.0})
      : super(
            pixelsPerSquareInch ?? (pixelsPerSquareMeter ?? 0.0),
            pixelsPerSquareInch != null
                ? PixelDensity.pixelsPerSquareInch
                : PixelDensity.pixelsPerSquareMeter,
            uncert) {
    var _ = siRegistered;
  }

  /// Constructs an instance without preferred units.
  PixelDensity.misc(dynamic conv)
      : super.misc(conv, PixelDensity.pixelDensityDimensions) {
    var _ = siRegistered;
  }

  /// Constructs a PixelDensity based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  PixelDensity.inUnits(dynamic value, PixelDensityUnits? units,
      [double uncert = 0.0])
      : super(value, units ?? PixelDensity.pixelsPerSquareMeter, uncert) {
    var _ = siRegistered;
  }

  /// Constructs a constant PixelDensity.
  const PixelDensity.constant(Number valueSI,
      {PixelDensityUnits? units, double uncert = 0.0})
      : super.constant(
            valueSI, PixelDensity.pixelDensityDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions pixelDensityDimensions =
      Dimensions.constant(<String, int>{'Length': -2}, qType: PixelDensity);

  /// Returns the product of this [PixelDensity] and a [multiplier].
  /// * `PixelDensity * Area` yields `Pixel`.
  @override
  Quantity operator *(dynamic multiplier) {
    if (multiplier is Area) {
      return Pixel(pixels: valueSI * multiplier.valueSI);
    }
    return super * multiplier;
  }

  // Units.

  /// The standard unit (pixels per square meter).
  static final PixelDensityUnits pixelsPerSquareMeter = PixelDensityUnits(
      'pixels per square meter',
      'px/m2',
      null,
      'pixel per square meter',
      1.0,
      true);

  /// Pixels per square inch.
  static final PixelDensityUnits pixelsPerSquareInch = PixelDensityUnits(
      'pixels per square inch',
      'px/in2',
      null,
      'pixel per square inch',
      1.0 / (0.0254 * 0.0254),
      false);
}

/// Units acceptable for use in describing PixelDensity quantities.
base class PixelDensityUnits extends PixelDensity with Units {
  /// Constructs an instance.
  PixelDensityUnits(String name, String? abbrev1, String? abbrev2,
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
  Type get quantityType => PixelDensity;

  /// Derive PixelDensityUnits using this PixelDensityUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      PixelDensityUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
