defmodule DTest do
  use ExUnit.Case

  import D

  describe "parse_date/1" do
    test "parses all sorts of dates" do
      assert parse_date("Jan 1, 2014") == Date.new!(2014, 1, 1)
      assert parse_date("Feb 23, 1979") == Date.new!(1979, 2, 23)
      assert parse_date("Mar 12, 1922") == Date.new!(1922, 3, 12)
      assert parse_date("Mar 12, 1922") == Date.new!(1922, 3, 12)
      assert parse_date("May 2, 1942") == Date.new!(1942, 5, 2)
    end
  end

  describe "parse_time/1" do
    test "parses just hour with am/pm" do
      assert parse_time("2pm") == Time.new!(14, 0, 0)
      assert parse_time("11am") == Time.new!(11, 0, 0)
    end

    test "parses hour and minutes with am/pm" do
      assert parse_time("4:04am") == Time.new!(4, 4, 0)
      assert parse_time("10:04pm") == Time.new!(22, 4, 0)
    end

    test "parses hour, minutes, and seconds with am/pm" do
      assert parse_time("11:04:56pm") == Time.new!(23, 4, 56)
      assert parse_time("11:04:56am") == Time.new!(11, 4, 56)
    end
  end
end
