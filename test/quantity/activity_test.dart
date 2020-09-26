import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Activity', () {
    test('constructors', () {
      Activity q = new Activity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Activity.activityDimensions);
      expect(q.preferredUnits, Activity.becquerels);
      expect(q.relativeUncertainty, 0);

      q = new Activity(Bq: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Activity.activityDimensions);
      expect(q.preferredUnits, Activity.becquerels);
      expect(q.relativeUncertainty, 0.001);

      q = new Activity(Ci: 1);
      expect(q.valueSI?.toDouble(), 3.7e10);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Activity.activityDimensions);
      expect(q.preferredUnits, Activity.curies);
      expect(q.relativeUncertainty, 0);
    });
  });
}
