import '../number/double.dart';
import '../number/precise.dart';
import '../si/types/scalar.dart';

/// The standard SI unit.
final ScalarUnits one = Scalar.one;

/// Synonymous with [Scalar.percent].
final ScalarUnits percent = Scalar.percent;

/// One trillionth (US: 10^-12) as a unit.
final ScalarUnits trillionthsUS = ScalarUnits(
    'trillionths', 'trillionths', 'trillionths', 'trillionth', 1.0e-12, false);

/// One billionth (US: 10^-9) as a unit.
final ScalarUnits billionthsUS = ScalarUnits(
    'billionths', 'billionths', 'billionths', 'billionth', 1.0e-9, false);

/// One millionth as a unit.
final ScalarUnits millionths = ScalarUnits(
    'millionths', 'millionths', 'millionths', 'millionth', 1.0e-6, false);

/// One thousandth as a unit.
final ScalarUnits thousandths = ScalarUnits(
    'thousandths', 'thousandths', 'thousandths', 'thousandth', 0.001, false);

/// One hundredth as a unit.
final ScalarUnits hundredths = ScalarUnits(
    'hundredths', 'hundredths', 'hundredths', 'hundredth', 0.01, false);

/// One tenth as a unit.
final ScalarUnits tenths =
    ScalarUnits('tenths', 'tenths', 'tenths', 'tenth', 0.1, false);

/// A pair is 2.
final ScalarUnits pair =
    ScalarUnits('pairs', 'pairs', 'pairs', 'pair', 2.0, false);

/// A half-dozen is 6.
final ScalarUnits halfDozen = ScalarUnits(
    'half dozen', 'half dozen', 'half dozen', 'half dozen', 6.0, false);

/// A dozen is 12.
final ScalarUnits dozen =
    ScalarUnits('dozen', 'dozen', 'dozen', 'dozen', 12.0, false);

/// A baker's dozen is 13.  One extra donut.  Thank you.
final ScalarUnits bakersDozen = ScalarUnits("baker's dozen", "baker's dozen",
    "baker's dozen", "baker's dozen", 13.0, false);

/// A score is 20.  Four score is 80.  More poetic than just saying eighty.
final ScalarUnits score =
    ScalarUnits('score', 'score', 'score', 'score', 20.0, false);

/// 100 as a unit.
final ScalarUnits hundred =
    ScalarUnits('hundred', 'hundred', 'hundred', 'hundred', 100.0, false);

/// A gross is 144.
final ScalarUnits gross =
    ScalarUnits('gross', 'gross', 'gross', 'gross', 144.0, false);

/// 1000 as a unit.
final ScalarUnits thousand =
    ScalarUnits('thousand', 'thousand', 'thousand', 'thousand', 1000.0, false);

/// A great gross is 1728.
final ScalarUnits greatGross = ScalarUnits(
    'great gross', 'great gross', 'great gross', 'great gross', 1728.0, false);

/// A myriad is ten thousand.
final ScalarUnits myriad =
    ScalarUnits('myriad', 'myriad', 'myriad', 'myriad', 10000.0, false);

/// One million as a unit.
final ScalarUnits million =
    ScalarUnits('million', 'million', 'million', 'million', 1.0e6, false);

/// One billion (US: 10^9) as a unit.
final ScalarUnits billionUS =
    ScalarUnits('billion', 'billion', 'billion', 'billion', 1.0e9, false);

/// One trillion (US: 10^12) as a unit.
final ScalarUnits trillionUS =
    ScalarUnits('trillion', 'trillion', 'trillion', 'trillion', 1.0e12, false);

/// One quadrillion (US: 10^15) as a unit.
final ScalarUnits quadrillionUS = ScalarUnits(
    'quadrillion', 'quadrillion', 'quadrillion', 'quadrillion', 1.0e15, false);

/// One quintillion (US: 10^18) as a unit.
final ScalarUnits quintillionUS = ScalarUnits(
    'quintillion', 'quintillion', 'quintillion', 'quintillion', 1.0e18, false);

/// One sextillion (US: 10^21) as a unit.
final ScalarUnits sextillionUS = ScalarUnits(
    'sextillion', 'sextillion', 'sextillion', 'sextillion', 1.0e21, false);

/// One septillion (US: 10^24) as a unit.
final ScalarUnits septillionUS = ScalarUnits(
    'septillion', 'septillion', 'septillion', 'septillion', 1.0e24, false);

/// One octillion (US: 10^27) as a unit.
final ScalarUnits octillionUS = ScalarUnits(
    'octillion', 'octillion', 'octillion', 'octillion', 1.0e27, false);

/// One nonillion (US: 10^30) as a unit.
final ScalarUnits nonillionUS = ScalarUnits(
    'nonillion', 'nonillion', 'nonillion', 'nonillion', 1.0e30, false);

