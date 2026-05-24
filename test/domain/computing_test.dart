import 'package:test/test.dart';
import 'package:quantity/domain/computing.dart';

void main() {
  group('Computing Domain', () {
    test('quantity types and units', () {
      expect(bits, isA<InformationUnits>());
      expect(bytes, isA<InformationUnits>());
      expect(kilobytes, isA<InformationUnits>());
      expect(megabytes, isA<InformationUnits>());
      expect(gigabytes, isA<InformationUnits>());
      expect(terabytes, isA<InformationUnits>());
    });

    test('classes availability', () {
      final t = Token(tokens: 4096);
      expect(t, isA<Token>());
      expect(t.inTokens, 4096);

      final tr = TokenRate(tps: 50);
      expect(tr, isA<TokenRate>());
      expect(tr.inTps, 50);

      final p = Pixel(pixels: 1920);
      expect(p, isA<Pixel>());
      expect(p.inPixels, 1920);

      final r = Resolution(ppi: 96);
      expect(r, isA<Resolution>());
      expect(r.inPpi, 96);

      final pd = PixelDensity(pixelsPerSquareInch: 1000);
      expect(pd, isA<PixelDensity>());
    });
  });
}
