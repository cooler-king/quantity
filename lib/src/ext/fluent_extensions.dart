import '../../quantity.dart';
import 'area_ext.dart' as ar_ext;
import 'energy_ext.dart' as en_ext;
import 'length_ext.dart' as len_ext;
import 'mass_ext.dart' as ms_ext;
import 'power_ext.dart' as pow_ext;
import 'speed_ext.dart' as sp_ext;
import 'temperature_ext.dart' as temp_ext;
import 'volume_ext.dart' as vol_ext;

/// Extension getters on [num] to fluently construct physical quantities.
extension FluentNumExtension on num {
  // Length
  Length get meters => Length(m: this);
  Length get kilometers => Length.inUnits(this, len_ext.kilometers);
  Length get centimeters => Length.inUnits(this, len_ext.centimeters);
  Length get millimeters => Length(mm: this);
  Length get inches => Length.inUnits(this, len_ext.inches);
  Length get feet => Length.inUnits(this, len_ext.feet);
  Length get yards => Length.inUnits(this, len_ext.yards);
  Length get miles => Length.inUnits(this, len_ext.miles);

  // Time
  Time get seconds => Time(s: this);
  Time get milliseconds => Time(ms: this);
  Time get microseconds => Time.inUnits(this, Time.microseconds);
  Time get nanoseconds => Time(ns: this);
  Time get minutes => Time(min: this);
  Time get hours => Time(h: this);
  Time get days => Time(d: this);

  // Mass
  Mass get grams => Mass(g: this);
  Mass get kilograms => Mass(kg: this);
  Mass get pounds => Mass.inUnits(this, ms_ext.poundsAvoirdupois);

  // Temperature
  Temperature get kelvins => Temperature(K: this);
  Temperature get celsius => Temperature(C: this);
  Temperature get fahrenheit => Temperature.inUnits(this, temp_ext.Fahrenheit);

  // Area
  Area get squareMeters => Area(m2: this);
  Area get hectares => Area(ha: this);
  Area get acres => Area.inUnits(this, ar_ext.acres);

  // Volume
  Volume get cubicMeters => Volume(m3: this);
  Volume get liters => Volume(L: this);
  Volume get gallons => Volume.inUnits(this, vol_ext.gallonsUSLiquid);

  // Speed
  Speed get metersPerSecond => Speed(metersPerSecond: this);
  Speed get kilometersPerHour => Speed.inUnits(this, sp_ext.kilometersPerHour);
  Speed get milesPerHour => Speed.inUnits(this, sp_ext.milesPerHour);

  // Acceleration
  Acceleration get metersPerSecondSquared =>
      Acceleration(metersPerSecondSquared: this);

  // Angle
  Angle get radians => Angle(rad: this);
  Angle get degrees => Angle(deg: this);

  // Energy
  Energy get joules => Energy(J: this);
  Energy get calories => Energy.inUnits(this, en_ext.caloriesThermo);

  // Power
  Power get watts => Power(W: this);
  Power get kilowatts => Power(kW: this);
  Power get horsepower => Power.inUnits(this, pow_ext.horsepower550);

  // Token
  Token get tokens => Token(tokens: this);
  TokenRate get tps => TokenRate(tps: this);
  TokenRate get tokensPerSecond => TokenRate(tps: this);

  // Pixel & Resolution
  Pixel get pixels => Pixel(pixels: this);
  Resolution get ppi => Resolution(ppi: this);
  Resolution get dpcm => Resolution(dpcm: this);
}

/// Extension getters on [Number] to fluently construct physical quantities.
extension FluentNumberExtension on Number {
  // Length
  Length get meters => Length(m: this);
  Length get kilometers => Length.inUnits(this, len_ext.kilometers);
  Length get centimeters => Length.inUnits(this, len_ext.centimeters);
  Length get millimeters => Length(mm: this);
  Length get inches => Length.inUnits(this, len_ext.inches);
  Length get feet => Length.inUnits(this, len_ext.feet);
  Length get yards => Length.inUnits(this, len_ext.yards);
  Length get miles => Length.inUnits(this, len_ext.miles);

  // Time
  Time get seconds => Time(s: this);
  Time get milliseconds => Time(ms: this);
  Time get microseconds => Time.inUnits(this, Time.microseconds);
  Time get nanoseconds => Time(ns: this);
  Time get minutes => Time(min: this);
  Time get hours => Time(h: this);
  Time get days => Time(d: this);

  // Mass
  Mass get grams => Mass(g: this);
  Mass get kilograms => Mass(kg: this);
  Mass get pounds => Mass.inUnits(this, ms_ext.poundsAvoirdupois);

  // Temperature
  Temperature get kelvins => Temperature(K: this);
  Temperature get celsius => Temperature(C: this);
  Temperature get fahrenheit => Temperature.inUnits(this, temp_ext.Fahrenheit);

  // Area
  Area get squareMeters => Area(m2: this);
  Area get hectares => Area(ha: this);
  Area get acres => Area.inUnits(this, ar_ext.acres);

  // Volume
  Volume get cubicMeters => Volume(m3: this);
  Volume get liters => Volume(L: this);
  Volume get gallons => Volume.inUnits(this, vol_ext.gallonsUSLiquid);

  // Speed
  Speed get metersPerSecond => Speed(metersPerSecond: this);
  Speed get kilometersPerHour => Speed.inUnits(this, sp_ext.kilometersPerHour);
  Speed get milesPerHour => Speed.inUnits(this, sp_ext.milesPerHour);

  // Acceleration
  Acceleration get metersPerSecondSquared =>
      Acceleration(metersPerSecondSquared: this);

  // Angle
  Angle get radians => Angle(rad: this);
  Angle get degrees => Angle(deg: this);

