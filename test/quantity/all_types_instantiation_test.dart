import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  final _ = siRegistered;

  test('Instantiate and verify all 75 quantity types', () {
    expect(allQuantityTypes, isNotEmpty);
    
    for (final type in allQuantityTypes) {
      final q = createTypedQuantityInstance(type, 42.0, null);
      expect(q, isNotNull);
      expect(q.valueSI.toDouble(), 42.0);
      expect(q.dimensions, isNotNull);
      expect(q.toJson(), isNotNull);
      expect(q.toString(), isNotNull);
      
      // Basic math operations to cover operator overrides
      if (q is! Level) {
        final qDouble = q * 2.0;
        expect(qDouble.valueSI.toDouble(), 84.0);
        expect(qDouble.dimensions, q.dimensions);

        final qSum = q + q;
        expect(qSum.valueSI.toDouble(), 84.0);
        expect(qSum.dimensions, q.dimensions);

        final qDiff = q - q;
        expect(qDiff.valueSI.toDouble(), 0.0);
        expect(qDiff.dimensions, q.dimensions);

        final qNeg = -q;
        expect(qNeg.valueSI.toDouble(), -42.0);
        expect(qNeg.dimensions, q.dimensions);

        expect(q.abs().valueSI.toDouble(), 42.0);
      } else {
        // Just verify basic operations execute without crashing for Level subclasses
        final qDouble = q * 2.0;
        expect(qDouble.dimensions, q.dimensions);

        final qNeg = -q;
        expect(qNeg.dimensions, q.dimensions);

        expect(q.abs().dimensions, q.dimensions);
      }
    }
  });
}
