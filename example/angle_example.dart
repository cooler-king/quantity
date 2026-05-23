// Import the quantity library.
import 'package:quantity/quantity.dart';

void main() {
  // Construct an Angle using the fluent extension.
  final ang = 1.1.radians;
  print('Angle1 (deg): ${ang.inDegrees}');

  // Construct an Angle in degrees.
  final ang2 = 270.degrees;
  print('Angle2 (deg): $ang2');

  // Find the difference.
  final diff = ang2 - ang as Angle;

  // Display the result in degrees.
  print('Difference (deg): ${diff.inDegrees}');

  // Display the result in radians.
  print('Difference (rad): ${diff.inRadians}');

  // Find the sum.
  final sum = ang2 + ang as Angle;

  // Display the result in degrees.
  print('Sum (deg): ${sum.inDegrees}');

  // Display the result in radians.
  print('Sum (rad): ${sum.inRadians}');
}
