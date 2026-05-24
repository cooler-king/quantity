# Roadmap: Quantity 5.0.0

This document outlines the strategic roadmap for the upcoming major release of the `quantity` Dart library (v5.0.0). The primary focus of this release is modernizing the codebase, maximizing performance, expanding test coverage, keeping examples and documentation synchronized, and delivering a state-of-the-art developer experience (DX).

---

## 1. Top Priorities

### 🎯 Full Test Coverage
While the previous test suite had untested edge cases, we expanded coverage across all files to exceed 90%.
- [x] **Identify Gaps:** Set up test coverage reporting (e.g., using `package:coverage`) to identify files with less than 90% statement/branch coverage.
- [x] **Precise and Number Edge Cases:** Ensure comprehensive test coverage for arbitrary precision calculations (`Precise`), imaginary/complex number parsing, boundary condition operations, and exception handling.
- [x] **Quantity & Units Verification:** Add unit tests to cover combinations of rare physical quantities and cross-dimensional operations (e.g., custom `MiscQuantity` conversions).

### ⚡ Performance Optimization (Numbers & Precise)
The math implementation has been optimized for low memory and execution overhead.
- [x] **Establish Benchmarking Suite:** Develop a benchmarking suite (e.g., using `package:benchmark_harness`) targeting core operations: `Precise` arithmetic, `Complex`/`Imaginary` numbers, and `Quantity` instantiation to measure baseline CPU and memory/GC pressure.
- [x] **Optimize `Precise` Representation:** 
  - Migrated the internal representation of `Precise` to use a flat `List<int>` representing digits directly rather than individual `ByteData`/`Digit` objects, eliminating heavy GC overhead.
- [x] **Reduce Allocation Overhead:** Reuse objects and utilize mutable/immutable pools for common constants (e.g., pre-allocated integer values).
- [x] **Improve Operation Algorithms:** Optimized long multiplication and division in `Precise` to perform calculations using native integer operations.
- [x] **Validate Improvements & Prevent Regressions:** Use the benchmarking suite to prove optimization gains, backed by a comprehensive regression testing check to ensure mathematical equivalence and correctness.

---

## 2. API Ergonomics & Developer Experience

### 🚀 Fluent Extension Getters
Constructing physical quantities is now clean, intuitive, and modern:
- [x] **Number Extensions:** Implement getters on `num` and `Number` to allow syntax like `5.meters`, `250.milliliters`, `2.hours`, and `9.8.metersPerSecondSquared`.
- [x] **Unit Shortcuts:** Add convenient extension-based unit conversions directly on quantity instances (e.g., `distance.inKilometers`).

---

## 3. Modernizing with Dart 3+ Language Features

### 🔒 Sealed Class Modifiers
- [x] Mark the abstract [Number](file:///c:/dev/github/quantity/lib/src/number/number.dart) class as `sealed`. This enables compile-time exhaustive pattern matching for mathematical calculations across `Integer`, `Double`, `Precise`, `Imaginary`, and `Complex`.
- [x] Mark [Quantity](file:///c:/dev/github/quantity/lib/src/si/quantity.dart) as a `base class` to control extension boundaries.
- [x] Mark [Dimensions](file:///c:/dev/github/quantity/lib/src/si/dimensions.dart) as a `final class` to prevent inheritance and secure hashing/equality behaviors.

### 🧩 Pattern Matching & Switch Expressions
- [x] Refactor legacy nested `if-else` map parsers (e.g., `Number.fromMap`) using Dart 3 map patterns.
- [x] Simplify [Dimensions.determineQuantityType](file:///c:/dev/github/quantity/lib/src/si/dimensions.dart#L392) using switch expressions.

---

## 4. Tree-Shaking & Bundle Size Optimization

- [x] **Decouple the Dynamic Registry:** Remove the monolithic, static `_typeInstantiatorMap` in `utilities.dart`. Switch to a lazy/dynamic registration model.
- [x] **Core Exports Separator:** Create a new entrypoint `package:quantity/quantity_core.dart` for apps needing only core dimensions and operations, enabling compilers to tree-shake all unused physical quantity classes.

---

## 5. Documentation & Examples (Continuous Updates)

To support seamless transitions for users migrating to 5.0.0, we have updated documentation and examples:
- [x] **Sync Examples:** Update all existing files in the [example/](file:///c:/dev/github/quantity/example) directory to use fluent extensions (`5.meters`) and new Dart 3 constructs.
- [x] **API Documentation:** Update inline docstrings, README references, and wiki documentation to reflect breaking changes (such as the new `sealed` and `base` modifiers, and the core vs extended library structure).
- [x] **Migration Guide:** Provide a clear migration guide detailing the change to fluent extension methods and the package import/export structure for 5.0.0.

---

## 6. Phase 6: Code Quality & CI Tooling (Pana & CI)
- [x] **Pana Lint Checklist:** Audit the package against `pana` rules (proper markdown formatting, example files, documentation of all public members) to guarantee a perfect 160/160 score on pub.dev.
- [x] **Resolve Unimplemented `NumberFormatSI` API Methods:** Forward `simpleCurrencySymbol`, `symbols`, and `turnOffGrouping` calls to the underlying `_scientific` formatter to prevent runtime `UnimplementedError` crashes.
- [x] **GitHub Actions CI Setup:** Create `.github/workflows/dart.yml` to automatically run `dart analyze` and `dart test` on every push/PR.

---

## 7. Phase 7: Serialization & Interoperability (JSON & Decimal)
- [x] **JSON Serialization:** Implement `toJson()` and `fromJson()` for `Quantity`, `Dimensions`, and the `Number` type hierarchy.
- [x] **`package:decimal` Interoperability:** Add utility converters or constructors to translate between high-precision `Quantity` values and `package:decimal` instances.
- [x] **Serialization & Interop Tests:** Write thorough unit tests validating JSON round-trip cycles and decimal conversions.

---

## 8. Phase 8: Advanced Verification & Automation (Property Testing & NIST)
- [x] **Property-Based Testing:** Implement randomized round-trip algebraic tests for `Dimensions` arithmetic (`*`, `/`, `inverse`) to verify that invariants like `(A * B) / B == A` always hold.
- [x] **Automated NIST Constant Updater:** Build a helper script to fetch, parse, and automatically sync physical constants in the library directly from the latest official NIST CODATA data files.

---

## 9. Phase 9: AI Readiness & Natural Language Processing (AI Gaps)
- [ ] **Natural Language Quantity Parser (`Quantity.parse`):** Implement parsing of quantity strings with values and compound unit expressions (supporting prefix parsing and dynamic dimension matching).
- [ ] **AI-Friendly Self-Discovery & Metadata APIs:** Provide APIs to query standard symbols, units, dimensions, and type mappings programmatically.
- [ ] **JSON Schema & LLM Tool Schema Generators:** Expose structured schemas and stateless helpers optimized for tool usage and structured output definitions.
- [ ] **Symbolic Dimensional Solver/Validator:** Add support for checking dimensional consistency in formulas.



