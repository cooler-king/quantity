import 'dart:math' show pow;
import 'package:quantity/quantity.dart';

class ParserHelpers {
  static final Map<String, Units> baseUnits = {
    'm': Length.meters,
    'g': Mass.grams,
    'kg': Mass.kilograms,
    's': Time.seconds,
    'A': Current.amperes,
    'K': Temperature.kelvins,
    'mol': AmountOfSubstance.moles,
    'cd': LuminousIntensity.candelas,
    'rad': Angle.radians,
    'sr': SolidAngle.steradians,
    'Hz': Frequency.hertz,
    'N': Force.newtons,
    'Pa': Pressure.pascals,
    'J': Energy.joules,
    'W': Power.watts,
    'C': Charge.coulombs,
    'V': ElectricPotentialDifference.volts,
    'F': Capacitance.farads,
    'ohm': Resistance.ohms,
    '\u2126': Resistance.ohms,
    '\u03A9': Resistance.ohms,
    'S': Conductance.siemens,
    'Wb': MagneticFlux.webers,
    'T': MagneticFluxDensity.teslas,
    'H': Inductance.henries,
    'lm': LuminousFlux.lumens,
    'lx': Illuminance.lux,
    'Bq': Activity.becquerels,
    'Gy': AbsorbedDose.grays,
    'Sv': DoseEquivalent.seiverts,
    'kat': CatalyticActivity.katals,
    'min': Time.minutes,
    'h': Time.hours,
    'd': Time.days,
    'l': Volume.liters,
    'L': Volume.liters,
    'deg': Angle.degrees,
    '°': Angle.degrees,
    'ft': feet,
    'in': inches,
    'lb': poundsAvoirdupois,
    'mph': milesPerHour,
    'tok': Token.tokens,
    'token': Token.tokens,
    'tokens': Token.tokens,
    'tps': TokenRate.tokensPerSecond,
    'px': Pixel.pixels,
    'pixel': Pixel.pixels,
    'pixels': Pixel.pixels,
    'ppi': Resolution.pixelsPerInch,
    'dpcm': Resolution.pixelsPerCentimeter,
    'm/s': Speed.metersPerSecond,
    'km/h': kilometersPerHour,
    'm/s2': Acceleration.metersPerSecondSquared,
    'm/s^2': Acceleration.metersPerSecondSquared,
    'N*m': Torque.newtonMeters,
    'N·m': Torque.newtonMeters,
    'Nm': Torque.newtonMeters,
  };

  static const Map<String, double> prefixes = {
    'Y': 1e24,
    'Z': 1e21,
    'E': 1e18,
    'P': 1e15,
    'T': 1e12,
    'G': 1e9,
    'M': 1e6,
    'k': 1e3,
    'h': 1e2,
    'da': 1e1,
    'd': 1e-1,
    'c': 1e-2,
    'm': 1e-3,
    'u': 1e-6,
    'n': 1e-9,
    'p': 1e-12,
    'f': 1e-15,
    'a': 1e-18,
    'z': 1e-21,
    'y': 1e-24,
  };

