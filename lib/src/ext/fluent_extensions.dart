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
  /// Constructs a [Length] in meters.
  Length get meters => Length(m: this);

  /// Constructs a [Length] in kilometers.
  Length get kilometers => Length.inUnits(this, len_ext.kilometers);

  /// Constructs a [Length] in centimeters.
  Length get centimeters => Length.inUnits(this, len_ext.centimeters);

  /// Constructs a [Length] in millimeters.
  Length get millimeters => Length(mm: this);

  /// Constructs a [Length] in inches.
  Length get inches => Length.inUnits(this, len_ext.inches);

  /// Constructs a [Length] in feet.
  Length get feet => Length.inUnits(this, len_ext.feet);

  /// Constructs a [Length] in yards.
  Length get yards => Length.inUnits(this, len_ext.yards);

  /// Constructs a [Length] in miles.
  Length get miles => Length.inUnits(this, len_ext.miles);

  // Time
  /// Constructs a [Time] in seconds.
  Time get seconds => Time(s: this);

  /// Constructs a [Time] in milliseconds.
  Time get milliseconds => Time(ms: this);

  /// Constructs a [Time] in microseconds.
  Time get microseconds => Time.inUnits(this, Time.microseconds);

  /// Constructs a [Time] in nanoseconds.
  Time get nanoseconds => Time(ns: this);

  /// Constructs a [Time] in minutes.
  Time get minutes => Time(min: this);

  /// Constructs a [Time] in hours.
  Time get hours => Time(h: this);

  /// Constructs a [Time] in days.
  Time get days => Time(d: this);

  // Mass
  /// Constructs a [Mass] in grams.
  Mass get grams => Mass(g: this);

  /// Constructs a [Mass] in kilograms.
  Mass get kilograms => Mass(kg: this);

  /// Constructs a [Mass] in pounds.
  Mass get pounds => Mass.inUnits(this, ms_ext.poundsAvoirdupois);

  // Temperature
  /// Constructs a [Temperature] in Kelvins.
  Temperature get kelvins => Temperature(K: this);

  /// Constructs a [Temperature] in degrees Celsius.
  Temperature get celsius => Temperature(C: this);

  /// Constructs a [Temperature] in degrees Fahrenheit.
  Temperature get fahrenheit => Temperature.inUnits(this, temp_ext.Fahrenheit);

  // Area
  /// Constructs an [Area] in square meters.
  Area get squareMeters => Area(m2: this);

  /// Constructs an [Area] in hectares.
  Area get hectares => Area(ha: this);

  /// Constructs an [Area] in acres.
  Area get acres => Area.inUnits(this, ar_ext.acres);

  // Volume
  /// Constructs a [Volume] in cubic meters.
  Volume get cubicMeters => Volume(m3: this);

  /// Constructs a [Volume] in liters.
  Volume get liters => Volume(L: this);

  /// Constructs a [Volume] in gallons.
  Volume get gallons => Volume.inUnits(this, vol_ext.gallonsUSLiquid);

  // Speed
  /// Constructs a [Speed] in meters per second.
  Speed get metersPerSecond => Speed(metersPerSecond: this);

  /// Constructs a [Speed] in kilometers per hour.
  Speed get kilometersPerHour => Speed.inUnits(this, sp_ext.kilometersPerHour);

  /// Constructs a [Speed] in miles per hour.
  Speed get milesPerHour => Speed.inUnits(this, sp_ext.milesPerHour);

  // Acceleration
  /// Constructs an [Acceleration] in meters per second squared.
  Acceleration get metersPerSecondSquared =>
      Acceleration(metersPerSecondSquared: this);

  // Angle
  /// Constructs an [Angle] in radians.
  Angle get radians => Angle(rad: this);

  /// Constructs an [Angle] in degrees.
  Angle get degrees => Angle(deg: this);

  // Energy
  /// Constructs an [Energy] in joules.
  Energy get joules => Energy(J: this);

  /// Constructs an [Energy] in calories.
  Energy get calories => Energy.inUnits(this, en_ext.caloriesThermo);

  // Power
  /// Constructs a [Power] in watts.
  Power get watts => Power(W: this);

  /// Constructs a [Power] in kilowatts.
  Power get kilowatts => Power(kW: this);

  /// Constructs a [Power] in mechanical horsepower.
  Power get horsepower => Power.inUnits(this, pow_ext.horsepower550);

  // Token
  /// Constructs a [Token] in tokens.
  Token get tokens => Token(tokens: this);

  /// Constructs a [TokenRate] in tokens per second.
  TokenRate get tps => TokenRate(tps: this);

  /// Constructs a [TokenRate] in tokens per second.
  TokenRate get tokensPerSecond => TokenRate(tps: this);

  // Pixel & Resolution
  /// Constructs a [Pixel] in pixels.
  Pixel get pixels => Pixel(pixels: this);

  /// Constructs a [Resolution] in pixels per inch.
  Resolution get ppi => Resolution(ppi: this);

  /// Constructs a [Resolution] in pixels per centimeter.
  Resolution get dpcm => Resolution(dpcm: this);
}

