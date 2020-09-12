import 'dart:math';
import '../src/ext/angle_ext.dart' show angle0, angle360, tau;
import '../src/si/types/angle.dart';
import 'quantity_range.dart';

/// An immutable angle range with a start angle, an end angle and an
/// implicit direction.
class AngleRange extends QuantityRange<Angle> {
  /// Constructs an angle range.
  AngleRange(Angle startAngle, Angle endAngle) : super(startAngle, endAngle);

  /// Constructs an angle range in radians.
  AngleRange.radians(double startAngleRad, double endAngleRad)
      : super(new Angle(rad: startAngleRad), new Angle(rad: endAngleRad));

  /// Constructs an angle range in degrees.
  AngleRange.degrees(double startAngleDeg, double endAngleDeg)
      : super(new Angle(deg: startAngleDeg), new Angle(deg: endAngleDeg));

  /// The starting angle in the range.
  Angle get startAngle => q1;

  /// The ending angle in the range.
  Angle get endAngle => q2;

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
  bool isTiny({Angle epsilon}) {
    epsilon ??= new Angle(deg: 0.001);
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
    if (overlaps(range2)) return true;

    // No direct overlap... check if the projections overlap
    final List<AngleRange> list1 = <AngleRange>[];
    final Angle min360 = minValue.angle360;
    Angle max360 = maxValue.angle360;
    if (max360 < min360) {
      max360 = max360 + new Angle(rad: twoPi) as Angle;
      list1..add(new AngleRange(min360, new Angle(rad: twoPi)))..add(new AngleRange(new Angle(rad: 0), max360));
    } else {
      list1.add(new AngleRange(min360, max360));
    }

    final List<AngleRange> list2 = <AngleRange>[];
    final Angle min360two = range2.minValue.angle360;
    Angle max360two = range2.maxValue.angle360;
    if (max360two < min360two) {
      max360two = max360two + new Angle(rad: twoPi) as Angle;
      list2..add(new AngleRange(min360two, new Angle(rad: twoPi)))..add(new AngleRange(new Angle(rad: 0), max360two));
    } else {
      list2.add(new AngleRange(min360two, max360two));
    }

    for (final AngleRange range1 in list1) {
      for (final AngleRange range2 in list2) {
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
      final Angle temp = q1;
      start = end;
      end = temp;
    }
    if (scale != null) {
      final Angle delta = (end - start) * (scale / 2.0) as Angle;
      start = centerValue - delta as Angle;
      end = centerValue + delta as Angle;
    }
    if (rotate != null) {
      final Angle newCenter = centerValue + rotate as Angle;
      final Angle delta = (end - start) / 2.0 as Angle;
      start = newCenter - delta as Angle;
      end = newCenter + delta as Angle;
    }

    return new AngleRange(start, end);
  }

  /// Returns the equivalent range(s) projected onto the 0-360 degree circle.
  ///
  /// Note that there may be either one or two ranges in the returned list,
  /// depending on whether or not the projection of this range crosses
  /// 0 degrees.
  List<AngleRange> get ranges360 {
    if (revolutions.abs() > 0) return <AngleRange>[new AngleRange(angle0, angle360)];

    final List<AngleRange> rangeList = <AngleRange>[];

    if (startAngle < endAngle) {
      // clockwise
      final Angle start360 = startAngle.angle360;
      final Angle delta = start360 - startAngle as Angle;
      final Angle endPlusDelta = endAngle + delta as Angle;
      if (endPlusDelta.valueSI > twoPi) {
        rangeList..add(new AngleRange(angle0, endPlusDelta.angle360))..add(new AngleRange(start360, angle360));
      } else {
        rangeList.add(new AngleRange(start360, endPlusDelta));
      }
    } else {
      // counterclockwise
      final Angle end360 = endAngle.angle360;
      final Angle delta = end360 - endAngle as Angle;
      final Angle startPlusDelta = startAngle + delta as Angle;
      if (startPlusDelta.valueSI > twoPi) {
        rangeList
          ..add(new AngleRange(angle360, end360))
          ..add(new AngleRange(startPlusDelta - angle360 as Angle, angle0));
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
    final Angle ang360 = angle.angle360;
    for (final AngleRange range in ranges360) {
      if (range.contains(ang360, inclusive, epsilon)) return true;
    }
    return false;
  }

  /// Find the angle within this range closest to the specified [angle].
  ///
  /// If [strict] is true, then only the actual range is used
  /// regardless of whether it falls within the nominal 0-360 degree
  /// range.  If [strict] is false then the closest angle as if the
  /// ranges were projected onto a single circle is returned.
  Angle angleClosestTo(Angle angle, [bool strict = false]) {
    final Angle ang = angle ?? angle0;

    // Contains?
    if (!strict && contains360(ang)) {
      return ang;
    } else if (contains(ang)) {
      return ang;
    }

    // Not contained... return closest endpoint.
    if (!strict) {
      final Angle angRev0 = ang.angle360;
      Angle closest;
      num minDeltaRad = angle360.mks.toDouble();
      final List<AngleRange> ranges = ranges360;
      num deltaStartRad;
      num deltaStartRadRev;
      num deltaEndRad;
      num deltaEndRadRev;
      for (final AngleRange range in ranges) {
        deltaStartRad = (range.startAngle.mks.toDouble() - angRev0.mks.toDouble()).abs();
        deltaStartRadRev = tau + range.startAngle.mks.toDouble() - angRev0.mks.toDouble();
        deltaStartRad = min(deltaStartRad, deltaStartRadRev);
        deltaEndRad = (range.endAngle.mks.toDouble() - angRev0.mks.toDouble()).abs();
        deltaEndRadRev = tau + range.endAngle.mks.toDouble() - angRev0.mks.toDouble();
        deltaEndRad = min(deltaEndRad, deltaEndRadRev);
        if (deltaStartRad < minDeltaRad) {
          closest = range.startAngle;
          minDeltaRad = deltaStartRad;
        }
        if (deltaEndRad < minDeltaRad) {
          closest = range.endAngle;
          minDeltaRad = deltaEndRad;
        }
      }
      return closest;
    } else {
      final num deltaStartRad = (startAngle.mks.toDouble() - ang.mks.toDouble()).abs();
      final num deltaEndRad = (endAngle.mks.toDouble() - ang.mks.toDouble()).abs();
      return (deltaStartRad <= deltaEndRad) ? new Angle(rad: deltaStartRad) : new Angle(rad: deltaEndRad);
    }
  }
}
