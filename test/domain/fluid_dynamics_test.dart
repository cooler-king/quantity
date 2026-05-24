import 'package:test/test.dart';
import 'package:quantity/domain/fluid_dynamics.dart';

void main() {
  group('Fluid Dynamics Domain', () {
    test('units', () {
      expect(stokes, isA<KinematicViscosityUnits>());
      expect(centistokes, isA<KinematicViscosityUnits>());
      expect(stokes.valueSI.toDouble(), 1e-4);
      expect(centistokes.valueSI.toDouble(), 1e-6);
      expect(DynamicViscosity.poiseuille, isNotNull);
    });

    test('classes availability', () {
      final dv = DynamicViscosity(Pas: 1.5);
      expect(dv, isA<DynamicViscosity>());

      final kv = KinematicViscosity.inUnits(10.0, centistokes);
      expect(kv, isA<KinematicViscosity>());
      expect(kv.valueInUnits(centistokes).toDouble(), 10.0);
    });
  });
}
