// Import the core SI library.
import 'package:quantity/quantity_si.dart';

void main() {
  // Construct an Angle in radians.
  final Angle ang = new Angle(rad: 1.1);

  // Construct an Angle in degrees.
  final Angle ang2 = new Angle(deg: 270);

  // Find the difference.
  final Angle diff = ang2 - ang as Angle;

  // Display the result in degrees.
  print('Difference (deg): ${diff.valueInUnits(Angle.degrees)}');

  // Display the result in radians.
  print('Difference (rad): ${diff.valueInUnits(Angle.radians)}');

  // Find the sum.
  final Angle sum = ang2 + ang as Angle;

  // Display the result in degrees.
  print('Sum (deg): ${sum.valueInUnits(Angle.degrees)}');

  // Display the result in radians.
  print('Sum (rad): ${sum.valueInUnits(Angle.radians)}');
}
