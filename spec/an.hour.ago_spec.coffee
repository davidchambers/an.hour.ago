require '../an.hour.ago'

Boolean::should_be = (compare) -> expect(@valueOf()).toEqual compare.valueOf()
Date::should_be    = (compare) -> expect(this).toEqual compare

a = an = 1
tomorrow  = a.day.from_now
halloween = new Date '31 October 2011'
christmas = new Date '25 December 2011'

describe 'an.hour.ago', ->

  it 'provides relative dates and times via `ago` and `from_now`', ->
    3.days.ago        .should_be new Date Date.now() - 3 * 24 * 60 * 60 * 1000
    1.5.hours.ago     .should_be new Date Date.now() -    1.5 * 60 * 60 * 1000
    1.minute.from_now .should_be new Date Date.now() +           1 * 60 * 1000

  it 'provides relative dates and times via `before`, `after`, and `from`', ->
    1.week.before(christmas) .should_be new Date +christmas - 7 * 24 * 60 * 60 * 1000
    2.days.after(halloween)  .should_be new Date +halloween + 2 * 24 * 60 * 60 * 1000
    1.week.from(tomorrow)    .should_be new Date +tomorrow  + 7 * 24 * 60 * 60 * 1000

  it 'allows `a` and `an` to be used in place of `1`', ->
    a.week.from(tomorrow).should_be 1.week.from tomorrow
    an.hour.ago.should_be 1.hour.ago

  it 'allows `a.fortnight` to be used in place of `2.weeks`', ->
    a.fortnight.from_now.should_be 2.weeks.from_now

  it 'supports complex relative dates and times', ->
    an.hour.and(58.minutes).from_now
    .should_be new Date Date.now() + 1 * 60 * 60 * 1000 + 58 * 60 * 1000
    11.hours.and(36.minutes).and(9.seconds).ago
    .should_be new Date Date.now() - 11 * 60 * 60 * 1000 - 36 * 60 * 1000 - 9 * 1000

  it 'can determine whether a given date lies within a given range', ->
    user_registered = 12.minutes.ago
    user_registered.more_than(10.minutes).ago .should_be true
    user_registered.more_than(15.minutes).ago .should_be false
    user_registered.less_than(10.minutes).ago .should_be false
    user_registered.less_than(15.minutes).ago .should_be true

    offer_expires = 10.days.from_now
    offer_expires.more_than(a.week).from_now  .should_be true
    offer_expires.more_than(2.weeks).from_now .should_be false
    offer_expires.less_than(7.days).from_now  .should_be false
    offer_expires.less_than(14.days).from_now .should_be true

    christmas.more_than(4.weeks).after(halloween)  .should_be true
    christmas.more_than(90.days).after(halloween)  .should_be false
    halloween.more_than(4.weeks).before(christmas) .should_be true
    halloween.more_than(90.days).before(christmas) .should_be false

    halloween.more_than(30.days).either_side_of(christmas)  .should_be true
    halloween.more_than(10.weeks).either_side_of(christmas) .should_be false
    halloween.less_than(30.days).either_side_of(christmas)  .should_be false
    halloween.less_than(10.weeks).either_side_of(christmas) .should_be true
    christmas.more_than(30.days).either_side_of(halloween)  .should_be true
    christmas.more_than(10.weeks).either_side_of(halloween) .should_be false
    christmas.less_than(30.days).either_side_of(halloween)  .should_be false
    christmas.less_than(10.weeks).either_side_of(halloween) .should_be true
