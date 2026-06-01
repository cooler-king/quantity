// Import the quantity library.
import 'package:quantity/quantity.dart';

void main() {
  /// Construct a Temperature using fluent celsius extension.
  final temp = 100.celsius;
  print('Temperature1: $temp  (${temp.inKelvins} K)');

  /// Construct a second Temperature using fluent kelvins extension.
  final temp2 = 100.kelvins;
  print('Temperature2: $temp2  (${temp2.inCelsius} C)');

  /// Calculate the difference in temperatures.
  final diff = temp - temp2 as TemperatureInterval;
  print('Temperature difference: $diff'); // 273.15 K

  /// Add 5 times the difference to the first temperature.
  final hot = temp + (diff * 5) as Temperature;
  print('Hot Temperature: $hot  (${hot.inCelsius} C)');
}
