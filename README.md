# quantity
Facilitates working with physical quantities.

_This is a work in progress; this package's API may change significantly.  
Some parts are currently unfinished, untested and/or undocumented.  Use at your own risk._

## Quick start

    // Import the core library
    import 'package:quantity/quantity_si.dart';

    // Construct an Angle in radians
    var ang = new Angle(rad: 1.1);

    // Construct an Angle in degrees
    var ang2 = new Angle(deg: 270);

    // Find the difference
    var diff = ang2 - ang;

    // Display the result in degrees
    print(diff.valueInUnits(Angle.degrees);

## Key Features

* Typed quantities (such as `Length`, `Mass` and `Temperature`) that are easy to construct and use in calculations.
* Encourages use of standard units by isolating non-standard units in an extension library.
* Support for relative standard uncertainty in quantity values and calculations.
* Allows use of arbitrary precision values (as well as complex and imaginary values).
* Provides access to the latest official constant values published by NIST. 
* Integration with Dart's existing `Duration` and `DateTime` classes.
* Extensive set of quantity types and standard and non-standard units.
* Support for untyped quantities having unusual dimensions with the `MiscQuantity` class.
* Models quantity ranges, including special support for angle ranges and time spans.
* Includes a mutable quantity with streams.
* Metric prefixes for any unit. 
