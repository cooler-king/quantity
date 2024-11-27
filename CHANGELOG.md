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
