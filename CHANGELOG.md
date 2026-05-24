### 5.0.0
  * **Dart 3+ Modernization**: Applied `sealed`, `base`, and `final` modifiers to `Number`, `Quantity`, and `Dimensions` classes. Refactored map parsing and type determination using modern pattern matching and switch expressions.
  * **Fluent DX & Unit Shortcuts**: Added extension getters on `num` and `Number` (e.g., `5.meters`, `75.tps`) and unit shortcuts (`inKilometers`, `inTps`, `inCelsius`).
  * **Registry Decoupling & Tree-Shaking**: Decoupled the physical quantity registry by registering subclasses dynamically, allowing for clean tree-shaking. Added a lightweight core entrypoint `lib/quantity_core.dart`.
  * **JSON Serialization**: Added full `toJson()` and `fromJson()` support to `Quantity`, `Number`, and `Dimensions` hierarchies.
  * **Decimal Interoperability**: Integrated the `decimal` package directly, introducing `valueSIAsDecimal`, `toDecimal()`, and `fromDecimal(Decimal)` to allow high-precision decimal operations.
  * **NIST Constants Sync**: Added an automated script `bin/update_nist_constants.dart` to synchronize physical constants and uncertainties with the official NIST CODATA table.
  * **AI Readiness & Natural Language Processing**: 
    * Added `Quantity.parse(String text)` for parsing natural language physical measurements (e.g., `'120 km/h'`, `'9.8 m/s^2'`).
    * Added `Quantity.checkDimensionalConsistency` to symbolically check math formula consistency (e.g., `s = u * t + 0.5 * a * t^2`).
    * Added `Dimensions.describe` returning human-readable dimensions (e.g. `'Length^1 / Time^2'`).
    * Exposed structured JSON schemas (`Quantity.jsonSchema`) for structured LLM function calling.
  * **Computational & Digital Layout Quantities**:
    * Introduced `Token` and `TokenRate` classes to support modeling, parsing, and arithmetic for NLP/LLM context tracking and throughput metrics.
    * Introduced `Pixel`, `Resolution` (pixels per length), and `PixelDensity` (pixels per area) classes to support spatial layout scaling, screen resolution calibration (PPI/DPI/DPCM), and graphics calculations with type-safe arithmetic operators.
  * **Synonym Quantity Types**: Added compile-time typedef aliases and dynamic runtime name registry mapping for 19 physical quantity synonyms across 12 distinct classes (e.g. `Irradiance` / `EnergyFluxDensity` / `PowerFluxDensity` synonymizing `HeatFluxDensity`, `Stress` synonymizing `Pressure`, `Work` synonymizing `Energy`, etc.).
  * **Domain Collections**: Added six domain library collections under `lib/domain/` to group quantity types, units, and constants commonly encountered in specific fields: `radiometry`, `atomic_nuclear`, `computing`, `chemistry`, `acoustics`, and `fluid_dynamics`. Added corresponding unit tests for each domain.
  * **Algebraic Property Verification**: Established property-based testing for `Dimensions` algebra.
  * **Test Coverage Boost**: Significantly expanded unit test coverage across the package. Wrote comprehensive tests for previously untested parts including the `Fraction` number representation class, trig functions and constants in `angle_ext`, fluent utility extensions on `num` and `Number`, and verified variable mappings across all 40+ extension libraries. Raised overall repository code coverage to **75.4%** (surpassing the target of 70%).

### 4.0.0
  * Breaking changes:
    * Changed some compound unit constructor names to be more descriptive.
    * Made `Units.singular` property non-nullable.
    * Number `==` operators now take an `Object` argument instead of `dynamic`,
  * Updated the minimum `intl` dependency to `0.19.0`.
  * Added unit tests for all compound unit constructors. 
    * Fixed numerous bugs in compound unit constructor logic.
  * Accounted for lower case `e` in number formatting/grouping.
  * Removed logging of quantity type resolution failure from `inverse` method.
  * Updated formatting; addressed pana suggestions.

### 3.0.2
  * Update lint dependency to `^3.0.0`.

### 3.0.1
  * Fixed bugs in Precise class.

### 3.0.0
  * Requires >= Dart SDK 3.0.

### 2.0.1
  * Support for intl 0.18.

### 2.0.0
  * Support for Dart 2.12, null safety.

### 1.0.0
  * Requires >= Dart SDK 2.3.
  * Increased testing.
  * Number formatting; quantity text output.
  * The latest official constants.
  * TimeInstant extensions.
  * MutableQuantity.

### 0.3.0
  * Relaxed `intl` package version dependency to `>=0.15.0 <1.0.0`.

### 0.2.0+1
  * Dart 2 support.
  * Stricter typing.
  * Addressed many (but not all) analyzer items.

### 0.1.5
  * Upgraded dependencies:  `intl 0.14` and `quiver 0.23`.

### 0.1.4
  * Added `isScalar` and `isScalarSI` to `Dimensions` and `Quantity`.
  * Extended use of type hints in dimensions for more efficient and accurate type determination during operations.
  * Generalized special handling of scalar quantities.

### 0.1.3+1
  * Fixed `CHANGELOG.md` formatting.

### 0.1.3
  * Added `operator ==` and `hashCode` to quantity range classes.
  * Added `toTypedQuantity` to `MiscQuantity`.
  * Changed `googol` constant to arbitrary precision.
  * Renamed private `_dimensions` constructor to `_internal` in quantities. 

### 0.1.2
  * `Precise` `isInteger` and `_limitPrecision` fixes.
  * `hashCode` testing for quantity objects (esp. `Scalar`)

### 0.1.1
  * `Temperature`, `TemperatureInterval` tests, tweaks, bug fixes.

### 0.1.0
  * Initial version.
