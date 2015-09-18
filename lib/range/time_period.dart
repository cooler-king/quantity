part of quantity_range;

class TimePeriod extends QuantityRange<TimeInstant> {
  /// Contructs a time period.
  TimePeriod(TimeInstant startTime, TimeInstant endTime) : super(startTime, endTime);
}

/// Constructs a [FiscalYear] time period.
///
/// Defaults to the US Government fiscal year which runs from October of the previous calendar
/// year through September.  This can be changed by setting the optional [monthOffset] parameter.
///
/// If the [year] provided is only 2 digits it will be converted to four digits, assuming anything
/// 70 or over means 19xx and anything under 70 mean 20xx.
///
class FiscalYear extends TimePeriod {
  FiscalYear({int year, int monthOffset: -3})
      : super(new TimeInstant.dateTime(new DateTime(fy4(year), 1 + monthOffset)),
            new TimeInstant.dateTime(new DateTime(fy4(year), 13 + monthOffset)));
}

class CalendarYear extends TimePeriod {
  CalendarYear(int year)
      : super(new TimeInstant.dateTime(new DateTime(year, 1)), new TimeInstant.dateTime(new DateTime(year + 1)));
}

/// Returns a four digit year from [year] which may be only 2 digits, assuming that
/// anything 70 or more means 19xx and under 70 means 20xx.
///
int fy4(int year) {
  if (year > 1000) return year;
  if (year > 69) return 1900 + year;
  return 2000 + year;
}
