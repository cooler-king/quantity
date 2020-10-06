// Import the core SI library.
import 'package:quantity/quantity_si.dart';

void main() {
  // Construct an Angle in radians.
  var ang = Angle(rad: 1.1);
  print('Angle1 (deg): ${ang.valueInUnits(Angle.degrees)}');

  // Construct an Angle in degrees.
  final ang2 = Angle(deg: 270);
  print('Angle2 (deg): $ang2');

  // Find the difference.
  final diff = ang2 - ang as Angle;

  // Display the result in degrees.
  print('Difference (deg): ${diff.valueInUnits(Angle.degrees)}');

  // Display the result in radians.
  print('Difference (rad): ${diff.valueInUnits(Angle.radians)}');

  // Find the sum.
  final sum = ang2 + ang as Angle;

  // Display the result in degrees.
  print('Sum (deg): ${sum.valueInUnits(Angle.degrees)}');

  // Display the result in radians.
  print('Sum (rad): ${sum.valueInUnits(Angle.radians)}');
}
