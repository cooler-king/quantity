part of quantity_range;

/// An immutable angle range with a start angle, an end angle and an
/// implicit direction.
///
class AngleRange extends QuantityRange<Angle> {
  /// Contructs an angle range.
  AngleRange(Angle startAngle, Angle endAngle) : super(startAngle, endAngle);

  /// Constructs an angle range in radians.
  AngleRange.radians(double startAngleRad, double endAngleRad)
      : super(new Angle(rad: startAngleRad), new Angle(rad: endAngleRad));

  /// Constructs an angle range in degrees.
  AngleRange.degrees(double startAngleDeg, double endAngleDeg)
      : super(new Angle(deg: startAngleDeg), new Angle(deg: endAngleDeg));

  Angle get startAngle => this.q1;

  Angle get endAngle => this.q2;

  /// True if the range represents a clockwise direction.
  bool get isClockwise => q2 > q1;

  /// True if the range represents a counterclockwise direction.
  ///
  /// Synonymous with anticlockwise.
  ///
  bool get isCounterclockwise => q1 > q2;

  /// True if the range represents a anticlockwise direction.
  ///
  /// Synonymous with counterclockwise.
  ///
  bool get isAnticlockwise => isCounterclockwise;

  /// A range is considered tiny if its width is less than or equal to
  /// [epsilon], which is 0.001 degree by default.
  ///
  bool isTiny({Angle epsilon}) {
    if (epsilon == null) epsilon = new Angle(deg: 0.001);
    if (span <= epsilon) return true;
    return false;
  }

  /// The change in value from start to end, which may be negative.
  @override
  Angle get delta => new Angle(rad: q2.mks - q1.mks);

  /// The number of full revolutions encompassed by the range.
  ///
  /// Counterclockwise revolutions will be returned as a negative number.
  ///
  int get revolutions => (q2.mks - q1.mks).toDouble() ~/ twoPi;

  /// Returns true if this angle range overlaps [range2]'s angle range
  /// (exclusive of the endpoints).
  ///
  /// The ranges are projected onto the 0-360 degree range.
  ///
  bool overlaps360(AngleRange range2) {
    if (this.overlaps(range2)) return true;

    // No direct overlap... check if the projections overlap
    List<AngleRange> list1 = [];
    Angle min360 = minValue.angle360;
    Angle max360 = maxValue.angle360;
    if (max360 < min360) {
      max360 += new Angle(rad: twoPi);
      list1.add(new AngleRange(min360, new Angle(rad: twoPi)));
      list1.add(new AngleRange(new Angle(rad: 0), max360));
    } else {
      list1.add(new AngleRange(min360, max360));
    }

    List<AngleRange> list2 = [];
    Angle min360_2 = range2.minValue.angle360;
    Angle max360_2 = range2.maxValue.angle360;
    if (max360_2 < min360_2) {
      max360_2 += new Angle(rad: twoPi);
      list2.add(new AngleRange(min360_2, new Angle(rad: twoPi)));
      list2.add(new AngleRange(new Angle(rad: 0), max360_2));
    } else {
      list2.add(new AngleRange(min360_2, max360_2));
    }

    for (AngleRange range1 in list1) {
      for (AngleRange range2 in list2) {
        if (range1.overlaps(range2)) return true;
      }
    }

    return false;
  }

  /// Derive a new AngleRange from this one by applying one or more
  /// transforms.
  ///
  /// Rotation:  move the range by [rotate] degrees
  /// Scale: grow or shrink the range about its center by a [scale] factor
  /// Reverse:  flip the direction by exchanging the start and end angles
  ///
  AngleRange deriveRange({double rotate, double scale, bool reverse}) {
    Angle start = q1;
    Angle end = q2;
    if (reverse != null && reverse) {
      Angle temp = q1;
      start = end;
      end = temp;
    }
    if (scale != null) {
      Angle delta = (end - start) * (scale / 2.0);
      start = centerValue - delta;
      end = centerValue + delta;
    }
    if (rotate != null) {
      Angle newCenter = centerValue + rotate;
      Angle delta = (end - start) / 2.0;
      start = newCenter - delta;
      end = newCenter + delta;
    }

    return new AngleRange(start, end);
  }

