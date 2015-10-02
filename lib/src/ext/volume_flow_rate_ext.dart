part of quantity_ext;

/// the standard SI unit
VolumeFlowRateUnits cubicMetersPerSecond = VolumeFlowRate.cubicMetersPerSecond;

/// shorthand synonym for standard SI unit
VolumeFlowRateUnits cumecs = cubicMetersPerSecond;

/// shorthand synonym for standard SI unit
VolumeFlowRateUnits musecs = cubicMetersPerSecond;

/// 0.001 cubic meter per second
VolumeFlowRateUnits litersPerSecond = new VolumeFlowRateUnits.volumeTime(liters, seconds);

/// shorthand synonym for liters per second
VolumeFlowRateUnits lusecs = litersPerSecond;

VolumeFlowRateUnits minersInches =
    new VolumeFlowRateUnits("miner's inch", null, null, "miner's inch", 7.07921e-4, false);
