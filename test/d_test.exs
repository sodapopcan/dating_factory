defmodule DTest do
  use ExUnit.Case

  import D

  def datetime(year, month, day, hour, minute, second) do
    date = Date.new!(year, month, day)
    time = Time.new!(hour, minute, second, 000000)

    DateTime.new!(date, time)
  end

  describe "~d/2" do
    test "parses full date" do
      assert ~d[Apr 24, 1981 - 3:33pm] == ~U[1981-04-24T15:33:00.000000Z]
    end

    test "date without year assumes current year" do
      now = DateTime.utc_now()

      assert ~d[Apr 24 - 3:33pm] == datetime(now.year, 4, 24, 15, 33, 0)
    end

    test "date without day or year assumes current day and year" do
      now = DateTime.utc_now()

      assert ~d[Apr - 3:33pm] == datetime(now.year, 4, now.day, 15, 33, 0)
    end

    test "time without a date assumes the current date" do
      now = DateTime.utc_now()

      assert ~d[4:11pm] == datetime(now.year, now.month, now.day, 16, 11, 0)
    end
  end

  describe "parse_date/1" do
    test "parses all sorts of dates" do
      assert parse_date("Jan 1, 2014") == Date.new!(2014, 1, 1)
      assert parse_date("Feb 23, 1979") == Date.new!(1979, 2, 23)
      assert parse_date("Mar 12, 1922") == Date.new!(1922, 3, 12)
      assert parse_date("Mar 12, 1922") == Date.new!(1922, 3, 12)
      assert parse_date("May 2, 1942") == Date.new!(1942, 5, 2)
    end

    test "assumes current year when no year given" do
      now = DateTime.utc_now()

      assert parse_date("Apr 24") == Date.new!(now.year, 4, 24)
    end
  end

  describe "parse_time/1" do
    test "parses just hour with am/pm" do
      assert parse_time("2pm") == Time.new!(14, 0, 0, 000000)
      assert parse_time("11am") == Time.new!(11, 0, 0, 000000)
    end

    test "parses hour and minutes with am/pm" do
      assert parse_time("4:04am") == Time.new!(4, 4, 0, 000000)
      assert parse_time("10:04pm") == Time.new!(22, 4, 0, 000000)
    end

    test "parses hour, minutes, and seconds with am/pm" do
      assert parse_time("11:04:56pm") == Time.new!(23, 4, 56, 000000)
      assert parse_time("11:04:56am") == Time.new!(11, 4, 56, 000000)
    end
  end
end