  /// Returns the equivalent range(s) projected onto the 0-360 degree circle.
  ///
  /// Note that there may be either one or two ranges in the returned list,
  /// depending on whether or not the projection of this range crosses
  /// 0 degrees.
  ///
  List<AngleRange> get ranges360 {
    if (revolutions.abs() > 0) return [new AngleRange(angle0, angle360)];

    List<AngleRange> rangeList = [];

    if (startAngle < endAngle) {
      // clockwise
      Angle start360 = startAngle.angle360;
      Angle delta = start360 - startAngle;
      Angle endPlusDelta = endAngle + delta;
      if (endPlusDelta.valueSI > twoPi) {
        rangeList.add(new AngleRange(angle0, endPlusDelta.angle360));
        rangeList.add(new AngleRange(start360, angle360));
      } else {
        rangeList.add(new AngleRange(start360, endPlusDelta));
      }
    } else {
      // counterclockwise
      Angle end360 = endAngle.angle360;
      Angle delta = end360 - endAngle;
      Angle startPlusDelta = startAngle + delta;
      if (startPlusDelta.valueSI > twoPi) {
        rangeList.add(new AngleRange(angle360, end360));
        rangeList.add(new AngleRange(startPlusDelta - angle360, angle0));
      } else {
        rangeList.add(new AngleRange(end360, startPlusDelta));
      }
    }

    return rangeList;
  }

  /// True if this range, projected onto the 0-360 degree circle
  /// contains [angle] when it also is projected onto the 0-360 circle.
  ///
  /// The test is [inclusive] of the endpoints by default and has a
  /// rounding tolerance, [epsilon] of 1.0e-10.
  ///
  /// This is a more lenient test than [contains()] in superclass
  /// [QuantityRange].
  ///
  bool contains360(Angle angle, [bool inclusive = true, double epsilon = 1.0e-10]) {
    if (contains(angle, inclusive, epsilon) || revolutions.abs() > 0) return true;
    Angle ang360 = angle.angle360;
    for (var range in this.ranges360) {
      if (range.contains(ang360, inclusive, epsilon)) return true;
    }
    return false;
  }

  /// Find the angle within this range closest to the specified
  /// [angle].
  ///
  /// If [strict] is true, then only the actual range is used
  /// regardless of whether it falls within the nominal 0-360 degree
  /// range.  If [strict] is false then the closest angle as if the
  /// ranges were projected onto a single circle is returned.
  ///
  Angle angleClosestTo(Angle angle, [bool strict = false]) {
    var ang = angle ?? angle0;

    // Contains?
    if (!strict && contains360(ang)) {
      return ang;
    } else if (contains(ang)) {
      return ang;
    }

    // Not contained... return closest endpoint
    if (!strict) {
      Angle angRev0 = ang.angle360;
      Angle closest;
      num minDeltaRad = angle360.mks.toDouble();
      List<AngleRange> ranges = this.ranges360;
      num deltaStartRad = 0;
      num deltaEndRad = 0;
      for (var range in ranges) {
        deltaStartRad = (range.startAngle.mks.toDouble() - angRev0.mks.toDouble()).abs();
        deltaEndRad = (range.endAngle.mks.toDouble() - angRev0.mks.toDouble()).abs();
        if (deltaStartRad < minDeltaRad) {
          closest = startAngle;
          minDeltaRad = deltaStartRad;
        }
        if (deltaEndRad < minDeltaRad) {
          closest = endAngle;
          minDeltaRad = deltaEndRad;
        }
      }
      return closest;
    } else {
      num deltaStartRad = (startAngle.mks.toDouble() - ang.mks.toDouble()).abs();
      num deltaEndRad = (endAngle.mks.toDouble() - ang.mks.toDouble()).abs();
      return (deltaStartRad <= deltaEndRad) ? new Angle(rad: deltaStartRad) : new Angle(rad: deltaEndRad);
    }
  }
}