/// One decillion (US: 10^33) as a unit.
final ScalarUnits decillionUS = ScalarUnits(
    'decillion', 'decillion', 'decillion', 'decillion', 1.0e33, false);

/// One duotrigintillion (10^99) as a unit.
final ScalarUnits duotrigintillion = ScalarUnits('duotrigintillion',
    'duotrigintillion', 'duotrigintillion', 'duotrigintillion', 1.0e99, false);

/// One googol (10^100) as a unit.
final ScalarUnits googols =
    ScalarUnits('googols', 'googols', 'googols', 'googol', 1.0e100, true);

// European variants.

/// The European variant of one billion (10^12) as a unit.
final ScalarUnits billionEur = ScalarUnits('billion (eur)', 'billion (eur)',
    'billion (eur)', 'billion (eur)', 1.0e12, false);

/// The European variant of one trillion (10^18) as a unit.
final ScalarUnits trillionEur = ScalarUnits('trillion (eur)', 'trillion (eur)',
    'trillion (eur)', 'trillion (eur)', 1.0e18, false);

/// The European variant of one quadrillion (10^24) as a unit.
final ScalarUnits quadrillionEur = ScalarUnits(
    'quadrillion (eur)',
    'quadrillion (eur)',
    'quadrillion (eur)',
    'quadrillion (eur)',
    1.0e24,
    false);

/// The European variant of one quintillion (10^30) as a unit.
final ScalarUnits quintillionEur = ScalarUnits(
    'quintillion (eur)',
    'quintillion (eur)',
    'quintillion (eur)',
    'quintillion (eur)',
    1.0e30,
    false);

/// The European variant of one sextillion (10^36) as a unit.
final ScalarUnits sextillionEur = ScalarUnits('sextillion (eur)',
    'sextillion (eur)', 'sextillion (eur)', 'sextillion (eur)', 1.0e36, false);

/// The European variant of one billion (10^42) as a unit.
final ScalarUnits septillionEur = ScalarUnits('septillion (eur)',
    'septillion (eur)', 'septillion (eur)', 'septillion (eur)', 1.0e42, false);

/// The European variant of one octillion (10^48) as a unit.
final ScalarUnits octillionEur = ScalarUnits('octillion (eur)',
    'octillion (eur)', 'octillion (eur)', 'octillion (eur)', 1.0e48, false);

/// The European variant of one nonillion (10^54) as a unit.
final ScalarUnits nonillionEur = ScalarUnits('nonillion (eur)',
    'nonillion (eur)', 'nonillion (eur)', 'nonillion (eur)', 1.0e54, false);

/// The European variant of one decillion (10^60) as a unit.
final ScalarUnits decillionEur = ScalarUnits('decillion (eur)',
    'decillion (eur)', 'decillion (eur)', 'decillion (eur)', 1.0e60, false);

// CONSTANTS.

/// Zero, as a Scalar.
const Scalar scalarZero = Scalar.constant(Double.zero);

/// A synonym for zero.
const Scalar naught = scalarZero;

/// A synonym for zero.
const Scalar zilch = scalarZero;

/// Fine structure constant (alpha).
const Scalar fineStructureConstant = Scalar.constant(
    Double.constant(7.2973525693e-3),
    uncert: 1.5073959899206537e-10);

/// Proton g factor (gp).
const Scalar protonGFactor = Scalar.constant(Double.constant(5.5856946893),
    uncert: 2.864460177289984e-10);

/// Electron g factor (ge).
const Scalar electronGFactor = Scalar.constant(
    Double.constant(-2.00231930436256),
    uncert: 1.7479729593448774e-13);

/// Neutron g factor (gn).
const Scalar neutronGFactor = Scalar.constant(Double.constant(-3.82608545),
    uncert: 2.3522736534804782e-7);

/// Muon g factor (gn).
const Scalar muonGFactor = Scalar.constant(Double.constant(-2.0023318418),
    uncert: 6.492430339775063e-10);

/// googol (10^100), arbitrary precision.
Scalar googol =
    Scalar(value: Precise.raw(<Digit>[Digit.one], power: 100, sigDigits: 101));

/// Sackur-Tetrode constant at 1 K and 100 kPa ('S0/R').
const Scalar sackurTetrode100kPa = Scalar.constant(
    Double.constant(-1.15170753706),
    uncert: 3.9072419474542043e-10);

/// Sackur-Tetrode constant at 1 K and 101.325 kPa ('S0/R').
const Scalar sackurTetrodeStdAtm = Scalar.constant(
    Double.constant(-1.16487052358),
    uncert: 3.863090282489196e-10);

/// Weak mixing angle.
const Scalar weakMixingAngle =
    Scalar.constant(Double.constant(0.22290), uncert: 0.0013458950201884253);
