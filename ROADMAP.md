# Roadmap: Quantity 5.0.0

This document outlines the strategic roadmap for the upcoming major release of the `quantity` Dart library (v5.0.0). The primary focus of this release is modernizing the codebase, maximizing performance, expanding test coverage, keeping examples and documentation synchronized, and delivering a state-of-the-art developer experience (DX).

---

## 1. Top Priorities

### 🎯 Full Test Coverage
While the current test suite contains 531 tests, there are still untested edge cases and components.
- [ ] **Identify Gaps:** Set up test coverage reporting (e.g., using `package:coverage`) to identify files with less than 90% statement/branch coverage.
- [ ] **Precise and Number Edge Cases:** Ensure comprehensive test coverage for arbitrary precision calculations (`Precise`), imaginary/complex number parsing, boundary condition operations, and exception handling.
- [ ] **Quantity & Units Verification:** Add unit tests to cover combinations of rare physical quantities and cross-dimensional operations (e.g., custom `MiscQuantity` conversions).

### ⚡ Performance Optimization (Numbers & Precise)
The current math implementation is rich but has significant memory and execution overhead.
- [ ] **Establish Benchmarking Suite:** Develop a benchmarking suite (e.g., using `package:benchmark_harness`) targeting core operations: `Precise` arithmetic, `Complex`/`Imaginary` numbers, and `Quantity` instantiation to measure baseline CPU and memory/GC pressure.
- [ ] **Optimize `Precise` Representation:** 
  - Currently, `Precise` stores numbers as `List<Digit>` where each `Digit` allocates a `ByteData(1)` instance. This leads to massive heap allocation overhead (e.g., a 50-digit number allocates 100+ helper objects).
  - Migrate the internal representation to a single `Uint8List` directly inside `Precise`, or transition to a chunked representation using a larger base (e.g., base-10^9 or base-10^18) to perform calculations using native integer chunks.
- [ ] **Reduce Allocation Overhead:** Reuse objects and utilize mutable/immutable pools for common constants (e.g., `Digit` instances or common dimensions).
- [ ] **Improve Operation Algorithms:** Optimize long multiplication and division in `Precise` to use faster algorithms for large numbers.
- [ ] **Validate Improvements & Prevent Regressions:** Use the benchmarking suite to prove optimization gains, backed by a comprehensive regression testing check to ensure mathematical equivalence and correctness.

---

## 2. API Ergonomics & Developer Experience

### 🚀 Fluent Extension Getters
Make constructing physical quantities clean, intuitive, and modern:
- [ ] **Number Extensions:** Implement getters on `num` and `Number` to allow syntax like `5.meters`, `250.milliliters`, `2.hours`, and `9.8.metersPerSecondSquared`.
- [ ] **Unit Shortcuts:** Add convenient extension-based unit conversions directly on quantity instances (e.g., `distance.inKilometers`).

---

## 3. Modernizing with Dart 3+ Language Features

### 🔒 Sealed Class Modifiers
- [ ] Mark the abstract [Number](file:///c:/dev/github/quantity/lib/src/number/number.dart) class as `sealed`. This enables compile-time exhaustive pattern matching for mathematical calculations across `Integer`, `Double`, `Precise`, `Imaginary`, and `Complex`.
- [ ] Mark [Quantity](file:///c:/dev/github/quantity/lib/src/si/quantity.dart) as a `base class` to control extension boundaries.
- [ ] Mark [Dimensions](file:///c:/dev/github/quantity/lib/src/si/dimensions.dart) as a `final class` to prevent inheritance and secure hashing/equality behaviors.

### 🧩 Pattern Matching & Switch Expressions
- [ ] Refactor legacy nested `if-else` map parsers (e.g., `Number.fromMap`) using Dart 3 map patterns.
- [ ] Simplify [Dimensions.determineQuantityType](file:///c:/dev/github/quantity/lib/src/si/dimensions.dart#L392) using switch expressions.

---

## 4. Tree-Shaking & Bundle Size Optimization

- [ ] **Decouple the Dynamic Registry:** Remove the monolithic, static `_typeInstantiatorMap` in `utilities.dart`. Switch to a lazy/dynamic registration model.
- [ ] **Core Exports Separator:** Create a new entrypoint `package:quantity/quantity_core.dart` for apps needing only core dimensions and operations, enabling compilers to tree-shake all unused physical quantity classes.

---

## 5. Documentation & Examples (Continuous Updates)

To support seamless transitions for users migrating to 5.0.0, we will update documentation and examples continuously as features are added:
- [ ] **Sync Examples:** Update all existing files in the [example/](file:///c:/dev/github/quantity/example) directory to use fluent extensions (`5.meters`) and new Dart 3 constructs as they are introduced.
- [ ] **API Documentation:** Update inline docstrings, README references, and wiki documentation to reflect breaking changes (such as the new `sealed` and `base` modifiers, and the core vs extended library structure).
- [ ] **Migration Guide:** Provide a clear migration guide detailing the change to fluent extension methods and the package import/export structure for 5.0.0.