/// Extension getters on [Number] to fluently construct physical quantities.
extension FluentNumberExtension on Number {
  // Length
  /// Constructs a [Length] in meters.
  Length get meters => Length(m: this);

  /// Constructs a [Length] in kilometers.
  Length get kilometers => Length.inUnits(this, len_ext.kilometers);

  /// Constructs a [Length] in centimeters.
  Length get centimeters => Length.inUnits(this, len_ext.centimeters);

  /// Constructs a [Length] in millimeters.
  Length get millimeters => Length(mm: this);

  /// Constructs a [Length] in inches.
  Length get inches => Length.inUnits(this, len_ext.inches);

  /// Constructs a [Length] in feet.
  Length get feet => Length.inUnits(this, len_ext.feet);

  /// Constructs a [Length] in yards.
  Length get yards => Length.inUnits(this, len_ext.yards);

  /// Constructs a [Length] in miles.
  Length get miles => Length.inUnits(this, len_ext.miles);

  // Time
  /// Constructs a [Time] in seconds.
  Time get seconds => Time(s: this);

  /// Constructs a [Time] in milliseconds.
  Time get milliseconds => Time(ms: this);

  /// Constructs a [Time] in microseconds.
  Time get microseconds => Time.inUnits(this, Time.microseconds);

  /// Constructs a [Time] in nanoseconds.
  Time get nanoseconds => Time(ns: this);

  /// Constructs a [Time] in minutes.
  Time get minutes => Time(min: this);

  /// Constructs a [Time] in hours.
  Time get hours => Time(h: this);

  /// Constructs a [Time] in days.
  Time get days => Time(d: this);

  // Mass
  /// Constructs a [Mass] in grams.
  Mass get grams => Mass(g: this);

  /// Constructs a [Mass] in kilograms.
  Mass get kilograms => Mass(kg: this);

  /// Constructs a [Mass] in pounds.
  Mass get pounds => Mass.inUnits(this, ms_ext.poundsAvoirdupois);

  // Temperature
  /// Constructs a [Temperature] in Kelvins.
  Temperature get kelvins => Temperature(K: this);

  /// Constructs a [Temperature] in degrees Celsius.
  Temperature get celsius => Temperature(C: this);

  /// Constructs a [Temperature] in degrees Fahrenheit.
  Temperature get fahrenheit => Temperature.inUnits(this, temp_ext.Fahrenheit);

  // Area
  /// Constructs an [Area] in square meters.
  Area get squareMeters => Area(m2: this);

  /// Constructs an [Area] in hectares.
  Area get hectares => Area(ha: this);

  /// Constructs an [Area] in acres.
  Area get acres => Area.inUnits(this, ar_ext.acres);

  // Volume
  /// Constructs a [Volume] in cubic meters.
  Volume get cubicMeters => Volume(m3: this);

  /// Constructs a [Volume] in liters.
  Volume get liters => Volume(L: this);

  /// Constructs a [Volume] in gallons.
  Volume get gallons => Volume.inUnits(this, vol_ext.gallonsUSLiquid);

  // Speed
  /// Constructs a [Speed] in meters per second.
  Speed get metersPerSecond => Speed(metersPerSecond: this);

  /// Constructs a [Speed] in kilometers per hour.
  Speed get kilometersPerHour => Speed.inUnits(this, sp_ext.kilometersPerHour);

  /// Constructs a [Speed] in miles per hour.
  Speed get milesPerHour => Speed.inUnits(this, sp_ext.milesPerHour);

  // Acceleration
  /// Constructs an [Acceleration] in meters per second squared.
  Acceleration get metersPerSecondSquared =>
      Acceleration(metersPerSecondSquared: this);

  // Angle
  /// Constructs an [Angle] in radians.
  Angle get radians => Angle(rad: this);

