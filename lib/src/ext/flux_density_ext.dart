part of quantity_ext;

final SpectralIrradianceUnits JOULE_PER_SQUARE_METER =
HeatFluxDensityUnits.;


final FluxDensityUnits JANSKYS =
   new HeatFluxDensityUnits("janskys","f.u.","Jy",null,1.0e-26,true);

final HeatFluxDensityUnits FLUX_UNIT = JANSKYS;

final HeatFluxDensityUnits WATT_PER_SQUARE_METER_PER_HERTZ =
   new HeatFluxDensityUnits(Power.WATTS,Area.SQUARE_METERS,Frequency.HERTZ);