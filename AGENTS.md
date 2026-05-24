# Guidance for AI Coding Agents

This file provides rules, constraints, and commands for AI agents developing or modifying the `quantity` codebase.

## Verification Commands
- **Run tests**: `dart test`
- **Run static analysis**: `dart analyze`
- **Run code formatter**: `dart format .`
- **Sync NIST CODATA constants**: `dart run bin/update_nist_constants.dart`

## Architecture & Constraints
- **Class Modifiers**: Keep the `sealed` modifier on `Number`, the `base` modifier on `Quantity`, and the `final` modifier on `Dimensions`.
- **Dynamic Registry**: Avoid hardcoding physical quantity instantiators in `utilities.dart`. Register new types using `registerQuantityType(...)`.
- **Constants**: If you define new fundamental physical constants, format them as:
  `const <Type> <varName> = <Type>.constant(Double.constant(<value>), uncert: <relativeUncertainty>);`
  This ensures they are discoverable and updatable automatically by the NIST synchronization script.
- **Imports**: Export public APIs in `lib/quantity.dart` and the tree-shaken `lib/quantity_core.dart`. Do not introduce circular public exports.
