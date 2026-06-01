import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:quantity/number.dart';

class PreciseAdditionBenchmark extends BenchmarkBase {
  PreciseAdditionBenchmark() : super('Precise Addition');

  late Precise p1;
  late Precise p2;

  @override
  void setup() {
    p1 = Precise('1234567890.12345678901234567890', sigDigits: 50);
    p2 = Precise('9876543210.98765432109876543210', sigDigits: 50);
  }

  @override
  void run() {
    // Run 1000 addition operations per benchmark loop iteration
    for (var i = 0; i < 1000; i++) {
      final _ = p1 + p2;
    }
  }
}

class PreciseSubtractionBenchmark extends BenchmarkBase {
  PreciseSubtractionBenchmark() : super('Precise Subtraction');

  late Precise p1;
  late Precise p2;

  @override
  void setup() {
    p1 = Precise('9876543210.98765432109876543210', sigDigits: 50);
    p2 = Precise('1234567890.12345678901234567890', sigDigits: 50);
  }

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      final _ = p1 - p2;
    }
  }
}

class PreciseMultiplicationBenchmark extends BenchmarkBase {
  PreciseMultiplicationBenchmark() : super('Precise Multiplication');

  late Precise p1;
  late Precise p2;

  @override
  void setup() {
    p1 = Precise('1234567890.12345678901234567890', sigDigits: 50);
    p2 = Precise('9876543210.98765432109876543210', sigDigits: 50);
  }

  @override
  void run() {
    for (var i = 0; i < 100; i++) {
      final _ = p1 * p2;
    }
  }
}

class PreciseDivisionBenchmark extends BenchmarkBase {
  PreciseDivisionBenchmark() : super('Precise Division');

  late Precise p1;
  late Precise p2;

  @override
  void setup() {
    p1 = Precise('9876543210.98765432109876543210', sigDigits: 50);
    p2 = Precise('1234567890.12345678901234567890', sigDigits: 50);
  }

  @override
  void run() {
    for (var i = 0; i < 50; i++) {
      final _ = p1 / p2;
    }
  }
}

void main() {
  PreciseAdditionBenchmark().report();
  PreciseSubtractionBenchmark().report();
  PreciseMultiplicationBenchmark().report();
  PreciseDivisionBenchmark().report();
}
