part of quantity_ext;

final ScalarUnits one = Scalar.one;
final ScalarUnits percent = Scalar.percent;

final ScalarUnits trillionthsUS =
    new ScalarUnits("trillionths", null, null, "trillionth", 1.0e-12, false);

final ScalarUnits billionthsUS =
    new ScalarUnits("billionths", null, null, "billionth", 1.0e-9, false);

final ScalarUnits millionths =
    new ScalarUnits("millionths", null, null, "millionth", 1.0e-6, false);

final ScalarUnits thousandths =
    new ScalarUnits("thousandths", null, null, "thousandth", 0.001, false);

final ScalarUnits hundredths =
    new ScalarUnits("hundredths", null, null, "hundredth", 0.01, false);

final ScalarUnits tenths =
    new ScalarUnits("tenths", null, null, "tenth", 0.1, false);

final ScalarUnits pair =
    new ScalarUnits("pairs", null, null, "pair", 2.0, false);

final ScalarUnits halfDozen =
    new ScalarUnits("half dozen", null, null, "half dozen", 6.0, false);

final ScalarUnits dozen =
    new ScalarUnits("dozen", null, null, "dozen", 12.0, false);

final ScalarUnits bakersDozen =
    new ScalarUnits("baker's dozen", null, null, "baker's dozen", 13.0, false);

final ScalarUnits score =
    new ScalarUnits("score", null, null, "score", 20.0, false);

final ScalarUnits hundred =
    new ScalarUnits("hundred", null, null, "hundred", 100.0, false);

final ScalarUnits gross =
    new ScalarUnits("gross", null, null, "gross", 144.0, false);

final ScalarUnits thousand =
    new ScalarUnits("thousand", null, null, "thousand", 1000.0, false);

final ScalarUnits greatGross =
    new ScalarUnits("great gross", null, null, "great gross", 1728.0, false);

final ScalarUnits myriad =
    new ScalarUnits("myriad", null, null, "myriad", 10000.0, false);

final ScalarUnits million =
    new ScalarUnits("million", null, null, "million", 1.0e6, false);

final ScalarUnits billionUS =
    new ScalarUnits("billion", null, null, "billion", 1.0e9, false);

final ScalarUnits trillionUS =
    new ScalarUnits("trillion", null, null, "trillion", 1.0e12, false);

final ScalarUnits quadrillionUS =
    new ScalarUnits("quadrillion", null, null, "quadrillion", 1.0e15, false);

final ScalarUnits quintillionUS =
    new ScalarUnits("quintillion", null, null, "quintillion", 1.0e18, false);

final ScalarUnits sextillionUS =
    new ScalarUnits("sextillion", null, null, "sextillion", 1.0e21, false);

final ScalarUnits setillionUS =
    new ScalarUnits("septillion", null, null, "septillion", 1.0e24, false);

final ScalarUnits octillionUS =
    new ScalarUnits("octillion", null, null, "octillion", 1.0e27, false);

final ScalarUnits nonillionUS =
    new ScalarUnits("nonillion", null, null, "nonillion", 1.0e30, false);

final ScalarUnits decillionUS =
    new ScalarUnits("decillion", null, null, "decillion", 1.0e33, false);

final ScalarUnits duotrigintillion = new ScalarUnits(
    "duotrigintillion", null, null, "duotrigintillion", 1.0e99, false);

final ScalarUnits googols =
    new ScalarUnits("googols", null, null, "googol", 1.0e100, true);

// Eurapean Variants
final ScalarUnits billionEur = new ScalarUnits(
    "billion (eur)", null, null, "billion (eur)", 1.0e12, false);

final ScalarUnits trillionEur = new ScalarUnits(
    "trillion (eur)", null, null, "trillion (eur)", 1.0e18, false);

final ScalarUnits quadrillionEur = new ScalarUnits(
    "quadrillion (eur)", null, null, "quadrillion (eur)", 1.0e24, false);

final ScalarUnits quintillionEur = new ScalarUnits(
    "quintillion (eur)", null, null, "quintillion (eur)", 1.0e30, false);

final ScalarUnits sextillionEur = new ScalarUnits(
    "sextillion (eur)", null, null, "sextillion (eur)", 1.0e36, false);

final ScalarUnits septillionEur = new ScalarUnits(
    "septillion (eur)", null, null, "septillion (eur)", 1.0e42, false);

final ScalarUnits octillionEur = new ScalarUnits(
    "octillion (eur)", null, null, "octillion (eur)", 1.0e48, false);

final ScalarUnits nonillionEur = new ScalarUnits(
    "nonillion (eur)", null, null, "nonillion (eur)", 1.0e54, false);

final ScalarUnits decillionEur = new ScalarUnits(
    "decillion (eur)", null, null, "decillion (eur)", 1.0e60, false);

// CONSTANTS

// zero, in various names **/
const Scalar scalarZero = const Scalar.constant(Double.zero);
final Scalar naught = scalarZero;
final Scalar zilch = scalarZero;

/// Fine structure constant (alpha).
final Scalar fineStructureConstant =
    new Scalar(value: 7.2973525698e-3, uncert: 3.2e-10);

/// Proton g factor (gp).
final Scalar protonGFactor = new Scalar(value: 5.585694713, uncert: 8.2e-9);

/// Electron g factor (ge).
final Scalar electronGFactor =
    new Scalar(value: -2.00231930436153, uncert: 2.6e-13);

/// Neutron g factor (gn).
final Scalar neutronGFactor = new Scalar(value: -3.82608545, uncert: 2.4e-7);

/// Muon g factor (gn).
final Scalar muonGFactor = new Scalar(value: -2.0023318418, uncert: 6.3e-10);

/// googol (10^100), arbitrary precision.
final Scalar googol = new Scalar(
    value:
        10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);

/// Sackur-Tetrode constant at 1 K and 100 kPa ("S0/R").
final Scalar SACKUR_TETRODE_100kPA = THERMODYNAMIC.SACKUR_TETRODE_100kPA;

/// Sackur-Tetrode constant at 1 K and 101.325 kPa ("S0/R")
final Scalar SACKUR_TETRODE_STD_ATM = THERMODYNAMIC.SACKUR_TETRODE_STD_ATM;

/// Weak mixing angle
final Scalar weakMixingAngle = new Scalar(value: 0.2223, uncert: 9.5e-3);
