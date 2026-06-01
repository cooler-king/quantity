import 'package:logging/logging.dart';
import 'dimensions.dart';
import 'dimensions_exception.dart';
import 'misc_quantity.dart';
import 'quantity.dart';
import 'units.dart';

/// Logger for use across entire library
Logger logger = Logger('quantity core')
  ..onRecord.listen((LogRecord record) {
    // ignore: avoid_print
    print('${record.level}: ${record.message}');
    // ignore: avoid_print
    if (record.error != null) print('   ERROR:  ${record.error}');
    // ignore: avoid_print
    if (record.stackTrace != null) print(record.stackTrace);
  });

/// Dynamic quantity typing may be turned off for increased
/// efficiency.  If false, the result of operations where
/// dimensions may change will be MiscQuantity type objects.
bool dynamicQuantityTyping = true;

/// Maps each quantity type to a function that can be used to create an instance of that type.
final Map<Type, Function> _typeInstantiatorMap = <Type, Function>{};

/// Maps each dimensions object to a physical quantity type.
final Map<Dimensions, Type> _dimensionsToTypeMap = <Dimensions, Type>{};

Map<Dimensions, Type> get dimensionsToTypeMap => _dimensionsToTypeMap;

/// Maps synonym string names to their target physical quantity type.
final Map<String, Type> _synonymNameToTypeMap = <String, Type>{};

/// Set of physical quantity names that are preferred when resolving duplicate dimensions (e.g. Time vs TimeInstant).
const Set<String> _preferredQuantityTypeNames = {
  'Length',
  'Mass',
  'Time',
  'TemperatureInterval',
  'Current',
  'LuminousIntensity',
  'AmountOfSubstance',
  'Angle',
  'SolidAngle',
  'AbsorbedDoseRate',
  'Acceleration',
  'AngularAcceleration',
  'AngularMomentum',
  'AngularSpeed',
  'Area',
  'CatalyticActivity',
  'Concentration',
  'DynamicViscosity',
  'Capacitance',
  'Charge',
  'ChargeDensity',
  'Conductance',
  'CurrentDensity',
  'ElectricFieldStrength',
  'ElectricFluxDensity',
  'ElectricPotentialDifference',
  'Resistance',
  'Energy',
  'Entropy',
  'Exposure',
  'Force',
  'Frequency',
  'HeatFluxDensity',
  'Illuminance',
  'Inductance',
  'KinematicViscosity',
  'Luminance',
  'LuminousFlux',
  'MagneticFieldStrength',
  'MagneticFlux',
  'MagneticFluxDensity',
  'MassDensity',
  'MassFlowRate',
  'MassFluxDensity',
  'MolarEnergy',
  'MolarEntropy',
  'Permeability',
  'Permittivity',
  'Power',
  'Pressure',
  'Radiance',
  'RadiantIntensity',
  'Scalar',
  'SpecificEnergy',
  'SpecificHeatCapacity',
  'SpecificVolume',
  'Speed',
  'SurfaceTension',
  'Volume',
  'VolumeFlowRate',
  'WaveNumber'
};

/// Trigger to initialize/register SI quantities. Populated by register_si.dart when loaded.
void Function()? siRegistryTrigger;

void _ensureRegistryInitialized() {
  if (siRegistryTrigger != null) {
    final trigger = siRegistryTrigger!;
    siRegistryTrigger = null; // Prevent reentrancy / loop
    trigger();
  }
}

/// Registers a constructor function for a physical quantity type.
void registerQuantityType(
    Type type, Dimensions dimensions, Function instantiator) {
  _typeInstantiatorMap[type] = instantiator;

  final existingType = _dimensionsToTypeMap[dimensions];
  if (existingType == null) {
    _dimensionsToTypeMap[dimensions] = type;
  } else {
    final newName = type.toString();
    final oldName = existingType.toString();
    final newPreferred = _preferredQuantityTypeNames.contains(newName);
    final oldPreferred = _preferredQuantityTypeNames.contains(oldName);
    if (newPreferred && !oldPreferred) {
      _dimensionsToTypeMap[dimensions] = type;
    }
  }
}

