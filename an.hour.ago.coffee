class NaturalDate
  constructor: (@value) ->

NaturalDate::and = (naturalDate) ->
  new NaturalDate @value + naturalDate.valueOf()

NaturalDate::before = (date) ->
  new Date date.valueOf() - @value

NaturalDate::from =
NaturalDate::after = (date) ->
  new Date date.valueOf() + @value

NaturalDate::valueOf = ->
  @value

def = (name, get) -> Object.defineProperty NaturalDate.prototype, name, {get}

def 'ago',      -> new Date (new Date).getTime() - @value
def 'from_now', -> new Date (new Date).getTime() + @value


numberProto = Number.prototype

units =
  millisecond:      1
  second: seconds = 1000
  minute: minutes = 60 * seconds
  hour:   hours   = 60 * minutes
  day:    days    = 24 * hours
  week:              7 * days

for own unit, ms of units
  get = ((ms) -> -> new NaturalDate this * ms) ms
  Object.defineProperty numberProto, unit, {get}
  Object.defineProperty numberProto, unit + 's', {get}


one = 1
two = 2

NaturalDate.a =
  millisecond:  one.millisecond
  second:       one.second
  minute:       one.minute
  day:          one.day
  week:         one.week
  fortnight:    two.weeks
NaturalDate.an =
  hour:         one.hour

@NaturalDate = NaturalDate
