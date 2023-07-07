import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('angle ext', () {
    test('common angles', () {
      //Scalar s = Scalar(value:42);
      expect(angle270, isNotNull);
      expect(angle270.valueInUnits(Angle.degrees).toDouble(), 270.0);
      expect(angle360, isNotNull);
    });
  });
}