  /// Constructs an [Angle] in degrees.
  Angle get degrees => Angle(deg: this);

  // Energy
  /// Constructs an [Energy] in joules.
  Energy get joules => Energy(J: this);

  /// Constructs an [Energy] in calories.
  Energy get calories => Energy.inUnits(this, en_ext.caloriesThermo);

  // Power
  /// Constructs a [Power] in watts.
  Power get watts => Power(W: this);

  /// Constructs a [Power] in kilowatts.
  Power get kilowatts => Power(kW: this);

  /// Constructs a [Power] in mechanical horsepower.
  Power get horsepower => Power.inUnits(this, pow_ext.horsepower550);

  // Token
  /// Constructs a [Token] in tokens.
  Token get tokens => Token(tokens: this);

  /// Constructs a [TokenRate] in tokens per second.
  TokenRate get tps => TokenRate(tps: this);

  /// Constructs a [TokenRate] in tokens per second.
  TokenRate get tokensPerSecond => TokenRate(tps: this);

  // Pixel & Resolution
  /// Constructs a [Pixel] in pixels.
  Pixel get pixels => Pixel(pixels: this);

  /// Constructs a [Resolution] in pixels per inch.
  Resolution get ppi => Resolution(ppi: this);

  /// Constructs a [Resolution] in pixels per centimeter.
  Resolution get dpcm => Resolution(dpcm: this);
}

/// Unit shortcut conversions on [Length].
extension LengthShortcuts on Length {
  /// Returns the value of this [Length] in meters.
  double get inMeters => valueInUnits(Length.meters).toDouble();

  /// Returns the value of this [Length] in kilometers.
  double get inKilometers => valueInUnits(len_ext.kilometers).toDouble();

  /// Returns the value of this [Length] in centimeters.
  double get inCentimeters => valueInUnits(len_ext.centimeters).toDouble();

  /// Returns the value of this [Length] in millimeters.
  double get inMillimeters => valueInUnits(Length.millimeters).toDouble();

  /// Returns the value of this [Length] in inches.
  double get inInches => valueInUnits(len_ext.inches).toDouble();

  /// Returns the value of this [Length] in feet.
  double get inFeet => valueInUnits(len_ext.feet).toDouble();

  /// Returns the value of this [Length] in yards.
  double get inYards => valueInUnits(len_ext.yards).toDouble();

  /// Returns the value of this [Length] in miles.
  double get inMiles => valueInUnits(len_ext.miles).toDouble();
}

/// Unit shortcut conversions on [Time].
extension TimeShortcuts on Time {
  /// Returns the value of this [Time] in seconds.
  double get inSeconds => valueInUnits(Time.seconds).toDouble();

  /// Returns the value of this [Time] in milliseconds.
  double get inMilliseconds => valueInUnits(Time.milliseconds).toDouble();

  /// Returns the value of this [Time] in microseconds.
  double get inMicroseconds => valueInUnits(Time.microseconds).toDouble();

  /// Returns the value of this [Time] in nanoseconds.
  double get inNanoseconds => valueInUnits(Time.nanoseconds).toDouble();

  /// Returns the value of this [Time] in minutes.
  double get inMinutes => valueInUnits(Time.minutes).toDouble();

  /// Returns the value of this [Time] in hours.
  double get inHours => valueInUnits(Time.hours).toDouble();

  /// Returns the value of this [Time] in days.
  double get inDays => valueInUnits(Time.days).toDouble();
}

/// Unit shortcut conversions on [Mass].
extension MassShortcuts on Mass {
  /// Returns the value of this [Mass] in grams.
  double get inGrams => valueInUnits(Mass.grams).toDouble();

  /// Returns the value of this [Mass] in kilograms.
  double get inKilograms => valueInUnits(Mass.kilograms).toDouble();

  /// Returns the value of this [Mass] in pounds.
  double get inPounds => valueInUnits(ms_ext.poundsAvoirdupois).toDouble();
}

/// Unit shortcut conversions on [Temperature].
extension TemperatureShortcuts on Temperature {
  /// Returns the value of this [Temperature] in Kelvins.
  double get inKelvins => valueInUnits(Temperature.kelvins).toDouble();

  /// Returns the value of this [Temperature] in degrees Celsius.
  double get inCelsius => valueInUnits(Temperature.degreesCelsius).toDouble();

  /// Returns the value of this [Temperature] in degrees Fahrenheit.
  double get inFahrenheit => valueInUnits(temp_ext.Fahrenheit).toDouble();
}

