# Migration Guide: Quantity 4.x to 5.0.0

Quantity 5.0.0 is a major release containing API modernization, modern Dart 3 feature adoption, comprehensive tree-shaking support, and significant performance optimizations.

This guide outlines the breaking changes and new APIs introduced in this version and how to migrate your code.

---

## 1. Class Modifiers (Dart 3+)

To ensure structural integrity and correct mathematical equivalence:
*   `Number` is now a `sealed class`. You cannot extend, implement, or mix in `Number` outside of the package. All subclasses (`Integer`, `Double`, `Precise`, `Imaginary`, `Complex`) are exhaustive.
*   `Quantity` is now a `base class`. Outside of the package, you can `extend` `Quantity` to define custom physical quantities, but you can no longer `implement` `Quantity` as an interface.
*   `Dimensions` is now a `final class`. You cannot extend or implement `Dimensions`.

### Migration Action
If you were using custom classes that implemented `Quantity` or `Number`, update them to extend `Quantity` or use the predefined `Number` subclasses instead.

```diff
-class CustomQuantity implements Quantity {
+base class CustomQuantity extends Quantity {
```

---

## 2. Dynamic SI Registry & Core Entrypoint (Tree-Shaking)

Previously, importing the core classes of the library transitively imported all 75+ physical quantity subclasses (like `Length`, `Volume`, etc.) due to a monolithic static type mapping registry in `utilities.dart`.

In 5.0.0:
*   The static registry has been decoupled into a lazy dynamic registry (`registerStandardSIQuantities`).
*   A new entrypoint `package:quantity/quantity_core.dart` has been created containing only the core mathematical and quantity classes (`Quantity`, `Dimensions`, `Units`, `Number`, `Double`, `Integer`, `Precise`, etc.), but **none** of the 75+ subclasses.
*   `package:quantity/quantity.dart` and `package:quantity/quantity_si.dart` continue to export all standard SI quantities and automatically trigger registration when used or imported.

### Migration Action
*   For applications needing only core dimensions and operations (e.g. custom dimensions or custom math without SI subclasses), import the core entrypoint for clean compiler tree-shaking:
    ```dart
    import 'package:quantity/quantity_core.dart';
    ```
*   For standard SI quantities, continue importing:
    ```dart
    import 'package:quantity/quantity.dart'; // or package:quantity/quantity_si.dart
    ```

---

## 3. Fluent Quantity Extensions & Unit Shortcuts (DX)

New extension methods on `num` and `Number` allow for much cleaner syntax for constructing quantities and converting units.

### Creating Quantities
Instead of using constructors or helper methods, you can construct quantities directly on numbers:

```dart
// Before
var distance = Length(m: 5);
var duration = Time(s: 10);

// After
var distance = 5.meters;
var duration = 10.seconds;
var speed = 2.5.metersPerSecond;
```

### Converting Units
Shortcut getters are provided for unit conversions on quantity instances:

```dart
// Before
var valueInKm = distance.valueInUnits(Length.kilometers);

// After
var valueInKm = distance.inKilometers;
```

---

## 4. Performance & Memory Optimizations

*   **Flat Precise Representation:** The internal representation of arbitrary precision `Precise` arithmetic has been rewritten to use a flat `List<int>` instead of allocating a custom wrapper object per digit. This eliminates garbage collection overhead and accelerates arithmetic operations by up to 35%.
*   **Dimensions Cache:** `Dimensions.determineQuantityType` is now cached, preventing unnecessary switch-expression checks on hot paths (e.g., repeating dimension operations).
*   **Constant Re-use:** `simplifyType` has been optimized to return pre-allocated static constants (`Integer.zero`, `Integer.one`, `Integer.negOne`) instead of allocating new instances for trivial integer values.
