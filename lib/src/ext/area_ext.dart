part of quantity_ext;

/// The standard SI unit for area quantities.
final AreaUnits squareMeters = Area.squareMeters;

/// Accepted for use with the SI, subject to further review...
/// equals one square decameter, or 100 square meters.
final AreaUnits ares = Area.ares;

/// Accepted for use with the SI, subject to further review...
/// equals 100 square femtometers, or 1.0e-28 square meters **/
final AreaUnits barns = Area.barns;

/// Accepted for use with the SI, subject to further review...
/// equals 1 square hectometer, or 10 000 square meters.
final AreaUnits hectares = Area.hectares;

final AreaUnits acres = new AreaUnits("acres", null, null, null, 4.0468564224e3, false);

final AreaUnits circularMils = new AreaUnits("circular mils", null, null, null, 5.0670748e-10, false);

final AreaUnits squareFeet = new AreaUnits.lengthSquared(feet);

final AreaUnits squareInches = new AreaUnits.lengthSquared(inches);

final AreaUnits squareKilometers = new AreaUnits.lengthSquared(kilometers);

final AreaUnits squareCentimeters = new AreaUnits.lengthSquared(centimeters);

final AreaUnits squareMiles = new AreaUnits.lengthSquared(miles);

final AreaUnits townships = new AreaUnits("townships", null, null, null, 9.3239572e7, false);

final AreaUnits squareYards = new AreaUnits.lengthSquared(yards);

final AreaUnits squareRods = new AreaUnits.lengthSquared(rods);

// convenience units
final AreaUnits sections = squareMiles;
final AreaUnits squarePoles = squareRods;
final AreaUnits squarePerches = squareRods;

// constants
const Area thomsonCrossSection =
    const Area.constant(const Double.constant(0.66524587158e-28), uncert: 1.367915290986615e-9);
