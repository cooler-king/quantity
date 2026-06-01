# quantity

[![pub.dev](https://img.shields.io/pub/v/quantity.svg)](https://pub.dev/packages/quantity)
[![Dart CI](https://github.com/cooler-king/quantity/actions/workflows/dart.yml/badge.svg)](https://github.com/cooler-king/quantity/actions/workflows/dart.yml)
[![codecov](https://codecov.io/gh/cooler-king/quantity/branch/master/graph/badge.svg)](https://codecov.io/gh/cooler-king/quantity)

Facilitates working with physical quantities such as angles, lengths, masses and temperatures.

In science and engineering it is critical to use units along with numerical values.
For example, 5 meters per second is decidedly _not_ the same speed as 5 feet per minute.
Calculations must include units, implicitly or explicitly, to be correct and useful.
This package provides classes for modeling quantities of specific types and their
associated units as well as their use in calculations.

The [International System of Units](https://physics.nist.gov/cuu/Units/index.html)
(often called 'SI' from its abbreviation in French) defines the quantity types, associated
units and constants used by scientists and engineers around the world. This package models
the SI base and derived quantities in its `quantity_si` library.

There are also many historical units, of course, that were around well before the SI came into
existence. These can be found in the `quantity_ext` library.

The `number` library adds support for quantities having values of arbitrary precision and the
`quantity_range` library adds special support for handling value ranges.

Together, these libraries give you the tools to maintain units discipline in your code
and make Dart a more attractive option for many science and engineering applications by
eliminating common mistakes and offering improved readability.

## Quick Start

```dart
import 'package:quantity/quantity.dart';

// Construct quantities with named-parameter constructors.
final speed = Speed(metersPerSecond: 30);
final dist  = Length(m: 1500);
final time  = Time(s: 50);

// Full arithmetic with automatic type inference.
final computed = dist / time;          // returns a Speed
print(computed);                       // '30 m/s'

// Fluent extension syntax for quick one-liners.
final ang  = 270.degrees;
final ang2 = 1.1.radians;
print((ang - ang2).inDegrees);        // degrees as a plain double

// Parse a string directly into a typed Quantity.
final q = Quantity.parse('120 km/h');
print(q.runtimeType);                 // Speed
print(q.valueInUnits(Speed.metersPerSecond)); // ~33.33

// Serialize to / from JSON.
final json  = q.toJson();
final back  = Quantity.fromJson(json);
```

## Key Features

### Core

- **75+ typed quantities** (`Length`, `Mass`, `Temperature`, `Speed`, `Force`, …) that are
  easy to construct and use in arithmetic — the correct result type is inferred automatically.
- **Encourages SI discipline** by isolating non-standard units in a separate extension library.
- **Relative standard uncertainty** is propagated through calculations automatically.
- **Arbitrary precision** via the `Precise` number type (as well as complex and imaginary
  values).
- **Official NIST constants** — current CODATA values are available as typed `const` objects
  and can be refreshed with `dart run bin/update_nist_constants.dart`.
- **Metric prefix support** on every unit (`unit.milli()`, `unit.kilo()`, …).
- **`MiscQuantity`** for untyped quantities with unusual dimensions.
- **Mutable quantities** with streams for reactive applications.
- **`Duration` / `DateTime` integration** — convert between Dart time types and `Time` /
  `TimeInstant` seamlessly.

### String Parsing (`Quantity.parse`)

Convert a plain string into a fully typed `Quantity` — ideal for reading user input, AI
responses, or configuration files.

```dart
Quantity.parse('5 m')          // → Length(5 m)
Quantity.parse('500 mg')       // → Mass(0.0005 kg)
Quantity.parse('9.8 m/s^2')   // → Acceleration
Quantity.parse('10 kg*m/s^2') // → Force (10 N)
Quantity.parse('15 N·m')      // → Torque
Quantity.parse('120 km / h')  // spaces around / and ^ are fine
Quantity.parse('5m')          // no space between value and unit is fine too
```

Supported features:
- SI base and derived units plus common non-SI units (`ft`, `in`, `lb`, `mph`, …)
- All SI metric prefixes (`k`, `M`, `G`, `m`, `µ`, `n`, …)
- Compound units with `/`, `*` and `^` (e.g. `kg*m/s^2`, `m/s^2`)
- Liberal whitespace handling — spaces around operators are normalised automatically
- Falls back to `MiscQuantity` for valid-but-unregistered dimension combinations

### Unit Conversion (`.to()` / `.valueInUnits()`)

```dart
final speed = Speed(metersPerSecond: 30);
print(speed.valueInUnits(Speed.kilometersPerHour)); // 108.0

final mass = Mass(kg: 1);
print(mass.valueInUnits(poundsAvoirdupois));        // ~2.205
```

Use `Quantity.getUnitSymbols(Speed)` to discover which symbol strings are accepted by
`Quantity.parse` for a given type:

```dart
Quantity.getUnitSymbols(Speed);        // ['km/h', 'm/s', 'mph', …]
Quantity.getUnitSymbols(Acceleration); // ['m/s^2', …]
```

### Serialization (`toJson` / `fromJson`)

Every `Quantity` can round-trip through JSON:

```dart
final length = Length(m: 42.0, uncert: 0.01);
final json   = length.toJson();
// {'type': 'Length', 'value': {'type': 'Double', 'value': '42.0'},
//  'dimensions': {'Length': 1}, 'uncertainty': 0.01}

final restored = Quantity.fromJson(json); // → Length(42 m)
```

Retrieve the JSON Schema describing the format (useful for LLM tool definitions):

```dart
final schema = Quantity.jsonSchema; // Map<String, dynamic> JSON Schema object
```

### AI / LLM Integration

Several utilities make it straightforward to use this library as a tool for an AI assistant.

#### `Quantity.parse` — accept natural-language unit strings

LLMs frequently output values such as `"120 km/h"` or `"9.8 m/s²"`. Feed them directly to
`Quantity.parse` and get a strongly typed result.

#### `Quantity.checkDimensionalConsistency` — validate formulas

Check whether a symbolic formula is dimensionally correct before evaluating it:

```dart
final vars = {
  's': Length.lengthDimensions,
  'u': Speed.speedDimensions,
  't': Time.timeDimensions,
  'a': Acceleration.accelerationDimensions,
};

Quantity.checkDimensionalConsistency(vars, 's = u*t + 0.5*a*t^2'); // true
Quantity.checkDimensionalConsistency(vars, 's = u*t + a');          // false
```

#### `Dimensions.describe` — human-readable dimension strings

```dart
Dimensions.describe(Speed.speedDimensions);        // 'Length^1 / Time^1'
Dimensions.describe(Acceleration.accelerationDimensions); // 'Length^1 / Time^2'
Dimensions.describe(Dimensions());                 // 'dimensionless'
```

#### `Quantity.jsonSchema` — expose your tool signature to an LLM

Pass `Quantity.jsonSchema` directly as the JSON Schema for a function parameter so the model
knows exactly how to produce a valid serialized quantity.

### New Quantity Types

| Type | Dimensions | Typical use |
|------|-----------|-------------|
| `Token` | custom (dimensionless-like) | LLM token counts |
| `TokenRate` | Token / Time | tokens per second |
| `Pixel` | custom | screen pixel counts |
| `Resolution` | Pixel / Length | DPI / PPI |
| `PixelDensity` | Pixel / Area | pixels per m² |
| `Torque` | Energy (distinct from Energy by semantics) | rotational force |

All new types are fully integrated with `Quantity.parse` and `Quantity.getUnitSymbols`.

```dart
Quantity.parse('1024 tokens');  // → Token
Quantity.parse('512 tps');      // → TokenRate
Quantity.parse('1920 px');      // → Pixel
Quantity.parse('96 ppi');       // → Resolution
```

### Fluent Extensions

Import `package:quantity/quantity.dart` (or `package:quantity/quantity_ext.dart`) to get
extension getters on `num` for concise quantity construction:

```dart
// Construction
30.0.metersPerSecond    // Speed
9.8.metersPerSecondSquared  // Acceleration
100.kilograms           // Mass
37.celsius              // Temperature
500.milliseconds        // Time
1920.pixels             // Pixel
4096.tokens             // Token

// Reading back (in* getters)
Length(m: 1).inCentimeters          // 100.0
Time(s: 86400).inDays               // 1.0
Speed(metersPerSecond: 10).inKilometersPerHour // 36.0
Mass(kg: 0.45359237).inPounds       // ~1.0
Angle(rad: pi).inDegrees            // 180.0
```

### Quantity Ranges

The `quantity_range` library provides `QuantityRange<T>` and a specialised `AngleRange`:

```dart
// Basic range
final r = QuantityRange<Length>(Length(m: 10), Length(m: 20));
print(r.span);        // 10 m
print(r.centerValue); // 15 m

// Angle range with wrap-around awareness
final arc = AngleRange.degrees(350, 30);
arc.overlaps360(AngleRange.degrees(10, 45)); // true
arc.contains360(Angle(deg: 5));              // true
arc.ranges360;      // splits into [350°,360°] ∪ [0°,30°]

// AngleRange operations
arc.deriveRange(rotate: 45.0);  // rotate the arc
arc.deriveRange(scale: 2.0);    // grow/shrink about center
arc.deriveRange(reverse: true); // flip direction
arc.angleClosestTo(Angle(deg: 180)); // nearest endpoint
```

`TimePeriod` provides analogous support for time ranges, with integration into Dart's
`Duration` and `DateTime`.

## Library Structure

| Import | Contents |
|--------|----------|
| `package:quantity/quantity.dart` | Everything — recommended for most apps |
| `package:quantity/quantity_core.dart` | Tree-shakeable core (no ext units/constants) |
| `package:quantity/quantity_si.dart` | SI quantities and units only |
| `package:quantity/quantity_ext.dart` | Non-SI units, fluent extensions, ranges, mutable |
| `package:quantity/number.dart` | Number types only (`Integer`, `Double`, `Precise`, `Complex`) |
| `package:quantity/quantity_range.dart` | Range classes only |

## Examples

```dart
import 'package:quantity/quantity.dart';

void main() {
  // ---------- Arithmetic ----------
  final v0   = Speed(metersPerSecond: 0);
  final a    = Acceleration(metersPerSecondSquared: 9.8);
  final t    = Time(s: 3.0);

  // v = v0 + a*t
  final v = v0 + a * t as Speed;
  print(v); // '29.4 m/s'

  // ---------- Parsing ----------
  final force  = Quantity.parse('10 N');
  final torque = Quantity.parse('15 N·m');
  print(force.runtimeType);  // Force
  print(torque.runtimeType); // Torque

  // ---------- Uncertainty ----------
  final measured = Length(m: 100.0, uncert: 0.02); // 2% relative uncertainty
  print(measured.relativeUncertainty);              // 0.02
  print(measured.standardUncertainty);              // Length(2 m)

  // ---------- Angle math ----------
  final heading = AngleRange.degrees(315, 45); // NW to NE, crossing North
  print(heading.contains360(Angle(deg: 0)));   // true (due North is inside)
  print(heading.contains360(Angle(deg: 180))); // false (South is outside)
}
```

## NIST Constants

All fundamental physical constants are available as `const` typed quantities.
They are kept in sync with the official CODATA release:

```dart
import 'package:quantity/quantity.dart';

// Universal constants
print(speedOfLightVacuum);           // Speed ~ 2.998e8 m/s
print(planckConstant);               // ~ 6.626e-34 J·s
print(elementaryCharge);             // ~ 1.602e-19 C
print(boltzmannConstant);            // ~ 1.381e-23 J/K
print(gravitationalConstant);        // ~ 6.674e-11 m³/kg/s²

// Refresh to latest NIST CODATA values:
// dart run bin/update_nist_constants.dart
```

## Quality

- **100% code coverage** — every line of library code is exercised by the test suite.
- **Zero analyzer warnings** — `dart analyze --fatal-infos` passes cleanly.
- **Formatted** — `dart format` is enforced by CI.
- All four pre-commit checks (`format` → `analyze` → `test` → `verify_coverage`) run
  automatically in GitHub Actions on every push.
