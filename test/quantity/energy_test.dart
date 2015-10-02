import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

main() {
  group('Energy', () {
    test('toMass', () {
      Energy e = new Energy(J: 1);
      var m = e.toMass();

      expect(m is Mass, true);
      expect(m.valueSI.toDouble(), 1.1126500560536185e-17);

      e = new Energy(J: 2.2);
      m = e.toMass();
      expect(m.valueSI.toDouble(), 2.447830123317961e-17);
    });
  });
}
