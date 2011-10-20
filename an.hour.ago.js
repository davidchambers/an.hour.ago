(function() {
  var NaturalDate, days, def, get, hours, minutes, ms, numberProto, one, seconds, two, unit, units;
  var __hasProp = Object.prototype.hasOwnProperty;
  NaturalDate = (function() {
    function NaturalDate(value) {
      this.value = value;
    }
    return NaturalDate;
  })();
  NaturalDate.prototype.and = function(naturalDate) {
    return new NaturalDate(this.value + naturalDate.valueOf());
  };
  NaturalDate.prototype.before = function(date) {
    return new Date(date.valueOf() - this.value);
  };
  NaturalDate.prototype.from = NaturalDate.prototype.after = function(date) {
    return new Date(date.valueOf() + this.value);
  };
  NaturalDate.prototype.valueOf = function() {
    return this.value;
  };
  def = function(name, get) {
    return Object.defineProperty(NaturalDate.prototype, name, {
      get: get
    });
  };
  def('ago', function() {
    return new Date((new Date).getTime() - this.value);
  });
  def('from_now', function() {
    return new Date((new Date).getTime() + this.value);
  });
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
    get = (function(ms) {
      return function() {
        return new NaturalDate(this * ms);
      };
    })(ms);
    Object.defineProperty(numberProto, unit, {
      get: get
    });
    Object.defineProperty(numberProto, unit + 's', {
      get: get
    });
  }
  one = 1;
  two = 2;
  NaturalDate.a = {
    millisecond: one.millisecond,
    second: one.second,
    minute: one.minute,
    day: one.day,
    week: one.week,
    fortnight: two.weeks
  };
  NaturalDate.an = {
    hour: one.hour
  };
  this.NaturalDate = NaturalDate;
}).call(this);
