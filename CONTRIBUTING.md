# Contributing Guidelines

Thank you for your interest in contributing to the `quantity` package! 

To maintain the high quality, correctness, and reliability required for a physics and dimensions library, we enforce strict development standards. Please read the guidelines below before making any changes.

---

## 🎯 100% Test Coverage Requirement (Project Canon)

The most important rule in this codebase is: **we maintain exactly 100.0% test coverage at all times**.

- **All code changes** (new features, bug fixes, refactoring, new physical quantity definitions) **MUST** include corresponding unit tests.
- **Coverage must remain at exactly 100.0%** across the entire package.
- Pull requests and commits that decrease the test coverage below 100.0% will fail the CI builds and will not be accepted.

---

## 🛠️ Verification & Testing Workflow

Before submitting a pull request, please run the following verification steps locally:

### 1. Run All Tests
Execute the full unit test suite:
```bash
dart test
```

### 2. Check Static Analysis & Formatting
Ensure the code is free of warnings and is properly formatted:
```bash
dart analyze
dart format .
```

### 3. Generate and Verify Test Coverage
To generate a coverage report and check if total coverage is at 100%, execute:

```bash
# 1. Run tests with coverage output
dart test --coverage=coverage

# 2. Format the coverage report into an LCOV file
dart run coverage:format_coverage --packages=.dart_tool/package_config.json --report-on=lib --lcov -i coverage -o coverage/coverage.lcov

# 3. Verify total coverage is exactly 100%
dart run tool/verify_coverage.dart
```

---

## 📐 Architecture & Constraints

- **Class Modifiers**: Keep the `sealed` modifier on `Number`, the `base` modifier on `Quantity`, and the `final` modifier on `Dimensions`.
- **Dynamic Registry**: Avoid hardcoding physical quantity instantiators in `utilities.dart`. Register new types using `registerQuantityType(...)`.
- **Constants**: If you define new fundamental physical constants, format them as:
  ```dart
  const <Type> <varName> = <Type>.constant(Double.constant(<value>), uncert: <relativeUncertainty>);
  ```
  This format ensures they are discoverable and updatable automatically by the NIST synchronization script (`dart run bin/update_nist_constants.dart`).
- **Imports**: Export public APIs in `lib/quantity.dart` and the tree-shaken `lib/quantity_core.dart`. Do not introduce circular public exports.
