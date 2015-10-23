/// Models ranges of quantites with start and end values (not necessarily increasing).
///
/// Additional classes and utilities are provided for `Angle` and `TimePeriod` ranges.
///
library quantity_range;

import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart' show angle0, angle360;
import 'package:quiver/core.dart' show hash2;

part 'range/angle_range.dart';
part 'range/quantity_range.dart';
part 'range/time_period.dart';
