import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:quantity/quantity.dart';

class QuantityCreationBenchmark extends BenchmarkBase {
  QuantityCreationBenchmark() : super('Quantity Creation');

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      final _ = Length(m: i.toDouble());
    }
  }
}

class DimensionsMathBenchmark extends BenchmarkBase {
  DimensionsMathBenchmark() : super('Dimensions Math (* and /)');

  late Dimensions d1;
  late Dimensions d2;

  @override
  void setup() {
    d1 = Length.lengthDimensions;
    d2 = Time.timeDimensions;
  }

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      final mult = d1 * d2;
      final _ = mult / d2;
    }
  }
}

class DetermineQuantityTypeBenchmark extends BenchmarkBase {
  DetermineQuantityTypeBenchmark() : super('Determine Quantity Type');

  late Dimensions dLength;
  late Dimensions dSpeed;
  late Dimensions dMisc;

  @override
  void setup() {
    dLength = Length.lengthDimensions;
    dSpeed = Speed.speedDimensions;
    dMisc = Dimensions.fromMap(
        <String, num>{'Length': 2, 'Mass': 1, 'Time': -3, 'Current': -2});
  }

  @override
  void run() {
    for (var i = 0; i < 1000; i++) {
      Dimensions.determineQuantityType(dLength);
      Dimensions.determineQuantityType(dSpeed);
      Dimensions.determineQuantityType(dMisc);
    }
  }
}

void main() {
  QuantityCreationBenchmark().report();
  DimensionsMathBenchmark().report();
  DetermineQuantityTypeBenchmark().report();
}
