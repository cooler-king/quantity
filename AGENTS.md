# Guidance for AI Coding Agents

This file provides rules, constraints, and commands for AI agents developing or modifying the `quantity` codebase.

## Verification Commands
- **Run tests**: `dart test`
- **Run static analysis**: `dart analyze`
- **Run code formatter**: `dart format .`
- **Sync NIST CODATA constants**: `dart run bin/update_nist_constants.dart`
- **Generate coverage report**: `dart test --coverage=coverage && dart run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -i coverage -o coverage/coverage.lcov`
- **Verify 100% coverage**: `dart run scratch/analyze_coverage.dart`

## Architecture & Constraints
- **Code Coverage**: The codebase is at **100.0% code coverage**. Any and all code changes, additions, or refactorings MUST include corresponding unit tests to guarantee that overall project coverage remains at exactly **100.0%**.
- **Class Modifiers**: Keep the `sealed` modifier on `Number`, the `base` modifier on `Quantity`, and the `final` modifier on `Dimensions`.
- **Dynamic Registry**: Avoid hardcoding physical quantity instantiators in `utilities.dart`. Register new types using `registerQuantityType(...)`.
- **Constants**: If you define new fundamental physical constants, format them as:
  `const <Type> <varName> = <Type>.constant(Double.constant(<value>), uncert: <relativeUncertainty>);`
  This ensures they are discoverable and updatable automatically by the NIST synchronization script.
- **Imports**: Export public APIs in `lib/quantity.dart` and the tree-shaken `lib/quantity_core.dart`. Do not introduce circular public exports.
