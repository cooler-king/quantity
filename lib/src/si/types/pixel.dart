import '../../number/util/converters.dart';
import '../../si/dimensions.dart';
import '../../si/quantity.dart';
import '../../si/units.dart';
import '../register_si.dart';
import 'area.dart';
import 'length.dart';
import 'pixel_density.dart';
import 'resolution.dart';

/// Represents a count of picture elements (pixels).
base class Pixel extends Quantity {
  /// Constructs a Pixel with pixels.
  /// Optionally specify a relative standard uncertainty.
  Pixel({dynamic pixels, double uncert = 0.0})
      : super(pixels ?? 0.0, Pixel.pixels, uncert) {
    var _ = siRegistered;
  }

  /// Constructs an instance without preferred units.
  Pixel.misc(dynamic conv) : super.misc(conv, Pixel.pixelDimensions) {
    var _ = siRegistered;
  }

  /// Constructs a Pixel based on the [value]
  /// and the conversion factor intrinsic to the passed [units].
  Pixel.inUnits(dynamic value, PixelUnits? units, [double uncert = 0.0])
      : super(value, units ?? Pixel.pixels, uncert) {
    var _ = siRegistered;
  }

  /// Constructs a constant Pixel.
  const Pixel.constant(Number valueSI, {PixelUnits? units, double uncert = 0.0})
      : super.constant(valueSI, Pixel.pixelDimensions, units, uncert);

  /// Dimensions for this type of quantity.
  static const Dimensions pixelDimensions =
      Dimensions.constant(<String, int>{}, qType: Pixel);

  /// Returns the quotient of this [Pixel] and a [divisor].
  /// * `Pixel / Resolution` yields `Length`.
  /// * `Pixel / Length` yields `Resolution`.
  /// * `Pixel / Area` yields `PixelDensity`.
  /// * `Pixel / PixelDensity` yields `Area`.
  @override
  Quantity operator /(dynamic divisor) {
    if (divisor is Resolution) {
      return Length(m: valueSI / divisor.valueSI);
    } else if (divisor is Length) {
      return Resolution(pixelsPerMeter: valueSI / divisor.valueSI);
    } else if (divisor is Area) {
      return PixelDensity(pixelsPerSquareMeter: valueSI / divisor.valueSI);
    } else if (divisor is PixelDensity) {
      return Area(m2: valueSI / divisor.valueSI);
    }
    return super / divisor;
  }

  // Units.

  /// The standard unit for pixels.
  static final PixelUnits pixels =
      PixelUnits('pixels', 'px', 'pixel', 'pixel', 1.0, true);
}

/// Units acceptable for use in describing Pixel quantities.
base class PixelUnits extends Pixel with Units {
  /// Constructs an instance.
  PixelUnits(String name, String? abbrev1, String? abbrev2, String singular,
      dynamic conv,
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
  Type get quantityType => Pixel;

  /// Derive PixelUnits using this PixelUnits object as the base.
  @override
  Units derive(String fullPrefix, String abbrevPrefix, double conv) =>
      PixelUnits(
          '$fullPrefix$name',
          abbrev1 != null ? '$abbrevPrefix$abbrev1' : null,
          abbrev2 != null ? '$abbrevPrefix$abbrev2' : null,
          '$fullPrefix$singular',
          valueSI * conv,
          false,
          offset);
}
