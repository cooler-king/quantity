part of quantity_ext;

/// The standard SI unit for angular momentum.
final AngularMomentumUnits jouleSecond = AngularMomentum.jouleSecond;

/// The Planck constant as units.
final AngularMomentumUnits planckUnits = new AngularMomentumUnits('h', '\u210E', null, 'h', 6.626070040e-34, false);

/// The Planck constant divided by 2 PI (a.k.a., 'h-bar') as units.
final AngularMomentumUnits hBarUnits =
    new AngularMomentumUnits('h-bar', '\u210F', null, 'h-bar', 1.054571800e-34, false);

// Constants

/// The Planck constant.
const AngularMomentum planckConstant =
    const AngularMomentum.constant(const Double.constant(6.626070040e-34), uncert: 1.2224440658040493e-8);

/// The Planck constant divided by 2 PI (a.k.a., 'h-bar')
const AngularMomentum hBar =
    const AngularMomentum.constant(const Double.constant(1.054571800e-34), uncert: 1.2327278237479894e-8);
