import 'package:quantity/quantity.dart';
import 'package:test/test.dart';

void main() {
  group('Display Resolution & Pixel Quantities', () {
    test('Pixel, Resolution, and PixelDensity construction and shortcuts', () {
      final p1 = Pixel(pixels: 1920);
      expect(p1, isA<Pixel>());
      expect(p1.inPixels, equals(1920.0));

      final p2 = 1080.pixels;
      expect(p2, isA<Pixel>());
      expect(p2.inPixels, equals(1080.0));

      final r1 = Resolution(ppi: 96);
      expect(r1, isA<Resolution>());
      expect(r1.inPpi, equals(96.0));

      final r2 = 300.ppi;
      expect(r2, isA<Resolution>());
      expect(r2.inPpi, equals(300.0));

      final r3 = 10.dpcm;
      expect(r3, isA<Resolution>());
      expect(r3.inDpcm, equals(10.0));

      final pd1 = PixelDensity(pixelsPerSquareInch: 10000);
      expect(pd1, isA<PixelDensity>());
      expect(pd1.valueInUnits(PixelDensity.pixelsPerSquareInch).toDouble(),
          equals(10000.0));
    });

    test('Layout arithmetic (1D spatial math)', () {
      final ppi = 96.ppi;
      final length = 5.inches;

      // Resolution * Length = Pixel
      final pixels = ppi * length;
      expect(pixels, isA<Pixel>());
      expect((pixels as Pixel).inPixels, closeTo(480.0, 0.0001));

      // Pixel / Resolution = Length
      final len = 480.pixels / ppi;
      expect(len, isA<Length>());
      expect((len as Length).inInches, closeTo(5.0, 0.0001));

      // Pixel / Length = Resolution
      final res = 480.pixels / length;
      expect(res, isA<Resolution>());
      expect((res as Resolution).inPpi, closeTo(96.0, 0.0001));

      // Pixel / num fallback
      final divResult = 480.pixels / 2;
      expect(divResult, isA<Pixel>());
      expect(divResult.valueSI.toDouble(), equals(240.0));
    });

    test('Layout arithmetic (2D spatial density math)', () {
      final density =
          PixelDensity.inUnits(1000, PixelDensity.pixelsPerSquareMeter);
      final area = 5.squareMeters;

      // PixelDensity * Area = Pixel
      final pixels = density * area;
      expect(pixels, isA<Pixel>());
      expect((pixels as Pixel).inPixels, equals(5000.0));

      // Pixel / Area = PixelDensity
      final dens = 5000.pixels / area;
      expect(dens, isA<PixelDensity>());
      expect(
          (dens as PixelDensity)
              .valueInUnits(PixelDensity.pixelsPerSquareMeter)
              .toDouble(),
          equals(1000.0));

      // Pixel / PixelDensity = Area
      final a = 5000.pixels / density;
      expect(a, isA<Area>());
      expect((a as Area).inSquareMeters, equals(5.0));
    });

    test('Natural Language Unit Parsing (Quantity.parse)', () {
      final q1 = Quantity.parse('1920 px');
      expect(q1, isA<Pixel>());
      expect(q1.valueSI.toDouble(), equals(1920.0));

      final q2 = Quantity.parse('300 ppi');
      expect(q2, isA<Resolution>());
      expect(
          q2.valueInUnits(Resolution.pixelsPerInch).toDouble(), equals(300.0));

      final q3 = Quantity.parse('10 dpcm');
      expect(q3, isA<Resolution>());
      expect(q3.valueInUnits(Resolution.pixelsPerCentimeter).toDouble(),
          equals(10.0));

      final q4 = Quantity.parse('100 px/m2');
      expect(q4, isA<PixelDensity>());
      expect(q4.valueSI.toDouble(), equals(100.0));
    });

    test('Registry getUnitSymbols', () {
      final pixelSymbols = Quantity.getUnitSymbols(Pixel);
      expect(pixelSymbols, contains('px'));
      expect(pixelSymbols, contains('pixel'));
      expect(pixelSymbols, contains('pixels'));

      final resSymbols = Quantity.getUnitSymbols(Resolution);
      expect(resSymbols, contains('ppi'));
      expect(resSymbols, contains('dpcm'));
      expect(resSymbols, contains('px/m'));
      expect(resSymbols, contains('px/in'));

      final densSymbols = Quantity.getUnitSymbols(PixelDensity);
      expect(densSymbols, contains('px/m2'));
      expect(densSymbols, contains('px/in2'));
    });

    test('Dimensions.describe', () {
      expect(
          Dimensions.describe(Pixel.pixelDimensions), equals('dimensionless'));
      expect(Dimensions.describe(Resolution.resolutionDimensions),
          equals('1 / Length^1'));
      expect(Dimensions.describe(PixelDensity.pixelDensityDimensions),
          equals('1 / Length^2'));
    });
  });
}
