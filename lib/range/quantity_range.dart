part of quantity_range;

//TODO k value?
QuantityRange uncertaintyRangeForQuantity(Quantity q) {
  Quantity std = q.standardUncertainty;
  return new QuantityRange(q - std, q + std);
}

class QuantityRange<Q extends Quantity> {
  Q q1;
  Q q2;

  // Derived values (calculated on first use)
  Q _minValue;
  Q _maxValue;
  Q _centerValue;
  Q _span;

  QuantityRange(this.q1, this.q2) {
    if (q1 is! Quantity || q2 is! Quantity) throw new ArgumentError(
        "QuantityRange endpoints must be Quantity objects");
  }

  // The minimum value in this range
  Q get minValue {
    if (_minValue == null) _minValue = (q1.valueSI <= q2.valueSI) ? q1 : q2;
    return _minValue;
  }

  // The maximum value in this range, in degrees
  Q get maxValue {
    if (_maxValue == null) _maxValue = (q1.valueSI > q2.valueSI) ? q1 : q2;
    return _maxValue;
  }

  // The value at the center of the range
  Q get centerValue {
    if (_centerValue == null) _centerValue = (q1 + q2) / 2.0;
    return _centerValue;
  }

  /// The magnitude of the range.
  ///
  /// This value is always positive (or zero).  Get [delta] to get the
  /// signed version of the range.
  ///
  Q get span {
    if (_span == null) _span = (q2 - q1).abs();
    return _span;
  }

  /// The change in value from start to end, which may be negative.
  Q get delta => q2 - q1;

  /// Returns true if this range overlaps [range2]
  /// (exclusive of the endpoints).
  ///
  bool overlaps(QuantityRange<Q> range2) {
    if (range2.minValue <= minValue) {
      return range2.maxValue > minValue;
    } else {
      return range2.minValue < maxValue;
    }
  }

  /// True if this range contains [quantity], with a tolerance, [epsilon], of
  /// rounding errors of 1.0e-10 and [inclusive] of the endpoints by default.
  ///
  bool contains(Q quantity, [bool inclusive = true, double epsilon = 1.0e-10]) {
    if (inclusive && (quantity == q1 || quantity == q2)) return true;
    if (epsilon == 0.0) {
      if (q1 < quantity && q2 > quantity) return true;
      if (q1 > quantity && q2 < quantity) return true;
    } else {
      if (inclusive) {
        if (q1.mks - epsilon < quantity.mks &&
            q2.mks + epsilon > quantity.mks) return true;
        if (q1.mks + epsilon > quantity.mks &&
            q2.mks - epsilon < quantity.mks) return true;
      } else {
        if (q1.mks - epsilon <= quantity.mks &&
            q2.mks + epsilon >= quantity.mks) return true;
        if (q1.mks + epsilon >= quantity.mks &&
            q2.mks - epsilon <= quantity.mks) return true;
      }
    }
    return false;
  }

  /// True only if this range completely encompasses range2.
  bool encompasses(QuantityRange<Q> range2) =>
      minValue <= range2.minValue && maxValue >= range2.maxValue;

  @override
  String toString() {
    return "${q1} to ${q2}";
  }
}
