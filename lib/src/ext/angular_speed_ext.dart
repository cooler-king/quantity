part of quantity_ext;

/** the standard SI unit **/
final AngularSpeedUnits radiansPerSecond = AngularSpeed.radiansPerSecond;

/** accepted for use with the SI **/
final AngularSpeedUnits degreesPerSecond = AngularSpeed.degreesPerSecond;

/** rotation frequency **/
final AngularSpeedUnits revolutionsPerMinute = new AngularSpeedUnits.angleTime(revolutions, Time.minutes);

final AngularSpeedUnits rpm = revolutionsPerMinute;
