part of quantity_ext;

ElectricPotentialDifferenceUnits volts = ElectricPotentialDifference.volts;

ElectricPotentialDifferenceUnits abvolts =
    new ElectricPotentialDifferenceUnits("abvolts", null, null, null, 1.0e-8, true);

ElectricPotentialDifferenceUnits statvolts =
    new ElectricPotentialDifferenceUnits("statvolts", null, null, null, 2.9979e2, false);

// convenience units
ElectricPotentialDifferenceUnits emuPotential = abvolts;
ElectricPotentialDifferenceUnits esuPotential = statvolts;
