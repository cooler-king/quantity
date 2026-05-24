import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

base class MockLevel extends Level {
  // ignore: non_constant_identifier_names
  MockLevel({super.Np, super.uncert});
  MockLevel.constant(super.valueSI) : super.constant();
  MockLevel.inUnits(super.value, super.units, [super.uncert]) : super.inUnits();
  MockLevel.misc(super.conv) : super.misc();
}

void main() {
  group('Level', () {
    test('base class and units', () {
      var l = MockLevel(Np: 2.5);
      expect(l.valueSI.toDouble(), 2.5);
      expect(l.preferredUnits, Level.nepers);

      var l2 = MockLevel.inUnits(3.0, Level.bels);
      expect(l2.valueSI.toDouble(), closeTo(3.0 * 1.1512925, 0.0001));

      var l3 = MockLevel.misc(1.5);
      expect(l3.valueSI.toDouble(), 1.5);

      expect(Level.nepers.name, 'nepers');
      expect(Level.bels.name, 'bels');
      expect(Level.decibels.name, 'decibels');

      var lConst = MockLevel.constant(Double(5.0));
      expect(lConst.valueSI.toDouble(), 5.0);

      // derive Units
      var derived = Level.nepers.derive('testPrefix', 'tp', 2.0);
      expect(derived.name, 'testPrefixnepers');
      expect(derived.singular, 'testPrefixneper');
      expect((derived as LevelUnits).valueSI.toDouble(), 2.0);
      expect(derived.quantityType, Level);
    });
  });

  group('FieldLevel', () {
    test('constructors and ratio', () {
      var q = FieldLevel(Force(N: 10), Force(N: 10));
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Level.levelDimensions);
      expect(q.preferredUnits, Level.nepers);
      expect(q.relativeUncertainty, 0);

      q = FieldLevel(Force(N: 100), Force(N: 10));
      expect(
          q.valueSI.toDouble(), closeTo(2.302585 / 2.0, 0.0001)); // ln(10) / 2
      expect(q.valueSI is Double, true);
      expect(q.ratio,
          closeTo(3.162277, 0.0001)); // ratio = exp(valueSI) = sqrt(10)
    });

    test('arithmetic + and -', () {
      // Adding two field levels
      var fl1 = FieldLevel.inUnits(1.0, Level.nepers); // ratio = exp(1) ~ 2.718
      var fl2 = FieldLevel.inUnits(2.0, Level.nepers); // ratio = exp(2) ~ 7.389
      // fl1 + fl2 => FieldLevel.inUnits(ln(2.718 + 7.389), nepers) => ln(10.107) ~ 2.313
      var sum = fl1 + fl2;
      expect(sum is FieldLevel, true);
      expect(sum.valueSI.toDouble(), closeTo(2.3132, 0.0001));

      // Subtracting two field levels
      // fl2 - fl1 => FieldLevel.inUnits(ln(7.389 - 2.718), nepers) => ln(4.671) ~ 1.541
      var diff = fl2 - fl1;
      expect(diff is FieldLevel, true);
      expect(diff.valueSI.toDouble(), closeTo(1.5413, 0.0001));

      // Fallback behavior
      expect(() => fl1 + Length(m: 5.0), throwsA(isA<DimensionsException>()));
      expect(() => fl1 + 'invalid', throwsA(isA<QuantityException>()));
      expect(() => fl1 - Length(m: 5.0), throwsA(isA<DimensionsException>()));
      expect(() => fl1 - 'invalid', throwsA(isA<QuantityException>()));
    });
  });

  group('PowerLevel', () {
    test('constructors and ratio', () {
      var q = PowerLevel(Power(W: 10), Power(W: 10));
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, Level.levelDimensions);
      expect(q.preferredUnits, Level.nepers);
      expect(q.relativeUncertainty, 0);

      q = PowerLevel(Power(W: 100), Power(W: 10));
      expect(q.valueSI.toDouble(),
          closeTo(0.5 * 2.302585, 0.0001)); // 0.5 * ln(10)
      expect(q.valueSI is Double, true);
      expect(q.ratio, closeTo(10.0, 0.0001)); // ratio = exp(2 * valueSI) = 10
    });

    test('arithmetic + and -', () {
      var pl1 = PowerLevel.inUnits(
          0.346573, Level.nepers); // ratio = exp(2 * 0.346573) = 2
      var pl2 = PowerLevel.inUnits(
          0.549306, Level.nepers); // ratio = exp(2 * 0.549306) = 3
      // pl1 + pl2 => 0.5 * ln(2 + 3) => 0.5 * ln(5) ~ 0.804718
      var sum = pl1 + pl2;
      expect(sum is PowerLevel, true);
      expect(sum.valueSI.toDouble(), closeTo(0.804718, 0.0001));

      // pl2 - pl1 => 0.5 * ln(3 - 2) => 0
      var diff = pl2 - pl1;
      expect(diff is PowerLevel, true);
      expect(diff.valueSI.toDouble(), closeTo(0.0, 0.0001));

      // Fallback behavior
      expect(() => pl1 + Length(m: 5.0), throwsA(isA<DimensionsException>()));
      expect(() => pl1 + 'invalid', throwsA(isA<QuantityException>()));
      expect(() => pl1 - Length(m: 5.0), throwsA(isA<DimensionsException>()));
      expect(() => pl1 - 'invalid', throwsA(isA<QuantityException>()));
    });
  });

  group('Sound Level Synonyms', () {
    test('SoundIntensityLevel and SoundPressureLevel', () {
      var sil = SoundIntensityLevel(Power(W: 20), Power(W: 10));
      expect(sil, isA<PowerLevel>());

      var spl = SoundPressureLevel(Force(N: 20), Force(N: 10));
      expect(spl, isA<FieldLevel>());
    });
  });
}