/// Unit shortcut conversions on [Area].
extension AreaShortcuts on Area {
  /// Returns the value of this [Area] in square meters.
  double get inSquareMeters => valueInUnits(Area.squareMeters).toDouble();

  /// Returns the value of this [Area] in hectares.
  double get inHectares => valueInUnits(Area.hectares).toDouble();

  /// Returns the value of this [Area] in acres.
  double get inAcres => valueInUnits(ar_ext.acres).toDouble();
}

/// Unit shortcut conversions on [Volume].
extension VolumeShortcuts on Volume {
  /// Returns the value of this [Volume] in cubic meters.
  double get inCubicMeters => valueInUnits(Volume.cubicMeters).toDouble();

  /// Returns the value of this [Volume] in liters.
  double get inLiters => valueInUnits(Volume.liters).toDouble();

  /// Returns the value of this [Volume] in U.S. liquid gallons.
  double get inGallons => valueInUnits(vol_ext.gallonsUSLiquid).toDouble();
}

/// Unit shortcut conversions on [Speed].
extension SpeedShortcuts on Speed {
  /// Returns the value of this [Speed] in meters per second.
  double get inMetersPerSecond =>
      valueInUnits(Speed.metersPerSecond).toDouble();

  /// Returns the value of this [Speed] in kilometers per hour.
  double get inKilometersPerHour =>
      valueInUnits(sp_ext.kilometersPerHour).toDouble();

  /// Returns the value of this [Speed] in miles per hour.
  double get inMilesPerHour => valueInUnits(sp_ext.milesPerHour).toDouble();
}

/// Unit shortcut conversions on [Acceleration].
extension AccelerationShortcuts on Acceleration {
  /// Returns the value of this [Acceleration] in meters per second squared.
  double get inMetersPerSecondSquared =>
      valueInUnits(Acceleration.metersPerSecondSquared).toDouble();
}

/// Unit shortcut conversions on [Angle].
extension AngleShortcuts on Angle {
  /// Returns the value of this [Angle] in radians.
  double get inRadians => valueInUnits(Angle.radians).toDouble();

  /// Returns the value of this [Angle] in degrees.
  double get inDegrees => valueInUnits(Angle.degrees).toDouble();
}

/// Unit shortcut conversions on [Energy].
extension EnergyShortcuts on Energy {
  /// Returns the value of this [Energy] in joules.
  double get inJoules => valueInUnits(Energy.joules).toDouble();

  /// Returns the value of this [Energy] in calories.
  double get inCalories => valueInUnits(en_ext.caloriesThermo).toDouble();
}

/// Unit shortcut conversions on [Power].
extension PowerShortcuts on Power {
  /// Returns the value of this [Power] in watts.
  double get inWatts => valueInUnits(Power.watts).toDouble();

  /// Returns the value of this [Power] in kilowatts.
  double get inKilowatts => valueInUnits(Power.kilowatts).toDouble();

  /// Returns the value of this [Power] in mechanical horsepower.
  double get inHorsepower => valueInUnits(pow_ext.horsepower550).toDouble();
}

/// Unit shortcut conversions on [Token].
extension TokenShortcuts on Token {
  /// Returns the value of this [Token] in tokens.
  double get inTokens => valueInUnits(Token.tokens).toDouble();
}

/// Unit shortcut conversions on [TokenRate].
extension TokenRateShortcuts on TokenRate {
  /// Returns the value of this [TokenRate] in tokens per second.
  double get inTokensPerSecond =>
      valueInUnits(TokenRate.tokensPerSecond).toDouble();

  /// Returns the value of this [TokenRate] in tokens per second.
  double get inTps => valueInUnits(TokenRate.tokensPerSecond).toDouble();
}

/// Unit shortcut conversions on [Pixel].
extension PixelShortcuts on Pixel {
  /// Returns the value of this [Pixel] in pixels.
  double get inPixels => valueInUnits(Pixel.pixels).toDouble();
}

/// Unit shortcut conversions on [Resolution].
extension ResolutionShortcuts on Resolution {
  /// Returns the value of this [Resolution] in pixels per inch.
  double get inPpi => valueInUnits(Resolution.pixelsPerInch).toDouble();

  /// Returns the value of this [Resolution] in pixels per centimeter.
  double get inDpcm => valueInUnits(Resolution.pixelsPerCentimeter).toDouble();
}
