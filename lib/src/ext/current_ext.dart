import '../si/types/current.dart';

/// The standard SI unit.
final CurrentUnits amperes = Current.amperes;

/// Abamperes as a unit.
final CurrentUnits abamperes =
    CurrentUnits('abamperes', 'abamperes', 'abamperes', 'abampere', 10.0, true);

/// Statamperes as a unit.
final CurrentUnits statamperes = CurrentUnits('statamperes', 'statamperes',
    'statamperes', 'statampere', 3.335640e-10, false);

/// Gilberts as a unit.
final CurrentUnits gilberts = CurrentUnits(
    'gilberts', 'gilberts', 'gilberts', 'gilbert', 7.9577e-1, false);

// Synonyms.

/// A synonym for [amperes].
final CurrentUnits amps = Current.amperes;
