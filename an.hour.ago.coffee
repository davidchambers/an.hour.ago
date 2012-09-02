# Helpers
# -------

{defineProperty} = Object
unless defineProperty?
  defineProperty = (object, name, descriptor) ->
    object.__defineGetter__ name, descriptor.get

def = (object, name, get) ->
  defineProperty object, name, {get}

now = Date.now or -> (new Date).getTime()


# `NaturalDate`
# -------------

class NaturalDate
  constructor: (@value) ->

$ND = NaturalDate.prototype

$ND.and = (naturalDate) ->
  new NaturalDate @value + naturalDate.valueOf()

$ND.before = (date) ->
  new Date date.valueOf() - @value

$ND.from = $ND.after = (date) ->
  new Date date.valueOf() + @value

$ND.valueOf = ->
  @value

def $ND, 'ago',      -> new Date now() - @value
def $ND, 'from_now', -> new Date now() + @value


# `DateComparator`
# ----------------

class DateComparator
  constructor: (@operator, @self, @offset) ->

$DC = DateComparator.prototype

$DC.before = (date) ->
  other = date.valueOf() - @offset
  switch @operator
    when '<' then @self > other
    when '>' then @self < other

$DC.from = $DC.after = (date) ->
  other = date.valueOf() + @offset
  switch @operator
    when '<' then @self < other
    when '>' then @self > other

$DC.either_side_of = (date) ->
  switch @operator
    when '<' then @before(date) and @after(date)
    when '>' then @before(date) or @after(date)

def $DC, 'ago',      -> @before now()
def $DC, 'from_now', -> @from now()


# Add properties to `Date.prototype`
# ----------------------------------

Date::less_than = (offset) ->
  new DateComparator '<', @valueOf(), offset

Date::more_than = (offset) ->
  new DateComparator '>', @valueOf(), offset


# Add properties to `Number.prototype`
# ------------------------------------

numberProto = Number.prototype

units =
  millisecond:      1
  second: seconds = 1000
  minute: minutes = 60 * seconds
  hour:   hours   = 60 * minutes
  day:    days    = 24 * hours
  week:   weeks   =  7 * days
  fortnight:         2 * weeks

for own unit, ms of units
  getter = do (ms = ms) -> -> new NaturalDate this * ms
  def numberProto, unit, getter
  def numberProto, unit + 's', getter