/// Returns the quantity type associated with [dimensions], if registered.
Type? getRegisteredQuantityType(Dimensions dimensions) {
  _ensureRegistryInitialized();
  return _dimensionsToTypeMap[dimensions];
}

///  Returns whether or not [q] is one of the seven SI base quantities.
///
///  * If a quantity is not one of the seven base SI quantities, then it is a derived quantity.
///  * The seven base SI Quantities are [Length], [Mass], [Duration],
///  [Temperature], [Current], [LuminousIntensity] and [AmountOfSubstance].
bool siBaseQuantity(Quantity q) {
  final typeStr = q.runtimeType.toString();
  return typeStr == 'Length' ||
      typeStr == 'Mass' ||
      typeStr == 'Time' ||
      typeStr == 'Current' ||
      typeStr == 'TemperatureInterval' ||
      typeStr == 'Temperature' ||
      typeStr == 'AmountOfSubstance' ||
      typeStr == 'LuminousIntensity';
}

/// Returns whether or not the magnitude of the difference between two
/// quantities is less than or equal to the specified [tolerance].
bool areWithin(Quantity q1, Quantity q2, Quantity tolerance) {
  if (q1.dimensions != q2.dimensions || q2.dimensions != tolerance.dimensions) {
    throw DimensionsException(
        'The two quantities and tolerance must have the same dimensions');
  }

  return (q1 - q2).abs().valueSI <= tolerance.valueSI;
}

/// Returns whether or not [q] is a derived quantity (as
/// opposed to one of the seven base SI quantities).
///
/// * If a quantity is not one of the seven base SI quantities, then it is
///   a derived quantity.
/// * The seven base SI Quantities are Length, Mass, Duration,
///   Temperature, ElectricCurrent, LuminousIntensity and AmountOfSubstance.
/// * The two auxiliary angle-related base quantities (Angle and SolidAngle)
///   will return true as they are not proper base quantities but special
///   cases of Scalar quantities used by convention.
bool siDerivedQuantity(Quantity q) => !siBaseQuantity(q);

/// Returns an iterable of Type objects representing all of the quantity types
/// supported by this library (for example, Angle, Length, etc.).
///
///  * The Iterable provides the types in alphabetical order.
///  * [MiscQuantity] is not included (as it is a catch-all for
///    all quantity types that are NOT explicitly supported).
Iterable<Type> get allQuantityTypes {
  _ensureRegistryInitialized();
  return _typeInstantiatorMap.keys;
}

/// Resolves a dynamic Type from its String typeName representation by searching the registered physical quantity subclasses and synonyms.
Type? getRegisteredTypeByName(String typeName) {
  _ensureRegistryInitialized();
  final synonym = _synonymNameToTypeMap[typeName];
  if (synonym != null) return synonym;

  for (final type in _typeInstantiatorMap.keys) {
    if (type.toString() == typeName) {
      return type;
    }
  }
  return null;
}

/// Registers a synonym name for a target physical quantity type.
void registerQuantitySynonym(String synonymName, Type targetType) {
  _synonymNameToTypeMap[synonymName] = targetType;
}

/// Returns all registered synonym names for a given quantity type.
List<String> getQuantitySynonyms(Type type) {
  _ensureRegistryInitialized();
  final list = <String>[];
  _synonymNameToTypeMap.forEach((name, targetType) {
    if (targetType == type) {
      list.add(name);
    }
  });
  return list;
}