  // Energy
  Energy get joules => Energy(J: this);
  Energy get calories => Energy.inUnits(this, en_ext.caloriesThermo);

  // Power
  Power get watts => Power(W: this);
  Power get kilowatts => Power(kW: this);
  Power get horsepower => Power.inUnits(this, pow_ext.horsepower550);

  // Token
  Token get tokens => Token(tokens: this);
  TokenRate get tps => TokenRate(tps: this);
  TokenRate get tokensPerSecond => TokenRate(tps: this);

  // Pixel & Resolution
  Pixel get pixels => Pixel(pixels: this);
  Resolution get ppi => Resolution(ppi: this);
  Resolution get dpcm => Resolution(dpcm: this);
}

/// Unit shortcut conversions on [Length].
extension LengthShortcuts on Length {
  double get inMeters => valueInUnits(Length.meters).toDouble();
  double get inKilometers => valueInUnits(len_ext.kilometers).toDouble();
  double get inCentimeters => valueInUnits(len_ext.centimeters).toDouble();
  double get inMillimeters => valueInUnits(Length.millimeters).toDouble();
  double get inInches => valueInUnits(len_ext.inches).toDouble();
  double get inFeet => valueInUnits(len_ext.feet).toDouble();
  double get inYards => valueInUnits(len_ext.yards).toDouble();
  double get inMiles => valueInUnits(len_ext.miles).toDouble();
}

/// Unit shortcut conversions on [Time].
extension TimeShortcuts on Time {
  double get inSeconds => valueInUnits(Time.seconds).toDouble();
  double get inMilliseconds => valueInUnits(Time.milliseconds).toDouble();
  double get inMicroseconds => valueInUnits(Time.microseconds).toDouble();
  double get inNanoseconds => valueInUnits(Time.nanoseconds).toDouble();
  double get inMinutes => valueInUnits(Time.minutes).toDouble();
  double get inHours => valueInUnits(Time.hours).toDouble();
  double get inDays => valueInUnits(Time.days).toDouble();
}

/// Unit shortcut conversions on [Mass].
extension MassShortcuts on Mass {
  double get inGrams => valueInUnits(Mass.grams).toDouble();
  double get inKilograms => valueInUnits(Mass.kilograms).toDouble();
  double get inPounds => valueInUnits(ms_ext.poundsAvoirdupois).toDouble();
}

/// Unit shortcut conversions on [Temperature].
extension TemperatureShortcuts on Temperature {
  double get inKelvins => valueInUnits(Temperature.kelvins).toDouble();
  double get inCelsius => valueInUnits(Temperature.degreesCelsius).toDouble();
  double get inFahrenheit => valueInUnits(temp_ext.Fahrenheit).toDouble();
}

/// Unit shortcut conversions on [Area].
extension AreaShortcuts on Area {
  double get inSquareMeters => valueInUnits(Area.squareMeters).toDouble();
  double get inHectares => valueInUnits(Area.hectares).toDouble();
  double get inAcres => valueInUnits(ar_ext.acres).toDouble();
}

/// Unit shortcut conversions on [Volume].
extension VolumeShortcuts on Volume {
  double get inCubicMeters => valueInUnits(Volume.cubicMeters).toDouble();
  double get inLiters => valueInUnits(Volume.liters).toDouble();
  double get inGallons => valueInUnits(vol_ext.gallonsUSLiquid).toDouble();
}

/// Unit shortcut conversions on [Speed].
extension SpeedShortcuts on Speed {
  double get inMetersPerSecond =>
      valueInUnits(Speed.metersPerSecond).toDouble();
  double get inKilometersPerHour =>
      valueInUnits(sp_ext.kilometersPerHour).toDouble();
  double get inMilesPerHour => valueInUnits(sp_ext.milesPerHour).toDouble();
}

/// Unit shortcut conversions on [Acceleration].
extension AccelerationShortcuts on Acceleration {
  double get inMetersPerSecondSquared =>
      valueInUnits(Acceleration.metersPerSecondSquared).toDouble();
}

/// Unit shortcut conversions on [Angle].
extension AngleShortcuts on Angle {
  double get inRadians => valueInUnits(Angle.radians).toDouble();
  double get inDegrees => valueInUnits(Angle.degrees).toDouble();
}

/// Unit shortcut conversions on [Energy].
extension EnergyShortcuts on Energy {
  double get inJoules => valueInUnits(Energy.joules).toDouble();
  double get inCalories => valueInUnits(en_ext.caloriesThermo).toDouble();
}

/// Unit shortcut conversions on [Power].
extension PowerShortcuts on Power {
  double get inWatts => valueInUnits(Power.watts).toDouble();
  double get inKilowatts => valueInUnits(Power.kilowatts).toDouble();
  double get inHorsepower => valueInUnits(pow_ext.horsepower550).toDouble();
}

/// Unit shortcut conversions on [Token].
extension TokenShortcuts on Token {
  double get inTokens => valueInUnits(Token.tokens).toDouble();
}

/// Unit shortcut conversions on [TokenRate].
extension TokenRateShortcuts on TokenRate {
  double get inTokensPerSecond =>
      valueInUnits(TokenRate.tokensPerSecond).toDouble();
  double get inTps => valueInUnits(TokenRate.tokensPerSecond).toDouble();
}

/// Unit shortcut conversions on [Pixel].
extension PixelShortcuts on Pixel {
  double get inPixels => valueInUnits(Pixel.pixels).toDouble();
}

/// Unit shortcut conversions on [Resolution].
extension ResolutionShortcuts on Resolution {
  double get inPpi => valueInUnits(Resolution.pixelsPerInch).toDouble();
  double get inDpcm => valueInUnits(Resolution.pixelsPerCentimeter).toDouble();
}