  static Quantity parse(String text) {
    // Ensure dynamic registry is initialized
    allQuantityTypes;

    final normalized = text.trim().replaceAll('·', '*');
    final match = RegExp(r'^\s*(-?[0-9.eE+-]+)\s*(.*)$').firstMatch(normalized);
    if (match == null) {
      throw FormatException('Could not parse quantity value from: $text');
    }

    final valueStr = match.group(1)!;
    final unitStr = match.group(2)!.trim();

    final numVal = num.parse(valueStr);
    final valueSI = numVal is int ? Integer(numVal) : Double(numVal.toDouble());

    if (unitStr.isEmpty) {
      return Scalar(value: valueSI);
    }

    final parts = unitStr.split('/');
    final numerator = parts[0].trim();
    final denominator = parts.length > 1 ? parts[1].trim() : '';

    final numTokens =
        numerator.split(RegExp(r'[\s*]')).where((s) => s.isNotEmpty).toList();
    final denTokens =
        denominator.split(RegExp(r'[\s*]')).where((s) => s.isNotEmpty).toList();

    var scaleFactor = 1.0;
    var dims = Dimensions();

    void processToken(String token, bool isDenominator) {
      final tokenMatch = RegExp(r'^([a-zA-Z°\u2126\u03A9]+)(?:\^?([0-9.-]+))?$')
          .firstMatch(token);
      if (tokenMatch == null) {
        throw FormatException('Invalid unit token: $token');
      }

      final unitName = tokenMatch.group(1)!;
      final exponentStr = tokenMatch.group(2);
      final exponent = exponentStr != null ? double.parse(exponentStr) : 1.0;

      final resolved = resolveUnit(unitName);
      final unit = resolved.unit;
      final prefMult = resolved.prefixMultiplier;

      final sign = isDenominator ? -1.0 : 1.0;
      final totalExponent = exponent * sign;

      scaleFactor *=
          pow(prefMult * (unit as Quantity).valueSI.toDouble(), totalExponent);

      final tokenDims = (unit as Quantity).dimensions;
      if (totalExponent == 1.0) {
        dims = dims * tokenDims;
      } else if (totalExponent == -1.0) {
        dims = dims / tokenDims;
      } else {
        // Construct dimensions manually for general exponents
        final map = <String, num>{};
        for (final key in tokenDims.toJson().keys) {
          map[key] = tokenDims.getComponentExponent(key) * totalExponent;
        }
        dims = dims * Dimensions.fromMap(map);
      }
    }

    for (final token in numTokens) {
      processToken(token, false);
    }
    for (final token in denTokens) {
      processToken(token, true);
    }

    final Number finalValueSI = valueSI * scaleFactor;

    var type = getRegisteredQuantityType(dims);
    if (type == Energy && (unitStr.contains('Nm') || unitStr.contains('N*m'))) {
      type = Torque;
      dims = Torque.torqueDimensions;
    } else if (unitStr.contains('tok') ||
        unitStr.contains('token') ||
        unitStr.contains('tps')) {
      if (dims == Token.tokenDimensions) {
        type = Token;
        dims = Token.tokenDimensions;
      } else if (dims == TokenRate.tokenRateDimensions) {
        type = TokenRate;
        dims = TokenRate.tokenRateDimensions;
      }
    } else if (unitStr.contains('px') ||
        unitStr.contains('pixel') ||
        unitStr.contains('ppi') ||
        unitStr.contains('dpcm')) {
      if (dims == Pixel.pixelDimensions) {
        type = Pixel;
        dims = Pixel.pixelDimensions;
      } else if (dims == Resolution.resolutionDimensions) {
        type = Resolution;
        dims = Resolution.resolutionDimensions;
      } else if (dims == PixelDensity.pixelDensityDimensions) {
        type = PixelDensity;
        dims = PixelDensity.pixelDensityDimensions;
      }
    }

    if (type != null) {
      return createTypedQuantityInstance(type, finalValueSI, null,
          dimensions: dims);
    }

    return MiscQuantity(finalValueSI, dims);
  }

  static ResolvedUnit resolveUnit(String name) {
    if (baseUnits.containsKey(name)) {
      return ResolvedUnit(baseUnits[name]!, 1.0);
    }

    // Check prefixes (longest first)
    final sortedPrefixes = prefixes.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    for (final pref in sortedPrefixes) {
      if (name.startsWith(pref)) {
        final rest = name.substring(pref.length);
        if (baseUnits.containsKey(rest)) {
          return ResolvedUnit(baseUnits[rest]!, prefixes[pref]!);
        }
      }
    }

    throw FormatException('Unknown unit symbol: $name');
  }

  static List<String> getUnitSymbols(Type type) {
    final symbols = <String>{};
    for (final entry in baseUnits.entries) {
      final unit = entry.value;
      if (unit.quantityType == type) {
        if (entry.key != '\u2126' && entry.key != '\u03A9') {
          // skip duplicate ohm symbols
          symbols.add(entry.key);
        }
      }
    }
    if (type == Speed) {
      symbols.addAll(['m/s', 'km/h']);
    } else if (type == Acceleration) {
      symbols.add('m/s^2');
    } else if (type == TokenRate) {
      symbols.addAll(['tok/s', 'token/s', 'tokens/s']);
    } else if (type == Resolution) {
      symbols.addAll(
          ['px/m', 'px/in', 'px/cm', 'pixels/m', 'pixels/in', 'pixels/cm']);
    } else if (type == PixelDensity) {
      symbols.addAll(['px/m2', 'px/in2', 'pixels/m2', 'pixels/in2']);
    }
    return symbols.toList()..sort();
  }
}

class ResolvedUnit {
  final Units unit;
  final double prefixMultiplier;
  ResolvedUnit(this.unit, this.prefixMultiplier);
}
