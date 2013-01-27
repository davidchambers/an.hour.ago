# an.hour.ago

an.hour.ago is a small utility which enables wonderfully expressive date and
time manipulation in JavaScript.

Before we proceed, let me be clear that if supporting Internet Explorer is a
requirement, you'd best turn back now. If, on the other hand, you're writing
server-side JavaScript (or CoffeeScript) and desire an elegant means of
expressing relative dates and times, read on!

Let's start with a simple example...

```coffeescript
# CoffeeScript                                  # JavaScript
3.days.ago                                      # 3..days.ago
```

This produces a [`Date`][1] instance representing 72 hours before the present.
Neat. What about the future?

```coffeescript
1.minute.from_now                               # 1..minute.from_now
```

Easy! Note the use of `minute` rather than `minutes`. The two are synonymous;
singular and plural properties exist for each of the supported units.

Decimals? You betcha:

```coffeescript
1.5.hours.ago                                   # 1.5.hours.ago
```

In fact, the JavaScript is identical to the CoffeeScript in this case as the
awkward double dot is not required.

What about dates relative to other points in time?

```coffeescript
tomorrow  = 1.day.from_now                      # var tomorrow  = 1..day.from_now
halloween = new Date '31 October 2011'          # var halloween = new Date('31 October 2011')
christmas = new Date '25 December 2011'         # var christmas = new Date('25 December 2011')
                                                #
1.week.from tomorrow                            # 1..week.from(tomorrow)
                                                #
2.days.after halloween                          # 2..days.after(halloween)
                                                #
1.week.before christmas                         # 1..week.before(christmas)
```

`from` and `after` are synonymous; use whichever reads better.

*This is pleasing,* you may be thinking, *but I'd never say “one week from
tomorrow” – it sounds a bit stiff.*

Well, if you must...

```coffeescript
a = an = 1                                      # var a = 1, an = 1
                                                #
a.week.from tomorrow                            # a.week.from(tomorrow)
                                                #
a.fortnight.from_now                            # a.fortnight.from_now
                                                #
an.hour.ago                                     # an.hour.ago
```

Oh, and I should mention, you can add `NaturalDate` instances using the `and`
method:

```coffeescript
an.hour.and(58.minutes).from_now                # an.hour.and(58..minutes).from_now
                                                #
11.hours.and(36.minutes).and(9.seconds).ago     # 11..hours.and(36..minutes).and(9..seconds).ago
```

*Can you help me with date comparison? To determine whether an event occurred
__more__ than a week ago I have to ask whether its numeric representation is
__less__ than that of "a week ago". It makes my head hurt.*

Perhaps you find this more natural?

```coffeescript
event_occurred.more_than(a.week).ago
```

A practical example:

```coffeescript
user_registered = db.get(id).registration_date

$('#tips').show() if user_registered.less_than(15.minutes).ago
```

`before`/`after` can follow `less_than`/`more_than`:

```coffeescript
apply_late_fee() if costume_returned.more_than(2.days).after halloween
```

There's also an `either_side_of` method which does what it says on the tin:

```coffeescript
unfortunate = birthday.less_than(3.days).either_side_of christmas
```

That just about covers it.

### Running the test suite

    make setup
    make test

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

### One last thing...

To be clear, an.hour.ago fiddles with `Date.prototype` and `Number.prototype`.
Two properties are added to `Date.prototype`:

  + `less_than`
  + `more_than`

The following properties are added to `Number.prototype`:

  + `day`
  + `days`
  + `hour`
  + `hours`
  + `millisecond`
  + `milliseconds`
  + `minute`
  + `minutes`
  + `second`
  + `seconds`
  + `week`
  + `weeks`

Each of these properties has a "getter" which returns a `NaturalDate` object.
The rest of the methods (`before`, `after`/`from`, and `and`) are attached to
`NaturalDate.prototype` (which is not exposed).


[1]: https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Date
