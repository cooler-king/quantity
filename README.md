# quantity
Facilitates working with physical quantities such as angles, lengths, masses and temperatures.

In science and engineering it is critical to use units along with numerical values.
For example, 5 meters per second is decidedly _not_ the same speed as 5 feet per minute. 
Calculations must include units, implicitly or explicitly, to be correct and useful.
This package provides classes for modeling quantities of specific types and their 
associated units as well as their use in calculations.

The [International System of Units](https://physics.nist.gov/cuu/Units/index.html) 
(often called 'SI' from its abbreviation in French) defines the quantity types, associated
units and constants used by scientists and engineers around the world.  This package models
the SI base and derived quantities in its `quantity_si` library.

There are also many historical units, of course, that were around well before the SI came into existence.
These can be found in the `quantity_ext` library.

The `number` library adds support for quantities having values of arbitrary precision and the 
`quantity_range` library adds special support for handling value ranges.

Together, these libraries give you the tools to maintain units discipline in your code
and make Dart a more attractive option for many science and engineering applications by eliminating
common mistakes and offering improved readability.

## Quick start

    // Import the core library.
    import 'package:quantity/quantity_si.dart';

    // Construct an Angle in radians.
    var ang = new Angle(rad: 1.1);

    // Construct an Angle in degrees.
    var ang2 = new Angle(deg: 270);

    // Find the difference.
    var diff = ang2 - ang;

    // Display the result in degrees.
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
