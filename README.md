# Dating Factory

A very simple library for parsing English date strings into `DateTime`s.

## About

This library exists for my personal using in testing.  I work on personal
projects where I'm asserting on dates often and for whatever reason, looking at
ISO dates make my eyes glaze over and give me headaches.  This is especially the
case when I need a full datetime stuct but only care about a portion of it.

This is heavily tailored to my own use.  It only supports English, always
returns a `DateTime` in UTC with microsecond precision, and the string itself
only supports a specific format (3-letter months, 12-hour time, and date and
time must be separated by ` - `).

All of this might change, of course.

If there is any interest in extending this lib to be a little more flexible,
I might be open to that.

I would also caution that using a library such as this in an open source project
as it makes the already English-centric world of programming even more
English-centric.

## Note

I just pushed this recently to have it in a repo.  I haven't even added a tag
yet.  Things might change heavily, including the sigil.

## Usage

```elixir
iex> import DatingFactory
iex> ~d[Apr 24, 1981 - 2pm]
~U[1981-04-24 14:00:00.000000Z]
iex> ~d[10:02am] # uses today's date
~U[2022-05-03 10:02:00.000000Z]
iex> ~d[Aug 23] # uses the current year but always at the beginning of the day
~U[2022-08-23 00:00:00.000000Z]
```

## Installation

```elixir
def deps do
  [
    {:dating_factory, git:  "https://github.com/sodapopcan/dating_factory.git"}
  ]
end
```
