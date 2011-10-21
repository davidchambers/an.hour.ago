if (typeof require != "undefined") {
  var NaturalDate = require("./an.hour.ago").NaturalDate
}


var _ = function (text, actual, expected) {
  console.log()
  console.log(text)
  console.log(actual.toString())
  if (Math.abs(actual.valueOf() - expected.valueOf()) > 10) {
    console.log("D'oh! (expected: " + expected + ")")
  }
}


var tomorrow  = 1..day.from_now
var halloween = new Date("31 October 2011")
var christmas = new Date("25 December 2011")
var a   = NaturalDate.a
var an  = NaturalDate.an
var now = function () {
  return new Date().getTime()
}


_("3..days.ago"
,  3..days.ago
,  new Date(now() - 3 * 24 * 60 * 60 * 1000))

_("1..minute.from_now"
,  1..minute.from_now
,  new Date(now() + 1 * 60 * 1000))

_("1.5.hours.ago"
,  1.5.hours.ago
,  new Date(now() - 1.5 * 60 * 60 * 1000))

_("2..days.after(halloween)"
,  2..days.after(halloween)
,  new Date(halloween.getTime() + 2 * 24 * 60 * 60 * 1000))

_("1..week.before(christmas)"
,  1..week.before(christmas)
,  new Date(christmas.getTime() - 7 * 24 * 60 * 60 * 1000))

_("a.week.from(tomorrow)"
,  a.week.from(tomorrow)
,  new Date(tomorrow.getTime() + 7 * 24 * 60 * 60 * 1000))

_("a.fortnight.from_now"
,  a.fortnight.from_now
,  new Date(now() + 2 * 7 * 24 * 60 * 60 * 1000))

_("an.hour.and(58..minutes).from_now"
,  an.hour.and(58..minutes).from_now
,  new Date(now() + 1 * 60 * 60 * 1000 + 58 * 60 * 1000))

_("11..hours.and(36..minutes).and(9..seconds).ago"
,  11..hours.and(36..minutes).and(9..seconds).ago
,  new Date(now() - 11 * 60 * 60 * 1000 - 36 * 60 * 1000 - 9 * 1000))
