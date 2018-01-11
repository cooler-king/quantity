part of quantity_ext;

final CurrentUnits amperes = Current.amperes;

final CurrentUnits abamperes = new CurrentUnits('abamperes', null, null, null, 10.0, true);

final CurrentUnits statamperes = new CurrentUnits('statamperes', null, null, null, 3.335640e-10, false);

final CurrentUnits gilberts = new CurrentUnits('gilberts', null, null, null, 7.9577e-1, false);

// Metric units
final CurrentUnits yottaamperes = Current.amperes.yotta() as CurrentUnits;
final CurrentUnits zettaamperes = Current.amperes.zetta() as CurrentUnits;
final CurrentUnits exaamperes = Current.amperes.exa() as CurrentUnits;
final CurrentUnits petaamperes = Current.amperes.peta() as CurrentUnits;
final CurrentUnits teraamperes = Current.amperes.tera() as CurrentUnits;
final CurrentUnits gigaamperes = Current.amperes.giga() as CurrentUnits;
final CurrentUnits megaamperes = Current.amperes.mega() as CurrentUnits;
final CurrentUnits kiloamperes = Current.amperes.kilo() as CurrentUnits;
final CurrentUnits hectoamperes = Current.amperes.hecto() as CurrentUnits;
final CurrentUnits dekaamperes = Current.amperes.deka() as CurrentUnits;
final CurrentUnits deciamperes = Current.amperes.deci() as CurrentUnits;
final CurrentUnits centiamperes = Current.amperes.centi() as CurrentUnits;
final CurrentUnits milliamperes = Current.milliamperes;
final CurrentUnits microamperes = Current.amperes.micro() as CurrentUnits;
final CurrentUnits nanoamperes = Current.amperes.nano() as CurrentUnits;
final CurrentUnits picoamperes = Current.amperes.pico() as CurrentUnits;
final CurrentUnits femtoamperes = Current.amperes.femto() as CurrentUnits;
final CurrentUnits attoamperes = Current.amperes.atto() as CurrentUnits;
final CurrentUnits zeptoamperes = Current.amperes.zepto() as CurrentUnits;
final CurrentUnits yoctoamperes = Current.amperes.yocto() as CurrentUnits;

// Synonyms
final CurrentUnits amps = Current.amperes;
