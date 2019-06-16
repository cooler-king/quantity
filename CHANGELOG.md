### 1.0.0
  * Requires >= Dart SDK 2.3

### 0.2.0+1
  * Dart 2 support.
  * Stricter typing.
  * Addressed many (but not all) analyzer items.

### 0.1.5
  * Upgraded dependencies:  `intl 0.14` and `quiver 0.23`

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