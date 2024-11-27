import 'package:test/test.dart';
import 'package:quantity/quantity.dart';

void main() {
  group('ThermalConductivity', () {
    test('constructors', () {
      var q = ThermalConductivity();
      expect(q.valueSI, Double.zero);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ThermalConductivity.thermalConductivityDimensions);
      expect(q.preferredUnits, ThermalConductivity.wattsPerMeterKelvin);
      expect(q.relativeUncertainty, 0);

      q = ThermalConductivity(wattsPerMeterKelvin: 42, uncert: 0.001);
      expect(q.valueSI.toDouble(), 42);
      expect(q.valueSI is Integer, true);
      expect(q.dimensions, ThermalConductivity.thermalConductivityDimensions);
      expect(q.preferredUnits, ThermalConductivity.wattsPerMeterKelvin);
      expect(q.relativeUncertainty, 0.001);
    });

    test('units', () {
      var u = ThermalConductivityUnits.powerPerLengthTemperature(
          Power.watts, Length.meters, TemperatureInterval.kelvins);
      expect(u.name, 'watts per meter kelvin');
      expect(u.singular, 'watt per meter kelvin');
      expect(u.convToMKS.toDouble(), 1.0);
      expect(u.abbrev1, 'W / m K');
      expect(u.abbrev2, 'W m\u{207b}\u{00b9} K\u{207b}\u{00b9}');

      var u2 = ThermalConductivityUnits.powerPerLengthTemperature(
          Power.kilowatts,
          Length.millimeters,
          TemperatureInterval.degreesCelsius);
      expect(u2.name, 'kilowatts per millimeter degree Celsius');
      expect(u2.singular, 'kilowatt per millimeter degree Celsius');
      expect(u2.convToMKS.toDouble(), 1.0e6);
      expect(u2.abbrev1, 'kW / mm deg C');
      expect(u2.abbrev2, 'kW mm\u{207b}\u{00b9} deg C\u{207b}\u{00b9}');

      var q1 = ThermalConductivity(wattsPerMeterKelvin: 1.0);
      var q2 = ThermalConductivity.inUnits(1.0e-6, u2);
      expect(q1 == q2, true);
      expect(q1.toString(), '1 W m\u{207b}\u{00b9} K\u{207b}\u{00b9}');
      expect(q2.toString(),
          '0.000 001 kW mm\u{207b}\u{00b9} deg C\u{207b}\u{00b9}');
    });
  });
}
