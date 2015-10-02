part of quantity_ext;

ResistanceUnits ohms = Resistance.ohms;

// Constants
const Resistance characteristicImpedanceOfVacuum = const Resistance.constant(const Double.constant(376.730313461));

const Resistance Z0 = characteristicImpedanceOfVacuum;

const Resistance vonKlitzingConstant =
    const Resistance.constant(const Double.constant(25812.8074555), uncert: 2.2856870606466607e-10);
