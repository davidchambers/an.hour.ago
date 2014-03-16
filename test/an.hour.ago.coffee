assert = require 'assert'

require '..'


isDate = (object) -> Object::toString.call(object) is '[object Date]'
eq = (actual, expected, message) ->
  if isDate(actual) and isDate(expected)
    assert.strictEqual +actual, +expected, message
  else
    assert.strictEqual actual, expected, message

a = an = 1
tomorrow  = a.day.from_now
halloween = new Date '31 October 2011'
christmas = new Date '25 December 2011'


describe 'an.hour.ago', ->

  it 'provides relative dates and times via `ago` and `from_now`', ->
    eq 3.days.ago,                new Date Date.now() - 3 * 24 * 60 * 60 * 1000
    eq 1.5.hours.ago,             new Date Date.now() -    1.5 * 60 * 60 * 1000
    eq 1.minute.from_now,         new Date Date.now() +           1 * 60 * 1000

  it 'provides relative dates and times via `before`, `after`, and `from`', ->
    eq 1.week.before(christmas),  new Date +christmas - 7 * 24 * 60 * 60 * 1000
    eq 2.days.after(halloween),   new Date +halloween + 2 * 24 * 60 * 60 * 1000
    eq 1.week.from(tomorrow),     new Date +tomorrow  + 7 * 24 * 60 * 60 * 1000

  it 'allows `a` and `an` to be used in place of `1`', ->
    eq a.week.from(tomorrow),     1.week.from tomorrow
    eq an.hour.ago,               1.hour.ago

  it 'allows `a.fortnight` to be used in place of `2.weeks`', ->
    eq a.fortnight.from_now,      2.weeks.from_now

  it 'supports complex relative dates and times', ->
    eq an.hour.and(58.minutes).from_now,
       new Date Date.now() + 1 * 60 * 60 * 1000 + 58 * 60 * 1000
    eq 11.hours.and(36.minutes).and(9.seconds).ago,
       new Date Date.now() - 11 * 60 * 60 * 1000 - 36 * 60 * 1000 - 9 * 1000

  it 'can determine whether a given date lies within a given range', ->
    user_registered = 12.minutes.ago
    eq user_registered.more_than(10.minutes).ago, yes
    eq user_registered.more_than(15.minutes).ago, no
    eq user_registered.less_than(10.minutes).ago, no
    eq user_registered.less_than(15.minutes).ago, yes

    offer_expires = 10.days.from_now
    eq offer_expires.more_than(a.week).from_now,  yes
    eq offer_expires.more_than(2.weeks).from_now, no
    eq offer_expires.less_than(7.days).from_now,  no
    eq offer_expires.less_than(14.days).from_now, yes

    eq christmas.more_than(4.weeks).after(halloween),  yes
    eq christmas.more_than(90.days).after(halloween),  no
    eq halloween.more_than(4.weeks).before(christmas), yes
    eq halloween.more_than(90.days).before(christmas), no

    eq halloween.more_than(30.days).either_side_of(christmas),  yes
    eq halloween.more_than(10.weeks).either_side_of(christmas), no
    eq halloween.less_than(30.days).either_side_of(christmas),  no
    eq halloween.less_than(10.weeks).either_side_of(christmas), yes
    eq christmas.more_than(30.days).either_side_of(halloween),  yes
    eq christmas.more_than(10.weeks).either_side_of(halloween), no
    eq christmas.less_than(30.days).either_side_of(halloween),  no
    eq christmas.less_than(10.weeks).either_side_of(halloween), yes
