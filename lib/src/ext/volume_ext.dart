part of quantity_ext;

VolumeUnits cubicMeters = Volume.cubicMeters;

VolumeUnits liters = Volume.liters;

VolumeUnits acreFoot = new VolumeUnits('acre foot', null, null, 'acre foot', 1.23348183754752e3, false);

VolumeUnits barrelsPetroleum =
    new VolumeUnits('barrels (petroleum, 42 gal)', null, null, 'barrel (petroleum, 42 gal)', 1.589873e-1, false);

VolumeUnits barrels = new VolumeUnits(
    'barrels (other liquids, 31.5 gal)', 'bbl', null, 'barrel (other liquids, 31.5 gal)', 0.11924, false);

VolumeUnits boardFeet = new VolumeUnits('board feet', null, null, 'board foot', 2.3597e-3, false);

VolumeUnits bushels = new VolumeUnits('bushels (U.S.)', 'bu', null, 'bushel (U.S.)', 3.523907016688e-2, false);

VolumeUnits cords = new VolumeUnits('cords', 'cd', null, null, 3.6245563, false);

VolumeUnits cups = new VolumeUnits('cups', null, null, null, 2.365882365e-4, false);

VolumeUnits drams = new VolumeUnits('drams (U.S. fluid)', null, null, 'dram (U.S. fluid)', 3.6966911953125e-6, false);

VolumeUnits fluidOunces = new VolumeUnits('fluid ounces', null, null, 'fluid ounce', 2.95735295625e-5, false);

VolumeUnits fluidOuncesUK = new VolumeUnits('fluid ounces (U.K.)', null, null, 'fluid ounce (U.K.)', 2.8413e-5, false);

VolumeUnits cubicFeet = new VolumeUnits.length(feet);

VolumeUnits gallonsUSLiquid =
    new VolumeUnits('gallons (U.S. liquid)', null, null, 'gallon (U.S. liquid)', 3.785411784e-3, false);

VolumeUnits gallonsUKLiquid =
    new VolumeUnits('gallons (U.K. liquid)', null, null, 'gallons (U.K. liquid)', 4.546087e-3, false);

VolumeUnits gallonsUSDry =
    new VolumeUnits('gallons (U.S. dry)', null, null, 'gallon (U.S. dry)', 4.40488377086e-3, false);

VolumeUnits gillsUK = new VolumeUnits('gills (U.K.)', null, null, 'gill (U.K.)', 1.420652e-4, false);

VolumeUnits gillsUS = new VolumeUnits('gills (U.S.)', null, null, 'gill (U.S.)', 1.1829412e-4, false);

VolumeUnits hogsheads = new VolumeUnits('hogsheads', null, null, null, 2.38480942392e-1, false);

VolumeUnits cubicInches = new VolumeUnits.length(inches);

VolumeUnits cubicParsecs = new VolumeUnits.length(parsecs);

VolumeUnits pecks = new VolumeUnits('pecks', null, null, null, 8.80976754172e-3, false);

VolumeUnits pintsDry = new VolumeUnits('pints (U.S. dry)', null, null, 'pint (U.S. dry)', 5.506104713575e-4, false);

VolumeUnits pintsLiquid =
    new VolumeUnits('pints (U.S. liquid)', null, null, 'pint (U.S. liquid)', 4.73176473e-4, false);

VolumeUnits quartsDry = new VolumeUnits('quarts (U.S. dry)', null, null, 'quart (U.S. dry)', 1.101220942715e-3, false);

VolumeUnits quartsLiquid =
    new VolumeUnits('quarts (U.S. liquid)', null, null, 'quart (U.S. liquid)', 9.4635295e-4, false);

VolumeUnits tablespoons = new VolumeUnits('tablespoons', null, 'Tbsp', null, 1.478676478125e-5, false);

VolumeUnits teaspoons = new VolumeUnits('teaspoons', null, 'tsp', null, 1.478676478125e-5, false);

VolumeUnits registryTons = new VolumeUnits('registry tons', null, null, null, 2.8316846592, false);

VolumeUnits cubicYards = new VolumeUnits.length(yards);

VolumeUnits cubicCentimeters = new VolumeUnits.length(centimeters);

// convenience units
VolumeUnits steres = cubicMeters;
