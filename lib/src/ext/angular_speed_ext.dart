import '../si/types/angular_speed.dart';
import '../si/types/time.dart';
import 'angle_ext.dart' show revolutions;

/// The standard SI unit.
final AngularSpeedUnits radiansPerSecond = AngularSpeed.radiansPerSecond;

/// Accepted for use with the SI.
final AngularSpeedUnits degreesPerSecond = AngularSpeed.degreesPerSecond;

/// Rotation frequency.
final AngularSpeedUnits revolutionsPerMinute = new AngularSpeedUnits.angleTime(revolutions, Time.minutes);

/// A synonym for [revolutionsPerMinute].
final AngularSpeedUnits rpm = revolutionsPerMinute;
