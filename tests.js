if (typeof require != "undefined") {
  var NaturalDate = require("./an.hour.ago").NaturalDate
}


var count = 0, failures = []
var assert = function (pass) {
  count += 1
  if (!pass) failures.push(count)
}
var assertEqual = function (actual, expected) {
  assert(Math.abs(actual.valueOf() - expected.valueOf()) < 10)
}
var assertFalse = function (actual) {
  assert(actual === false)
}
var assertTrue = function (actual) {
  assert(actual === true)
}


var tomorrow  = 1..day.from_now
var halloween = new Date("31 October 2011")
var christmas = new Date("25 December 2011")
var a   = NaturalDate.a
var an  = NaturalDate.an
var now = function () {
  return new Date().getTime()
}


// 1
assertEqual(
  3..days.ago,
  new Date(now() - 3 * 24 * 60 * 60 * 1000))

// 2
assertEqual(
  1..minute.from_now,
  new Date(now() + 1 * 60 * 1000))

// 3
assertEqual(
  1.5.hours.ago,
  new Date(now() - 1.5 * 60 * 60 * 1000))

// 4
assertEqual(
  2..days.after(halloween),
  new Date(halloween.getTime() + 2 * 24 * 60 * 60 * 1000))

// 5
assertEqual(
  1..week.before(christmas),
  new Date(christmas.getTime() - 7 * 24 * 60 * 60 * 1000))

// 6
assertEqual(
  a.week.from(tomorrow),
  new Date(tomorrow.getTime() + 7 * 24 * 60 * 60 * 1000))

// 7
assertEqual(
  a.fortnight.from_now,
  new Date(now() + 2 * 7 * 24 * 60 * 60 * 1000))

// 8
assertEqual(
  an.hour.and(58..minutes).from_now,
  new Date(now() + 1 * 60 * 60 * 1000 + 58 * 60 * 1000))

// 9
assertEqual(
  11..hours.and(36..minutes).and(9..seconds).ago,
  new Date(now() - 11 * 60 * 60 * 1000 - 36 * 60 * 1000 - 9 * 1000))

var user_registered = new Date(12..minutes.ago)

// 10
assertTrue(user_registered.more_than(10..minutes).ago)

// 11
assertFalse(user_registered.more_than(15..minutes).ago)

// 12
assertFalse(user_registered.less_than(10..minutes).ago)

// 13
assertTrue(user_registered.less_than(15..minutes).ago)

var offer_expires = new Date(10..days.from_now)

// 14
assertTrue(offer_expires.more_than(a.week).from_now)

// 15
assertFalse(offer_expires.more_than(2..weeks).from_now)

// 16
assertFalse(offer_expires.less_than(7..days).from_now)

// 17
assertTrue(offer_expires.less_than(14..days).from_now)

// 18
assertTrue(christmas.more_than(4..weeks).after(halloween))

// 19
assertFalse(christmas.more_than(90..days).after(halloween))

// 20
assertTrue(halloween.more_than(4..weeks).before(christmas))

// 21
assertFalse(halloween.more_than(90..days).before(christmas))

// 22
assertTrue(halloween.more_than(30..days).either_side_of(christmas))

// 23
assertFalse(halloween.more_than(10..weeks).either_side_of(christmas))

// 24
assertFalse(halloween.less_than(30..days).either_side_of(christmas))

// 25
assertTrue(halloween.less_than(10..weeks).either_side_of(christmas))

// 26
assertTrue(christmas.more_than(30..days).either_side_of(halloween))

// 27
assertFalse(christmas.more_than(10..weeks).either_side_of(halloween))

// 28
assertFalse(christmas.less_than(30..days).either_side_of(halloween))

// 29
assertTrue(christmas.less_than(10..weeks).either_side_of(halloween))


var message = count - failures.length + " of " + count + " tests passed"
if (failures.length) {
  message += " (failed: " + failures.join(", ") + ")"
}
console.log(message)
