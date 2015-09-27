# quantity
A package to make it easy to work with physical quantities.

_This is a work in progress; this package's API may change significantly.  Use at your own risk._

## Libraries

The quantity package consists of a number of separate libraries to meet different needs:

* __quantity_si__: Includes the core quantity classes and types and units consistent with the International System of Units (SI).  If you only import this library then it facilitates compliance with SI guidelines.
* __quantity_ext__: Extends the SI types with units that lie outside the SI and useful constants
* __quantity_range__: Models quantity ranges with specific additional functionality for `AngleRange`s and `TimePeriod`s.
* __number__: Enables support for arbitrary precision and imaginary and complex numbers.  All the quantity libraries use the `number` library implicitly.
* __quantity__: A superset of all the above libraries.  Just import this one to gain access to everything in the quantity package. 
 
The quantity package also includes set of domain-specific libraries that expose commonly used units, constants and symbols for a particular domain: 
* __astronomical__  
* __electromagnetic__ 
* __thermodynamic__  
* __universal__