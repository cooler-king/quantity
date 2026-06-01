import 'package:quantity/domain/acoustics.dart';
import 'package:test/test.dart';

void main() {
  group('Acoustics Domain', () {
    test('classes availability', () {
      final f = Frequency(Hz: 1000);
      expect(f, isA<Frequency>());

      final p = SoundPressureLevel(Pressure(Pa: 1), Pressure(Pa: 20e-6));
      expect(p, isA<SoundPressureLevel>());

      final intensity = SoundIntensityLevel(Power(W: 1), Power(W: 1e-12));
      expect(intensity, isA<SoundIntensityLevel>());
    });
  });
}
