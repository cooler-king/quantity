import '../si/types/volume.dart';
import 'length_ext.dart';

/// The standard SI unit.
VolumeUnits cubicMeters = Volume.cubicMeters;

/// A terse alternative to `Volume.liters`.
VolumeUnits liters = Volume.liters;

/// Acre foot as a unit.
VolumeUnits acreFoot = VolumeUnits(
    'acre foot', 'acre ft', 'acre ft', 'acre foot', 1.23348183754752e3, false);

/// Barrels petroleum as a unit.
VolumeUnits barrelsPetroleum = VolumeUnits(
    'barrels (petroleum, 42 gal)',
    'barrels (petrol, 42 gal)',
    'barrels (petrol, 42 gal)',
    'barrel (petroleum, 42 gal)',
    1.589873e-1,
    false);

/// Barrels as a unit.
VolumeUnits barrels = VolumeUnits('barrels (other liquids, 31.5 gal)', 'bbl',
    'bbl', 'barrel (other liquids, 31.5 gal)', 0.11924, false);

/// Board feet as a unit.
VolumeUnits boardFeet = VolumeUnits(
    'board feet', 'board ft', 'board ft', 'board foot', 2.3597e-3, false);

/// Bushels as a unit.
VolumeUnits bushels = VolumeUnits(
    'bushels (U.S.)', 'bu', 'bu', 'bushel (U.S.)', 3.523907016688e-2, false);

/// Cords as a unit.
VolumeUnits cords = VolumeUnits('cords', 'cd', 'cd', 'cord', 3.6245563, false);

/// Cups as a unit.
VolumeUnits cups =
    VolumeUnits('cups', 'cups', 'cups', 'cup', 2.365882365e-4, false);

/// Drams as a unit.
VolumeUnits drams = VolumeUnits('drams (U.S. fluid)', 'drams (US fluid)',
    'drams (US fluid)', 'dram (U.S. fluid)', 3.6966911953125e-6, false);

/// Fluid ounces as a unit.
VolumeUnits fluidOunces = VolumeUnits('fluid ounces', 'fluid oz', 'fluid oz',
    'fluid ounce', 2.95735295625e-5, false);

/// U.K. fluid ounces as a unit.
VolumeUnits fluidOuncesUK = VolumeUnits('fluid ounces (U.K.)', 'fluid oz (UK)',
    'fluid oz (UK)', 'fluid ounce (U.K.)', 2.8413e-5, false);

/// Barrels as a unit.
VolumeUnits cubicFeet = VolumeUnits.lengthCubed(feet);

/// U.S. liquid gallons as a unit.
VolumeUnits gallonsUSLiquid = VolumeUnits(
    'gallons (U.S. liquid)',
    'gallons (US liq)',
    'gallons (US liq)',
    'gallon (U.S. liquid)',
    3.785411784e-3,
    false);

/// U.K. liquid gallons as a unit.
VolumeUnits gallonsUKLiquid = VolumeUnits(
    'gallons (U.K. liquid)',
    'gallons (UK liq)',
    'gallons (UK liq)',
    'gallons (U.K. liquid)',
    4.546087e-3,
    false);

/// U.S. dry gallons as a unit.
VolumeUnits gallonsUSDry = VolumeUnits('gallons (U.S. dry)', 'gallons (US dry)',
    'gallons (US dry)', 'gallon (U.S. dry)', 4.40488377086e-3, false);

/// U.K. gills as a unit.
VolumeUnits gillsUK = VolumeUnits('gills (U.K.)', 'gills (UK)', 'gills (UK)',
    'gill (U.K.)', 1.420652e-4, false);

/// U.S. gills as a unit.
VolumeUnits gillsUS = VolumeUnits('gills (U.S.)', 'gills (US)', 'gills (US)',
    'gill (U.S.)', 1.1829412e-4, false);

/// Hogsheads as a unit.
VolumeUnits hogsheads = VolumeUnits(
    'hogsheads', 'hogsheads', 'hogsheads', 'hogshead', 2.38480942392e-1, false);

/// Cubic inches as a unit.
VolumeUnits cubicInches = VolumeUnits.lengthCubed(inches);

/// Cubic parsecs as a unit.
VolumeUnits cubicParsecs = VolumeUnits.lengthCubed(parsecs);

/// Pecks as a unit.
VolumeUnits pecks =
    VolumeUnits('pecks', 'pecks', 'pecks', 'peck', 8.80976754172e-3, false);

/// U.S. dry pints as a unit.
VolumeUnits pintsDry = VolumeUnits('pints (U.S. dry)', 'pints (US dry)',
    'pints (US dry)', 'pint (U.S. dry)', 5.506104713575e-4, false);

/// U.S. liquid pints as a unit.
VolumeUnits pintsLiquid = VolumeUnits('pints (U.S. liquid)', 'pints (US liq)',
    'pints (US liq)', 'pint (U.S. liquid)', 4.73176473e-4, false);

/// U.S. dry quarts as a unit.
VolumeUnits quartsDry = VolumeUnits('quarts (U.S. dry)', 'quarts (US dry)',
    'quarts (US dry)', 'quart (U.S. dry)', 1.101220942715e-3, false);

/// U.S. liquid quarts as a unit.
VolumeUnits quartsLiquid = VolumeUnits(
    'quarts (U.S. liquid)',
    'quarts (US liq)',
    'quarts (US liq)',
    'quart (U.S. liquid)',
    9.4635295e-4,
    false);

/// Tablespoons as a unit.
VolumeUnits tablespoons = VolumeUnits(
    'tablespoons', 'Tbsp', 'Tbsp', 'tablespoon', 1.478676478125e-5, false);

/// Teaspoons as a unit.
VolumeUnits teaspoons = VolumeUnits(
    'teaspoons', 'tsp', 'tsp', 'teaspoon', 1.478676478125e-5, false);

/// Registry tons as a unit.
VolumeUnits registryTons = VolumeUnits('registry tons', 'registry tons',
    'registry tons', 'registry ton', 2.8316846592, false);

/// Cubic yards as a unit.
VolumeUnits cubicYards = VolumeUnits.lengthCubed(yards);

/// Cubic centimeters as a unit.
VolumeUnits cubicCentimeters = VolumeUnits.lengthCubed(centimeters);

// Convenience units.

/// A synonym for cubic meters.
VolumeUnits steres = cubicMeters;
