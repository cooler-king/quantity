import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

main() {
  group('Mass', () {
    test('toEnergy', () {
      Mass m = new Mass(kg: 1);
      var e = m.toEnergy();

      expect(e is Energy, true);
      expect(e.valueSI.toDouble(), 8.9875517873681764e16);

      m = new Mass(g: 1);
      e = m.toEnergy();
      expect(e.valueSI.toDouble(), 8.9875517873681764e13);

      m = new Mass(kg: 2.2);
      e = m.toEnergy();
      expect(e.valueSI.toDouble(), 1.97726139322099870e17);
    });
  });
}
