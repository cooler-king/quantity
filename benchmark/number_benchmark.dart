import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:quantity/number.dart';

class ComplexAdditionBenchmark extends BenchmarkBase {
  ComplexAdditionBenchmark() : super('Complex Addition');

  late Complex c1;
  late Complex c2;

  @override
  void setup() {
    c1 = Complex.coeff(12.34, 56.78);
    c2 = Complex.coeff(98.76, 54.32);
  }

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      final _ = c1 + c2;
    }
  }
}

class ComplexMultiplicationBenchmark extends BenchmarkBase {
  ComplexMultiplicationBenchmark() : super('Complex Multiplication');

  late Complex c1;
  late Complex c2;

  @override
  void setup() {
    c1 = Complex.coeff(12.34, 56.78);
    c2 = Complex.coeff(98.76, 54.32);
  }

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      final _ = c1 * c2;
    }
  }
}

class NumberSimplifyBenchmark extends BenchmarkBase {
  NumberSimplifyBenchmark() : super('Number Simplify Type');

  late Complex cSimple;
  late Complex cComplex;

  @override
  void setup() {
    cSimple = Complex.coeff(5.0, 0.0);
    cComplex = Complex.coeff(12.34, 56.78);
  }

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      Number.simplifyType(cSimple);
      Number.simplifyType(cComplex);
    }
  }
}

void main() {
  ComplexAdditionBenchmark().report();
  ComplexMultiplicationBenchmark().report();
  NumberSimplifyBenchmark().report();
}
