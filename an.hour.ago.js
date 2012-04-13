(function() {
  var $DC, $ND, DateComparator, NaturalDate, days, def, defineProperty, getter, hours, minutes, ms, now, numberProto, seconds, unit, units,
    __hasProp = Object.prototype.hasOwnProperty;

  defineProperty = Object.defineProperty;

  if (defineProperty == null) {
    defineProperty = function(object, name, descriptor) {
      return object.__defineGetter__(name, descriptor.get);
    };
  }

  def = function(object, name, get) {
    return defineProperty(object, name, {
      get: get
    });
  };

  now = Date.now || function() {
    return (new Date).getTime();
  };

  NaturalDate = (function() {

    function NaturalDate(value) {
      this.value = value;
    }

    return NaturalDate;

  })();

  $ND = NaturalDate.prototype;

  $ND.and = function(naturalDate) {
    return new NaturalDate(this.value + naturalDate.valueOf());
  };

  $ND.before = function(date) {
    return new Date(date.valueOf() - this.value);
  };

  $ND.from = $ND.after = function(date) {
    return new Date(date.valueOf() + this.value);
  };

  $ND.valueOf = function() {
    return this.value;
  };

  def($ND, 'ago', function() {
    return new Date(now() - this.value);
  });

  def($ND, 'from_now', function() {
    return new Date(now() + this.value);
  });

  DateComparator = (function() {

    function DateComparator(operator, self, offset) {
      this.operator = operator;
      this.self = self;
      this.offset = offset;
    }

    return DateComparator;

  })();

  $DC = DateComparator.prototype;

  $DC.before = function(date) {
    var other;
    other = date.valueOf() - this.offset;
    switch (this.operator) {
      case '<':
        return this.self > other;
      case '>':
        return this.self < other;
    }
  };

  $DC.from = $DC.after = function(date) {
    var other;
    other = date.valueOf() + this.offset;
    switch (this.operator) {
      case '<':
        return this.self < other;
      case '>':
        return this.self > other;
    }
  };

  $DC.either_side_of = function(date) {
    switch (this.operator) {
      case '<':
        return this.before(date) && this.after(date);
      case '>':
        return this.before(date) || this.after(date);
    }
  };

  def($DC, 'ago', function() {
    return this.before(now());
  });

  def($DC, 'from_now', function() {
    return this.from(now());
  });

  Date.prototype.less_than = function(offset) {
    return new DateComparator('<', this.valueOf(), offset);
  };

  Date.prototype.more_than = function(offset) {
    return new DateComparator('>', this.valueOf(), offset);
  };

  numberProto = Number.prototype;

  units = {
    millisecond: 1,
    second: seconds = 1000,
    minute: minutes = 60 * seconds,
    hour: hours = 60 * minutes,
    day: days = 24 * hours,
    week: 7 * days
  };

  for (unit in units) {
    if (!__hasProp.call(units, unit)) continue;
    ms = units[unit];
    getter = (function(ms) {
      return function() {
        return new NaturalDate(this * ms);
      };
    })(ms);
    def(numberProto, unit, getter);
    def(numberProto, unit + 's', getter);
  }

  NaturalDate.a = {
    millisecond: 1..millisecond,
    second: 1..second,
    minute: 1..minute,
    day: 1..day,
    week: 1..week,
    fortnight: 2..weeks
  };

  NaturalDate.an = {
    hour: 1..hour
  };

  this.NaturalDate = NaturalDate;

}).call(this);
