/// The quantity extension library includes unit synonyms to enable very terse
/// constructors and expressions, non-SI units, constants, and auxiliary
/// functions.
///
library quantity_ext;

import 'package:quantity/number.dart';
import 'package:quantity/quantity.dart';

export 'src/quantity/ext/angle_ext.dart';

// quantity type extensions
//part 'src/quantity/ext/angle_ext.dart';
part 'src/quantity/ext/amount_of_substance_ext.dart';
part 'src/quantity/ext/length_ext.dart';
part 'src/quantity/ext/luminous_intensity_ext.dart';
part 'src/quantity/ext/mass_ext.dart';
part 'src/quantity/ext/scalar_ext.dart';
part 'src/quantity/ext/temperature_ext.dart';
part 'src/quantity/ext/time_ext.dart';