/// Creates an instance of a typed quantity of type [t] having the specified
/// [value] in [units].
///
/// If type [t] is not recognized a [MiscQuantity] with [value] and the dimensions
/// of [units] will be created and returned instead.  If units are null and the
/// the type is not recognized, then [dimensions] must be provided in order to
/// construct a MiscQuantity.  A DimensionsException will be thrown if null units
/// and null dimensions are detected for types that don't have an associated
/// instantiator.
///
/// The quantity's relative uncertainty can optionally be provided (defaults to 0).
Quantity createTypedQuantityInstance(Type t, dynamic value, Units? units,
    {double uncert = 0.0, Dimensions? dimensions}) {
  _ensureRegistryInitialized();
  final quantityInstantiator = _typeInstantiatorMap[t];
  if (quantityInstantiator != null) {
    return Function.apply(quantityInstantiator, <dynamic>[value, units, uncert])
        as Quantity;
  }

  // Fall back to MiscQuantity.
  if (dimensions == null && units == null) {
    throw DimensionsException(
        'Dimensions must be provided if units are not when creating an instance of an unrecognized quantity type');
  }
  return MiscQuantity(value, (units as Quantity).dimensions, uncert);
}

/// Maps a digit, decimal point or minus sign string to a unicode exponent character.
const Map<String, String> expUnicodeMap = <String, String>{
  '0': '\u{2070}',
  '1': '\u{00b9}',
  '2': '\u{00b2}',
  '3': '\u{00b3}',
  '4': '\u{2074}',
  '5': '\u{2075}',
  '6': '\u{2076}',
  '7': '\u{2077}',
  '8': '\u{2078}',
  '9': '\u{2079}',
  '.': '\u{02d9}',
  '-': '\u{207b}',
};

/// Returns the unicode symbols that represent an exponent.
String unicodeExponent(num exp) {
  final neg = exp < 0 ? '\u{207b}' : '';
  final absExp = exp.abs();
  final expStr = absExp.toString();
  final buf = StringBuffer()..write(neg);
  for (var place = 0; place < expStr.length; place++) {
    buf.write(expUnicodeMap[expStr[place]]);
  }

  return buf.toString();
}

String? condenseUnicodeSequences(String? input) {
  if (input == null) return null;

  final regex = RegExp(
      r'[\u2070\u00B9\u00B2\u00B3\u2074\u2075\u2076\u2077\u2078\u2079\u207B]{2,}');
  final superscriptToValue = {
    '\u{2070}': 0,
    '\u{00B9}': 1,
    '\u{00B2}': 2,
    '\u{00B3}': 3,
    '\u{2074}': 4,
    '\u{2075}': 5,
    '\u{2076}': 6,
    '\u{2077}': 7,
    '\u{2078}': 8,
    '\u{2079}': 9,
  };

  String digitToSuperscript(int digit) {
    if (digit == 0) return '\u{2070}';
    if (digit == 1) return '\u{00B9}';
    if (digit == 2) return '\u{00B2}';
    if (digit == 3) return '\u{00B3}';
    return String.fromCharCode(0x2070 + digit);
  }

  // Find all matches
  final matches = regex.allMatches(input).toList();
  if (matches.isEmpty) {
    return input; // No sequences found
  }

  // Build the result string step-by-step
  final buffer = StringBuffer();
  int previousEnd = 0;

  for (final match in matches) {
    // Add any text before the current match
    buffer.write(input.substring(previousEnd, match.start));

    final sequence = match.group(0)!;
    int sign = 1;
    int product = 1;

    // Calculate the product of the numbers in the superscript sequence
    for (var char in sequence.split('')) {
      if (char == '\u{207B}') {
        sign *= -1;
      } else {
        final value =
            superscriptToValue[char] ?? 1; // Default to 1 if unrecognized
        product *= value;
      }
    }

    // Determine the combined sign
    final combinedSign = sign == -1 ? '\u{207B}' : '';

    // Convert the product back to superscript format
    final productDigits = product.toString().split('');
    final combinedExponent = productDigits.map((digit) {
      final digitValue = int.parse(digit);
      return digitToSuperscript(digitValue);
    }).join('');

    // Replace the current sequence in the result
    buffer.write(combinedSign + combinedExponent);

    // Update the previousEnd to the end of the current match
    previousEnd = match.end;
  }

  // Add any remaining text after the last match
  buffer.write(input.substring(previousEnd));

  return buffer.toString();
}
