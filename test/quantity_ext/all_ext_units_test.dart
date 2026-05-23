import 'package:test/test.dart';
import 'package:quantity/quantity.dart';
import 'package:quantity/quantity_ext.dart';

void main() {
  group('Extension Units and Constants', () {
    test('acceleration_ext', () {
      expect(standardAccelerationOfGravity.valueSI.toDouble(), 9.80665);
      expect(gees.name, 'gees');
    });

    test('amount_of_substance_ext', () {
      expect(moles.name, 'moles');
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
    });

    test('angular_speed_ext', () {
      expect(revolutionsPerMinute.name, 'revolutions per minute');
      expect(rpm.name, 'revolutions per minute');
    });

    test('area_ext', () {
      expect(ares.name, 'ares');
      expect(hectares.name, 'hectares');
      expect(acres.name, 'acres');
      expect(barns.name, 'barns');
    });

    test('capacitance_ext', () {
      expect(farads.name, 'farads');
    });

    test('charge_ext', () {
      expect(ampereHours.name, 'ampere hours');
      expect(abcoulombs.name, 'dekacoulombs');
      expect(statcoulombs.name, 'statcoulombs');
    });

    test('conductance_ext', () {
      expect(mho.name, 'siemens');
    });

    test('current_ext', () {
      expect(abamperes.name, 'abamperes');
      expect(statamperes.name, 'statamperes');
    });

    test('electric_potential_difference_ext', () {
      expect(abvolts.name, 'abvolts');
      expect(statvolts.name, 'statvolts');
    });

    test('energy_ext', () {
      expect(joules.name, 'joules');
      expect(caloriesThermo.name, 'calories (thermochemical)');
      expect(therms.name, 'therms');
      expect(electronVolts.name, 'electronvolts');
      expect(ergs.name, 'ergs');
    });

    test('energy_flux_ext', () {
      expect(wattsPerSquareMeter.name, 'watts per square meter');
    });

    test('entropy_ext', () {
      expect(clausius.name, 'Clausius');
    });

    test('force_ext', () {
      expect(newtons.name, 'newtons');
      expect(dynes.name, 'dynes');
      expect(poundsForceAvoirdupois.name, 'pounds force (avoirdupois)');
      expect(kilogramsForce.name, 'kilograms force');
    });

    test('illuminance_ext', () {
      expect(lux.name, 'lux');
    });

    test('inductance_ext', () {
      expect(henries.name, 'henries');
    });

    test('information_ext', () {
      expect(bits.name, 'bits');
      expect(bytes.name, 'bytes');
      expect(kilobytes.name, 'kilobytes');
      expect(megabytes.name, 'megabytes');
    });

    test('kinematic_viscosity_ext', () {
      expect(stokes.name, 'stokes');
    });

    test('length_ext', () {
      expect(feet.name, 'feet');
      expect(inches.name, 'inches');
      expect(miles.name, 'miles');
      expect(yards.name, 'yards');
      expect(meters.name, 'meters');
    });

    test('luminous_intensity_ext', () {
      expect(candelas.name, 'candelas');
    });

    test('magnetic_flux_density_ext', () {
      expect(teslas.name, 'teslas');
      expect(gauss.name, 'gauss');
    });

    test('magnetic_flux_ext', () {
      expect(webers.name, 'webers');
      expect(maxwells.name, 'maxwells');
    });

    test('mass_density_ext', () {
      expect(gramsPerCubicCentimeter.name, 'grams per cubic centimeter');
    });

    test('mass_ext', () {
      expect(grams.name, 'grams');
      expect(poundsAvoirdupois.name, 'pounds (avoirdupois)');
      expect(ouncesAvoirdupois.name, 'ounces (avoirdupois)');
    });

    test('permeability_ext', () {
      expect(vacuumMagneticPermeability.valueSI.toDouble(), closeTo(1.256637e-6, 1e-11));
    });

    test('permittivity_ext', () {
      expect(vacuumElectricPermittivity.valueSI.toDouble(), closeTo(8.8541878e-12, 1e-18));
    });

    test('power_ext', () {
      expect(horsepower550.name, 'horsepower (550 ft lbs/s)');
      expect(watts.name, 'watts');
    });

    test('pressure_ext', () {
      expect(atmospheres.name, 'atmospheres (std)');
      expect(bars.name, 'bars');
      expect(pascals.name, 'pascals');
      expect(torrs.name, 'torrs');
      expect(psi.name, 'pounds force (avoirdupois) per square inch');
    });

    test('resistance_ext', () {
      expect(ohms.name, 'ohms');
    });

    test('scalar_ext', () {
      expect(percent.name, 'percent');
      expect(thousandths.name, 'thousandths');
      expect(hundred.name, 'hundred');
      expect(dozen.name, 'dozen');
    });

    test('solid_angle_ext', () {
      expect(steradians.name, 'steradians');
    });

    test('specific_energy_ext', () {
      expect(joulesPerKilogram.name, 'joules per kilogram');
    });

    test('spectral_irradiance_ext', () {
      expect(janskys.name, 'janskys');
      expect(fluxUnits.name, 'janskys');
    });

    test('speed_ext', () {
      expect(knots.name, 'knots');
      expect(milesPerHour.name, 'miles per hour');
      expect(metersPerSecond.name, 'meters per second');
    });

    test('temperature_ext', () {
      expect(Fahrenheit.name, 'degrees Fahrenheit');
    });

    test('time_ext', () {
      expect(seconds.name, 'seconds');
      expect(minutes.name, 'minutes');
      expect(hours.name, 'hours');
      expect(days.name, 'days');
      expect(yearsCalendar.name, 'years');
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
    });

    test('volume_flow_rate_ext', () {
      expect(cumecs.name, 'cubic meters per second');
    });
  });
}
