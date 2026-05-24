import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart';

void main() {
  group('Extension Units and Constants', () {
    test('acceleration_ext', () {
      expect(standardAccelerationOfGravity.valueSI.toDouble(), 9.80665);
      expect(gees.name, 'gees');
      expect(meterPerSecondSquared.name, 'meters per second squared');
      expect(footPerSecondSquared.name, 'feet per second squared');
      expect(inchPerSecondSquared.name, 'inches per second squared');
      expect(galileos.name, 'galileos');
      expect(gals, galileos);
    });

    test('amount_of_substance_ext', () {
      expect(moles.name, 'moles');
      expect(kilomoles.name, 'kilomoles');
    });

    test('angle_ext', () {
      expect(degrees.name, 'degrees');
      expect(minutesArc.name, 'arc minutes');
      expect(secondsArc.name, 'arc seconds');
      expect(radians.name, 'radians');
      expect(grads.name, 'grads');
    });

    test('angular_momentum_ext', () {
      expect(hBar.valueSI.toDouble(), closeTo(1.0545718e-34, 1e-40));
      expect(jouleSecond.name, 'joule seconds');
      expect(planckUnits.name, 'h');
      expect(hBarUnits.name, 'h-bar');
      expect(planckConstant.valueSI.toDouble(), 6.62607015e-34);
    });

    test('angular_speed_ext', () {
      expect(revolutionsPerMinute.name, 'revolutions per minute');
      expect(rpm.name, 'revolutions per minute');
      expect(radiansPerSecond.name, 'radians per second');
      expect(degreesPerSecond.name, 'degrees per second');
    });

    test('area_ext', () {
      expect(squareMeters.name, 'square meters');
      expect(ares.name, 'ares');
      expect(hectares.name, 'hectares');
      expect(acres.name, 'acres');
      expect(barns.name, 'barns');
      expect(circularMils.name, 'circular mils');
      expect(squareFeet.name, 'square feet');
      expect(squareInches.name, 'square inches');
      expect(squareKilometers.name, 'square kilometers');
      expect(squareCentimeters.name, 'square centimeters');
      expect(squareMiles.name, 'square miles');
      expect(townships.name, 'townships');
      expect(squareYards.name, 'square yards');
      expect(squareRods.name, 'square rods');
      expect(sections.name, 'square miles');
      expect(squarePoles.name, 'square rods');
      expect(squarePerches.name, 'square rods');
      expect(thomsonCrossSection.valueSI.toDouble(),
          closeTo(6.6524587051e-29, 1e-35));
      expect(sigma0, thomsonCrossSection);
    });

    test('capacitance_ext', () {
      expect(farads.name, 'farads');
      expect(emuCapacitance.name, 'emu (capacitance)');
      expect(statfarads.name, 'statfarads');
      expect(abfarads.name, 'gigafarads');
      expect(esuCapacitance, statfarads);
    });

    test('charge_ext', () {
      expect(coulombs.name, 'coulombs');
      expect(ampereHours.name, 'ampere hours');
      expect(abcoulombs.name, 'dekacoulombs');
      expect(statcoulombs.name, 'statcoulombs');
      expect(faradaysC12.name, 'faradays (carbon 12)');
      expect(faradaysChemical.name, 'faradays (chemical)');
      expect(faradaysPhysical.name, 'faradays (physical)');
      expect(
          elementaryCharge.valueSI.toDouble(), closeTo(1.602176634e-19, 1e-25));
    });

    test('conductance_ext', () {
      expect(mho.name, 'siemens');
      expect(statmhos.name, 'statmhos');
      expect(abmho.name, 'gigasiemens');
      expect(conductanceQuantum.valueSI.toDouble(), 0.00007748091729);
    });

    test('current_ext', () {
      expect(amperes.name, 'amperes');
      expect(abamperes.name, 'abamperes');
      expect(statamperes.name, 'statamperes');
      expect(gilberts.name, 'gilberts');
      expect(amps.name, 'amperes');
    });

    test('electric_potential_difference_ext', () {
      expect(abvolts.name, 'abvolts');
      expect(statvolts.name, 'statvolts');
      expect(volts.name, 'volts');
      expect(emuPotential, abvolts);
      expect(esuPotential, statvolts);
    });

    test('energy_ext', () {
      expect(joules.name, 'joules');
      expect(caloriesThermo.name, 'calories (thermochemical)');
      expect(therms.name, 'therms');
      expect(electronVolts.name, 'electronvolts');
      expect(ergs.name, 'ergs');
      expect(btuInternationalTable.name, 'Btu (IT)');
      expect(btuThermo.name, 'Btu (thermochemical)');
      expect(btuMean.name, 'Btu (mean)');
      expect(btu39.name, 'Btu (39 deg F)');
      expect(btu60.name, 'Btu (60 deg F)');
      expect(caloriesInternationalTable.name, 'calories (IT)');
      expect(caloriesMean.name, 'calories (mean)');
      expect(calories15.name, 'calories (15 deg C)');
      expect(calories20.name, 'calories (20 deg C)');
      expect(caloriesKgInternationalTable.name, 'calories (kg, IT)');
      expect(caloriesKgMean.name, 'calories (kg, mean)');
      expect(caloriesKgThermo.name, 'calories (kg, thermochemical)');
      expect(footPoundsForce.name, 'foot pounds force');
      expect(footPoundals.name, 'foot-poundals');
      expect(kilowattHours.name, 'kilowatt hours');
      expect(tons.name, 'tons (equivalent TNT)');
      expect(wattHour.name, 'watt hours');
      expect(wattSecond.name, 'watt seconds');
      expect(kilojoules.name, 'kilojoules');
      expect(kilocaloriesThermo, caloriesKgThermo);
      expect(
          hartreeEnergy.valueSI.toDouble(), closeTo(4.359744722206e-18, 1e-24));
    });

    test('energy_flux_ext', () {
      expect(wattsPerSquareMeter.name, 'watts per square meter');
      expect(langleys.name, 'langleys');
    });

    test('entropy_ext', () {
      expect(clausius.name, 'Clausius');
      expect(thermalCoulomb, joulesPerKelvin);
      expect(boltzmannUnit.name, 'Boltzmanns');
      expect(ergPerKelvin.name, 'ergs per kelvin');
      expect(boltzmannConstant.valueSI.toDouble(), 1.380649e-23);
    });

    test('force_ext', () {
      expect(newtons.name, 'newtons');
      expect(dynes.name, 'dynes');
      expect(poundsForceAvoirdupois.name, 'pounds force (avoirdupois)');
      expect(kilogramsForce.name, 'kilograms force');
      expect(kips.name, 'kips');
      expect(ouncesForceAvoirdupois.name, 'ounces force (avoirdupois)');
      expect(poundals.name, 'poundals');
      expect(kiloponds, kilogramsForce);
    });

    test('illuminance_ext', () {
      expect(lux.name, 'lux');
      expect(footCandles.name, 'foot candles');
      expect(phots.name, 'phots');
    });

    test('inductance_ext', () {
      expect(henries.name, 'henries');
      expect(esuOfInductance.name, 'esu of inductance');
      expect(abhenries.name, 'nanohenries');
      expect(emuOfInductance, abhenries);
    });

    test('information_ext', () {
      expect(bits.name, 'bits');
      expect(bytes.name, 'bytes');
      expect(kilobytes.name, 'kilobytes');
      expect(megabytes.name, 'megabytes');
      expect(gigabytes.name, 'gigabytes');
      expect(terabytes.name, 'terabytes');
      expect(petabytes.name, 'petabytes');
      expect(exabytes.name, 'exabytes');
    });

    test('kinematic_viscosity_ext', () {
      expect(stokes.name, 'stokes');
      expect(metersSquaredPerSecond.name, 'square meters per second');
      expect(centistokes.name, 'centistokes');
      expect(squareFeetPerSecond.name, 'square feet per second');
    });

    test('length_ext', () {
      expect(feet.name, 'feet');
      expect(inches.name, 'inches');
      expect(miles.name, 'miles');
      expect(yards.name, 'yards');
      expect(meters.name, 'meters');
      expect(yottameters.name, 'yottameters');
      expect(zettameters.name, 'zettameters');
      expect(exameters.name, 'exameters');
      expect(petameters.name, 'petameters');
      expect(terameters.name, 'terameters');
      expect(gigameters.name, 'gigameters');
      expect(megameters.name, 'megameters');
      expect(kilometers.name, 'kilometers');
      expect(hectometers.name, 'hectometers');
      expect(dekameters.name, 'dekameters');
      expect(decimeters.name, 'decimeters');
      expect(centimeters.name, 'centimeters');
      expect(millimeters.name, 'millimeters');
      expect(micrometers.name, 'micrometers');
      expect(nanometers.name, 'nanometers');
      expect(picometers.name, 'picometers');
      expect(femtometers.name, 'femtometers');
      expect(attometers.name, 'attometers');
      expect(zeptometers.name, 'zeptometers');
      expect(yoctometers.name, 'yoctometers');
      expect(astronomicalUnits.name, 'astronomical units');
      expect(fermis.name, 'fermis');
      expect(cables.name, 'cables');
      expect(calibers.name, 'calibers');
      expect(chainsSurveyor.name, 'chains (surveyor)');
      expect(chainsEngineer.name, 'chains (engineer)');
      expect(cubits.name, 'cubits');
      expect(fathoms.name, 'fathoms');
      expect(feetUsSurvey.name, 'feet (US survey)');
      expect(furlongs.name, 'furlongs');
      expect(hands.name, 'hands');
      expect(leaguesUkNautical.name, 'leagues (UK nautical)');
      expect(leaguesNautical.name, 'leagues (nautical)');
      expect(leaguesStatute.name, 'leagues (statute)');
      expect(lightYears.name, 'light years');
      expect(linksEngineer.name, 'links (engineer)');
      expect(linksSurveyor.name, 'links (surveyor)');
      expect(microns.name, 'micrometers');
      expect(nauticalMilesUk.name, 'nautical miles (UK)');
      expect(paces.name, 'paces');
      expect(perches.name, 'perches');
      expect(points.name, 'points');
      expect(poles.name, 'poles');
      expect(rods.name, 'rods');
      expect(skeins.name, 'skeins');
      expect(spans.name, 'spans');
      expect(angstromStars.name, 'Angstrom stars');
      expect(lengthZero.valueSI.toDouble(), 0.0);
      expect(planckLength.valueSI.toDouble(), closeTo(1.616255e-35, 1e-40));
      expect(angstromStar.valueSI.toDouble(), 1.00001495e-10);
      expect(bohrRadius.valueSI.toDouble(), closeTo(5.2917721e-11, 1e-18));
      expect(
          comptonWavelength.valueSI.toDouble(), closeTo(2.4263102e-12, 1e-19));
      expect(
          tauComptonWavelength.valueSI.toDouble(), closeTo(6.97771e-16, 1e-21));
      expect(classicalElectronRadius.valueSI.toDouble(),
          closeTo(2.8179403e-15, 1e-20));
      expect(mils.name, 'mils');
      expect(parsecs.name, 'parsecs');
      expect(picas.name, 'picas');
      expect(xUnits.name, 'X units');
    });

    test('luminous_intensity_ext', () {
      expect(candelas.name, 'candelas');
    });

    test('magnetic_flux_density_ext', () {
      expect(teslas.name, 'teslas');
      expect(gauss.name, 'gauss');
      expect(unitPolesDensity.name, 'unit poles');
      expect(magFieldAtomicUnit.name, 'magnetic field, atomic unit');
      expect(magneticGammas.name, 'nanoteslas');
    });

    test('magnetic_flux_ext', () {
      expect(webers.name, 'webers');
      expect(maxwells.name, 'maxwells');
      expect(unitPoles.name, 'unit poles');
      expect(magneticFluxQuantum.valueSI.toDouble(),
          closeTo(2.067833848e-15, 1e-21));
    });

    test('mass_density_ext', () {
      expect(kilogramsPerCubicMeter.name, 'kilograms per cubic meter');
      expect(gramsPerCubicCentimeter.name, 'grams per cubic centimeter');
      expect(poundsPerCubicInch.name, 'pounds (avoirdupois) per cubic inch');
      expect(poundsPerCubicFoot.name, 'pounds (avoirdupois) per cubic foot');
      expect(slugsPerCubicFoot.name, 'slugs per cubic foot');
    });

    test('mass_ext', () {
      expect(grams.name, 'grams');
      expect(poundsAvoirdupois.name, 'pounds (avoirdupois)');
      expect(ouncesAvoirdupois.name, 'ounces (avoirdupois)');
      expect(kilograms.name, 'kilograms');
      expect(milligrams.name, 'milligrams');
      expect(kg, kilograms);
      expect(g, grams);
      expect(mg, milligrams);
      expect(gammas.name, 'micrograms');
      expect(metricTons.name, 'megagrams');
      expect(tonnes, metricTons);
      expect(unifiedAtomicMassUnits.name, 'unified atomic mass units');
      expect(caratsMetric.name, 'carats (metric)');
      expect(dramsApothecary.name, 'drams (apothecary)');
      expect(dramsAvoirdupois.name, 'drams (avoirdupois)');
      expect(grains.name, 'grains');
      expect(hundredweightLong.name, 'hundredweight (long)');
      expect(hundredweightShort.name, 'hundredweight (short)');
      expect(ouncesApothecary.name, 'ounces (apothecary)');
      expect(pennyweightTroy.name, 'pennyweight (troy)');
      expect(poundsApothecary.name, 'pounds (apothecary)');
      expect(quintals.name, 'quintals');
      expect(scruples.name, 'scruples');
      expect(slugs.name, 'slugs');
      expect(tonsLong.name, 'tons (long)');
      expect(tonsShort.name, 'tons (short)');
      expect(tonsAssay.name, 'tons (assay)');
      expect(kgfSecondSquaredMeter.name, 'kgf second squared meter');
      expect(planckMass.valueSI.toDouble(), closeTo(2.176434e-8, 1e-13));
      expect(alphaParticleMass.valueSI.toDouble(),
          closeTo(6.644657345e-27, 1e-33));
      expect(atomicMass.valueSI.toDouble(), closeTo(1.660539066e-27, 1e-35));
      expect(electronMass.valueSI.toDouble(), closeTo(9.1093837e-31, 1e-37));
      expect(protonMass.valueSI.toDouble(), closeTo(1.67262192e-27, 1e-34));
      expect(neutronMass.valueSI.toDouble(), closeTo(1.67492749e-27, 1e-34));
      expect(tauMass.valueSI.toDouble(), closeTo(3.16754e-27, 1e-31));
      expect(deuteronMass.valueSI.toDouble(), closeTo(3.3435837e-27, 1e-33));
      expect(helionMass.valueSI.toDouble(), closeTo(5.0064127e-27, 1e-33));
      expect(muonMass.valueSI.toDouble(), closeTo(1.8835316e-28, 1e-34));
    });

    test('permeability_ext', () {
      expect(vacuumMagneticPermeability.valueSI.toDouble(),
          closeTo(1.256637e-6, 1e-11));
      expect(henriesPerMeter.name, 'henries per meter');
      expect(newtonsPerAmpereSquared.name, 'newtons per ampere squared');
    });

    test('permittivity_ext', () {
      expect(vacuumElectricPermittivity.valueSI.toDouble(),
          closeTo(8.8541878e-12, 1e-18));
      expect(faradsPerMeter.name, 'farads per meter');
    });

    test('power_ext', () {
      expect(horsepower550.name, 'horsepower (550 ft lbs/s)');
      expect(watts.name, 'watts');
      expect(btuThermsPerHour.name, 'Btu (thermochemical) per hour');
      expect(btuThermsPerSecond.name, 'Btu (thermochemical) per second');
      expect(
          caloriesThermoPerSecond.name, 'calories (thermochemical) per second');
      expect(ergsPerSecond.name, 'ergs per second');
      expect(forceDeCheval.name, 'force de cheval');
      expect(horsepowerBoiler.name, 'horsepower (boiler)');
      expect(horsepowerElectric.name, 'horsepower (electric)');
      expect(horsepowerMetric.name, 'horsepower (metric)');
      expect(horsepowerWater.name, 'horsepower (water)');
      expect(referenceSound.name, 'reference (sound)');
      expect(kilowatts.name, 'kilowatts');
      expect(solarLuminosity.valueSI.toDouble(), closeTo(3.846e26, 1e20));
    });

    test('pressure_ext', () {
      expect(atmospheres.name, 'atmospheres (std)');
      expect(bars.name, 'bars');
      expect(pascals.name, 'pascals');
      expect(torrs.name, 'torrs');
      expect(psi.name, 'pounds force (avoirdupois) per square inch');
      expect(atmospheresTechnical.name, 'atmospheres (tech)');
      expect(baryes.name, 'baryes');
      expect(cmMercury0.name, 'centimeters of mercury (0 deg C)');
      expect(cmWater4.name, 'centimeters of water (4 deg C)');
      expect(ftWater39.name, 'feet of water (39.2 deg F)');
      expect(inMercury32.name, 'inches of mercury (32 deg F)');
      expect(inWater39.name, 'inches of water (39.2 deg F)');
      expect(referenceSoundAir.name, 'reference sound pressure (air)');
      expect(referenceSoundWater.name, 'reference sound pressure (water)');
      expect(newtonsPerSquareMeter, pascals);
      expect(millibars.name, 'hectopascals');
    });

    test('resistance_ext', () {
      expect(ohms.name, 'ohms');
      expect(characteristicImpedanceOfVacuum.valueSI.toDouble(),
          closeTo(376.7303, 1e-3));
      expect(Z0, characteristicImpedanceOfVacuum);
      expect(vonKlitzingConstant.valueSI.toDouble(), closeTo(25812.807, 1e-2));
    });

    test('scalar_ext', () {
      expect(percent.name, 'percent');
      expect(thousandths.name, 'thousandths');
      expect(hundred.name, 'hundred');
      expect(dozen.name, 'dozen');
      expect(one.name, '1');
      expect(trillionthsUS.name, 'trillionths');
      expect(billionthsUS.name, 'billionths');
      expect(millionths.name, 'millionths');
      expect(hundredths.name, 'hundredths');
      expect(tenths.name, 'tenths');
      expect(pair.name, 'pairs');
      expect(halfDozen.name, 'half dozen');
      expect(bakersDozen.name, "baker's dozen");
      expect(score.name, 'score');
      expect(gross.name, 'gross');
      expect(thousand.name, 'thousand');
      expect(greatGross.name, 'great gross');
      expect(myriad.name, 'myriad');
      expect(million.name, 'million');
      expect(billionUS.name, 'billion');
      expect(trillionUS.name, 'trillion');
      expect(quadrillionUS.name, 'quadrillion');
      expect(quintillionUS.name, 'quintillion');
      expect(sextillionUS.name, 'sextillion');
      expect(septillionUS.name, 'septillion');
      expect(octillionUS.name, 'octillion');
      expect(nonillionUS.name, 'nonillion');
      expect(decillionUS.name, 'decillion');
      expect(duotrigintillion.name, 'duotrigintillion');
      expect(googols.name, 'googols');
      expect(billionEur.name, 'billion (eur)');
      expect(trillionEur.name, 'trillion (eur)');
      expect(quadrillionEur.name, 'quadrillion (eur)');
      expect(quintillionEur.name, 'quintillion (eur)');
      expect(sextillionEur.name, 'sextillion (eur)');
      expect(septillionEur.name, 'septillion (eur)');
      expect(octillionEur.name, 'octillion (eur)');
      expect(nonillionEur.name, 'nonillion (eur)');
      expect(decillionEur.name, 'decillion (eur)');
      expect(scalarZero.valueSI.toDouble(), 0.0);
      expect(naught, scalarZero);
      expect(zilch, scalarZero);
      expect(fineStructureConstant.valueSI.toDouble(),
          closeTo(0.0072973525643, 1e-10));
      expect(protonGFactor.valueSI.toDouble(), closeTo(5.5856946893, 1e-9));
      expect(electronGFactor.valueSI.toDouble(),
          closeTo(-2.00231930436092, 1e-12));
      expect(neutronGFactor.valueSI.toDouble(), closeTo(-3.82608552, 1e-7));
      expect(muonGFactor.valueSI.toDouble(), closeTo(-2.00233184123, 1e-9));
      expect(googol.valueSI.toDouble(), 1.0e100);
      expect(sackurTetrode100kPa.valueSI.toDouble(),
          closeTo(-1.15170753496, 1e-9));
      expect(sackurTetrodeStdAtm.valueSI.toDouble(),
          closeTo(-1.16487052149, 1e-9));
      expect(weakMixingAngle.valueSI.toDouble(), closeTo(0.22305, 1e-5));
    });

    test('solid_angle_ext', () {
      expect(steradians.name, 'steradians');
      expect(millisteradians.name, 'millisteradians');
      expect(spats.name, 'spats');
      expect(spheres.name, 'spheres');
      expect(hemispheres.name, 'hemispheres');
      expect(octants.name, 'octants');
      expect(sphericalRightTriangles, octants);
      expect(squareDegrees.name, 'degrees squared');
      expect(squareArcMinutes.name, 'arc minutes squared');
      expect(squareArcSeconds.name, 'arc seconds squared');
    });

    test('specific_energy_ext', () {
      expect(joulesPerKilogram.name, 'joules per kilogram');
      expect(squareMetersPerSquareSecond.name,
          'meters squared per second squared');
      expect(speedOfLightSquared.name, '(speed of light) squared');
    });

    test('spectral_irradiance_ext', () {
      expect(janskys.name, 'janskys');
      expect(fluxUnits.name, 'janskys');
    });

    test('speed_ext', () {
      expect(knots.name, 'knots');
      expect(milesPerHour.name, 'miles per hour');
      expect(metersPerSecond.name, 'meters per second');
      expect(speedOfLightUnits.name, 'speed of light');
      expect(feetPerHour.name, 'feet per hour');
      expect(feetPerMinute.name, 'feet per minute');
      expect(feetPerSecond.name, 'feet per second');
      expect(inchesPerSecond.name, 'inches per second');
      expect(kilometersPerHour.name, 'kilometers per hour');
      expect(milesPerMinute.name, 'miles per minute');
      expect(milesPerSecond.name, 'miles per second');
      expect(speedOfLightVacuum.valueSI.toDouble(), 2.99792458e8);
      expect(speedOfSoundAir0C.valueSI.toDouble(), 331.6);
    });

    test('temperature_ext', () {
      expect(kelvins.name, 'kelvins');
      expect(degK, kelvins);
      expect(degreesCelsius.name, 'degrees Celsius');
      expect(fiveNinths.toDouble(), 5.0 / 9.0);
      expect(Rankine.name, 'degrees Rankine');
      expect(degreesFahrenheit, Fahrenheit);
      expect(degF, Fahrenheit);
      expect(degreesRankine, Rankine);
      expect(degR, Rankine);
      expect(planckTemperature.valueSI.toDouble(), closeTo(1.416784e32, 1e27));
    });

    test('time_ext', () {
      expect(seconds.name, 'seconds');
      expect(minutes.name, 'minutes');
      expect(hours.name, 'hours');
      expect(days.name, 'days');
      expect(yearsCalendar.name, 'years');
      expect(yottaseconds.name, 'yottaseconds');
      expect(zettaseconds.name, 'zettaseconds');
      expect(exaseconds.name, 'exaseconds');
      expect(petaseconds.name, 'petaseconds');
      expect(teraseconds.name, 'teraseconds');
      expect(gigaseconds.name, 'gigaseconds');
      expect(megaseconds.name, 'megaseconds');
      expect(kiloseconds.name, 'kiloseconds');
      expect(hectoseconds.name, 'hectoseconds');
      expect(dekaseconds.name, 'dekaseconds');
      expect(deciseconds.name, 'deciseconds');
      expect(centiseconds.name, 'centiseconds');
      expect(milliseconds.name, 'milliseconds');
      expect(microseconds.name, 'microseconds');
      expect(nanoseconds.name, 'nanoseconds');
      expect(picoseconds.name, 'picoseconds');
      expect(femtoseconds.name, 'femtoseconds');
      expect(attoseconds.name, 'attoseconds');
      expect(zeptoseconds.name, 'zeptoseconds');
      expect(yoctoseconds.name, 'yoctoseconds');
      expect(daysMeanSolar.name, 'days');
      expect(hoursMeanSolar.name, 'hours');
      expect(minutesMeanSolar.name, 'minutes');
      expect(daysSidereal.name, 'days (sidereal)');
      expect(hoursSidereal.name, 'hours (sidereal)');
      expect(minutesSidereal.name, 'minutes (sidereal)');
      expect(secondsSidereal.name, 'seconds (sidereal)');
      expect(yearsSidereal.name, 'years (sidereal)');
      expect(yearsTropical.name, 'years (tropical)');
      expect(yearsJulian.name, 'years (Julian)');
      expect(aeons.name, 'aeons');
      expect(eons, aeons);
      expect(planckTime.valueSI.toDouble(), closeTo(5.391247e-44, 1e-50));
    });

    test('time_instant_ext', () {
      expect(J2000.valueSI.toDouble(), 2451545.0);
      expect(GPST.name, 'GPS Satellite Time');
      expect(TAI.name, 'International Atomic Time');
    });

    test('volume_ext', () {
      expect(liters.name, 'liters');
      expect(gallonsUSLiquid.name, 'gallons (U.S. liquid)');
      expect(quartsLiquid.name, 'quarts (U.S. liquid)');
      expect(pintsLiquid.name, 'pints (U.S. liquid)');
      expect(cups.name, 'cups');
      expect(cubicMeters.name, 'cubic meters');
      expect(acreFoot.name, 'acre foot');
      expect(barrelsPetroleum.name, 'barrels (petroleum, 42 gal)');
      expect(barrels.name, 'barrels (other liquids, 31.5 gal)');
      expect(boardFeet.name, 'board feet');
      expect(bushels.name, 'bushels (U.S.)');
      expect(cords.name, 'cords');
      expect(drams.name, 'drams (U.S. fluid)');
      expect(fluidOunces.name, 'fluid ounces');
      expect(fluidOuncesUK.name, 'fluid ounces (U.K.)');
      expect(cubicFeet.name, 'cubic feet');
      expect(gallonsUKLiquid.name, 'gallons (U.K. liquid)');
      expect(gallonsUSDry.name, 'gallons (U.S. dry)');
      expect(gillsUK.name, 'gills (U.K.)');
      expect(gillsUS.name, 'gills (U.S.)');
      expect(hogsheads.name, 'hogsheads');
      expect(cubicInches.name, 'cubic inches');
      expect(cubicParsecs.name, 'cubic parsecs');
      expect(pecks.name, 'pecks');
      expect(pintsDry.name, 'pints (U.S. dry)');
      expect(quartsDry.name, 'quarts (U.S. dry)');
      expect(tablespoons.name, 'tablespoons');
      expect(teaspoons.name, 'teaspoons');
      expect(registryTons.name, 'registry tons');
      expect(cubicYards.name, 'cubic yards');
      expect(cubicCentimeters.name, 'cubic centimeters');
      expect(steres, cubicMeters);
    });

    test('volume_flow_rate_ext', () {
      expect(cumecs.name, 'cubic meters per second');
      expect(cubicMetersPerSecond.name, 'cubic meters per second');
      expect(musecs, cubicMetersPerSecond);
      expect(litersPerSecond.name, 'liters per second');
      expect(lusecs, litersPerSecond);
      expect(minersInches.name, "miner's inch");
    });
  });
}
