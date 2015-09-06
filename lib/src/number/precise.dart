part of number;

/// [Precise] represents an arbitrary precision number.
///
/// It can be used anywhere a [Real] [Number] is used.
///
/// Arbitrary precision can be used to combat the effects of cumulative rounding errors in circumstances
/// where those errors can be significant.
///
/// This class enables arbitary precision calculations in both Dart and when transpiled to JavaScript by
/// representing numbers as discrete blocks of digits that stay within the limitations of the underlying number
/// system in the language.  In JavaScript the maximum value of a number, because they are 64-bit floating
/// point values, is 2^53, or 9007199254740992, and the maximum number of significant digits as a result is 16.
///
class Precise extends Real {
  static final zero = new Precise("0");

  /// The digits of the arbitrary precision number are represented as a list of Digit objects,
  /// lowest significant digit to most significant digit.
  final List<Digit> _digits = [];

  int _power = 0;

  /// Flag for negative values
  bool _neg = false;

  /// Optional precision cutoff (max number of significant digits allowed)
  int _precision;

  /// Construct an arbitrary precision number from a string.
  ///
  /// Examples:
  ///   new Precise("12")
  ///   new Precise("0.1234")
  ///   new Precise("-12.345")
  ///   new Precise("1.23456789e-6")
  ///
  Precise(String value) {
    String str = value.toLowerCase().trim();
    if (str.startsWith("-")) _neg = true;
    int decimalPointIndex = str.indexOf(".");
    int eIndex = str.indexOf("e");

    if (decimalPointIndex != -1) {
      _power = eIndex != -1 ? -(eIndex - decimalPointIndex - 1) : -(str.length - decimalPointIndex - 1);
    }
    if (eIndex != -1) {
      _power += int.parse(str.substring(eIndex + 1));
    }
    int endParseIndex = eIndex != -1 ? eIndex - 1 : value.length - 1;
    String char = "";
    bool decimalPoint = false;
    for (int index = endParseIndex; index > -1; index--) {
      char = str[index];

      // Ignore one decimal
      if (char == ".") {
        if (!decimalPoint) {
          decimalPoint = true;
          continue;
        } else {
          throw "Precise cannot parse string with multiple decimal points";
        }
      }

      // Ignore sign character at start
      if (char == "-" || char == "+" && index == 0) break;
      _digits.add(new Digit.char(char));
    }
  }

  factory Precise.num(num value) => value != null ? new Precise(value.toString()) : Precise.zero;

  /// Creates a new arbitrary precision number directly from digits.
  ///
  /// [digits] must be ordered from least significant to most.
  ///
  /// [power] sets the offset of the decimal point, if any (defaults to 0).  For example,
  /// a power of -2 means that the decimal point is located between the second and third digits.
  /// A power of +2 means that two zeroes are implied before the least significant digit (that is, the number is
  /// one hundred times greater than the number specified by the digits).
  ///
  /// For a negative number set [neg] to true.
  ///
  /// Default [precision] is 50 digits.
  ///
  Precise.raw(List<Digit> digits, {int power: 0, bool neg: false, int precision: 50}) {
    if (digits != null && digits.isNotEmpty) {
      _digits.addAll(digits);
    } else {
      _digits.add(Digit.zero);
    }
    _power = power;
    _neg = neg;
    _precision = precision;
  }

  /// Returns a copy of the internal digits list, from least significant to most.
  ///
  List<Digit> get digits => new List.from(_digits);

  int get power => _power;

  int get precision => _precision;

  /// Returns the digit at [place], where place is with respect to the decimal number system
  /// (that is, place 1 is tens, place 2 is hundreds, place -3 is thousandths, etc).
  ///
  /// Therefore place is not a direct index into the digits list; power must be taken into account first.
  ///
  Digit digitAtPlace(int place) {
    int index = place - power;
    if (index > -1 && index < _digits.length) {
      return _digits[index];
    } else {
      return Digit.zero;
    }
  }

  @override bool get isInteger => _power == 0;

  @override int toInt() {
    if (_power >= 0) return int.parse(toString());
    return toDouble().round();
  }

  @override double toDouble() => double.parse(toString());

  num get value => isInteger ? toInt() : toDouble();

  /// Negation operator.
  ///
  @override
  Number operator -() {
    if (_neg) return new Precise(toString().substring(1));
    return new Precise("-${toString()}");
  }

