/// Core library containing only core dimensions, units, numbers and quantity engine classes.
/// Does not export any of the 75+ physical quantity subclasses, allowing clean compiler tree-shaking.
library quantity_core;

export 'package:decimal/decimal.dart';
export 'number.dart';
export 'src/si/dimensions.dart';
export 'src/si/dimensions_exception.dart';
export 'src/si/engineering_format_si.dart';
export 'src/si/immutable_quantity_exception.dart';
export 'src/si/misc_quantity.dart';
export 'src/si/number_format_si.dart';
export 'src/si/quantity.dart';
export 'src/si/quantity_exception.dart';
export 'src/si/scientific_format_si.dart';
export 'src/si/uncertainty_format.dart';
export 'src/si/units.dart';
export 'src/si/utilities.dart';
