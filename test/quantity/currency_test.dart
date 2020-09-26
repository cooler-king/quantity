import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/number.dart';

void main() {
  group('Currency', () {
    test('constructors', () {
      Currency q = new Currency();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Currency.currencyDimensions);
      expect(q.preferredUnits, Currency.dollarsUS);
      expect(q.relativeUncertainty, 0);

      q = new Currency(USD: 42, uncert: 0.001);
      expect(q.valueSI?.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Currency.currencyDimensions);
      expect(q.preferredUnits, Currency.dollarsUS);
      expect(q.relativeUncertainty, 0.001);
    });

    test('operator +', () {
      final Currency c1 = new Currency(USD: 12.34);
      final Currency c2 = new Currency(USD: 56.78);
      dynamic sum = c1 + c2;
      expect(sum is Currency, true);
      expect(sum.valueSI.toDouble(), 69.12);

      // Adding Scalar allowed
      sum = c1 + new Scalar(value: 23);
      expect(sum is Currency, true);
      expect(sum.valueSI.toDouble(), 35.34);

      // Adding num allowed
      sum = c1 + 14.05;
      expect(sum is Currency, true);
      expect(sum.valueSI.toDouble(), 26.39);
    });

    test('operator -', () {
      final Currency c1 = new Currency(USD: 12.34);
      final Currency c2 = new Currency(USD: 56.78);
      dynamic diff = c2 - c1;
      expect(diff is Currency, true);
      expect(diff.valueSI.toDouble(), 44.44);
      diff = c1 - c2;
      expect(diff is Currency, true);
      expect(diff.valueSI.toDouble(), -44.44);

      // Subtracting Scalar allowed
      diff = c2 - new Scalar(value: 23);
      expect(diff is Currency, true);
      expect(diff.valueSI.toDouble(), closeTo(33.78, 0.00001));

      // Subtracting num allowed
      diff = c2 - 14.05;
      expect(diff is Currency, true);
      expect(diff.valueSI.toDouble(), closeTo(42.73, 0.00001));
    });

    test('operator *', () {
      final Currency c1 = new Currency(USD: 12.34);

      dynamic prod = c1 * 2;
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(24.68, 0.00001));

      prod = c1 * new Integer(3);
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(37.02, 0.00001));

      prod = c1 * new Double(4.5);
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(12.34 * 4.5, 0.00001));

      prod = c1 * new Scalar(value: 8.1);
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(12.34 * 8.1, 0.00001));
    });

    test('operator /', () {
      final Currency c1 = new Currency(USD: 12.34);

      dynamic prod = c1 / 2;
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(6.17, 0.00001));

      prod = c1 / new Integer(3);
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(12.34 / 3, 0.00001));

      prod = c1 / new Double(4.5);
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(12.34 / 4.5, 0.00001));

      prod = c1 / new Scalar(value: 8.1);
      expect(prod is Currency, true);
      expect(prod.valueSI.toDouble(), closeTo(12.34 / 8.1, 0.00001));
    });
  });
}
