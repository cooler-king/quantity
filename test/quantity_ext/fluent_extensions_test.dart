import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('Fluent Extensions and Shortcuts', () {
    test('num extensions', () {
      expect(5.meters, isA<Length>());
      expect(5.meters.inMeters, 5.0);

      expect(10.kilometers, isA<Length>());
      expect(10.kilometers.inKilometers, 10.0);
      expect(10.kilometers.inMeters, 10000.0);

      expect(100.centimeters.inMeters, 1.0);
      expect(1000.millimeters.inMeters, 1.0);
      expect(12.inches.inFeet, closeTo(1.0, 0.0001));
      expect(3.feet.inYards, closeTo(1.0, 0.0001));
      expect(1.miles.inFeet, 5280.0);

      expect(30.seconds, isA<Time>());
      expect(30.seconds.inSeconds, 30.0);
      expect(2.minutes.inSeconds, 120.0);
      expect(1.hours.inMinutes, 60.0);
      expect(1.days.inHours, 24.0);
      expect(500.milliseconds.inSeconds, 0.5);
      expect(1000000.microseconds.inSeconds, 1.0);
      expect(1000000000.nanoseconds.inSeconds, 1.0);

      expect(1000.grams.inKilograms, 1.0);
      expect(1.kilograms.inGrams, 1000.0);
      expect(1.pounds.inGrams, closeTo(453.59, 0.0001));

      expect(0.kelvins.inKelvins, 0.0);
      expect(0.celsius.inKelvins, 273.15);
      expect(32.fahrenheit.inCelsius, closeTo(0.0, 0.0001));

      expect(2.squareMeters.inSquareMeters, 2.0);
      expect(1.hectares.inSquareMeters, 10000.0);
      expect(1.acres.inSquareMeters, closeTo(4046.856, 0.01));

      expect(1.cubicMeters.inCubicMeters, 1.0);
      expect(1000.liters.inCubicMeters, 1.0);
      expect(1.gallons.inLiters, closeTo(3.78541, 0.0001));

      expect(10.metersPerSecond.inMetersPerSecond, 10.0);
      expect(36.kilometersPerHour.inMetersPerSecond, closeTo(10.0, 0.0001));
      expect(60.milesPerHour.inMilesPerHour, 60.0);

      expect(9.8.metersPerSecondSquared.inMetersPerSecondSquared, 9.8);

      expect(1.radians.inRadians, 1.0);
      expect(180.degrees.inRadians, closeTo(3.1415926535, 0.00001));

      expect(100.joules.inJoules, 100.0);
      expect(1.calories.inJoules, closeTo(4.184, 0.0001));

      expect(5.watts.inWatts, 5.0);
      expect(2.kilowatts.inWatts, 2000.0);
      expect(1.horsepower.inWatts, closeTo(745.7, 0.1));

      // Token and TokenRate
      expect(100.tokens, isA<Token>());
      expect(100.tokens.inTokens, 100.0);
      expect(50.tps, isA<TokenRate>());
      expect(50.tps.inTps, 50.0);
      expect(50.tokensPerSecond.inTokensPerSecond, 50.0);

      // Pixel and Resolution
      expect(1920.pixels, isA<Pixel>());
      expect(1920.pixels.inPixels, 1920.0);
      expect(96.ppi, isA<Resolution>());
      expect(96.ppi.inPpi, 96.0);
      expect(10.dpcm, isA<Resolution>());
      expect(10.dpcm.inDpcm, 10.0);
    });

    test('Number extensions', () {
      final numVal = Integer(5);
      expect(numVal.meters, isA<Length>());
      expect(numVal.meters.inMeters, 5.0);

      expect(Double(10).kilometers.inMeters, 10000.0);
      expect(Double(100).centimeters.inMeters, 1.0);
      expect(Double(1000).millimeters.inMeters, 1.0);
      expect(Double(12).inches.inFeet, closeTo(1.0, 0.0001));
      expect(Integer(3).feet.inYards, closeTo(1.0, 0.0001));
      expect(Integer(1).yards.inFeet, 3.0);
      expect(Integer(1).miles.inFeet, 5280.0);

      expect(Double(30).seconds.inSeconds, 30.0);
      expect(Integer(500).milliseconds.inSeconds, 0.5);
      expect(Integer(1000000).microseconds.inSeconds, 1.0);
      expect(Integer(1000000000).nanoseconds.inSeconds, 1.0);
      expect(Integer(2).minutes.inSeconds, 120.0);
      expect(Double(1).hours.inMinutes, 60.0);
      expect(Double(1).days.inHours, 24.0);

      expect(Integer(1000).grams.inKilograms, 1.0);
      expect(Integer(1).kilograms.inGrams, 1000.0);
      expect(Double(1).pounds.inGrams, closeTo(453.59, 0.0001));

      expect(Double(0).kelvins.inKelvins, 0.0);
      expect(Double(0).celsius.inKelvins, 273.15);
      expect(Double(32).fahrenheit.inCelsius, closeTo(0.0, 0.0001));

      expect(Double(2).squareMeters.inSquareMeters, 2.0);
      expect(Integer(1).hectares.inSquareMeters, 10000.0);
      expect(Double(1).acres.inSquareMeters, closeTo(4046.856, 0.01));

      expect(Double(1).cubicMeters.inCubicMeters, 1.0);
      expect(Integer(1000).liters.inCubicMeters, 1.0);
      expect(Double(1).gallons.inLiters, closeTo(3.78541, 0.0001));

      expect(Integer(10).metersPerSecond.inMetersPerSecond, 10.0);
      expect(Double(36).kilometersPerHour.inMetersPerSecond, closeTo(10.0, 0.0001));
      expect(Integer(60).milesPerHour.inMilesPerHour, 60.0);
      expect(Double(9.8).metersPerSecondSquared.inMetersPerSecondSquared, 9.8);

      expect(Double(1).radians.inRadians, 1.0);
      expect(Double(180).degrees.inRadians, closeTo(3.1415926535, 0.00001));

      expect(Integer(100).joules.inJoules, 100.0);
      expect(Double(1).calories.inJoules, closeTo(4.184, 0.0001));

      expect(Double(5).watts.inWatts, 5.0);
      expect(Integer(2).kilowatts.inWatts, 2000.0);
      expect(Double(1).horsepower.inWatts, closeTo(745.7, 0.1));

      expect(Integer(100).tokens.inTokens, 100.0);
      expect(Double(50).tps.inTps, 50.0);
      expect(Double(50).tokensPerSecond.inTokensPerSecond, 50.0);

      expect(Integer(1920).pixels.inPixels, 1920.0);
      expect(Double(96).ppi.inPpi, 96.0);
      expect(Double(10).dpcm.inDpcm, 10.0);
    });
  });
}