  /// Addition operator.
  ///
  @override
  Number operator +(addend) {
    Precise preciseAddend =
        addend is Precise ? addend : addend is num ? new Precise.num(addend) : new Precise("${addend}");

    // Divert to subtraction if signs are not the same
    if (_neg != preciseAddend._neg) {
      if (_neg) return preciseAddend - (-this);
      return this - (-preciseAddend);
    }

    int minPlace = Math.min(_power, addend._power);
    int maxPlace = Math.max(_power + _digits.length - 1, addend._power + _digits.length - 1);
    List<Digit> sum = [];
    int carry = 0;
    int temp = 0;
    for (int place = minPlace; place <= maxPlace; place++) {
      Digit d1 = digitAtPlace(place);
      Digit d2 = preciseAddend.digitAtPlace(place);
      temp = d1 + d2 + carry;
      if (temp < 10) {
        sum.add(new Digit(temp));
        carry = 0;
      } else {
        sum.add(new Digit(temp - 10));
        carry = 1;
      }
    }
    return new Precise.raw(sum, power: minPlace, neg: _neg);
  }

  /// Support [dart:json] stringify.
  ///
  /// Map Contents:
  ///     "precise" : string representation of the number
  ///
  Map toJson() {
    return {"precise": toString()};
  }

  @override
  String toString() {
    StringBuffer buf = new StringBuffer();
    if (_neg) buf.write("-");
    _digits.reversed.forEach((d) => buf.write(d));

    if (_power > 0) {
      if (_power > 3) {
        buf.write("e${_power}");
      } else {
        // Add zeroes
        for (int i = 0; i <= _power; i++) {
          buf.write("0");
        }
      }
    } else if (_power < 0) {
      if (_power.abs() < _digits.length) {
        // Insert decimal point
        String str = buf.toString();
        StringBuffer buf2 = new StringBuffer();
        int splitIndex = _digits.length + _power;
        buf2.write(str.substring(0, splitIndex));
        buf2.write(".");
        buf2.write(str.substring(splitIndex));
      } else {
        buf.write("e${_power}");
      }
    }

    return buf.toString();
  }
}

/// Represents a digit in four bits of a single byte.
///
/// This wastes four bits but that's a decent tradeoff for simplicity and better
/// anyway than the 4+ bytes allocated for a regular int.
///
class Digit {
  static final Digit zero = new Digit(0);
  static final Digit one = new Digit(1);
  static final Digit two = new Digit(2);
  static final Digit three = new Digit(3);
  static final Digit four = new Digit(4);
  static final Digit five = new Digit(5);
  static final Digit six = new Digit(6);
  static final Digit seven = new Digit(7);
  static final Digit eight = new Digit(8);
  static final Digit nine = new Digit(9);

  static final int codeUnit0 = "0".codeUnitAt(0);

  final ByteData value = new ByteData(1);

  Digit(int num) {
    if (num == null) throw "Digit cannot be constructed with null";
    if (num > 9 || num < 0) throw "Digit must be between 0 and 9";
    value.setUint8(0, num);
  }

  factory Digit.char(String digitChar) {
    if (digitChar == null) throw "Digit cannot be constructed with null character";
    if (digitChar.length != 1) throw "Digit must be constructed with a single character";
    return new Digit(digitChar.codeUnitAt(0) - codeUnit0);
  }
  @override
  bool operator ==(other) {
    if (other is Digit) return value.getUint8(0) == other.value.getUint8(0);
    if (other is num) return value.getUint8(0) == other;
    if (other is Number) return other == value.getUint8(0);
    return false;
  }

  @override int get hashCode => value.getUint8(0);

  /// Adds two digits together.
  ///
  /// The result will either be a digit or a list of two digits
  /// if the sum is greater than 10.  The order of the digits
  /// is like it would be read (e.g., [1, 5] for fifteen), which is
  /// opposite of the way [Precise] stores them.
  ///
  /// If [addend] is not a [Digit] then an exception will be thrown.
  ///
  int operator +(addend) {
    if (addend is! Digit) throw "Addend must be a Digit";
    return toInt() + addend.toInt();
  }

  int toInt() => value.getUint8(0);

  @override
  String toString() => "${toInt()}";
}
